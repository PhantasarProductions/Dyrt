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
function A_Go(x,y)
Actors.Pick("Player")
local bx = Actors.PA_X()
local by = Actors.PA_Y()
Actors.WalkTo(bx+x,by+y)
end

function Bye()
WorldMap("AERIA")
end

function Welcome()
if not Done("&DONE.WELCOME.RAYAL") then MapText("WELCOME") end
end

-- No go areas
function Voogelaer()
MapText("VOOGELAER"); A_Go(1,0)
end

function Waznabaer()
MapText("WAZNABAER"); A_Go(-1,0)
end

function Fly()
MapText("FLY"); A_Go(0,-1)
end

-- Stand holders
function Klazien()
MapText("KLAZIEN")
Shop("KLAZIEN")
end

function Gerard()
MapText("GERARD")
end

function Clam()
MapText("CLAM")
Shop("CLAM")
end

function Rayfey()
MapText("RAYFEY")
Bank()
end

-- NPCs
function ACTOR_GUARD() MapText("GUARD") end -- This function will apply for ALL guards.

function ACTOR_TAMARA() MapText("TAMARA") end 
function ACTOR_ZYONA() MapText("ZYONA") end
function ACTOR_LUCAS() MapText("LUCAS") end
function ACTOR_GNOOK() MapText("GNOOK") end


function GALE_OnLoad()
CSay("Welcome to Rayal")
Music("Divertimento K131")
ZA_Enter(0x00,Bye) -- This is to kick any party out of town who'd end up in the placeholder location during the alpha stage. Only used for debug purposes.
ZA_Enter(0x04,Bye)
ZA_Enter(0x05,Voogelaer)
ZA_Enter(0x06,Waznabaer)
ZA_Enter(0x07,Fly)
ZA_Enter(0x03,Welcome)
end


-- @USEDIR Scripts/Use/AnyWay
-- @USEDIR Scripts/Use/Maps
