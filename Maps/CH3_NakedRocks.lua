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
 



Version: 14.05.24

]]
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps

function GALE_OnLoad()
Music("Ocean-Waves-1")
-- @IF !CHAPTER3
MapText("NOCH3")
-- @FI
end

function SWT(A)
Actors.Pick('Player')
Actors.WalkTo(A[1],A[2])
repeat
Walk(true)
DrawScreen()
Flip()
until Actors.PA_X()==A[1] and Actors.PA_Y()==A[2]
local wnd = {'North','East','South','West','North'}
local ak,w,al
for ak,w in ipairs(wnd) do     
    for al=1,25 do 
        Walk(true)
        Actors.ChoosePic("Scyndi."..w)
        DrawScreen()
        Flip()
        end
    end
end

function STARTCHAPTERTHREE()
Maps.CamX = 1184
Maps.CamY = 0
Look(0)
NewParty('"Scyndi","Irravonia"')
SetRENC("Off")
local WanderSpots = 
   {
      {51,12}, -- 1   also first spot Scyndi walks to
      {44,15}, -- 2
      {45,10}, -- 3
      {45,14}, -- 4
      {53,10}, -- 5
      {38,11}, -- 6
      {43,12}, -- 7
      {47,11}  -- 8
   }
local ScyndiFirst = WanderSpots[1]   
local r,ak,oldr
local ScyndiGo = {}
local w
oldr=1
for ak=1,10 do
    repeat
    r = rand(1,#WanderSpots)
    until r~=oldr
    oldr = r
    table.insert(ScyndiGo,WanderSpots[r])
    end
SpawnPlayer('Scyndi')
MapText("START_A")
Actors.Pick("Player")
SWT(ScyndiFirst)
MapText("START_B")
Chapter(3)
for ak,w in ipairs(ScyndiGo) do SWT(w) end
SWT({18,12})
Teleport('WithIrra')
Maps.CamX = 0
Maps.CamY = 0
Actors.ChoosePic("Scyndi.South")
MapText("START_C")
Maps.LayerDefValue(5,14,'Obstacles',0,1)
Maps.BuildBlockMap()
DungeonTitle()
SetDefeatRespawn()
LAURA.ExecuteGame("CH3_IRRAZERO")
SetRENC("On")
end

function Exit()
Maps.LoadMap("CH3_NAKEDROCKSCAVE")
Maps.CamX = 944
Maps.CamY = -96
Look(0)
if not CVV('&DONE.NAKEDROCKS') then
   PartyPop('Start','*bundle',{'Scyndi','Irravonia'})
   MapText('END')
   PartyUnPop()
   Var.D("&DONE.NAKEDROCKS","TRUE")
   end
SpawnPlayer('N')   
end
