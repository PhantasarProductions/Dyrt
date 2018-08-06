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
 



Version: 14.09.13

]]
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps


function BossSheckLock()
if CVV("&DONE.SHECKLOCK3") then return end
PartyPop("Sh","*bundle")
MapText("SHECKBOSS")
PartyUnPop()
ClearBattleVars()
BattleInit('Music'        ,'Monkeys Spinning Monkeys')
BattleInit("Arena"        ,"Forest.png")
BattleInit("Enemy5"       ,"SHECKLOCK3")
BattleInit('VictoryTune'  ,'VICTORY.OGG')
if not StartCombat() then return end
PartyPop("Sh","*bundle")
MapText("SHECKAFTER")
PartyUnPop()
Done("&DONE.SHECKLOCK3")
end

function ACTOR_SHECKLOCK()
MapText("SHECKSTONE")
StoneMaster("Sheck-Lock")
end

function EndLevel()
Var.D("&TOE.CH4_FRENDORBUSHES","TRUE")
WorldMap_Reveal("DELISTO","BLACKPRISON")
WorldMap()
end

function GALE_OnLoad()
Music("Pippin the hunchback")
ZA_Enter(0x05,BossSheckLock)
ZA_Enter(0x01,WorldMap)
ZA_Enter(0x03,EndLevel)
end
