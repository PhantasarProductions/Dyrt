--[[
/* 
  

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



Version: 14.02.15

]]
function GameAction()
Actors.Pick('Player')
local x = Actors.PA_X()
local y = Actors.PA_Y()
local w = Actors.PA_Wind()
if w == "" then w = 'North' end
Console.Write('Perform action. Pos('..x..','..y..')  Wind:'..w,192,96,74)
local fx,fy = GetFrontCoords(x,y,w)
-- Savespot
if SaveSpots[fx..","..fy] then SaveSpot(SaveSpots[fx..","..fy]) end
-- Actor
if Actors.AnybodyThere(fx,fy,1)~="*NOBODY*" then 
   Actors.Action()
   end
-- Removal switches
if RemovalSwitches[fx..","..fy] then
   RemovingSwitch(fx..','..fy)
   end   
-- AKEvent
PerformKeybaordAKEvent(x,y)
end


function GetFrontCoords(x,y,w)
local ret1,ret2
-- @SELECT w
-- @CASE 'North'
   ret1,ret2 =  x,y-1
-- @CASE 'South'
   ret1,ret2 =  x,y+1
-- @CASE 'East'
   ret1,ret2 =  x+1,y
-- @CASE 'West'
   ret1,ret2 =  x-1,y
-- @DEFAULT
   Sys.Error("Unknown wind direction '"..w.."'")
-- @ENDSELECT
return ret1,ret2
end

function PerformKeybaordAKEvent(x,y)
local AKE,param 
for _,AKE in pairs(AKEvents) do
    if x==AKE.x and y==AKE.y then
       Actors.Pick("Player")
       if AKE.KeyMustFace~="" then Actors.NewWind(AKE.KeyMustFace) end
       param=nil
       if AKE.Parameter~="" then param=AKE.Parameter end
       if AKE.MapFunction~="" then Maps.Run(AKE.MapFunction,param) end
       if AKE.GameFunction~="" then LAURA.ExecuteGame(AKE.MapFunction,param) end
       end
    end
end
