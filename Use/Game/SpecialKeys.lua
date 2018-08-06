--[[
/* 
  Special Keys

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



Version: 14.11.02

]]

-- Special Keys pressed?
function SpecialKeys()
local k,v,done
local ch
-- Change active character
if KeyHit(config.key.char) or joyhit(config.joy.char) then
   Actors.Pick("Player")
   if Actors.Walking()~=0 then return end -- Prevent freeze game when changing leader while walking.
   done = false	
   for k,v in ipairs(party) do
   	   if v==activecharacter and (not done) then
   	   	  activecharacter = party[k+1]
   	   	  if activecharacter == "Shanda" then activecharacter = party[k+2] end
   	   	  done = true
   	   	  end
   	   end	  
    if not activecharacter then activecharacter = party[1] end
    Console.Write('Current character is now '..activecharacter,146,88,198)
    end
Actors.Pick('Player')
-- Personal (non-combat) action    
if (KeyHit(config.key.pact) or joyhit(config.joy.pact)) and (Actors.Walking()==0) and Actors.Moving()==0 then
   ch = activecharacter
   if PersonalAction[ch] then PersonalAction[ch]() else Console.Write("!WARNING! No personal action found for character: "..ch,255,0,0) end    
   end
-- Turn combat on or off if you are allowed to do so
if (KeyHit(config.key.toe) or joyhit(config.joy.toe)) and AllowTOE then
   RandEncOff = not RandEncOff
   end
-- Reset moveblocks
if KeyHit(config.key.reset) or joyhit(config.joy.reset) then ResetMoveBlocks() end   
end
