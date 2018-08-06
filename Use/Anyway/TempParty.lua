--[[
/* 
  Dyrt - Temp party

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



Version: 14.08.11

]]
SavedParties = {}

function SaveParty(name)
if not GameScript then 
   LAURA.ExecuteGame("SaveParty",name)
   else
   SavedParties[name] = party
   end
end

function RestoreParty(name)
if not GameScript then 
   LAURA.ExecuteGame("RestoreParty",name)
   else
   party = SavedParties[name]
   activecharacter = party[1]
   end
end

function __consolecommand.SAVEDPARTIES()
local s,ch,k
local count=0
for k,s in spairs(SavedParties) do
    CWrite("- "..k,255,0,0)
    for _,ch in ipairs(s) do CWrite("  = "..ch,255,255,0) end
    count = count + 1
    end
CWrite("        "..count.." saved parties have been found!",0,0,255)
end    
