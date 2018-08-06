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
SpawnPlayer('ExitKirana')
end

function Boss()
if CVV('&DONE.BOSS.GRWOL') then Done('&TOE.CH4_DARKSTORAGE_KIRANA') LAURA.ExecuteGame('ResetTOE') return end
MapText('PREBOSS')
ClearBattleVars()
BattleInit('Music'        ,'Boss')
BattleInit("Arena"        ,"Storage_Kirana.png")
BattleInit('Enemy5'       ,'Grwol')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
if StartCombat() then Done('&DONE.BOSS.GRWOL'); Done('&TOE.CH4_DARKSTORAGE_Kirana') end
LAURA.ExecuteGame('ResetTOE')
end

function ACTOR_KIRANA()
PartyPop('Ki','*bundle')
MapText('KIRANA')
PartyUnPop()
ClearBattleVars()
BattleInit('Music'        ,'OrderOfOnyx')
BattleInit("Arena"        ,"Storage_Kirana.png")
BattleInit('Enemy5'       ,'Kirana2')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('DefeatAction' ,'GameOver') -- Security measure due to the key stealing thing in this fight
if not StartCombat() then return end
Actors.Remove('Kirana',1)
PartyPop('Ki','*bundle')
MapText('AFTER')
PartyUnPop()
end


function GALE_OnLoad()
Music('dungeon1')
ZA_Enter(0x33,Boss)
end
