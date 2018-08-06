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
 



Version: 14.03.27

]]
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps

function GALE_OnLoad()
Console.Write("Welcome to prison",0,255,255)
Music("Prisoner of War - Jail - Widzy")
end

function GALE_OnUnload()
Console.Write("Leaving the prison so soon?",0,255,255)
end


function ACTOR_BLENCHY()
ToBlenchy()
end

function ToBlenchy()
-- When the next 2 lines are not properly present the game will crash out with a "C Stack Overflow" error!
if ToBlenchyRun then return end
ToBlenchyRun = true
-- End C Stack overflow prevention
if CVV("&DONE.BLENCHYBOSS") then return end
local supchar = {"Eric","Rebecca","Brendor","Scyndi"}
local ak,ch
Actors.Pick("Player")
Actors.WalkTo(91,39)
while Actors.Walking()==1 do
      LAURA.ExecuteGame("Walk")
      DrawScreen()
      LAURA.ExecuteGame("Flip")
      end
for ak,ch in ipairs(supchar) do
    SpawnActor("B"..ch,{['ID']='BLENCHY_'..ch,['SinglePic']='Heroes/'..ch..'.png'})
    end       
SetActive("Irravonia")
Actors.Pick("Player")
Actors.ChoosePic("Irravonia.South") 
MapText("BLENCHY")
ClearBattleVars()
BattleInit('Num'    ,2)
BattleInit('Enemy5'       ,'BLENCHY')
BattleInit('Music'        ,'BOSSBLENCHY.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'PRISON.PNG')
local v = StartCombat() 
ToBlenchyRun = false
if not v then return end
Actors.Despawn("Blenchy")
Var.D("&DONE.BLENCHYBOSS","TRUE")
MapText("AFTERBLENCHY")
for ak,ch in ipairs(supchar) do
    Actors.Despawn('BLENCHY_'..ch)
    end
LAURA.ExecuteGame("AwardTrophy","CHAPTER1")    
end


function ExitPrison()
-- @IF !CHAPTER2
Var.D("%NEXTCHAPTER",2)
Maps.LoadRoom('Wachtkamer')
-- SpawnPlayer("Start")
return
-- @FI
-- @IF CHAPTER2
LAURA.Shell('StartChapter2.lua')
-- @FI
end
