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
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps

-- Leaving town
function Bye()
WorldMap()
end



-- Initiating the city
function EmptyCity()
Music("Water Prelude")
if not CVV("&DONE.GAGOLTONFOUNDEMPTY") then
   Var.D("&DONE.GAGOLTONFOUNDEMPTY","TRUE")
   Maps.CamX=0
   Maps.CamY=0
   PartyPop("Leeg","*bundle")
   MapText("LEEG")
   PartyUnPop()    
   end
WorldMap_Reveal("DELISTO","INDIEBUSH")   
end

function CrowdedCity()
Music("Oregon")
Maps.LayerDefValue(9,2,"WallsDeco",0x01,0)
end


-- Juggernaut
function UseBlackOrb()
CWrite("Player tried to use a black orb",180,0,255)
local orbx = {78,81,84,90,93,96}
local socket = nil
local x,ak
local px,py,pw = PlayerCoords()
for ak,x in ipairs(orbx) do
    if px==x or px==x+1 then socket={ak,x} end
    end
if not socket then return CWrite("REJECTED! Not standing in front of a socket",255,0,0) end
if Done("&BLACKORB.SOCKET["..socket[1].."]") then
   CWrite("REJECTED! Requested socket was already filled")
   return
   end
CWrite("ACCEPTED! Orb placed in socket #"..socket[1],180,255,0)   
Maps.LayerDefValue(socket[2],7,"WallsDeco",0xf0,1)
local count
for ak=1,6 do
    if CVV("&BLACKORB.SOCKET["..ak.."]") then count = (count or 0) + 1 end
    end
CWrite("Now "..count.." sockets have been filled",0,255,180)    
if count==6 then 
   Maps.LayerDefValue(87,7,"Walls",0,1)
   CWrite("The door to Juggernaut has been opened!",0,180,255) 
   end    
LAURA.ExecuteGame("RemoveItem","BLACKORB")   
end

function EnterBlackRoom()
Music("TheDread")
end

function LeaveBlackRoom()
Music("Water Prelude")
end

function Juggernaut()
if CVV("&JUGGERNAUT") then 
   MapText("JUGDONE")
   return
   end
MapText("JUGSTART")
ClearBattleVars()
BattleInit('Num'    ,1)
BattleInit('Enemy5'       ,'JUGGERNAUT')
BattleInit('Music'        ,'WICKED.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'EMPTY.PNG')
if StartCombat() then Done("&JUGGERNAUT") end
--Sys.Error("Boss Juggernaut not yet implemented!")   
end

-- Onload
function GALE_OnLoad()
ZA_Enter(0x03,Bye)
ZA_Enter(0x10,EnterBlackRoom)
ZA_Enter(0x11,Juggernaut)
ZA_Enter(0x0a,LeaveBlackRoom)
if CVV("&DONE.BOSS.KIRANA1") then
   EmptyCity()
   else
   CrowdedCity()
   end
DungeonTitle()   
end



-- Easter Egg
function Barrel()
SFX("SFX/General/Barrel.ogg")
end

-- Research Notes
function ResearchNotes()
if CVV("&FOUND.RESEARCHNOTES") then return end
MapText("RESEARCHNOTES")
WorldMap_Reveal("DELISTO","THEABYSS")
Var.D("&FOUND.RESEARCHNOTES","TRUE")
end

function StayOutOfMyLab()
if CVV("&DONE.BOSS.KIRANA1") then
   return
   end
MapText("GETOUTOFMYLAB")
Actors.Pick("Player")
Actors.WalkTo(55,27)   
end

-- Town's people (as long as they are there) :P
function ACTOR_JUGGUARD1()
MapText("JUGNOENTRY")
end
ACTOR_JUGGUARD2 = ACTOR_JUGGUARD1 -- Both guards say the same.

function ACTOR_ARYA()
MapText("ARYA")
end

function ACTOR_ELENA()
MapText("ELENA")
end

function ACTOR_SAMANTHA()
MapText("SAMANTHA")
end

function ACTOR_GRELDIR()
MapText("GRELDIR")
end

function ACTOR_ROSETTA()
MapText("ROSETTA")
StoneMaster("ROSETTA")
end

function ACTOR_HANS()
MapText("HANS")
end

function ACTOR_JOHN()
MapText("JOHN")
end

function ACTOR_FRYDA()
MapText("FRYDA")
end

function ACTOR_XENETHOR()
MapText("XENETHOR")
end

function ACTOR_ARJEN()
MapText("ARJEN")
end
function ACTOR_WESLEY()
MapText("WESLEY")
end


function ACTOR_KIRANA()
PartyPop("Kira","*bundle")
MapText("KIRANA")
PartyUnPop()
Var.D("&DONE.SPOKEN.KIRANA.GAGOLTON")
Actors.Remove("Kirana",1)
WorldMap_Reveal("DELISTO","AIROM")
end

function ACTOR_DOG()
if GetActiveChar()=='Scyndi' then
   MapText("DOG.SCYNDI")
   else
   MapText("DOG")
   end
end   

function ACTOR_CYNTHIA()
MapText("CYNTHIA")   
end

function SHOP_KARL()
if CVV("&DONE.BOSS.KIRANA1") then
   MapText("NOKARL")
   else
   MapText("KARL")
   Shop("KARL")
   end
end   

-- Debug Routine
function RemoveAll()
Var.D("&DONE.BOSS.KIRANA1","TRUE")
LAURA.ExtractSwap("MapChanges/CH3_City_Gagolton.lua")
CSay("Gagolton set to the empty mode. Please leave this area and come back to see the full effect!")
end  
