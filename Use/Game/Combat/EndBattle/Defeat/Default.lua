--[[
/* 
  Default End Battle

  Copyright (C) 2013, 2014 JPB
  
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



Version: 14.02.25

]]
function CheckDefeat.Default()
local ret = true
local ak,ch
local k,v,c
-- Are we defeated?
for ak=0,4 do
    ch = party[ak]
    if ch then
       if char[ch].HP[1]>0 then ret = false end
       end
    end
-- Leerooooooooooooooooooooooooooooooooooooooooy Jennnnnnnkins!!!! 
if ret then    
   c = 0
   for k,v in pairs(Foe) do
       if v then c = c + 1 end
       end
   if c==9 then AwardTrophy("LEEROY") end
   end
return ret
end


function DefeatAction.Default(CBData)
StopMusic()
-- Always look on the bright side of life
AwardTrophy("BrightSide")
if not DefeatRespawn then Sys.Error("Defeat respawn data not properly set!") end
SerialBattleBoxText('GENERAL/ENDBATTLE',"DEFEAT")
Maps.LoadMap(DefeatRespawn.Room)
teleporters["Defeat"] = {}
teleporters["Defeat"].X      = DefeatRespawn.X
teleporters["Defeat"].Y      = DefeatRespawn.Y
teleporters["Defeat"].CamX   = DefeatRespawn.CamX
teleporters["Defeat"].CamY   = DefeatRespawn.CamY
teleporters["Defeat"].Wind   = 'South'
SpawnPlayer('Defeat')
if skill==2 then
   cash = round(cash / 2)
   end
if skill==3 then
   cash = round(cash / 4)
   stones = round(stones *.75)
   SaveGame(true) -- No cheating with old saved games. We overwrite it, hahaha!!!
   end
if Var.C('&DEFTUTOR')~='TRUE' then
   SerialBoxText('GENERAL/ENDBATTLE',"DEFTUTOR"..skill..".")
   end
local k,v
for k,v in pairs(party) do
    if v then
       char[v].HP[1] = char[v].HP[2]
       end
    end
return true    
end

