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
 



Version: 14.11.02

]]


-- @UNDEF DERNORDEBUG

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


function setupchar.Dernor()
char.Dernor = 
  {
  ["Name"] = "$DERNOR",
  ["Abilities"] = {"Charm","Bio"},
  --["AblTime"] = {10,10,10,10},
  ["SkillNames"] = {"Bat Skills","Mother Nature"},
  ["SkillLevels"] = {4-skill,round(9/skill)},
  ["SkillExperience"] = {8,15-skill}, 
  ["Experience"] = 1200 * (skill*skill),
  ["SkillFP"] = {1,4},
  ["Victory"] = "Attacking us was a mistake!",
  ["Perfect"] = "That was not a battle! That was just murder.",
  ["VicDead"] = "We must keep our minds to it!"  
  }
equip.Dernor = 
  {
  ["WEAPON"] = "EQ_DE_WP_BAT",
  ["ARMOR"]  = "EQ_DE_AR_SHIRT",
  ["JEWEL"]  = nil  
  }
resistance.Dernor =
  {
  ["FIRE"]          = 0,
  ["WIND"]          = 0.24/skill,
  ["WATER"]         = 0.24/skill,
  ["EARTH"]         = 0.24/skill,
  ["LIGHT"]         = 0,
  ["DARKNESS"]      = 0,
  ["THUNDER"]       = 0.24/skill,
  ["FROST"]         = 0.24/skill,
  ["STPOISON"]      = 0.9/skill,
  ["STPARALYSIS"]   = 0,
  ["STSLEEP"]       = 0,
  ["STCONFUSION"]   = 0,
  ["STSILENCE"]     = 0,
  ["STEXHAUST"]     = 0,
  ["STFEAR"]        = 0,
  ["STCURSE"]       = 0,
  ["STDEATH"]       = 0.65 - (skill*0.2),
  ["STDESTRUCTION"] = 0.60 - (skill*0.2)
  }
GrabLevelStats('Dernor',30-(skill*3))   
end


APRegen.Dernor = {
    
    Interval = 450*(skill or 3),
    Time = 15000,
    AP = function()
         local s = char.Dernor.Level
         local ak,v
         for ak,v in pairs(char.Dernor.SkillLevels) do 
             s = s + v
             if ak==2 then s = s + v end 
             end         
         return math.floor(s / (skill*14))
         end   
    }


function levelup.Dernor()

end

function skilllevelup.Dernor(skillnr)
CSay('Debug: Yeah, Dernor goes a level up in skill: '..skillnr)
char.Dernor.TrophySkill = {"FIGHT","NATURE"}
-- 1 Weapon
-- 2 Fire
-- 3 Wind
-- 4 Water
-- 5 Earth
local spells = {
      NEUTRALPOISON  =  {2,8},
      RECOVER        =  {2,25}
      }
AutoTeach('Dernor',spells)
local resup = {'BLAHBLAH','STPOISON'}
if skillnr>1 and skillnr<5 then
   local r = rand(1,100)
   if r>skill*20 then 
      resistance.Dernor[resup[skillnr]] = resistance.Dernor[resup[skillnr]] + 0.01
      if resistance.Dernor[resup[skillnr]]>1 then resistance.Dernor[resup[skillnr]]=1 end
      end 
   end   
end

function DernorCheckSpots(appearing)
local _,rec
local px,py,pw = PlayerCoords()
local sx,sy,dx,dy
local afstand,alpha
local Dernor = GetActiveChar()=='Dernor'
-- @IF DERNORDEBUG
local msx,msy,dbgy,k,v
-- @FI
for _,rec in ipairs(DernorSpots) do
    -- @IF DERNORDEBUG
    dx = (rec.x*Maps.Map.GridX)-Maps.CamX --+(Maps.Map.GridX/2)-Maps.CamX
    dy = (rec.y*Maps.Map.GridY)-Maps.CamY --+(Maps.Map.GridY/2)-Maps.CamY
    sx,sy = rec.x,rec.y
    afstand = Pythagoras(px,py,sx,sy)
    msx,msy = mousepos()
    dbgy = dbgy or dy
    if msx>=dx and msx<dx+32 and msy>=dy and msy<dy+32 then
       Image.Color(255,255,255)
       Image.NoFont()
       for k,v in spairs(rec) do 
           if k=='texture' then DText(k.." = "..Dec2Hex(sval(v)),msx,dbgy) else DText(k.." = "..sval(v),msx,dbgy) end
           dbgy = dbgy + 15
           end
       DText("afstand = "..afstand,msx,dbgy); dbgy = dbgy + 15
       DText("zichtbaar = "..sval(Maps.SpotVisible(rec.x,rec.y)==1),msx,dbgy); dbgy = dbgy + 15    
       dbgy = dbgy + 15       
       end
    -- @FI
    if rec.appear==appearing and Maps.SpotVisible(rec.x,rec.y)==1 then -- If not in a visible zone, then ignore this entire crap.
       sx,sy = rec.x,rec.y
       afstand = Pythagoras(px,py,sx,sy)
       if rec.appear then -- appearing
          alpha = 0
          if Dernor and afstand<=5 then
             alpha = 1 - (afstand/5)
             end
       elseif Maps.SpotVisible(rec.x,rec.y)==1 then -- Not appearing
         alpha = 1
         if afstand<=5 and Dernor then
            alpha = afstand/5
            end
         end -- appearing or disappearing
       dx = (rec.x*Maps.Map.GridX)-Maps.CamX --+(Maps.Map.GridX/2)-Maps.CamX
       dy = (rec.y*Maps.Map.GridY)-Maps.CamY --+(Maps.Map.GridY/2)-Maps.CamY
       Image.SetAlpha(alpha)
       Maps.DrawTexture(rec.texture,dx,dy)
       Image.SetAlpha(1)       
       end -- visibility check   
    end -- for loop
end
