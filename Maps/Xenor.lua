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
 



Version: 14.04.20

]]
function GALE_OnLoad()
Music("Oregon.ogg")
end

function Bye()
WorldMap()
end


function EnterEricRebeccaHome()
Maps.LoadMap('EricRebeccaHome')
SpawnPlayer('Entrance')
SpawnActor('Wendy',{['ID']='WENDY',['SinglePic']='NPC/Wendy.png'})
end


-- NPC Characters

function ACTOR_MIRANDA()
MapText("MIRANDA."..Str.Upper(GetActiveChar()))
end

function ACTOR_GEORGE()
MapText("GEORGE")
end

-- Shelley the Shopkeeper
function ACTOR_SHELLEY()
MapText("SHELLEY")
Shop("SHELLEY")
end

-- Dagobert the banker
function ACTOR_DAGOBERT()
MapText("DAGOBERT")
Bank()
end

-- Mariska the child
function ACTOR_MARISKA()
MapText("MARISKA")
MapText("MARISKA."..upper(GetActiveChar()))
end

function ACTOR_DAISY()
MapText("DAISY")
end

-- @USEDIR SCRIPTS/USE/ANYWAY
-- @USEDIR SCRIPTS/USE/MAPS
