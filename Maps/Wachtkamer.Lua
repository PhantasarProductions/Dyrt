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

--[[


     This script belongs to the map "Wachtkamer" 
     which basically means "Waiting Room" in Dutch.
     
     Whenever the player reaches a point that has not 
     yet been developped (basically at the start of a
     new chapter of which the development has just
     begun, the player will end up here.
     
     Banthosor can provide a tiny preview on what
     the player will await in the next chapter 
     once its development has been completed.
     
     Shanda will act as a gatekeeper. Just
     remains silent when the chapter is not 
     yet ready. Allowing the player to resume the game
     once the chapter is available to be played.
     
]]

-- @USEDIR Scripts/Use/AnyWAY
-- @USEDIR Scripts/Use/Maps

function GALE_OnLoad()
Music("The Waiting Room (Calmer Indoors)")
Look(1)
Maps.CamX = 16
Maps.CamY = 1
if not (CVV("&DONE.WACHTKAMER.INTRO")) then
   -- @IF !CHAPTER2
   SpawnPlayer("Start")
   -- @FI
   MapText("INTRO")
   Var.D("&DONE.WACHTKAMER.INTRO","TRUE")
   end
end     

function GALE_OnUnload()
CSay("Well, we're done waiting. Let's play!")
end

function ACTOR_BANTHOSOR()
MapText("PREVIEW"..CVV("%NEXTCHAPTER")..".")
end

-- The scripts in this function should be defined depending on the chapters currently available.
function ACTOR_SHANDA()
-- @IF CHAPTER2
if CVV('%NEXTCHAPTER')==nil or CVV('%NEXTCHAPTER')==2 then
   MapText("NEXT")
   if BoxQuestion(MapTextArray,"NEXTQ")==1 then LAURA.Shell('StartChapter2.lua') end
   return
   end
-- @FI
-- @IF CHAPTER3
if CVV('%NEXTCHAPTER')==3 then
   MapText("NEXT")
   if BoxQuestion(MapTextArray,"NEXTQ")==1 then LAURA.Shell('StartChapter3.lua') end
   return
   end
-- @FI
-- @IF CHAPTER4
if CVV('%NEXTCHAPTER')==4 then
   MapText("NEXT")
   if BoxQuestion(MapTextArray,"NEXTQ")==1 then LAURA.Shell('StartChapter4.lua') end
   return
   end
-- @FI
-- @IF CHAPTER5
if CVV('%NEXTCHAPTER')==5 then
   MapText("NEXT")
   if BoxQuestion(MapTextArray,"NEXTQ")==1 then LAURA.Shell('StartChapter5.lua') end
   return
   end
-- @FI
MapText("NOGO")
end

function ACTOR_ELDER()
MapText("ELDER")
LAURA.ExecuteGame("ShowCredits")
end
