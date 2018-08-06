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
 



Version: 14.05.24

]]
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps

function Bye()
WorldMap()
end


-- Stone Masters
function ACTOR_FEENALARIA()
if not CVV("&SPOKEN.FEENALARIA") then
   if GetActiveChar()~="Irravonia" then return MapText("FEENA.NOTIRRA") end
   MapText("FEENA.IRRAFIRST")
   Var.D("&SPOKEN.FEENALARIA","TRUE")
   else
   MapText("FEENA")
   end
StoneMaster("Feenalaria")
end

function ACTOR_TEPHONDAR()
MapText("TEPHONDAR."..Str.Upper(GetActiveChar()))
StoneMaster("Tephondar")
end


-- Regular NPCs
function ACTOR_YANNEE()
if GetActiveChar()=="Irravonia" then MapText("YANNEE.IRRA") else MapText("YANNEE.NOTIRRA") end
end

-- Non-importance NPCs
function ACTOR_LONA() MapText("LONA") end
function ACTOR_RONA() MapText("RONA") end
function ACTOR_JYNO() MapText("JYNO") end
function ACTOR_YOUK() MapText("YOUK") end

-- Just the silly onload, yeah it needs to be there, eh?
function GALE_OnLoad()
DungeonTitle()
Music("Enchanted Valley")
end
