--[[
/* 
  Doubline - Phantasar - Dyrt

  Copyright (C) 2014 Jeroen P. broks
  
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



Version: 14.06.17

]]

-- @USEDIR scripts/use/anyway
-- @USEDIR scripts/use/maps

function GALE_OnLoad()
Music("IrishFisherman")
DungeonTitle()
end


function ACTOR_SHOPHOER()
local gender = "FEMALE"
local ch = GetActiveChar()
CSay(ch.." is talking to the shophoer.")
if ch=='Eric' or ch=='Brendor' or ch=='Dernor' then gender='MALE' end
MapText("SHOPHOER."..gender)
if CVV("&DONE.BOSS.KIRANA1") then
   Shop("SHOPHOER2")
   else
   Shop("SHOPHOER")
   end
end

function ACTOR_FISH2DYRT()
local go
if CVV("&DONE.CHAPTER1") then 
   MapText("FISH2DYRT.N")
   else
   MapText("FISH2DYRT.GO")
   go = BoxQuestion(MapTextArray,"FISH2DYRT.GOQ")
   if go==1 then LAURA.Shell("ToForgottenRealm.lua") end
   end
end

function ACTOR_NINA()
MapText('NINA')
end

function ACTOR_MARTIN()
MapText('MARTIN')
end

function ACTOR_MARTINA()
MapText('MARTINA')
end

function Exit()
if CVV("&DONE.CHAPTER1") then WorldMap(); return end
Maps.LoadRoom("BushesNorth")
SpawnPlayer("StartFromDoubline")
end

