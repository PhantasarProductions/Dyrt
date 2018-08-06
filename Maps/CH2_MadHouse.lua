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
 



Version: 14.11.13

]]
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps

function IrraCheck()
ScanParty()
if not(CVV("&INPARTY.IRRAVONIA")) then
   MapText("NO_IRRA")
   Bye()
   end  
end

function GALE_OnLoad()
Music("Fun in a Bottle")
if (not CVV("&DONE.MADHOUSE.INTRO")) then
   Look(1)
   Maps.CamX = 1
   Maps.CamY = 1
   Var.D("&DONE.MADHOUSE.INTRO","TRUE")
   MapText("SECSCE")
   end
DungeonTitle()
local ak
for ak=0,0xff do ZA_Enter(ak,IrraCheck) end
end


function Bye()
Maps.LoadMap("CH2_XRoads")
SpawnPlayer("FromMadHouse")
end   

function WarningSign()
MapText("WARNING")
end

function Complete()
LAURA.ExecuteGame("AwardTrophy","SD_MADHOUSE")
end

function Boss()
if CVV("&DONE.BOSSCREEP") then return end
ClearBattleVars()
BattleInit('Num'    ,2)
BattleInit('Enemy5'       ,'CREEP')
BattleInit('Music'        ,'BOSS.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'MADHOUSE.PNG')
if StartCombat() then
   Var.D("&DONE.BOSSCREEP","TRUE")
   end
end
