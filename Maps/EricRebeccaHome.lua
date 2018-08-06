--[[
/**********************************************
  
  (c) Jeroen Broks, 2013, All Rights Reserved.
  
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
 



Version: 14.04.20

]]
function GALE_OnLoad(...)
Console.Write('Eric and Rebecca welcome you into their house',184,10,198)
Music('Calm Indoors')
end

function GALE_OnUnload(...)
Console.Write('Eric and Rebecca say goodbye',58,60,122)
end

function Exit()
Maps.LoadMap("Xenor")
SpawnPlayer("LeaveHouse")
end

function ACTOR_WENDY()
if not CVV("&DONE.WENDYINTRO") then
   MapText("WENDY."..Str.Upper(GetActiveChar()))
   if GetActiveChar()=="Rebecca" then Var.D("&DONE.WENDYINTRO","TRUE") end
   end
if CVV("&DONE.WENDYINTRO") then
   MapText("WENDY.STONE")
   StoneMaster("Wendy")
   end   
end

-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Map
