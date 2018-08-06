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
 



Version: 14.04.22

]]
-- @USEDIR Scripts/Use/AnyWay
-- @USEDIR Scripts/USE/Maps



function Guardian()
ClearBattleVars()
BattleInit('Num'    ,2)
BattleInit('Enemy5'       ,'BLACKGUARDIAN')
BattleInit('Music'        ,'*NOCHANGE*')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'BLACKDRAGON.PNG')
if not StartCombat() then return false end
Var.D("&BOSS.BLACKGUARDIAN","TRUE")   
-- Baas verslagen? Dan gaan we naar het volgende deel van de dungeon ;)
LAURA.ExecuteGame('ManualTeleport','AfterBoss');
SetDefeatRespawn()
-- Var.D(bb,"TRUE")
Var.D("&TOE.CH2_BLACKDRAGONCAVE","TRUE")
LAURA.ExecuteGame("ResetTOE")
return true
end


function Dragon()
local heroes = {'Eric','Irravonia','Brendor','Scyndi','Rebecca'}
local P = Actors.Permanent
Actors.Permanent = 0
Actors.Despawn('Player')
Actors.Permanent = P
Maps.CamX = 208
Maps.CamY = 2368
local h
for _,h in ipairs(heroes) do
    SpawnActor(h,{['ID']=h,['SinglePic']='Heroes/'..h..'Right.png'}) 
    end
MapText("DRAGON_A")
NewParty('"Eric"')
ClearBattleVars()
BattleInit('Num'    ,1)
BattleInit('Enemy1'       ,'BLACKDRAGON')
BattleInit('Music'        ,'BOSSDRAGON.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'BLACKDRAGON.PNG')
local victory = StartCombat()
NewParty('"Eric","Irravonia","Brendor","Scyndi","Rebecca"')
if not victory then return end
MapText("DRAGON_B")
Var.D("&DONE.BLACKDRAGON","TRUE")
NewSpellGroup("Eric",5,"Black Dragon",1)
SpawnPlayer("Start")
end

function Bye()
if CVV("&DONE.BLACKDRAGON") and (not CVV("&DONE.RONDOMO1")) then
   Maps.LoadMap("CH2_BlackDragonOutDoor")
   else
   WorldMap()
   end
end



---------------------
-- The Memory Game --
---------------------

-- Init the shit!
function InitMemory()
PlayMemory = not CVV("&DONE.BLACKDRAGON")
if not PlayMemory then return end
Memory = { {}, {}, {}, {} }
MemorySpot = {}
CSay("Init Memory")
local ak,al,rx,ry,timeout
for ak=1,8 do for al=1,2 do
    timeout=0
    repeat
    rx = rand(1,4)
    ry = rand(1,4)
    timeout=timeout+1
    if timeout>100000 then Sys.Error("SubGame.InitMemory: Timeout") end
    until not Memory[rx][ry]
    Memory[rx][ry] = ak+9
    CSay("Card #"..ak.."."..al.." has been set onto spot ("..rx..','..ry..")")
    MemorySpot["M"..rx..ry] = {79+(rx*2),45+(ry*2)}
    MemorySpot["F"..MemorySpot["M"..rx..ry][1]..MemorySpot["M"..rx..ry][2]] = {rx,ry}
    Maps.LayerDefValue(MemorySpot["M"..rx..ry][1],MemorySpot["M"..rx..ry][2],'FloorDeco',18,0)    
    end end
CSay("All set.... Let's play!")
rsv = nil    
rev = { {}, {}, {}, {}, {} }
Correct = 0
end

-- Reveal the shit!
function MoveMemory()
if not PlayMemory then return end
local x,y,w = PlayerCoords()
local cx,cy
Correct = Correct or 0

if MemorySpot["F"..x..y] then
   cx = MemorySpot["F"..x..y][1]
   cy = MemorySpot["F"..x..y][2]
   end   
if MemorySpot["F"..x..y] and (not rev[cx][cy]) then
   rev[cx][cy] = 1
   Maps.LayerDefValue(x,y,'FloorDeco',Memory[cx][cy],0)
   if rsv then
      Actors.Pick("Player")
      Actors.NewSpot(Actors.PA_X(),Actors.PA_Y()-1,Actors.PA_Wind())
      Actors.StopWalking()
      if Memory[cx][cy]==rsv.P then
         Correct = Correct + 1 
         -- Maps.LayerDefValue(cx,cy,"FloorDeco",Memory[cx][cy],1)
         -- Maps.LayerDefValue(rsv.X,rsv.Y,'FloorDeco',rsv.P,1)
         else 
         LAURA.ExecuteGame("DrawScreen")
         Flip()
         Time.Sleep(250)
         Maps.LayerDefValue(x,y,"FloorDeco",18,0)
         Maps.LayerDefValue(rsv.FX,rsv.FY,'FloorDeco',18,0)
         rev[cx][cy] = false
         rev[rsv.X][rsv.Y] = false
         end 
      rsv = nil   
      else
      rsv = 
        {
           X = cx,
           Y = cy,
           FX= x,
           FY= y,
           P = Memory[cx][cy]
        }
      end
   end
if Correct==8 then
   if not Guardian() then return end
   for x = 1,4 do for y = 1,4 do
       Maps.LayerDefValue(MemorySpot['M'..x..y][1],MemorySpot['M'..x..y][2],'FloorDeco',Maps.LayerValue(MemorySpot['M'..x..y][1],MemorySpot['M'..x..y][2],'FloorDeco'),1) -- Seal the puzzle result FOREVER!
       end end
   end       
end


----------
-- Main --
----------

-- Load it all
function GALE_OnLoad()
Music("Black Vortex")
ZA_Enter(2,InitMemory)
ZA_Move (2,MoveMemory)
end
