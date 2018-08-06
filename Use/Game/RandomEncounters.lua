--[[
/* 
  Random Encounters - Dyrt

  Copyright (C) 2013, 2014 JP Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
  the restrictions of this file are removed and will automatically become
  zLib licensed (see below).
  
  Please note that doing so counts as a modification and must be marked as such
  in accordance to the zLib license.
  ===========================


  zLib license terms:

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.

*/



Version: 14.10.22

]]
MaxSteps = {80,60,40}

RandEncOff = false

function RandomEncounters(force)
if EncounterTable=="" then return end -- When no encounter table, go away!
Var.D("%SKILL",skill)
if not force then -- Skip everything that can break off this encounter when you call for an encounter by Eric with the red staff
   if RandEncOff then return end
   gamesteps = gamesteps or MaxSteps[skill]
   -- @IF DEVELOPMENT
   if debugnoencounters then return end
   -- @FI
   Image.Color(255,255,255)
   if OldZone then
      if NoCombatZone[OldZone] then return end -- Player is now in a no-combat zone, so no random encounters should occur.
      if MaxRandEncnt[OldZone] and gamesteps>MaxRandEncnt[OldZone] then gamesteps = MaxRandEncnt[OldZone]+1 end
      end
   gamesteps = gamesteps or MaxSteps[skill]
   gamesteps = gamesteps - 1
   if gamesteps>10 then return end -- Make sure that interval between encounters is NEVER too short!
   if rand(1,gamesteps)~=1 then return end -- Makes the interval vary a little
   -- Make sure no "illegal cancels" happen
   Key.Flush()
   while CancelKeyHit() do end
   end
local edata
if AltEnc[EncounterTable] then edata = AltEnc[EncounterTable]() else edata = JINC('RandEnc/'..EncounterTable..".lua") end
if edata.Initiative<0 then edata.Initiative = Initiative() end
local points = edata.Migrant / MigrantLevel
if points<1 then points=0 end
local Go = false
local cnt = 50
local knipper = true
if edata.Initiative==2 or ECNBar<edata.Migrant or force then
   Go = true
   else
   -- SFX("SFX/Combat/BattleApproaching.ogg") -- On rem until some good polishing could be done.
   Key.Flush()
   cnt = 50
   repeat   
   cnt = cnt - 1
   TrueDrawScreen()
   Image.Color(255,255,255)
   if knipper then 
      if points==0 then
         Image.Draw("E_GREEN",400,300)
         else
         Image.Draw("E_YELLOW",400,300)
         end
      end
   -- @IF DEVELOPMENT
   DText("cnt: "..cnt,0,599,0,1)
   -- @FI
   Flip()   
   if Str.Right(cnt,1)=='0' or Str.Right(cnt,1)=='5' then knipper = not knipper end
   if cnt<=0 then Go=true end   
   until cnt<=0 or CancelKeyHit() or Mouse.Hit(2)~=0
   end
if not Go then 
  ECNBar = ECNBar - points
  SFX("SFX/Combat/Cancel.ogg") 
  end   
if Go then
   if edata.Music~="*NOCHANGE*" then StopMusic() end
   SFX("SFX/Combat/Engage.ogg")
   Image.Color(255,255,255)
   Image.Cls()
   Image.Draw("E_RED",400,300)
   Actors.Pick("Player")
   Actors.WalkTo(Actors.PA_X(),Actors.PA_Y())
   Flip()
   Time.Sleep(500)
   Combat(edata)
   end
gamesteps = rand(round(MaxSteps[skill]*.95),round(MaxSteps[skill]*1.25))
end

function SetEncounterTable(Table)
EncounterTable = Table
end



function Initiative()
local r
local ret
-- @SELECT skill
-- @CASE 1
   r = rand(1,20)
   if r==1 then ret = 1 end
-- @CASE 2
   r = rand(1,20)
   if r==1 then ret = 1 end
   if r==2 then ret = 2 end
-- @CASE 3
   r = rand(1,40)
   if r<10 then ret = 2 end
   if r==1 then ret = 1 end
-- @ENDSELECT
return ret
end

-- @IF DEVELOPMENT
function __consolecommand.RANDOMENCOUNTERDATA()
local r = 74
local g = 86
local b = 64
Console.Write("Table    "..EncounterTable,r,g,b)
Console.Write("Steps    "..gamesteps,r,g,b)
Console.Write("Maxsteps "..MaxSteps[skill],r,g,b)
end

function __consolecommand.NOENCOUNTERS()
debugnoencounters = not debugnoencounters
CSay("Debug No Encounters is set to : "..sval(debugnoencounters))
end
-- @FI


AltEnc = {}

function AltEnc.Training()
local sowieso = {"ORC","GHOST","FLAMEGHOST","FIREGHOUL","IGNIS"}
local numenem = 1
local ak
local ret = {}
local foe
local foelist = JINC("AltRandEnc/Training.lua")
ret.Arena = "Forest.png"
ret.VictoryTune = 'Victory.ogg'
if CVV('%TFC')==0 then Var.D("%TFC",2) end -- TFC = Training Field Chapter. Must be set in later chapters :)
ret.Music = 'BATTLE_Chapter'..CVV('%TFC')..'.OGG'
-- @SELECT skill
-- @CASE 1
   repeat
   for ak=1,9 do
       if rand(1,ak)==1 then numenem=ak end
       end
   until numenem<rand(1,12)       
-- @CASE 2      
   repeat 
   for ak=1,9 do
       if rand(1,ak)<3 then numenem=ak end
       end
   until numenem<rand(1,15)       
-- @CASE 3
   numenem=rand(3,9)
-- @ENDSELECT
ret.Migrant = 20
ret.Initiative = -1
for ak=1,numenem do
    repeat
    foe = foelist[rand(1,foelist.num)]
    -- CSay(foe.." in sowieso    = "..sval(tablecontains(sowieso,foe)))
    -- CSay(foe.." in bestiary    = "..sval(Bestiary[foe]))
    until tablecontains(sowieso,foe) or Bestiary[foe]
    ret["Enemy"..ak] = foe
    end   
return ret    
end


function SetRENC(v)
RandEncOff = upper(v) =='OFF'
end
