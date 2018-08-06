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
 



Version: 14.10.22

]]
-- @USE use.lua

function Welcome()
if not donewelcome then MapText("WELCOME") end
donewelcome = true
end


-- This function will come into play when the player steps onto the wrong tile in the letter tile puzzle.
function FoutjeBedankt()
Actors.Pick("Player")
local x = Actors.PA_X()
local y = Actors.PA_Y()
Actors.NewSpot(0,0,"North") -- Just be out of sight.
Maps.LayerDefValue(x,y,"FloorDeco",0,0)
Maps.LayerDefValue(x,y,"Floor",0,0)
DrawScreen()
Flip()
Time.Sleep(1500)
LAURA.ExecuteGame('ManualTeleport','Fout'); 
end

function TileComplete()
if Done("&DONE.CH5.DEATHCAVE.TILEPUZZLE") then return end
local x,y
for x=0,100 do for y=0,100 do
    if Maps.LayerValue(x,y,"Zone_Visibility")==0x0D then Maps.LayerDefValue(x,y,"FloorDeco",0,1) Maps.LayerDefValue(x,y,"Floor",0,1) end
    end end
end

function Faith()
MapText("FAITH")
end

function AllComplete()
LAURA.ExecuteGame("AwardTrophy","SD_DEATHCAVE")
Done("&TOE.CH5_DYRT_DEATHCAVE")
LAURA.ExecuteGame("ResetTOE")
end

-- Black Market
function ACTOR_BW_ITEMS() MapText("BW_ITEMS") Shop("BM_Item" ) end
function ACTOR_BW_JEWEL() MapText("BW_JEWEL") Shop("BM_Jewel") end


-- Boss
function ACTOR_BOSSMUMMY()
ClearBattleVars()
BattleInit('Num'    ,1)
BattleInit('Enemy6'       ,'UBERMUMMY')
BattleInit('Music'        ,'BOSS.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'NAKEDROCKSCAVE.PNG')
if not StartCombat() then return end
Actors.Remove("BOSSMUMMY",1)
end


function GALE_OnLoad()
donewelcome = Done("&DONE.WELCOME.DEATHCAVES")
Welcome()
Music("Tempting Secrets")
ZA_Enter(0x0d,FoutjeBedankt)
ZA_Enter(0x17,AllComplete)
end
