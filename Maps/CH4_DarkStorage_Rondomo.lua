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
 



Version: 14.10.14

]]
-- @USEDIR Scripts/use/anyway
-- @USEDIR Scripts/use/maps


---------------------
-- The Memory Game --
---------------------

-- Init the shit!
function InitMemory()
PlayMemory = not CVV("&DONE.RONDOMO_MEMORY")
if not PlayMemory then return end
Memory = { {}, {}, {}, {} }
MemorySpot = {}
CSay("Init Memory - Rondomo")
local ak,al,rx,ry,timeout
for ak=1,8 do for al=1,2 do
    timeout=0
    repeat
    rx = rand(1,4)
    ry = rand(1,4)
    timeout=timeout+1
    if timeout>100000 then Sys.Error("SubGame.InitMemory: Timeout") end
    until not Memory[rx][ry]
    Memory[rx][ry] = ak+0x4f
    CSay("Card #"..ak.."."..al.." has been set onto spot ("..rx..','..ry..")")
    MemorySpot["M"..rx..ry] = {89+(rx*2),42+(ry*2)}
    MemorySpot["F"..MemorySpot["M"..rx..ry][1]..MemorySpot["M"..rx..ry][2]] = {rx,ry}
    Maps.LayerDefValue(MemorySpot["M"..rx..ry][1],MemorySpot["M"..rx..ry][2],'FloorDeco',0x58,0)    
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
         Maps.LayerDefValue(x,y,"FloorDeco",0x58,0)
         Maps.LayerDefValue(rsv.FX,rsv.FY,'FloorDeco',0x58,0)
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
   -- if not Guardian() then return end
   for x = 1,4 do for y = 1,4 do
       Maps.LayerDefValue(MemorySpot['M'..x..y][1],MemorySpot['M'..x..y][2],'FloorDeco',Maps.LayerValue(MemorySpot['M'..x..y][1],MemorySpot['M'..x..y][2],'FloorDeco'),1) -- Seal the puzzle result FOREVER!
       end end
   Maps.LayerDefValue(84,54,'Walls',0,1)    
   end       
end


----------
-- Main --
----------





function Bye()
Maps.LoadMap('CH4_DARKSTORAGE_MAIN')
SpawnPlayer('ExitRondomo')
end

function Boss()
if CVV('&DONE.BOSS.DSRONBOSS') then Done('&TOE.CH4_DARKSTORAGE_RONDOMO') LAURA.ExecuteGame('ResetTOE') return end
MapText('PREBOSS')
ClearBattleVars()
BattleInit('Music'        ,'Boss')
BattleInit("Arena"        ,"Storage_Rondomo.png")
BattleInit('Enemy5'       ,'Smiley')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
if StartCombat() then Done('&DONE.BOSS.DSRONBOSS'); Done('&TOE.CH4_DARKSTORAGE_RONDOMO') end
LAURA.ExecuteGame('ResetTOE')
end

function ACTOR_RONDOMO()
PartyPop('Ro','*bundle')
MapText('RONDOMO')
PartyUnPop()
ClearBattleVars()
BattleInit('Music'        ,'OrderOfOnyx')
BattleInit("Arena"        ,"Storage_Rondomo.png")
BattleInit('Enemy5'       ,'Rondomo2')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('DefeatAction' ,'GameOver') -- Security measure due to the key stealing thing in this fight
if not StartCombat() then return end
Actors.Remove('Rondomo',1)
PartyPop('Ro','*bundle')
MapText('AFTER')
PartyUnPop()
end


function GALE_OnLoad()
Music("Black Vortex")
ZA_Enter(0x49,Boss)
ZA_Enter(0x4c,InitMemory)
ZA_Move (0x4c,MoveMemory)
end
