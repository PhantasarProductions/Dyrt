--[[
/* 
  Drain - Dyrt

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



Version: 14.06.26

]]
-- @IF IGNOREME
Combat_XAbilityEffect = {} -- Ignored by GALE, but not by Eclipse, so the outliner will still pick this up, but GALE won't
-- @FI

function Drain(AGROUP,ACTOR,TGROUP,TARGET,Percent)
local thp = Combat_GetHP(TGROUP,TARGET)
local ahp = Combat_GetHP(AGROUP,ACTOR)
local mhp = Combat_GetHP(AGROUP,ACTOR,true)
local drn = math.floor(thp * (Percent/100))
if drn > thp        then drn=thp end
if drn + ahp > mhp  then drn=mhp-ahp end
Combat_Hurt(TGROUP,TARGET,drn)
Combat_Heal(AGROUP,ACTOR,drn,true,true)
return true
end


function Combat_XAbilityEffect.Drain10 (AG,A,TG,T) return Drain(AG,A,TG,T, 10) end
function Combat_XAbilityEffect.Drain25 (AG,A,TG,T) return Drain(AG,A,TG,T, 25) end
function Combat_XAbilityEffect.Drain50 (AG,A,TG,T) return Drain(AG,A,TG,T, 50) end
function Combat_XAbilityEffect.Drain75 (AG,A,TG,T) return Drain(AG,A,TG,T, 75) end
function Combat_XAbilityEffect.Drain100(AG,A,TG,T) return Drain(AG,A,TG,T,100) end

