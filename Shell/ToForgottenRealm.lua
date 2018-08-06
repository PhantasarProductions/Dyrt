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
 



Version: 14.01.22

]]
-- @USEDIR Scripts/Use/Anyway

function Main()
Maps.LoadMap('ShandaCastle')
Look(1)
Maps.CamX = 16
Maps.CamY = 784
-- SpawnActor('Irravonia1',{['ID']='IRRAVONIA1',['SinglePic']='Heroes/IrravoniaBack.png'})
text = ReadLanguageFile('Chapter1/StartShanda')
SerialBoxText(text,"A")
local ak
for ak=784,896,2 do
  Maps.CamY = ak
  DrawScreen()
  LAURA.ExecuteGame('Flip')
  end
SerialBoxText(text,"B")
Maps.CamY = -32
Look(2)
SerialBoxText(text,"C")
Maps.LoadMap("ShandaDung")  
SpawnPlayer("Start")
NewParty("'Eric','Irravonia','Rebecca','Shanda'")
SetDefeatRespawn()
end
