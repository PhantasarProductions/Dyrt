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

function MeryaTutorial()
if CVV("&DONE.TUTOR.MERYA") then return end
MapText("MERYASCOUTTUTORIAL")
Var.D("&DONE.TUTOR.MERYA","TRUE")
end

-- All together again ;)
function RejoinParty()
if CVV("&DONE.AZQUAKUNDAREJOIN") then return end
Var.D("&DONE.AZQUAKUNDAREJOIN","TRUE")
Maps.CamY=1600
NewParty('"Eric","Irravonia","Brendor","Scyndi","Rebecca","Dernor","Merya"')
PartyPop("Rejoin","*bundle")
MapText("REJOIN")
PartyUnPop()
SetDefeatRespawn()
LAURA.ExecuteGame("LevelAbsenceUpdate",   "Eric;Irravonia;%CH3.IRRASTARTLEVEL")
LAURA.ExecuteGame("LevelAbsenceUpdate","Brendor;Irravonia;%CH3.IRRASTARTLEVEL")
Var.D("&TOE.CH3_AZQUAKUNDA","TRUE")
LAURA.ExecuteGame("ResetTOE")
CharRecover({'Eric','Brendor'})
end

function Aldarus()
if not CVV("&DONE.AZQUAKUNDAREJOIN") then return end
if CVV("&DONE.AZQUAKUNDABOSS") then return end
if CVV("&DONE.AZQUAKUNDAREBOSS") then return end -- Bug prevention
PartyPop("Ald","*bundle")
Maps.CamX = 16
Maps.CamY = 2720
local cage = Image.Load("GFX/DrawScreenX/Cage.png"); Image.Hot(cage,Image.Width(cage)/2,Image.Height(cage))
local ak
NewDSX("ALDARUSCAGE",368,-101,cage)
MoveDSX("ALDARUSCAGE",368,353,2,2)
for ak=0,200 do DrawScreen(); Flip() end
MapText("ALDARUS_A")
local bang = Image.Load("GFX/Scenario/Explosion.png")
Image.HotCenter(bang)
local s,v
SFX("SFX/Scenario/OnyxBang.ogg")
for ak = 0,360,5 do
    s = math.abs(Math.Sin(ak))
    DrawScreen()
    Image.Scale(s,s)
    Image.Draw(bang,387,433)
    Image.Scale(1,1)
    Image.Flip()
    if ak==270 then SpawnActor('Aldarus',{['ID']='Aldarus',['SinglePic']='Onyx/AldarusBack.png'}) end
    end
MapText("ALDARUS_B")    
ClearBattleVars()
NewParty("'Eric'")
BattleInit('Enemy8'       ,'ALDARUS1')
BattleInit('Music'        ,'ORDEROFONYX.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'AZQUAKUNDA.PNG')
local victory = StartCombat()
NewParty('"Eric","Irravonia","Brendor","Scyndi","Rebecca","Dernor","Merya"')
if not victory then
   RemoveDSX('ALDARUSCAGE')
   Image.Free(cage) 
   return 
   end
MapText("ALDARUS_C")
for ak = 0,360,5 do
    s = math.abs(Math.Sin(ak))
    DrawScreen()
    Image.Scale(s,s)
    Image.Draw(bang,387,433)
    Image.Scale(1,1)
    Image.Flip()
    if ak==270 then Actors.Remove("Aldarus") end -- SpawnActor('Aldarus',{['ID']='Aldraus',['SinglePic']='Onyx/Aldarus.png'}) end
    end
MoveDSX("ALDARUSCAGE",368,-100,1,1)    
MapText("ALDARUS_D")
RemoveDSX("ALDARUSCAGE")
Image.Free(cage)
WorldMap_Reveal("DELISTO","YASATHAR")
PartyUnPop()
Var.D("&DONE.AZQUAKUNDABOSS","TRUE")
-- Sys.Error("Next event not yet scripted. Please come back later ;)")
end

function Bye()
WorldMap()
end

function GALE_OnLoad()
Console.Write("Welcome to Azquakunda prison",0,255,255)
Music("Prisoner of War - Jail - Widzy")
DungeonTitle()
ZA_Enter(0x48,RejoinParty)
end

function GALE_OnUnload()
Console.Write("Leaving Azquakunda prison so soon?",0,255,255)
end

-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps
