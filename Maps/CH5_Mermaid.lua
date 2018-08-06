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
-- @USE use.lua


function ACTOR_NIKKI() MapText("NIKKI") end


function ACTOR_ARIEL() -- Ariel is the one to transport you between Dyrt and Delisto
MapText("ARIEALREADY") -- Typo in the language files, too much hassle to fix and the players won't see it anyway :P
local go2dyrt = BoxQuestion(MapTextArray,"ARIELQUESTION1")
if go2dyrt~=1 then return end
if not Done("&DONE.INTRO.ARIEL") then
   Actors.Pick("Player")
   Actors.ChoosePic("Yasathar."..Actors.PA_Wind()) 
   MapText("ARIELINTRO") 
   end
Maps.LoadMap("CH5_Dyrt_Beach")
SpawnPlayer("MermaidStart")
LAURA.ExecuteGame("GameFieldMessage","The Forgotten Kingdom of Dyrt")
end


function GALE_OnLoad()
ZA_Enter(0x01,WorldMap)
Music("AcidJazz")
Done("&CATININDEPENEDENCE")
end
