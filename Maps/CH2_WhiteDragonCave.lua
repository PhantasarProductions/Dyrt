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


-- Slide over the ice
function IceSlide()
local SlD = {
   North = { X= 0, Y=-1},
   South = { X= 0, Y= 1},
   East  = { X= 1, Y= 0},
   West  = { X=-1, Y= 0}}
local x,y,w = PlayerCoords()
local mx,my = x,y
local timeout 
local function slidestop()
      if Maps.LayerValue(mx,my,"Zone_Visibility")~=1 then return true end
      local ret = Maps.VBlockMap(mx+SlD[w].X,my+SlD[w].Y) == 1
      return ret
      end   
while not slidestop() do
      timeout = (timeout or 0) + 1
      if timeout>1000 then Sys.Error("IceSlide Timeout!") end
      mx = mx + SlD[w].X
      my = my + SlD[w].Y
      end
Actors.StopWalk()      
Actors.Pick("Player")
Actors.MoveTo(mx,my)            
end


-- At the final puzzle, put the camera to (0,0)
function NulNulNix()
if     Maps.CamX>0 then Maps.CamX = Maps.CamX - 1
elseif Maps.CamY>0 then Maps.CamY = Maps.CamY - 1 end
end

-- Load this shit
function GALE_OnLoad()
DungeonTitle()
Music("Water Prelude")
CSay("Adding IceSlide  to Enter"); ZA_Enter(1,IceSlide)
CSay("Adding IceSlide  to Move");  ZA_Move (1,IceSlide)
CSay("Adding NulNulNix to Cycle"); ZA_Cycle(4,NulNulNix) 
end


function Guardian()
if CVV('&DONE.WHITEDRAGON') then LAURA.ExecuteGame('ManualTeleport','Start'); return end
ClearBattleVars()
BattleInit('Num'    ,2)
BattleInit('Enemy5'       ,'WHITEGUARDIAN')
BattleInit('Music'        ,'BOSS.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'WHITEDRAGONCAVE.PNG')
if not StartCombat() then return end
Var.D("&BOSS.WHITEGUARDIAN","TRUE")   
-- Baas verslagen? Dan gaan we naar het volgende deel van de dungeon ;)
LAURA.ExecuteGame('ManualTeleport','AfterBoss');
SetDefeatRespawn()
Var.D(bb,"TRUE")
Var.D("&TOE.CH2_WHITEDRAGONCAVE","TRUE")
LAURA.ExecuteGame("ResetTOE")
end

function Dragon()
local heroes = {'Eric','Irravonia','Brendor','Scyndi','Rebecca'}
local P = Actors.Permanent
Actors.Permanent = 0
Actors.Despawn('Player')
Actors.Permanent = P
Maps.CamX = 16 
Maps.CamY = 2608
local h
for _,h in ipairs(heroes) do
    SpawnActor(h,{['ID']=h,['SinglePic']='Heroes/'..h..'Right.png'}) 
    end
MapText("DRAGON_A")
NewParty('"Eric"')
ClearBattleVars()
BattleInit('Num'    ,1)
BattleInit('Enemy1'       ,'WHITEDRAGON')
BattleInit('Music'        ,'BOSSDRAGON.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'WHITEDRAGONCAVE.PNG')
local victory = StartCombat()
NewParty('"Eric","Irravonia","Brendor","Scyndi","Rebecca"')
if not victory then return end
MapText("DRAGON_B")
Var.D("&DONE.WHITEDRAGON","TRUE")
NewSpellGroup("Eric",4,"White Dragon",1)
SpawnPlayer("Start")
end


function Bye()
Maps.LoadMap("CH2_HIDDENBUSH")
SpawnPlayer("FromWhite")
end
