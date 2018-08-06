--[[
/* 
  Move Blocks - Dyrt

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



Version: 14.08.05

]]
MB_BlockMap = {}

function MoveBlocksBlockMap()
local bm
for _,bm in ipairs(MB_BlockMap) do
    Maps.DBlockMap(bm.x,bm.y,0)
    end
MB_BlockMap = {}
local bl    
for _,bl in ipairs(MoveBlocks[OldZone]) do
    table.insert(MB_BlockMap,{ x = bl.cx, y = bl.cy })
    Maps.DBlockMap(bl.cx,bl.cy,1)
    CWrite("MB>Blocking: ("..bl.cx..","..bl.cy..")",255,0,255)
    end 
--Maps.BuildBlockMap()       
end

-- Called when player enters a room with MoveBlocks. It can also be called by the ResetMoveBlocks() function.
function AutoResetMoveBlocks(force)
local bl
if not (force or OldZone) then return end
if force or OldMoveBlockZone~=OldZone then -- Reset Blocks if needed
   CWrite("New Zone: #"..OldZone)
   OldMoveBlockZone = OldZone
   if MoveBlocks[OldZone] then
      CWrite("Resetting Blocks for zone #"..sval(OldZone),200,180,60)
      for _,bl in ipairs(MoveBlocks[OldZone]) do 
          bl.cx = bl.ox
          bl.cy = bl.oy
          bl.fx = 0
          bl.fy = 0
          end
       Actors.Pick("Player")
       MBResetSpot = { x = Actors.PA_X(), y = Actors.PA_Y(), w = Actors.PA_Wind()}   
       MoveBlocksBlockMap()          
       end       
   end   
end

-- Called when player pressed the 'reset' key.
function ResetMoveBlocks()
if not MoveBlocks[OldZone] then
   CWrite("? This is not a moveblock area, so no resetting allowed here",255,0,0)
   return
   end
Actors.Pick("Player") 
Actors.NewSpot(MBResetSpot.x,MBResetSpot.y,MBResetSpot.w)
AutoResetMoveBlocks(true)
CWrite("Moveblocks reset by player")
end

-- @IF IGNOREME
__consolecommand = {}
-- @IF

