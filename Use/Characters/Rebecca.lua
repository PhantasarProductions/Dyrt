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
 



Version: 14.04.20

]]
function setupchar.Rebecca()
char.Rebecca = 
  {
  ["Name"] = "$REBECCA",  
  ["Abilities"] = {},     -- Rebecca starts without any abilities, but will likely learn her first one soon :)    
  ["SkillNames"] = {"Sword Skills"},
  ["SkillLevels"] = {1},
  ["SkillExperience"] = {0}, 
  ["SkillFP"] = {4},  
  ["Experience"] = rand(1,4000),
  ["Victory"] = "It's done",
  ["Perfect"] = "That was pathetic",
  ["VicDead"] = "LetÕs not challenge opponents who are too strong for us"
  }
equip.Rebecca = 
  {
  ["WEAPON"] = "EQ_SY_WP_SHORTSWORD",
  ["ARMOR"]  = "EQ_SY_AR_ARMOR",
  ["JEWEL"]  = nil
  }
resistance.Rebecca =
  {
  ["FIRE"]          = 0,
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
  ["STCONFUSION"]   = 0,
  ["STSILENCE"]     = 0,
  ["STEXHAUST"]     = 0.12 / skill,
  ["STFEAR"]        = 0.30 / skill,
  ["STCURSE"]       = 0.03,
  ["STDEATH"]       = 0.60 - (skill*0.2),
  ["STDESTRUCTION"] = 0.80 - (skill*0.25)
  }
GrabLevelStats('Rebecca',char.Eric.Level+5)  
end


APRegen.Rebecca = {
    
    Interval = 2000,
    Time = 10000,
    AP = function()
         return rand(1,6/skill)
         end   
    }




function skilllevelup.Rebecca(skillnr)
char.Rebecca.TrophySkill = {"FIGHT"}
CSay('Debug: Yeah, Rebecca goes a level up in skill: '..skillnr)
-- 1 Weapon
local spells = {
      ['2XPS']          = { 1,  5 },
      ['3XPS']          = { 1, 20 },
      ['4XPS']          = { 1, 40 },
      ['BATTLECRY']     = { 1, 10 },
--    ['PROVOKE']       = { 1, 15 }
      }
AutoTeach('Rebecca',spells)
local resup = {'STFEAR'}
local r = rand(1,100)
if r>skill*30 then 
   resistance.Rebecca[resup[skillnr]] = resistance.Rebecca[resup[skillnr]] + 0.01
   if resistance.Rebecca[resup[skillnr]]>1 then resistance.Rebecca[resup[skillnr]]=1 end
   end   
end


function AfterAttack.Rebecca(TACT)
if TACT["TargetGroup"] == 'Player' or TACT["TargetGroup"] == 'Players' or TACT["TargetGroup"] == 'Hero' or TACT["TargetGroup"] == 'Heroes' then
   G = 'Player'   
   return -- No Strike Streak on players when confused.
   end
if TACT["TargetGroup"] == 'Enemy'  or TACT["TargetGroup"] == 'Enemies' or TACT["TargetGroup"] == 'Foe'  or TACT["TargetGroup"] ==   'Foes' then
   G = 'Foe'
   end
if StrikeStreakBusy then CSay("Strike Streak Request rejected. One is already going on!") return end
StrikeStreakBusy = true
local G
local rm = 5
local streak = 0
local ak
local chnRebecca
local foehp = Combat_GetHP("Foe",TACT.Target)
for ak=1,4 do
    if party[ak]=='Rebecca' then chnRebecca = ak end
    end
if not chnRebecca then Sys.Error("Tried to strike streak wile Rebecca is not at front. How odd.") end    
while rand(0,rm)==1 do
      streak = streak + 1
      rm = rm + 1
      end
CSay("Number of extra attacks in strike streak: "..streak)      
if streak>0 then
   if foehp>0 then Combat_Message("Strike Streak") end
   for ak=1,streak do 
       foehp = Combat_GetHP("Foe",TACT.Target)
       if foehp>0 then
          Combat_SpriteInAction("Player",chnRebecca,1) 
          Combat_Attack("Player",chnRebecca,TACT)
          Combat_SpriteInAction("Player",chnRebecca,2)           
          end 
       end
   end      
StrikeStreakBusy = false   
end

function levelup.Rebecca()
end
