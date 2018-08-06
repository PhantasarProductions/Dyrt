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
 



Version: 14.04.20

]]
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps


function Bye()
WorldMap()
end

function Green()
Maps.LoadMap("CH2_GreenDragonCave")
SpawnPlayer("Start")
end

function White()
Maps.LoadMap("CH2_WhiteDragonCave")
SpawnPlayer("Start")
end

function GALE_OnLoad()
DoSheckLock = CVV("&DONE.WHITEDRAGON") and CVV("&DONE.GREENDRAGON") and (not CVV("&DONE.SHECKLOCK1"))
Music("Disco4")
DungeonTitle()
if DoSheckLock then
   Look(0)
   MapText("SHEKKIE_INTRO")
   MapText("SHEKKIE_I_"..Str.Upper(GetActiveChar()))
   SpawnActor("SheckLock",{['ID']='SheckLock',['SinglePic']='NPC/SheckLockWest.png'})
   end
end


function SheckLock()
if not DoSheckLock then return end
local heroes = {'Eric','Irravonia','Brendor','Scyndi','Rebecca'}
Actors.Despawn('Player')
for _,h in ipairs(heroes) do
    SpawnActor(h,{['ID']=h,['SinglePic']='Heroes/'..h..'Right.png'}) 
    end
MapText("SHEKKIE_A")
ClearBattleVars()
BattleInit('Num'    ,2)
BattleInit('Enemy5'       ,'SHECKLOCK1')
BattleInit('Music'        ,'Monkeys Spinning Monkeys.OGG')
BattleInit('VictoryTune'  ,'Victory.ogg')
BattleInit('Arena'        ,'FOREST.PNG')
if not StartCombat() then return end
Var.D("&DONE.SHECKLOCK1","TRUE")
MapText("SHEKKIE_B")
WorldMap_Reveal("DELISTO","BLACKDRAGON")
Image.Cls()
Image.Flip()
Actors.Despawn('SHECKLOCK')
Time.Sleep(50)
MapText("SHEKKIE_C")
WorldMap()
-- Sys.Error("Boss-Fight 'SheckLock' has not yet been scripted!")    
end
