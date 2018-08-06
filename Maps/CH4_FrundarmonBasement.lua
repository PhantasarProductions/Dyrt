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
 



Version: 14.09.10

]]
-- @USEDIR Scripts/Use/AnyWay
-- @USEDIR Scripts/Use/Maps

FrundarmonDefeated = "&DONE.FRUNDARMON.DEFEATED"



function Welcome()
if not donewelcome then MapText("WELCOME") end
donewelcome = true
end

function ScyndiNoUse()
MapText("SCYNDINOUSE")
end


function Bye()
Maps.LoadMap("CH4_FRUNDARMON")
SpawnPlayer("FromBasement")
end

function Complete()
LAURA.ExecuteGame("AwardTrophy","SD_FRUNDARMONBASEMENT")
Done("&TOE.CH4_FRUNDARMONBASEMENT")
LAURA.ExecuteGame("ResetTOE")
end

function Boss()
if CVV("&BOSS.LICHKING") then return end
ClearBattleVars()
BattleInit('Num'    ,2)
BattleInit('Enemy5'       ,'LICHKING')
BattleInit('Music'        ,'BOSS.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'PRISON.PNG')
if not StartCombat() then return end
Done("&BOSS.LICHKING")
end

function GALE_OnLoad()
Music("Tempting Secrets")
if not Done("&DONE.WELCOME.FRUNDARMONBASEMENT") then ZA_Enter(0x01,Welcome) end
if not CVV(FrundarmonDefeated) then ZA_Enter(0x02,ScyndiNoUse) end
ZA_Enter(0xFC,Complete)
ZA_Enter(0x19,Boss)
end 
