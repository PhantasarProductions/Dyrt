--[[
/* 
  Zone Action - Dyrt

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



Version: 14.04.20

]]
----------------------------------------------------------------
----------------------------------------------------------------
--- This file contains some functions which should make the  ---
--- game respond on entering, leaving and staying in zones   ---
--- or simply ignore it when nothing is set.                 ---
---                                                          ---
--- The first dungeon to take advantage of this script was   ---
--- The White Dragon Cave in chapter 2                       ---
----------------------------------------------------------------
----------------------------------------------------------------

-- Our function storage
array_zoneaction = {}

-- LIST or no LIST (cut short, LornoL)
function lornol(f)
if type(f)=='function' then return ipairs({f}) end
if type(f)=='table' then return ipairs(f) end
Sys.Error("'lornol' accepts only a table or a function but I got "..type(f))
end


function ZA_New(zone,forcenew)
if forcenew then array_zoneaction[zone]=nil end
array_zoneaction[zone] = array_zoneaction[zone] or {}
end

function ZA_ListItUp(zone,atype,f)
local r,g,b = rand(1,255),rand(1,255),rand(1,255)
ZA_New(zone)
array_zoneaction[zone][atype] = array_zoneaction[zone][atype] or {}
local fn
for _,fn in lornol(f) do
    table.insert(array_zoneaction[zone][atype],fn)
    Console.Write("Zone_Action.Zone["..zone.."]."..atype.."     >> added a function!",r,g,b)
    end
end

function ZA_Enter(zone,f)
ZA_ListItUp(zone,'Enter',f)
end

function ZA_Leave(zone,f)
ZA_ListItUp(zone,'Leave',f)
end

function ZA_Cycle(zone,f)
ZA_ListItUp(zone,'Cycle',f)
end

function ZA_Move(zone,f)
ZA_ListItUp(zone,'Move',f)
end

function ZA_do(zone,t)
local z = Sys.Val(zone)
local f
if not array_zoneaction[z] then return end
if not array_zoneaction[z][t] then return end
for _,f in ipairs(array_zoneaction[z][t]) do f() end
end

function ZA_doEnter(zone)
ZA_do(zone,"Enter")
end

function ZA_doLeave(zone)
ZA_do(zone,"Leave")
end

function ZA_doCycle(zone)
ZA_do(zone,"Cycle")
end

function ZA_doMove(zone)
ZA_do(zone,"Move")
end

function ZA_ConsoleView()
local r,g,b = rand(1,255),rand(1,255),rand(1,255)
local ak,at,zone,fl,af,fn
for ak,zone in pairs(array_zoneaction) do
    for at,fl in pairs(zone) do
        Console.Write("Zone #"..ak.." in list '"..at.."' is a "..type(fl),r,g,b)
        for af,fn in ipairs(fl) do
            Console.Write("   = Found "..type(fn).." #"..af,r,g,b)
            end
        end
    end
end    

