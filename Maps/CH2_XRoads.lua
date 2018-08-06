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
 



Version: 14.03.27

]]
-- @USEDIR Scripts/Use/AnyWay
function GALE_OnLoad()
Music("World")
DungeonTitle()
end


ExitReveal = { N = {}, S = {'CRYPT','FRENDOR'}, W = {'EXAMRUINS','XENOR','XENORBUSHES','XENORBUSHESNORTH','XENORBUSHESWEST'} }

function Exit(wind)
local m
for _,m in ipairs(ExitReveal[wind]) do 
    CSay("Let's reveal: "..m)
    WorldMap_Reveal('Delisto',m)   
    end
WorldMap()    
end

function MadHouse()
Maps.LoadMap("CH2_MadHouse")
SpawnPlayer("Start")
end
