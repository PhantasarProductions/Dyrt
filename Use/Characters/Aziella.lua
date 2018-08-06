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
-- All these definitions will be ignored by GALE, but my IDE won't and so I can fool it so it outlines this script the way it should :P
setupchar = {}
char = {}
equip = {}
resistance = {}
APRegen = {}
skilllevelup = {}
-- @FI

function setupchar.Aziella()
char.Aziella = 
  {
  ["Name"] = "$AZIELLA",
  ["Abilities"] = {"PIERCE","HEAL","PROTECT"},
  --["AblTime"] = {10,10,10,10},
  ["SkillNames"] = {"Crossbow Skills","Befindo Enchants"},
  ["SkillLevels"] = {36/skill,5},
  ["SkillExperience"] = {50,15-skill}, 
  ["Experience"] = 3000 * (skill*skill),
  ["SkillFP"] = {0,5},
  ["Victory"] = "In honor of the king!",
  ["Perfect"] = "I shouldn't kill harmless creatures!",
  ["VicDead"] = "I need more training!"  
  }
if char.Aziella.SkillLevels[1]>=10 then table.insert(char.Aziella.Abilities,2,"VENOMSHOT") end  
if char.Aziella.SkillLevels[1]>=36 then table.insert(char.Aziella.Abilities,2,"SHOWER") end  
equip.Aziella = 
  {
  ["WEAPON"] = "EQ_AZ_WP_BOLT",
  ["ARMOR"]  = "EQ_AZ_AR_TOGA",
  ["JEWEL"]  = nil  
  }
resistance.Aziella =
  {
  ["FIRE"]          = 0.12/skill,
  ["WIND"]          = 0,
  ["WATER"]         = 0,
  ["EARTH"]         = 0,
  ["LIGHT"]         = 0,
  ["DARKNESS"]      = 0,
  ["THUNDER"]       = 0,
  ["FROST"]         = 0,
  ["STPOISON"]      = 0,
  ["STPARALYSIS"]   = 0,
  ["STSLEEP"]       = 0,
  ["STCONFUSION"]   = 0.7, 
  ["STSILENCE"]     = 0,
  ["STEXHAUST"]     = 0.36 - (skill*0.06),
  ["STFEAR"]        = 0.30 - (skill*0.10),
  ["STCURSE"]       = 0.36 / skill,
  ["STDEATH"]       = 0.50 - (skill*0.2),
  ["STDESTRUCTION"] = 0.50 - (skill*0.2)
  }
local AzLevel=30
local ch,dat
local bannedch = {"YoungIrravonia","Shanda","Kirana","Aziella"}
local AzMax = {200,90,44}
for ch,dat in pairs(char) do
    if not tablecontains(bannedch,ch) then
       if dat.Level>AzLevel then AzLevel = dat.Level end
       end
    end  
AzLevel=AzLevel+5
if AzLevel>AzMax[skill] then AzLevel=AzMax[skill] end
CSay("Aziella's level has been set to "..AzLevel)    
GrabLevelStats('Aziella',AzLevel)   
end


APRegen.Aziella = {
    
    Interval = 350*(skill or 3),
    Time = 15000,
    AP = function()
         local s = char.Aziella.Level
         local ak,v
         for ak,v in pairs(char.Aziella.SkillLevels) do 
             s = s + v
             if ak==2 then s = s + v end 
             end         
         return math.floor(s / (skill*15))
         end   
    }


function levelup.Aziella()

end

function skilllevelup.Aziella(skillnr)
CSay('Debug: Yeah, Aziella goes a level up in skill: '..skillnr)
char.Aziella.TrophySkill = {"FIGHT","ENCHANT"}
-- 1 Weapon
-- 2 Fire
-- 3 Wind
-- 4 Water
-- 5 Earth
local spells = {
      -- Crossbow
      VENOMSHOT     = {1,10},
      SHOWER        = {1,30},
      -- Befindo Enchants
      PROTECT       = {2,4},
      SHIELD        = {2,6},
      HYPER         = {2,7},
      ACCELERATOR   = {2,9},
      BLUNT         = {2,11},
--    PERMANENCE    = {2,12},  -- Removed! See Buff and Debuf section for details.
      REMCURSE      = {2,12},
      SLEEP         = {2,14},
      DISPEL        = {2,15}
      }
if skill==1 then spells.PERMANENCE=nil end      
AutoTeach('Aziella',spells)
local resup = {'STFEAR','STCONFUSION'}
if skillnr>1 and skillnr<5 then
   local r = rand(1,100)
   if r>skill*30 then 
      resistance.Aziella[resup[skillnr]] = resistance.Aziella[resup[skillnr]] + 0.01
      if resistance.Aziella[resup[skillnr]]>1 then resistance.Aziella[resup[skillnr]]=1 end
      end 
   end   
end
