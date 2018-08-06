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
 



Version: 14.08.22

]]
-- @USEDIR Scripts/use/Anyway
-- @USEDIR SCRIPTS/use/MAPS

function Bye()
WorldMap('AERIA')
end

function RevealCave()
WorldMap_Reveal("AERIA","MALABIACAVE")
end

function Boss()
if CVV("&DONE.FRUSKBRANDOBOSS") then return end 
ClearBattleVars()
BattleInit('Enemy6'       ,'BIGDEMONAIR')
BattleInit('Music'        ,'BOSS.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'FOREST_DEAD_GRASS.PNG')
local victory = StartCombat()
if victory then Var.D("&DONE.FRUSKBRANDOBOSS","TRUE") end
end

function GALE_OnLoad()
Music("The Complex")
if not Done("&DONE.FIRSTENTER.FRUSKBRANDO") then
   Maps.CamX=0
   Maps.CamY=0
   Look(0)
   PartyPop("W","*bundle")
   MapText("WELCOME")
   PartyUnPop()
   end
DungeonTitle()
ZA_Enter(0x05,{RevealCave,Bye})
ZA_Enter(0x06,Bye)   
end

