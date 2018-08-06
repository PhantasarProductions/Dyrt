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
function SheckLock()
if CVV("&DONE.BOSS.SHECKLOCK2") then return end
PartyPop("SL","*bundle")
MapText("SHECKLOCK")
ClearBattleVars()
BattleInit('Num'    ,2)
BattleInit('Enemy5'       ,'SHECKLOCK2')
BattleInit('Music'        ,'Monkeys Spinning Monkeys.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'MARSHES.PNG')
if not StartCombat() then return false end
Actors.Remove("SHECKLOCK",1)
Var.D("&DONE.BOSS.SHECKLOCK2","TRUE")
MapText("NASHECKLOCK")
PartyUnPop()
end

--[[
function CompleteDungeon()
WorldMap()
end
]]

function Dernor_Tutorial()
if not Done("&DONE.TUTORIAL.DERNOR.MARSHES") then MapText("DERNOR_TUTORIAL") end
end

function Boss()
if CVV("&DONE.BOSS.SALAMANDER") then return end
ClearBattleVars()
BattleInit('Num'    ,2)
BattleInit('Enemy5'       ,'BIGSALAMANDER')
BattleInit('Music'        ,'Boss.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'MARSHES.PNG')
if not StartCombat() then return false end
Var.D("&DONE.BOSS.SALAMANDER","TRUE")
end


function EnterTemple()
Music('Angevin')
Var.D("&SCYNDIHAS.HANDOSTILLOR","TRUE")
if Done("&DONE.HANDOSTILLOR") then return end
PartyPop('Stillor','*bundle')
MapText('STILLOR_A')
DrawScreen()
Flip()
Time.Sleep(2500)
MapText('STILLOR_B')
NewSpellGroup("Scyndi",3,"Hando Stillor",1)
PartyUnPop()
Var.D("&TOE.CH3_MARSHES","TRUE")
LAURA.ExecuteGame("ResetTOE")
end

function LeaveTemple()
Music('Ooze')
end

function GALE_OnLoad()
Music("Ooze")
if not CVV("&DONE.BOSS.SHECKLOCK2") then ZA_Enter(0xff,SheckLock) end
ZA_Enter(0x09,EnterTemple)
ZA_Enter(0xfe,WorldMap)
-- ZA_Enter(0xfd,CompleteDungeon)
ZA_Leave(0x09,LeaveTemple)
end


-- @USEDIR Scripts/Use/Anyway/
-- @USEDIR Scripts/Use/Maps/
