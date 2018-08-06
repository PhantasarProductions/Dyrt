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

FrundarmonDefeated = "&DONE.FRUNDARMON.DEFEATED"


function Goodbye()
WorldMap("CAT-ISLAND")
end

function EntranceParty()
local ak
if Done("&DONE.FIRST.FELIXIUMENTER") then return end
Maps.CamY = 1552
Look(0)
MapText("BINNENKOMST_A")
PartyPop("A_")
for ak=1552,1280,-2 do
    Maps.CamY=ak
    DrawScreen()
    Flip()
    end
MapText("BINNENKOMST_B")
PartyUnPop()
Look(2)
Teleport('EnterTigerion')
Maps.CamX = 2368
Maps.CamY = 1824
MapText("BINNENKOMST_C")   
WorldMap_Reveal("CAT-ISLAND","PURPLEFOREST")
PartyUnPop()  
Actors.Remove("EnterTigerion",1)
end

-- Pray to Thrur. Can we also obtain his powers?
function Thrur()
MapText("THRUR")
if GetActiveChar()=='Scyndi' and (not Done('&SCYNDI.THRUR')) then   
   NewSpellGroup("Scyndi",4,"Thrur",1)
   Done("&SCYNDIHAS.THRUR")
   end
end



-- Item merchant
function ACTOR_FELICIA() 
MapText("FELICIA")
Shop("Felicia") 
end

-- Banker
function ACTOR_CATSH()
MapText("CATSH")
Bank()
end

-- Actors
function ACTOR_KATHA() 
if CVV(FrundarmonDefeated) then MapText("KATHA.AFTERFRUNDARMON") else MapText("KATHA.BEFOREFRUNDARMON") end
end

function ACTOR_TIGERION()
if GetActiveChar()=='Rebecca' then 
   MapText("TIGERION.REBECCA")
   elseif CVV(FrundarmonDefeated) then
   MapText("TIGERION.AFTER")
   else
   MapText("TIGERION.BEFOREFRUNDARMON")
   end
end

function ACTOR_KIERAN() MapText("KIERAN") end
function ACTOR_GATA() MapText("GATA") end

-- General
function GALE_OnLoad()
Music("Chee Zee Jungle")
ZA_Enter(0xf3,Goodbye)
ZA_Enter(0x00,EntranceParty)
end
