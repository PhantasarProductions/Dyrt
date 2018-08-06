--[[
/* 
  Basic Ability Effects

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

-- @IF IGNOREME
Combat_AbilityEffect = {}
-- @FI
function Combat_AbilityEffect.HPto1(TGROUP,TACTOR)
local h = Combat_HP(TGROUP,TACTOR)-1
if h<0 then h=0 end
Combat_Hurt(TGROUP,TACTOR,h)
return true
end

function Combat_AbilityEffect.APto0(TGROUP,TACTOR)
local s = StN[TGROUP]
if s~=1 then return end -- Only playable characters.
local ch = party[TACTOR]
party[ch].AP[1] = 0
end

function Combat_AbilityEffect.APandHPgone(TG,TT)
Combat_AbilityEffect.HPto1(TG,TT)
Combat_AbilityEffect.APto0(TG,TT)
end


function Combat_AbilityEffect.NegativeGauge(TGROUP,TACTOR)
local s = StN[TGROUP]
local h = {'Heroes','Foes'}
CombatTime[h[s]][TACTOR] = math.abs(CombatTime[h[s]][TACTOR])*-1  
end

function Combat_AbilityEffect.SkipTurn()
return true
end
