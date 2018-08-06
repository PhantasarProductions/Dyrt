--[[
/**********************************************
  
  (c) Jeroen Broks, 2013, 2014, All Rights Reserved.
  
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

function main()
Maps.LoadMap('Blanco')
local Text = ReadLanguageFile('Chapter1/YoungIrravoniaEnd')
-- Dark     "Am I dead?"
SerialBoxText(Text,'DARK')
-- In the room (child)
Maps.LoadMap('EricRebeccaHome')
Maps.CamX = 0
Maps.CamY = 0
Look(0)
IrraKid = {['ID'] = 'Player', ['PicBundle']='Player',['ChosenPic']='YoungIrravonia'}
EricKid = {['ID'] = 'Eric', ['SinglePic']='Heroes/Young Eric.png'}
RebeKid = {['ID'] = 'Rebecca', ['SinglePic']='Heroes/Young Rebecca.png'}
Jack    = {['ID'] = 'Jack', ['SinglePic']='NPC/JackFront.png'}
Wendy   = {['ID'] = 'Wendy', ['SinglePic']='NPC/Wendy.png'}
--SpawnActor('IrraKid'   ,IrraKid)
SpawnPlayer('IrraKid')
SpawnActor('EricKid'   ,EricKid)
SpawnActor('RebeccaKid',RebeKid)
SpawnActor('Jack'      ,Jack)
SerialBoxText(Text,'A')
Tephondar = {['ID'] = 'Tephondar', ['SinglePic']='NPC/TephondarBack.png'}
SpawnActor('Tephondar',Tephondar)
SerialBoxText(Text,'B')
NewParty('"Eric","Irravonia"')
-- Back in jail
Maps.LoadMap("Prison")
Maps.IamSeeing(0x01,1)
Maps.CamY = 928
Maps.CamX = 0
SerialBoxText(Text,'PRISON')
Maps.LoadMap('Blanco')
SerialBoxText(Text,'SLEEPY')
-- Back to Eric and Rebecca's house
Maps.LoadMap('EricRebeccaHome')
Maps.LayerDefValue(15,2,"Walls",0x13,1) -- An extra bed has been placed into the house. After all Irravonia had to sleep somewhere :)
Look(0)
Maps.CamX=0
Maps.CamY=0
if Str.Upper(Var.C('$IRRAVONIA'))=='IRRAVONIA' then
   Var.D('$IRRASHORT','Irra')
   else
   Var.D('$IRRASHORT',Var.C('$IRRAVONIA'))
   end
SetActive('Eric')
SpawnPlayer('IrraKid')
SpawnActor('Wendy',Wendy)
SpawnActor('RebeccaKid',{['ID']='IRRAVONIA',['SinglePic']='Heroes/Irravonia.png'})
SerialBoxText(Text,'UP')
Actors.Pick('Player')
Actors.WalkTo(11,11)
local x,y
while not ok do
      Actors.Walk()
      LAURA.ExecuteGame('DrawScreen')
      Image.Flip()
      x = Actors.PA_X()
      y = Actors.PA_Y()
      ok = (x==11 and y==11)
      end
Actors.Despawn('Player')
Look(0)
Maps.CamX=0
Maps.CamY=0
SerialBoxText(Text,'LOVE')
Maps.LoadMap('BushesWest')
Maps.CamY=0
Maps.CamX=2000
SpawnPlayer('Start')
SetDefeatRespawn()
--Sys.Error('Temp End of Script Reached')
end
