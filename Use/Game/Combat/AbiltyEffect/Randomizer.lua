--[[
/* 
  Randomizer - Dyrt

  Copyright (C) 2014 J.P. Broks
  
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



Version: 14.06.26

]]
function Combat_AbilityEffect.Randomizer(TGROUP,TARGET)
local chi
local ret = false
-- @SELECT StN[TGROUP]
-- @CASE 1
   chi = party[TARGET]
   if char[chi].HP[1]>0 then char[chi].HP[1]=rand(1,char[chi].HP[2]) ret = ret or true end
-- @CASE 2
   if FoeData[TARGET]>0 then FoeData[TARGET].HP=rand(1,FoeData[TARGET].HPMax) ret = ret or true end
-- @DEFAULT
   Sys.Error("Unknown TGROUP ("..sval(StN[TGROUP]).."/"..sval(TGROUP))
-- @ENDSELECT
return ret   
end
