--[[
/* 
  

  Copyright (C) 2013 JP Broks
  
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



Version: 14.01.11

]]

-- This routine will create the correct initial data from the system variables.
-- This routine is needed as shelled routines (which will be the routines that will 
-- call for boss battles most) cannot transfer the data directly.


function BattleVars(prefix)
local bv = {'VictoryTune','Music','Arena','Victory','Defeat','CheckVictory','VictoryAction','CheckDefeat','DefeatAction'}
local ak,v
for ak=1,9 do
    table.insert(bv,'Enemy'..ak)
    end
local pbv = {}
for ak,v in ipairs(bv) do
    table.insert(pbv,'$COMBAT.'..v)
    end
if prefix then
   return pbv
   else
   return bv
   end
end

function PBV(prefix)
return ipairs(BattleVars(prefix))
end


function ClearBattleVars()
local ak,v
for ak,v in PBV(true) do
    Var.Clear(v)
    end
Console.Write('Combat init vars have all been deleted',96,88,176)   
end

function BattleInit(key,value)
Var.D('$COMBAT.'..key,value)
Console.Write('Combat variable '..key..' has been set to "'..value..'"',60,86,144)
end

function StartCombat()
if Combat_InitFromVars then
   Combat_InitFromVars()
   else
   LAURA.ExecuteGame('Combat_InitFromVars','')   
   end
return CVV('&VICTORY')   
end

