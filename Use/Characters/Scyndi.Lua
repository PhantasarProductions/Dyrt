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
 



Version: 14.10.14

]]

-- @IF IGNOREME
char = {}
-- @FI

function setupchar.Scyndi()
char.Scyndi = 
  {
  ["Name"] = "$SCYNDI",
  ["Abilities"] = {"FirstAID"},
  --["AblTime"] = {10,10,10,10},
  ["SkillNames"] = {"Whip Skills"},
  ["SkillLevels"] = {3},
  ["SkillExperience"] = {0}, 
  ["Experience"] = 1000 * (skill*skill),
  ["SkillFP"] = {1,2,1,1,1},
  ["Victory"] = "NEXT!",
  ["Perfect"] = "What a waste of time!",
  ["VicDead"] = "Go easy on us, will ya!"  
  }
equip.Scyndi = 
  {
  ["WEAPON"] = "EQ_SC_WP_WHIP",
  ["ARMOR"]  = "EQ_IR_AR_DRESS",
  ["JEWEL"]  = nil  
  }
resistance.Scyndi =
  {
  ["FIRE"]          = 0,
  ["WIND"]          = 0,
  ["WATER"]         = 0.1,
  ["EARTH"]         = 0,
  ["LIGHT"]         = 0.90/skill,
  ["DARKNESS"]      = -.05,
  ["THUNDER"]       = 0.05,
  ["FROST"]         = 0,
  ["STPOISON"]      = 0,
  ["STPARALYSIS"]   = 0.05,
  ["STSLEEP"]       = 0,
  ["STCONFUSION"]   = 0.09,
  ["STSILENCE"]     = 0.20,
  ["STEXHAUST"]     = 0.18 - (skill*0.06),
  ["STFEAR"]        = 0.30 - (skill*0.10),
  ["STCURSE"]       = 0.05,
  ["STDEATH"]       = 0.60 - (skill*0.2),
  ["STDESTRUCTION"] = 0.70 - (skill*0.2)
  }
GrabLevelStats('Scyndi',12/skill) -- Chosen skill does matter here ;)  
end


APRegen.Scyndi = {
    
    Interval = 950,
    Time = 10000,
    AP = function()
         local s = char.Scyndi.Level
         local ak,v
         for ak,v in pairs(char.Scyndi.SkillLevels) do 
             s = s + v
             if ak==2 then s = s + v end 
             end         
         return math.floor(s / (skill*15))
         end   
    }


function levelup.Scyndi()

end

function skilllevelup.Scyndi(skillnr)
CSay('Debug: Yeah, Scyndi goes a level up in skill: '..skillnr)
char.Scyndi.TrophySkill = {"FIGHT","WENIARIA","STILLOR","THRUR","MALABIA"}
-- 1 Weapon
-- 2 Fire
-- 3 Wind
-- 4 Water
-- 5 Earth
local spells = {
        -- Weniaria
        NEUTRALPOISON = {2,5},
        REMPARALYSIS  = {2,8},
        RECOVER       = {2,10},
        SANITY        = {2,15},
        CUREDISEASE   = {2,17},
        VITALIZE      = {2,20},
        RAISEDEAD     = {2,25},
        CURE          = {2,30},
        VIGOR         = {2,35},
        GRANDHEAL     = {2,45},
        WHIZZY        = {2,50},
        WENIARIA      = {2,100},
        -- Hando Stillor
        MENTALGYM     = {3,1},
        CURESILENCE   = {3,3},
        BLAST         = {3,6},
        ENLIGHTEN     = {3,9},
        PRAY          = {3,12},
        DEVISTATE     = {3,15},
        -- Thrur
        JOLT          = {4,1},
        LIGHTNING     = {4,8},
        MYOLLNIR      = {5,20},
        -- Malabia
        RAY           = {5,1},
        SOLARIA       = {5,10},
        REMCURSE      = {5,18},
        HOLYSHIT      = {5,25}
      }
