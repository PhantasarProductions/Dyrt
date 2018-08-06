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
SpawnPlayer('ExitAldarus')
end

function Boss()
if CVV('&DONE.BOSS.GIANTSQUID') then Done('&TOE.CH4_DARKSTORAGE_ALDARUS') LAURA.ExecuteGame('ResetTOE') return end
MapText('KANTINE')
ClearBattleVars()
BattleInit('Music'        ,'Boss')
BattleInit("Arena"        ,"Storage_Aldarus.png")
BattleInit('Enemy5'       ,'GiantSquid')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
if StartCombat() then Done('&DONE.BOSS.GIANTSQUID'); Done('&TOE.CH4_DARKSTORAGE_ALDARUS') end
LAURA.ExecuteGame('ResetTOE')
end

function ACTOR_ALDARUS()
PartyPop('Al','*bundle')
MapText('ALDARUS')
PartyUnPop()
ClearBattleVars()
BattleInit('Music'        ,'OrderOfOnyx')
BattleInit("Arena"        ,"Storage_Aldarus.png")
BattleInit('Enemy5'       ,'Aldarus2')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('DefeatAction' ,'GameOver') -- Security measure due to the key stealing thing in this fight
if not StartCombat() then return end
Actors.Remove('Aldarus',1)
PartyPop('Al','*bundle')
MapText('AFTER')
PartyUnPop()
end


function GALE_OnLoad()
Music('Prisoner of war - Jail - Widzy')
ZA_Enter(0x0a,Boss)
end
