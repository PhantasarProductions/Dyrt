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
-- @USEDIR Scripts/USE/AnyWay
-- @USEDIR Scripts/USE/Maps

function GALE_OnLoad()
Music('Pippin the Hunchback')
Look(0)
Maps.CamX=1
Maps.CamY=1
-- @IF !CHAPTER2
   MapText('CHAPTER2.')
-- @FI
if (not CVV('&DONE.DRAGONCRACK.INTRO')) then
   Var.D('&DONE.DRAGONCRACK.INTRO','TRUE')
   PartyPop('Start_','*bundle',{'Eric','Irravonia','Brendor','Scyndi','Rebecca'})
   MapText('A')
   PartyUnPop()
   Chapter(2)
   end   
DungeonTitle()   
end

function GALE_OnUnload()
CSay('Byebye, Dragon Crack Forest')
end

function Exit()
WorldMap()
end


function ToRedDragon()
if CVV("&DONE.TOREDDRAGON") then
   WorldMap()
   return
   end
-- From now on, random encounters can be skipped in the next dungeons:   
Var.D("&DONE.TOREDDRAGON","TRUE")
Var.D("&TOE.BUSHES","TRUE")
Var.D("&TOE.BUSHESNORTH","TRUE")
Var.D("&TOE.BUSHESWEST","TRUE")
Var.D("&TOE.EXAMRUINS","TRUE")
Var.D("&TOE.MYSTERIOUSCRYPT","TRUE")
Var.D("&TOE.PRISON","TRUE")
Var.D("&TOE.CH2_DRAGONCRACKFOREST","TRUE")
-- Well, that being set straight, let's move on to the next part. The Epilogue
Maps.LoadMap("CH2_DRAGONCRACKFORESTEPILOGUE")   
Look(0)
local P = {"Eric","Irravonia","Rebecca","Brendor","Scyndi"}
local C
Maps.CamX = 32
Maps.CamY = 32
MapText("END_A")
-- CRACK!!!
for _,C in ipairs(P) do Actors.DeSpawn(C) end
Maps.LayerDefValue(11,5,'FloorDeco',0xff)
MapText("END_B")
-- Inside the cave
Maps.LoadMap("CH2_REDDRAGONCAVE")
Look(0)
Maps.CamX = 1200
Maps.CamY = 1328
MapText("END_C")
for _,C in ipairs(P) do Actors.DeSpawn(C) end
SpawnPlayer("Start")
DungeonTitle()
Maps.BuildBlockMap()
end   
