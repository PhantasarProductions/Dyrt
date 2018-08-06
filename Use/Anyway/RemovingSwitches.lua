--[[
/* 
  Removing Switches - Dyrt

  Copyright (C) 2014 Jeroen P. Broks

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



Version: 14.06.12

]]
--[[   This is just a small system that will just flip a switch and remove a tile elsewhere in the 
       dungeon and save the concequences so that they will apply again when the player gets back here.
       The Tags used here are defined in the LoadMap.lua file, in the Game scripts.
       ]]
function RemovingSwitch(XYTag)
if not GameScript then LAURA.Execute("RemovingSwitch",Tag); return  end
local mapname = Maps.MapName
SwitchRemoved = SwitchRemoved or {}
SwitchRemoved[mapname] = SwitchRemoved[mapname] or {}
if SwitchRemoved[mapname][XYTag] then CSay('Switch at ('..XYTag..') was already operated!') return end
SwitchRemoved[mapname][XYTag] = true
local S = RemovalSwitches[XYTag]
if not S then Sys.Error("No switch at ("..XYTag..")") end
if S.tot == Maps.LayerValue(S.x,S.y,"Obstacles") then return end
Maps.LayerDefValue(S.x,S.y,"Obstacles",S.tot,1)
RemovingTag(S.tag)
end

function RemovingTag(Tag) -- ,scroll)
if not GameScript then LAURA.Execute("RemovingTag",Tag); return  end
if not RemovalTags[Tag] then 
   CWrite("Tag '"..Tag.."', not found.... Request ignored!",255,180,0)
   return
   end
local sx,sy
local r = RemovalTags[Tag]
local scroll = r.Scroll
if not r then Sys.Error("Removing tag '"..Tag.."' does not exist!") end
sx = (r.x*32)-400
sy = (r.y*32)-300
if scroll==nil or scroll==true then
   repeat
   if sx<Maps.CamX-5 then Maps.CamX = Maps.CamX - 2 elseif sx>Maps.CamX+5 then Maps.CamX = Maps.CamX + 2 end
   if sy<Maps.CamY-5 then Maps.CamY = Maps.CamY - 2 elseif sy>Maps.CamY+5 then Maps.CamY = Maps.CamY + 2 end
   if sx<Maps.CamX   then Maps.CamX = Maps.CamX - 1 elseif sx>Maps.CamX   then Maps.CamX = Maps.CamX + 1 end
   if sy<Maps.CamY   then Maps.CamY = Maps.CamY - 1 elseif sy>Maps.CamY   then Maps.CamY = Maps.CamY + 1 end
   DrawScreen()
   Flip()
   until sx==Maps.CamX and sy==Maps.CamY
   Time.Sleep(100)   
   end
Maps.LayerDefValue(r.x,r.y,r.Layer,0,1)
if scroll==nil or scroll==true then
   DrawScreen()
   Flip()
   Time.Sleep(100)
   end   
end
