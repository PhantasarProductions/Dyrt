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
function GALE_OnLoad()
Music('The Snow Queen')
end

function NorthExit()
Maps.LoadMap("CH3_NAKEDROCKS")
SpawnPlayer('E')
Maps.CamY=0
end

function HookTutorial()
if CVV('&TUTOR.HOOK') then return end
Var.D('&TUTOR.HOOK','TRUE')
MapText('HOOK')
end

function Boss()
if CVV('&BOSS.BIGCRYSTAL') then return end
ClearBattleVars()
BattleInit('Num'    ,1)
BattleInit('Enemy1'       ,'BIGCRYSTAL')
BattleInit('Music'        ,'BOSS.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'NAKEDROCKSCAVE.PNG')
if not StartCombat() then return end
Var.D("&BOSS.BIGCRYSTAL","TRUE")
Maps.LayerDefValue(81,11,"Obstacles",0,1)
Var.D("&TOE.CH3_NAKEDROCKSCAVE","TRUE")
Var.D("&TOE.CH3_NAKEDROCKS","TRUE")
LAURA.ExecuteGame("ResetTOE")
end

function ToJennifer()
Maps.LoadMap("CH3_JENNIFER")
SpawnPlayer("FromCave")
Look(0x01)
if CVV("&DONE.JENNIFERENTERINTRO") then return end
Var.D( "&DONE.JENNIFERENTERINTRO","TRUE")
MapText("JENNIFER")
Var.D("&TOE.CH3_NAKEDROCKSCAVE","TRUE")
Var.D("&TOE.CH3_NAKEDROCKS","TRUE")
end

-- @USEDIR Scripts/Use/AnyWay
-- @USEDIR Scripts/USE/Maps
