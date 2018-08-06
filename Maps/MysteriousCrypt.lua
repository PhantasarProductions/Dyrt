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
 



Version: 14.08.05

]]
function GALE_OnLoad()
Music("120bpmonster")
DungeonTitle()
-- if not(CVV("&DONE.MYSTCRYPT")) then SetDefeatRespawn() end
end

function GALE_OnUnload()
end

function SIGN_SQ()
MapText("SQUARE")
end

function SIGN_RT()
MapText("ROOT")
end

function SIGN_NN()
MapText("NINE")
end

function SIGN_FINALHINT()
MapText("FINALHINT")
end

SIGN_FH = SIGN_FINALHINT -- Confusion here, and so it MUST work :P

function WrongSwitch()
CSay("Hey! That's the wrong switch!")
if not(CVV("&DONE.MYSTCRYPT.SWITCH.K4")) then
   Teleport("Start")
   Look(1)
   MapText("WRONGSWITCH")
   else
   MapText("STUCK")
   end
end

function RightSwitch()
CSay("Hey! That's the correct switch!")
if not(CVV("&DONE.MYSTCRYPT.SWITCH.K4")) then
   Var.D("&DONE.MYSTCRYPT.SWITCH.K4","TRUE")
   Maps.LayerDefValue(20,58,"Walls",0x00,1)
   Maps.LayerDefValue( 7,64,"Walls",0xf1,1)
   else
   MapText("STUCK")
   end
end

function ACTOR_THEBOSS()
   local v
   ClearBattleVars()
   BattleInit('Num'    ,2)
   BattleInit('Enemy5'       ,'BOSSBIGSCORPION')
   BattleInit('Music'        ,'BOSS.OGG')
   BattleInit('VictoryTune'  ,'VICTORY.OGG')
   BattleInit('Arena'        ,'MYSTERIOUSCRYPT.PNG')
   v = StartCombat() 
   if v then 
      Actors.Despawn("TheBoss")
      Maps.BuildBlockMap() 
      end
end

function ACTOR_MERCHANT()
MapText("MERCHANT")
Shop("CRYPTMERCHANT")
end

function TheEnd()
if CVV("&DONE.MYSTCRYPT") then return end
Var.D("&DONE.MYSTCRYPT","TRUE")
Actors.Despawn("MERCHANT")
Actors.Despawn("Merchant") -- Not sure about the case, and so he despawns anyway.
MapText("END_A")
Maps.LoadMap("Prison")
Maps.IamSeeing(0x01,1)
Maps.CamY = 928
Maps.CamX = 0
MapText("END_B")
-- Hindro Astra & Gandra Faldar in conversation
Maps.LoadMap("CutSceneForest")
Maps.IamSeeing(0x00,1)
Maps.CamX = 48
Maps.CamY = 96
MapText("SCYNDI_START_A")
-- Scyndi and the squirrel
Maps.CamY = 928
MapText("SCYNDI_START_B")
Music('Panic Stations')
MapText("SCYNDI_START_PANIC")
-- Scyndi running towards the temple
Actors.Pick("SCYNDI")
Actors.WalkTo(0,37)
local NextFrame
local NoodTeller = 500
repeat
Actors.Walk()
NextFrame = NextFrame or 4
NextFrame = NextFrame - 1
if NextFrame==0 then Actors.IncFrame() NextFrame = 4 end 
DrawScreen()
Image.Flip()
Actors.Pick("SCYNDI") 
NoodTeller = NoodTeller -1  
until Actors.PA_X()==1 or NoodTeller<1
Actors.Remove("SCYNDI")
-- Scyndi & Dernor
MapText("SCYNDI_START_C")
Maps.CamY = 1728
MapText("SCYNDI_START_D")
--Sys.Error("Weneria's Temple not yet created")
Var.D("$SCYNDI",Var.C("!seelahgandra"))
-- Start the Temple of Weniaria
Maps.LoadMap("Weniaria")
NewParty("'Scyndi','Brendor'")
SetActive("Scyndi")
SpawnPlayer("Start")
SetDefRespawn()
end

function Bye()
if CVV("&DONE.CHAPTER1") then WorldMap(); return end
end


-- @USEDIR Scripts/USE/Anyway
-- @USEDIR Scripts/USE/Maps
