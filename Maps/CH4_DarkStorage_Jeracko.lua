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
-- @USEDIR Scripts/use/anyway
-- @USEDIR Scripts/use/maps

function Bye()
Maps.LoadMap('CH4_DARKSTORAGE_MAIN')
SpawnPlayer('ExitJeracko')
end

function Boss()
if CVV('&DONE.BOSS.JERBOSSPAKHUIS') then return end
MapText('PREBOSS')
ClearBattleVars()
BattleInit('Music'        ,'Boss')
BattleInit("Arena"        ,"Storage_Jeracko.png")
BattleInit('Enemy5'       ,'SuperHag')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
if StartCombat() then Done('&DONE.BOSS.JERBOSSPAKHUIS'); Done('&TOE.CH4_DARKSTORAGE_JERACKO') end
LAURA.ExecuteGame('ResetTOE')
end

function Jeracko() -- Unlike the other three, Jeracko will immediately respond upon entering his room.
if CVV("&DONE.JERACKO2") then return end
repeat
Maps.CamY = Maps.CamY - 1
DrawScreen()
Flip()
until Maps.CamY<=528
PartyPop('Je','*bundle')
MapText('JERACKO')
PartyUnPop()
ClearBattleVars()
BattleInit('Music'        ,'OrderOfOnyx')
BattleInit("Arena"        ,"Storage_Jeracko.png")
BattleInit('Enemy5'       ,'Jeracko2')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('DefeatAction' ,'GameOver') -- Security measure due to the key stealing thing in this fight

if not StartCombat() then return end
Actors.Remove('Jeracko',1)
PartyPop('Je','*bundle')
MapText('AFTER')
PartyUnPop()
Done('&DONE.JERACKO2')
end


function GALE_OnLoad()
Music('Ooze')
ZA_Enter(0x20,Boss)
ZA_Enter(0x27,Jeracko)
end
