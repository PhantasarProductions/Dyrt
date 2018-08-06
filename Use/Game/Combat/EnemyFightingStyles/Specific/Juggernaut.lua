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
Juggernaut_Spot = 5

Juggernaut_Abilities = {

     Solo = {"MARKRUTTE"},
     
     Attack = {
            -- Fire
            "FIRE","FIRE","FIRE","FIRE","FIRE","FIRE",
            "INFERNO","INFERNO","INFERNO",
            "DEATHFIRE","DEATHFIRE",
            "HELL",
            -- Water
            "WATER","WATER","WATER","WATER","WATER",
            "TSUNAMI","TSUNAMI","TSUNAMI",
            "DROWN","DROWN",
            -- Wind
            "BLOW","BLOW","BLOW","BLOW","BLOW","BLOW",
            "STORM","STORM","STORM",
            "HURRICANE","HURRICANE",
            -- Earth
            "ROCK","ROCK","ROCK","ROCK","ROCK","ROCK",
            "QUAKE","QUAKE","QUAKE",
            "KILLER_ROCK","KILLER_ROCK",
            -- Lightning
            "SPARK","SPARK","SPARK","SPARK","SPARK","SPARK",
            "LIGNTNING","LIGHTNING","LIGHTNING",
            "MYOLLNIR","MYOLLNIR",
            -- Frost
            "COLD","COLD","COLD","COLD","COLD","COLD",
            "BLIZZARD","BLIZZARD","BLIZZARD",
            "VERYCOLD","VERYCOLD",           
            -- Darkness           
            "DARKNESS","DARKNESS","DARKNESS","DARKNESS",
            "POWEROFEVIL","POWEROFEVIL","POWEROFEVIL",
            "VOID"             
        },
     Heal = {
           "HEAL","HEAL","HEAL","HEAL","HEAL","HEAL","HEAL",
           "RECOVER","RECOVER",
           "CURE"
     },   
     Status = {
           "POISON",
           "DISEASE",
           "PARALYSE",
           "CONFUSE",
           "CURSE",
           "DEATH",
           "DESTRUCTION",
           "EXHAUST",
           "FEAR",
           "SILENCE",
           "SLEEP"
           }

}
function E_IMove.Juggernaut(ACTOR)
local ok,tgt
local timeout=0
ok=true
repeat 
   -- Enter "JUG"
   FoeAct = FoeAct or {}
   FoeAct[ACTOR]                 = {}
   FoeAct[ACTOR].Action          = 'JUG'
   FoeAct[ACTOR].TargetGroup     = 'Heroes'
   FoeAct[ACTOR].Target          = rand(1,4)
   FoeAct[ACTOR].ActSpeed        = 250
   tgt = FoeAct[ACTOR].Target
   --ok = party[tgt] and char[party[tgt]].HP[1]>0
   -- end of entering move. 
--timeout = timeout + 1
--if timeout > 100000 then Sys.Error('Juggernaut setup timeout') end
-- Timeout set on 'rem' just in case, but it should not be needed here. 
until ok
end 

function Juggernaut_Attack()
local jugact = FoeAct[Juggernaut_Spot]
local action,actions
local timeout,ok,tgt
local solo
local key
timeout=0
repeat
if rand(1,30/skill)==1 then 
   -- Only one move
   action = {
         Action         = "ABL",
         TargetGroup    = "Heroes",
         Target         = rand(1,4),
         ActSpeed       = 250,
         Ability        = "JUG_"..Juggernaut_Abilities.Solo[rand(1,#Juggernaut_Abilities.Solo)]
      }
   tgt = action.Target
   ok = party[tgt] and char[party[tgt]].HP[1]>0
   solo = true      
   actions = {action}
   else
   -- The 3 way combo
   solo=false
   ok=true
   actions = {}
   for _,key in ipairs({"Attack","Status","Heal"}) do
       action = {
         Action         = "ABL",
         TargetGroup    = "Heroes",
         Target         = rand(1,4),
         ActSpeed       = 250,
         Ability        = "JUG_"..Juggernaut_Abilities[key][rand(1,#Juggernaut_Abilities[key])]
         }
       table.insert(actions,action)
       if key=="Heal" then 
          action.TargetGroup = "Foes"
          action.Target      = Juggernaut_Spot
          else
          tgt = action.Target
          ok = ok and party[tgt] and char[party[tgt]].HP[1]>0
          end                
       end   
   end
timeout = timeout + 1
if timeout > 100000 then Sys.Error('Juggernaut execution timeout') end    
until ok
-- All setup, let's roll 'em, boys!   
for _,action in ipairs(actions) do
    Combat_Ability("Foes",Juggernaut_Spot,action)
    end
end
