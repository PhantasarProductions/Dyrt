--[[
/* 
  Open Red Seals

  Copyright (C) 2014 JP Broks
  
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
function OpenRedSeal()
ClearBattleVars()
BattleInit('Music'        ,       MapSealedBoss.Music)
BattleInit("Arena"        ,       MapSealedBoss.Arena)
BattleInit('Enemy6'       ,"ZZ_"..MapSealedBoss.Boss)
BattleInit('VictoryTune'  ,'VICTORY.OGG')
if not StartCombat() then return end
Done("&REDSEAL."..Maps.MapName)
local c = CVV("%REDBOSSESDEFEATED") + 1
Var.D('%REDBOSSESDEFEATED',c)
if c==8 then AwardTrophy("ZZZZ_ALLSEALED") end
Maps.LayerDefvalue(MapSealedBoss.X,MapSealedBoss.Y-1,"Obstacles",0,1) -- Remove the seal from sight ;)
Teach(MapSealedBoss.Char,MapSealedBoss.Ability)
end

function __consolecommand.REDSEALS()
local k,v
if not MapSealedBoss then 
   CWrite("No sealed boss has been found in this area",255,0,0)
   else
   CWrite("MapSealedBoss = {",255,255,0)
   for k,v in spairs(MapSealedBoss) do
       CWrite("   "..k.." = "..v,255,180,0)
       end
   CWrite("}",255,255,0)
   end
end
