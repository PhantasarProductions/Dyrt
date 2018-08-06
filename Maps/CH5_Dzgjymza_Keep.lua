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
 



Version: 14.11.02

]]
-- @USE USE.LUA

function Room_Main()
if not Done("&DONE.DZGJYMZA.KEEP.WELCOME") then
   PartyPop("Begin","*bundle")
   MapText("WELCOME")
   PartyUnPop()
   end
if not DreadPlay then Music("TheDread") end
end

function Room_Weniaria()
Music("Angevin")
DreadPlay = nil -- This line makes sure "The Dread" resumes to play when the player leaves Weniaria's Sanctum.
end

function Sokkel(name)
MapText("SOKKEL_"..upper(name))
end

function Bye()
WorldMap("DYRT")
end


function Up(W)
Maps.LoadRoom("CH5_DZGJYMZA_UPSTAIRS")
SpawnPlayer(W.."Start")
end

function GALE_OnLoad()
local ak
local mainrooms = {1,2,3,4,5,6,8}
for _,ak in ipairs(mainrooms) do ZA_Enter(ak,Room_Main) end
ZA_Enter(0x07,Room_Weniaria)
ZA_Enter(0xff,Bye)
end