AutoTeach('Scyndi',spells)
local resup = {'BLAHBLAH','STPOISON','STSILENCE','THUNDER','LIGHT'}
if skillnr>1 and skillnr<5 then
   local r = rand(1,100)
   if r>skill*30 then 
      resistance.Scyndi[resup[skillnr]] = resistance.Scyndi[resup[skillnr]] + 0.01
      if resistance.Scyndi[resup[skillnr]]>1 then resistance.Scyndi[resup[skillnr]]=1 end
      end 
   end   
end

function AllyHurt.Scyndi()
local ak,chnScyndi,CriticalFound,ch
local x,y
ScyndiEmergencyCD = ScyndiEmergencyCD or 0
for ak=1,4 do
    ch = party[ak]
    if party[ak]=='Scyndi' then chnScyndi=ak end
    if char[ch] then
       CriticalFound = CriticalFound or (char[ch].HP[1]<char[ch].HP[2]*.20 and char[ch].HP[1]>0)
       end
    end
if CriticalFound and CombatTime.Heroes[chnScyndi]<10000 then
   if ScyndiEmergencyCD==0 then
      CombatTime.Heroes[chnScyndi] = 9999
      if skill==1 then char.Scyndi.AP[1]=char.Scyndi.AP[2] end
      -- Combat_Message('Emergency Action')
      x,y = Combat_PlayerSpot(chnScyndi)
      AddMiniMessage("Combat",Var.S("$SCYNDI takes an 'Emergency Action'!"),x,y)
      ScyndiEmergencyCD = rand(skill*5,skill*20)
      else
      ScyndiEmergencyCD = ScyndiEmergencyCD - 1
      end
   end    
end


function PersonalAction.Scyndi()
local dir = { North = {0,-1}, South = {0,1}, East = {1,0}, West = {-1,0} }
local stopwhip = {}
local k,v
for k,v in pairs(dir) do 
    stopwhip[k]= { v[1]*-1,v[2]*-1 } 
    end
local x,y,w = PlayerCoords()
local endreached = false
local tx = x
local ty = y
local hookpoint = nil
local psx,psy = Map2ScreenPos(x,y)
local tsx,tsy
-- Let's throw out the whip
repeat
tx = tx + dir[w][1]
ty = ty + dir[w][2]
if ScyndiHook[tx..","..ty] then hookpoint = {tx,ty} end
endreached = Maps.LayerValue(tx,ty,"Walls")~=0 or Maps.LayerValue(tx,ty,"Obstacles")~=0 or hookpoint or tx>=99 or ty>=99 or tx<=1 or ty<=1
tsx,tsy = Map2ScreenPos(tx,ty)
DrawScreen()
Image.Color(255,180,0)
Image.Line(psx,psy-16,tsx,tsy-16)
-- @IF DEVELOPMENT
DText("Whip at ("..tx..","..ty..")  Line ("..psx..","..psy..") to ("..tsx..","..tsy..")")
-- @FI
Flip()
until endreached
-- Go Scyndi Go
local px,py
if hookpoint then
   Actors.MoveTo(tx+stopwhip[w][1],ty+stopwhip[w][2])
   repeat
   px,py = PlayerCoords()
   psx,psy = Map2ScreenPos(px,py)
   Actors.Walk()
   DrawScreen()
   Image.Color(255,180,0)
   Image.Line(psx,psy-16,tsx,tsy-16)
   Flip()   
   until px==tx+stopwhip[w][1] and py==ty+stopwhip[w][2]
   end
end

function Scyndi_Get_Malabia()
local k,v
local total = 0
local avg
for k,v in ipairs(char.Scyndi.SkillLevels) do
    if k~=1 and k~=5 then total = total + v end
    end
avg = round(total / 3)
if avg<1 then avg=1 end
char.Scyndi.SkillLevels[5]     = avg
char.Scyndi.SkillNames[5]      = 'Malabia'
char.Scyndi.SkillExperience[5] = 0
skilllevelup.Scyndi(5)
end
