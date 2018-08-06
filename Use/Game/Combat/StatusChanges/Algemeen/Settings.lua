--[[
/* 
  Settings

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



Version: 14.10.14

]]
StatusData = {}    -- The names and functions of the statusses themselves.

StatusSet = StatusSet or { {}, {} } -- Set to which character (friend or foe)

StN = { [0]=1, [1]=2, ["Friend"] = 1, ["Friends"] = 1, ["Heroes"] = 1, ["Hero"] = 1, ["Player"] = 1, ["Players"] = 1, ["Foe"] = 2, ["Foes"] = 2, ["Enemies"] = 2, ["Enemy"] = 2, ["Monster"]=1, ["Monsers"]=2 } -- (When you scripted too fast before you have to take some measures to fix things) :(


function StatusLingerCheck()
StatusSet[2] = {} -- Enemies always start again without any status changes.
local chn,tab
local stat,value
for chn,tab in pairs(StatusSet[1]) do
    for stat,value in pairs(tab) do
        if not StatusData[stat].Linger then StatusSet[1][chn][stat] = nil end
        end
    end
end

function StatusAttackBlock(TG,TA)
local chi
local ret = false
if StN[TG]==1 then chi = party[TA] else chi=TA end
StatusSet[StN[TG]] = StatusSet[StN[TG]] or {}
for statdata,_ in pairs(StatusSet[StN[TG]][chi]) do
    if not StatusData[statdata] then 
       Sys.Error("No status data for status: "..statdata,"TG,"..TG..";TA,"..TA..";chi,"..chi)
       end
    ret = ret or StatusData[statdata].NoAttack 
    end
return ret    
end

function StatusSpellBlock(TG,TA)
local chi
local ret = false
if StN[TG]==1 then chi = party[TA] else chi=TA end
StatusSet[StN[TG]] = StatusSet[StN[TG]] or {}
for statdata,_ in pairs(StatusSet[StN[TG]][chi]) do
    if not StatusData[statdata] then 
       Sys.Error("No status data for status: "..statdata,"TG,"..TG..";TA,"..TA..";chi,"..chi)
       end
    ret = ret or StatusData[statdata].NoSpell 
    end
return ret    
end

function __consolecommand.STATUSCHANGES()
local a = serialize("StatusSet",StatusSet)
local d = split(a,"\n")
local l,ak
local r  = 0
local g  = 0
local b  = 255
local go = 1
for ak,l in ipairs(d) do
    if r==255 then go=-1 end
    if r==000 then go= 1 end
    r = r + go
    b = 255 - r
    Console.Write(l,r,g,b)
    end
end

function __consolecommand.STATUSDATA()
local stkey,stdata
local stdkey,stddata
for stkey,stdata in spairs(StatusData) do
    Console.Write("Status "..stkey,255,255,0)
    for stdkey,stddata in spairs(stdata) do
        Console.Write("    "..stdkey.." = "..sval(stddata),0,255,255) 
        end
    end
end
