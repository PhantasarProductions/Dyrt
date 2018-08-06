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
 



Version: 14.09.13

]]

Onyx = {"Aldarus","Jeracko","Kirana","Rondomo"}

function Entree()
if not Done('&DONE.DARKSTORAGE.ENTREE') then MapText('ENTREE') end
if HaveItem('ONYX_KEY')==4 and (not Done('&DONE.DARKSTORAGE.MEANWHILE')) then
   CSay("Meanwhile...")
   Meanwhile()
   Maps.CamX = 800
   Maps.CamY = 2112
   Look(0xa2)
   MapText("MEANWHILE_A")
   Maps.CamX=528
   Maps.CamY=-64
   Teleport('FromMain')
   Look(0)   
   DrawScreen()
   Time.Sleep(500)
   Maps.LayerDefValue(28,1,'Walls',0,1)
   PartyPop("Open",'*bundle')
   MapText("OPEN")
   PartyUnPop()   
   local o
   for _,o in ipairs(Onyx) do Actors.Remove("MW_"..o,1) end
   else
   CWrite("Request rejected to do the meanwhile section!",255,0,0)
   CWrite("ONYX_KEY >>> "..HaveItem('ONYX_KEY').." which has to be 4",255,180,0)
   CWrite("DONE = "..Var.C('&DONE.DARKSTORAGE.MEANWHILE'),0,180,0)
   end
end

function OrderOfOnyx()
local sx = 528
local sy = 1632 
local o
while Maps.CamX~=sx or Maps.CamY~=sy do
      if Maps.CamX>sx then Maps.CamX = Maps.CamX-1 end
      if Maps.CamY>sy then Maps.CamY = Maps.CamY-1 end
      if Maps.CamX<sx then Maps.CamX = Maps.CamX+1 end
      if Maps.CamY<sy then Maps.CamY = Maps.CamY+1 end
      DrawScreen()
      Flip()
      end
if CVV("&DONE.BEATENONYX") then return end
PartyPop("Onyx","*bundle")
MapText("ONYX")
PartyUnPop()
ClearBattleVars()
BattleInit('Music'        ,'OrderOfOnyx')
BattleInit("Arena"        ,"Storage_Main.png")
BattleInit('Enemy1'       ,'Aldarus3')
BattleInit('Enemy3'       ,'Kirana3')
BattleInit('Enemy7'       ,'Rondomo3')
BattleInit('Enemy9'       ,'Jeracko3')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
if not StartCombat() then return end
LAURA.ExecuteGame("AwardTrophy","BOSSONYX")
for _,o in ipairs(Onyx) do Actors.Remove("Boss_"..o,1) end
PartyPop("Onyx","*bundle")
MapText("AFTER")
PartyUnPop()
Done("&DONE.BEATENONYX")
end      

function AllYourBase()
MapText("ALL_YOUR_BASE")
end

function EmptyRoom()
if Done('&DONE.DARKSTORAGE.EMPTYROOM') then return end
Maps.CamX=544
Maps.CamY=1248
NewParty('"Rebecca","Scyndi","Irravonia","Brendor","Dernor","Merya","Aziella"')
PartyPop("Empty","*bundle")
MapText("EMPTY")
PartyUnPop()
SpawnActor("JoinKirana",{ID='KiranaJoin',SinglePic='Onyx/KiranaWingless.png'},1)
end

function ACTOR_KIRANAJOIN()
PartyPop("Kirana","*bundle")
MapText("KIRANA")
PartyUnPop()
NewParty('"Kirana","Irravonia","Brendor","Scyndi","Rebecca","Dernor","Merya","Aziella"')
Actors.Remove("KiranaJoin",1)
MapText("TUTKIRANA")
WorldMap_Reveal("DELISTO","FRENDORBUSHS")
Var.D("&BLOCK.GORDO","TRUE")
end

function Section(A) 
Maps.LoadMap('CH4_DARKSTORAGE_'..A)
SpawnPlayer('Start')
end

function Aldarus() Section('Aldarus') end
function Jeracko() Section('Jeracko') end
function Kirana () Section('Kirana')  end
function Rondomo() Section('Rondomo') end

function Bye() WorldMap() end

function GALE_OnLoad()
ZA_Enter(0x00,Entree)
ZA_Enter(0xa3,OrderOfOnyx)
ZA_Enter(0xa4,EmptyRoom)
Music('Moonlight Hall')
DungeonTitle()
end

-- @USEDIR Scripts/use/anyway
-- @USEDIR Scripts/use/maps
