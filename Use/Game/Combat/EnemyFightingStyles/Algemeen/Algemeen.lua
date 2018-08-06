--[[
/* 
  

  Copyright (C) 2014 Jeroen P. Broks
  
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



Version: 14.09.10

]]

-- Tacts Arrays

E_IMove = {}

E_AbilityRespond = {}

E_Die = {}




-- Some functions the tacts may need

-- Pick Hero 
function Enemy_PickHero()
local timeout=0
local r
repeat
r = rand(1,4)
timeout = timeout + 1
if timeout>10000 then Sys.Error('Enemy_PickHero(): Timeout!') end
until party[r]
return r
end

function Enemy_PickFoe()
local timeout=0
local r
repeat
r = rand(1,9)
timeout = timeout + 1
if timeout>10000 then Sys.Error('Enemy_PickHero(): Timeout!') end
until FoeData[r] and FoeData[r].HP>0
return r
end

ENEMY_TARGETARRAY =
    {
       [1] = Enemy_PickHero,
       [2]    = Enemy_PickFoe
    }

function Enemy_PickTarget(Group)
if not StN[Group] then Sys.Error("Enemy_PickTarget('"..Group.."'). Unknown group") end
local f = ENEMY_TARGETARRAY[StN[Group]]
if not f then Sys.Error("Enemy_PickTarget('"..Group.."'). Unknown group number (#"..StN[Group]..")") end
return f()
end
