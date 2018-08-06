--[[
/**********************************************
  
  (c) Jeroen Broks, 2014, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is stricyly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.

  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************/
 



Version: 14.08.05

]]
-- @IF IGNOREME
-- All these definitions will be ignored by GALE, but my IDE won't and so I can fool it so it outlines this script the way it should :P
setupchar = {}
char = {}
equip = {}
resistance = {}
APRegen = {}
skilllevelup = {}
PersonalAction = {}
charwalk = {}
-- @FI

function setupchar.Merya()
char.Merya = 
  {
  ["Name"] = "$MERYA",
  ["Abilities"] = {"MYSTIC","PILFER"},
  --["AblTime"] = {10,10,10,10},
  ["SkillNames"] = {"Dagger Skills","Rogue Skills"},
  ["SkillLevels"] = {3,5},
  ["SkillExperience"] = {0,15-skill}, 
  ["Experience"] = 1000 * (skill*skill),
  ["SkillFP"] = {0,5},
  ["Victory"] = "Yo! Nobody can beat us!",
  ["Perfect"] = "That was way too easy!",
  ["VicDead"] = "I guess we were a little too cocky!"  
  }
equip.Merya = 
  {
  ["WEAPON"] = "EQ_ME_WP_DAGGER",
  ["ARMOR"]  = "EQ_ME_AR_CLOAK",
  ["JEWEL"]  = nil  
  }
resistance.Merya =
  {
  ["FIRE"]          = 0,
  ["WIND"]          = 0.5/skill,
  ["WATER"]         = 0,
  ["EARTH"]         = 0,
  ["LIGHT"]         = 0,
  ["DARKNESS"]      = 0,
  ["THUNDER"]       = 0,
  ["FROST"]         = 0,
  ["STPOISON"]      = 0,
  ["STPARALYSIS"]   = 0,
  ["STSLEEP"]       = 0,
  ["STCONFUSION"]   = 0.9 / skill,
  ["STSILENCE"]     = 0,
  ["STEXHAUST"]     = 0.36 - (skill*0.06),
  ["STFEAR"]        = 0.30 - (skill*0.10),
  ["STCURSE"]       = 0.07,
  ["STDEATH"]       = 0.50 - (skill*0.2),
  ["STDESTRUCTION"] = 0.50 - (skill*0.2)
  }
GrabLevelStats('Merya',17)   
end


APRegen.Merya = {
    
    Interval = 350*(skill or 3),
    Time = 15000,
    AP = function()
         local s = char.Merya.Level
         local ak,v
         for ak,v in pairs(char.Merya.SkillLevels) do 
             s = s + v
             if ak==2 then s = s + v end 
             end         
         return math.floor(s / (skill*15))
         end   
    }


function levelup.Merya()

end

function skilllevelup.Merya(skillnr)
CSay('Debug: Yeah, Merya goes a level up in skill: '..skillnr)
char.Merya.TrophySkill = {"FIGHT","ROGUE"}
-- 1 Weapon
-- 2 Fire
-- 3 Wind
-- 4 Water
-- 5 Earth
local spells = {
    --  MYSTIC        = {2,0},
        PILFER        = {2,5},
        FASTDRAW      = {2,8},
        SMOKEBOMB     = {2,10},
        STUNSTAB      = {2,15},
        BACKSTAB      = {2,25},
        FOLLOWME      = {2,35}
      }
AutoTeach('Merya',spells)
local resup = {'BLAHBLAH','STPARALYSIS'}
if skillnr>1 and skillnr<5 then
   local r = rand(1,100)
   if r>skill*30 then 
      resistance.Merya[resup[skillnr]] = resistance.Merya[resup[skillnr]] + 0.01
      if resistance.Merya[resup[skillnr]]>1 then resistance.Merya[resup[skillnr]]=1 end
      end 
   end   
end

function PersonalAction.Merya()
-- Show circle
local px,py = PlayerCoords()
local cx,cy = Map2ScreenPos(px,py)
local rad
for rad=0,500,4 do
    DrawScreen()
    Image.Color(0x9f,0x00,0xF0)
    Image.Circle(cx,cy,rad)
    Flip() 
    end
-- Found something?
local spot
local fspots = {}
local distance
local sx,sy
local z = OldZone
for _,spot in pairs(RogueSpots) do
    if tablecontains(spot.zones,z) then
       -- CSay("Pythagoras in") 
       distance = Pythagoras(px,py,spot.x,spot.y) -- round(Math.Dist2D(px,py,spot.x,spot.y)) -- for some odd reasons the Pythagoras algorithm inside GALE refuses to be called, so let's do this manually
       --CSay("Pythagoras out")
       rollspot  = rand(1,spot.level)+distance
       rollmerya = rand(1,char.Merya.SkillLevels[2])-(char.Merya.SearchPenalty or 0)
       if rollspot<rollmerya or spot.level==0 then -- YEAH! WE FOUND SOMETHING!
          CSay("Adding spot to fspots!")
          table.insert(fspots,spot)
          if skill~=3 then char.Merya.SearchPenalty = (char.Merya.SearchPenalty or 0) - 1 end
          else
          char.Merya.SearchPenalty = (char.Merya.SearchPenalty or 0) + 1
          end
       end
    end
CSay((#fspots).." spots found, let's show them!")
local d = {1,-1,1,-1}
local s= {25,0,25,0,25}
if #fspots>0 then
   -- for rad=0,720 do  
   for ak=1,4 do for rad=s[ak+1],s[ak],d[ak] do
       DrawScreen()
       for _,spot in ipairs(fspots) do
           sx,sy = Map2ScreenPos(spot.x,spot.y)
           Image.Color(rand(1,255),rand(1,255),rand(1,255))
           Image.SetAlpha(.4)
           -- Image.Circle(sx,sy,abs(sin(rad)*25),1)
           Image.Circle(sx,sy-16,rad,1)
           Image.SetAlpha(1) 
           end
       Flip()    
       end end
   else
   char.Merya.SearchPenalty = (char.Merya.SearchPenalty or 0) + 2
   end    
end

function charwalk.Merya()
local r = rand(1,skill^skill)
if r==1 and char.Merya.SearchPenalty then
   if char.Merya.SearchPenalty>0 then char.Merya.SearchPenalty=char.Merya.SearchPenalty-1 end
   if char.Merya.SearchPenalty<0 then char.Merya.SearchPenalty=char.Merya.SearchPenalty+1 end
   end
end
