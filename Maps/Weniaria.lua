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
-- @USEDIR Scripts/Use/AnyWay
-- @USEDIR Scripts/Use/Maps


function GALE_OnLoad()
Music("Angevin")
if not CVV("&DONE.WENIARIATEMPLE.BOSS") then LAURA.ExecuteGame("SetEncounterTable","WENIARIA") end
DungeonTitle()
end

function GALE_OnUnload()
CSay("Bye, Weniaria")
CSay("I hope to see you soon again!")
end

function HugeStatue()
local y = Maps.CamY
local ay
local ty = 1936
if CVV("&DONE.CHAPTER1") then
   if Actors.Pick("FATHER",1)==0 then
      SpawnActor('Father',{['ID']='FATHER',['SinglePic']='NPC/HindroAstraEast.png'}) 
      end
   end
if CVV("&DONE.INTRODUCEWENIARIASTATUE") then return end
for ay=y,ty,-2 do
    Maps.CamY = ay
    DrawScreen()
    LAURA.ExecuteGame("Flip")
    end
MapText("HUGE")    
Var.D("&DONE.INTRODUCEWENIARIASTATUE","TRUE")
end    


function StatueFirst()
if not CVV("&DONE.WENIARIATEMPLE.CHECKSTATUE") then
   MapText("STATUEFIRST")
   Actors.Pick("Player")
   Actors.Walkto(Actors.PA_X(),Actors.PA_Y()+2)
   end
end

function Statue()
local ch
if CVV("&DONE.CHAPTER1") then MapText("STATUEGENERAL") return end 
if not CVV("&DONE.WENIARIATEMPLE.CHECKSTATUE") then
   Var.D("&DONE.WENIARIATEMPLE.CHECKSTATUE","TRUE")
   MapText("STATUEEVIL")
   return
   end
if not CVV("&DONE.WENIARIATEMPLE.BOSS") then
   MapText("STATUEEVILB")
   return
   end
if not CVV("&DONE.WENIARIATEMPLE") then
   MapText("END_A")
   Maps.LoadMap("Prison")
   Maps.IamSeeing(0x01,1)
   Maps.CamY = 928
   Maps.CamX = 1
   MapText("END_B")
   Maps.LayerDefValue(9,31,"Walls",0,1)
   SpawnActor('Rebecca',{['ID']='Rebecca',['SinglePic']='Heroes/Rebecca.png'})
   MapText("END_C")
   NewParty("'Eric','Irravonia','Brendor','Scyndi','Rebecca'")
   NewSpellGroup("Scyndi",2,"Weniaria",1)
   for _,ch in ipairs({'Eric','Irravonia','Brendor','Scyndi','Rebecca'}) do Actors.Despawn(ch) end
   SpawnPlayer("Start")
   Maps.BuildBlockMap()
   SetDefeatRespawn()
   --[[
   Image.Cls()
   Image.Color(rand(1,255),rand(1,255),rand(1,255))
   Image.DText("This part is not yet written. I'll get to that as soon as I can.",0,0)
   Image.DText("Hit any key",0,25)
   Image.Flip()
   Key.Wait()
   ]]
   return
   end
MapText("STATUEGENERAL")
end   

function Boss()
if CVV("&DONE.WENIARIATEMPLE.BOSS") then return end
local v
ClearBattleVars()
BattleInit('Num'    ,1)
BattleInit('Enemy6'       ,'SHADOWSWEEPER')
BattleInit('Music'        ,'BOSS.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'WENIARIA.PNG')
v = StartCombat() 
if v then 
      Actors.Despawn("BOSS")
      Maps.BuildBlockMap() 
      Var.D("&DONE.WENIARIATEMPLE.BOSS","TRUE")
      LAURA.ExecuteGame("SetEncounterTable","")
      MapText("AFTERBOSS")
      end
end
   
function Exit()
if CVV("&DONE.CHAPTER1") then WorldMap(); return end
end


function ACTOR_FATHER()
MapText("FATHER")
StoneMaster("Hindro Astra")
end
