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
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps


function ESouth()
WorldMap("CAT-ISLAND") 
end

function ENorth()
WorldMap_Reveal("CAT-ISLAND","FRUNDARMON")
WorldMap("CAT-ISLAND") 
end

function FirstVisit()
if not ESD then 
   ZA_Enter(0x01,ESouth)
   ESD = true
   end
if Done("&DONE.PURPLEFOREST.FIRSTENTER") then return end
local sy = Maps.CamY
local ey = Maps.CamY-1000
local ay
for ay=sy,ey,-2 do
    Maps.CamY=ay
    DrawScreen()
    Flip()
    end
MapText("PURPLE")
end

function TOE()
Done("&TOE.CH4_PURPLEFOREST")
LAURA.ExecuteGame("ResetTOE")
end

function GALE_OnLoad()
Music("How did I get down here")
ZA_Enter(0x00,FirstVisit)
ZA_Enter(0x04,ENorth)
ZA_Enter(0x03,TOE)
end
