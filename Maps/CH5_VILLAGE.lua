--[[
/**********************************************
  
  (c) Jeroen Broks, 2015, All Rights Reserved.
  
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
 



Version: 14.10.22

]]
-- @USE use.lua


-- General NPCs
function ACTOR_CYNTHIA() MapText("CYNTHIA") end
function ACTOR_IVO()     MapText("IVO")     end
function ACTOR_STEFAN()  MapText("STEFAN")  end
function ACTOR_DENNIS()  MapText("DENNIS")  end
function ACTOR_BAS()     MapText("BAS")     end


-- Service NPCs
function ACTOR_MICHAEL() MapText("MICHAEL") Shop("MICHAEL") end -- Items
function ACTOR_ESTHER()  MapText("ESTHER")  Shop("ESTHER")  end -- Weapons
function ACTOR_CINDY()   MapText("CINDY")   Bank()          end -- Bank
function ACTOR_ASTRID()  MapText("ASTRID")  Shop("ASTRID")  end -- Armor

-- TOE Service
function ACTOR_JURGEN()
if CVV("&TOE.CH5_VILLAGE") then
  MapText("JURGENYES")
  return
  end
MapText("JURGEN")
local letsdoit = BoxQuestion(MapTextArray,"TOE1")
if letsdoit~=1 then
   MapText("JURGENNO")
   return
   end
if Pay(20000) then
   MapText("JURGENYES")
   Done("&TOE.CH5_VILLAGE")
   LAURA.ExecuteGame("ResetTOE")
   else
   MapText("JURGENNOCASH")
   end   
end

function WExit()
WorldMap("DYRT")
end

function NExit()
WorldMap_Reveal("DYRT","DEATHCAVE")
WorldMap("DYRT")
end

function EExit()
WorldMap_Reveal("DYRT","KEEP")
WorldMap("DYRT")
end
function GALE_OnLoad()
Music("Tempting Secrets")
ZA_Enter(0x04,NExit)
ZA_Enter(0x05,EExit)
ZA_Enter(0x06,WExit)
end
