--[[
/**********************************************
  
  (c) Jeroen Broks, 2013, All Rights Reserved.
  
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

-- This script is loaded when needed, and will be dumped after it's finished.
function Main()
-- Prologue in prison
Maps.LoadMap("Prison")
Maps.CamY = 928
Maps.CamX = 0
Maps.IamSeeing(0x01,1)
SerialBoxText("Prologue/Start","A")
Var.D("$BRENDOR",GphInput(SysText("askname"),DefaultCharName("brendor")))
Var.D("!seelahgandra",DefaultCharName("seelahgandra"))
Var.D("$SCYNDI",DefaultCharName("seelahgandra"))
SerialBoxText("Prologue/Start","INT")
Var.D("$ERIC",GphInput(SysText("askname"),DefaultCharName("eric")))
Var.D("$IRRAVONIA",GphInput(SysText("askname"),DefaultCharName("irravonia")))
SerialBoxText("Prologue/Start","B")
Var.D("$REBECCA",GphInput(SysText("askname"),DefaultCharName("rebecca")))
SerialBoxText("Prologue/Start","C")
-- Cutscene Irravonia's house
Maps.LoadMap("IrravoniaHome")
Maps.CamX = 32
Maps.CamY = 0
Maps.IamSeeing(0x01,1)
SpawnActor('ELDER',{['ID']='ELDER',['SinglePic']='NPC/ElderBack.png'})
SerialBoxText("Chapter1/StartIrravonia","I")
Maps.CamX = 1040
Maps.CamY = 176
Maps.IamSeeing(0x02,1)
SerialBoxText("Chapter1/StartIrravonia","J")
Actors.Despawn("KindjeIrravonia")
Maps.CamX = 32
Maps.CamY = 0
DrawScreen()
Image.Flip()
Time.Sleep(2000)
Maps.CamX = 1040
Maps.CamY = 176
Maps.IamSeeing(0x02,1)
DrawScreen()
Image.Flip()
SerialBoxText("Chapter1/StartIrravonia","K")
-- Start Bushes in Irravonia's child chapter
Maps.LoadMap("Bushes")
local tx = 2448
local ty = 1280
SpawnPlayer("Start")
Maps.CamX = 0
Maps.CamY = 0
Maps.IamSeeing(0x00,1)
repeat
if Maps.CamX<tx then Maps.CamX = Maps.CamX + 4 end
if Maps.CamY<ty then Maps.CamY = Maps.CamY + 4 end
DrawScreen()
Image.Flip()
until Maps.CamX>=tx and Maps.CamY>=ty
SerialBoxText("Chapter1/StartIrravonia","IRRA")
-- And now all the starting stuff is done. The Game's Main function should take it over from here.
end

function GALE_OnLoad()
CSay("Oh, are we starting a new game, then let's start the introduction talkie")
end

function GALE_OnUnload()
CSay("Introduction talkie begone!")
end

-- @USEDIR Scripts/Use/AnyWaY/
