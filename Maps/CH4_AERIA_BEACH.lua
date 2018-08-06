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

function GALE_OnLoad()
Music("Ocean-Waves-1")
end

function STARTCHAPTERFOUR()
Chapter(4)
local SGuard
for ak=1,7 do
    SGuard = {
         ID = 'Guard'..ak,
         SinglePic = 'TownPeople/BefindoGuard.png'
      }
    SpawnActor("Guard"..ak,SGuard)
    end
PartyPop("St","*bundle")
Look(0)
Maps.CamX=16
Maps.CamY=16
MapText("WELCOME1.")
Actors.Pick("StAziella")
Actors.ChoosePic("Aziella.South")
MapText("WELCOME2.")
PartyUnPop()
Maps.LoadMap("CH4_Rayal_Palace")
SpawnPlayer("Start")
Look(2)
MapText("WELCOME3.")
-- Sys.Error("Next part not yet scripted")    
end

letsgo = {
   function() Maps.LoadMap("CH3_Indiecity") SpawnPlayer('FlyStart') end,
   function() Maps.LoadMap("CH4_CatBeach")  SpawnPlayer('FlyStart') end,
   function() end
}

function ACTOR_GUARD()
local go = BoxQuestion(MapTextArray,"WHERETO1")
letsgo[go]()
end
