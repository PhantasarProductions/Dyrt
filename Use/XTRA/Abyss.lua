--[[
/* 
  Abyss - Level Generator

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



Version: 14.06.26

]]
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps

plasmacol = { r = 255, g = 255, b = 255  }

pclevel = {
                 { r =   0, g = 255, b = 255 }, 
                 { r = 255, g =   0, b =   0 },
                 { r =   0, g = 255, b =   0 },
                 { r = 255, g =   0, b = 255 },
                 { r = 255, g = 255, b =   0 },
                 { r =   0, g =   9, b = 255 }
          }

function BackDrawScreen()
BlopPlasma.DrawCol(plasmacol.r,plasmacol.g,plasmacol.b)
end

function PlaceItem(x,y)
local lv = CVV("%ABYSS.LEVEL")
local lvgroup = math.ceil(lv/5)
local aitems = AllowItems[lvgroup]
local itnum = rand(1,#aitems)
local item = aitems[itnum]
local MN = upper(Maps.MapName)
LAURA.ExecuteGame("PlaceItem",MN..";"..x..";"..y..";"..item)
end

function GenerateLevel()
-- First empty the level we got
local MN = Upper(Maps.MapName)
LAURA.ExecuteGame("EmptyItemMap",MN)
LAURA.ExecuteGame("RemoveSaveSpots")
local x,y,ak
local lv = CVV("%ABYSS.LEVEL")
for x=0,100 do for y=0,100 do
    Maps.LayerDefValue(x,y,"Floor",0)
    Maps.LayerDefValue(x,y,"FloorDeco",0)
    Maps.LayerDefValue(x,y,"Zone_Visibility",0xff)
    Maps.DBlockMap(x,y,1)
    end end -- Two fors, so two ends.
-- Set initial data    
local dirs = {{-1,0},{1,0},{0,-1},{0,1},{-1,-1},{-1,1},{1,1},{1,-1}}
local ways = rand(1,6)
local way = {}
-- Start position of all the ways
local px,py,pw = PlayerCoords()
for ak=1,ways do
    table.insert(way,{
            x = px, y = py,
            d = rand(1,#dirs)
         })
    end
-- Let's go
local counter = 0
local w
repeat
for _,w in ipairs(way) do
    if rand(1,15)==1 or w.x+dirs[w.d][1]<2 or w.x+dirs[w.d][1]>98 or w.y+dirs[w.d][2]<2 or w.y+dirs[w.d][2]>98 then
       w.d = rand(1,#dirs)
       else
       for x=w.x-1,w.x+1 do for y=w.y-1,w.y+1 do
           Maps.LayerDefValue(x,y,"Floor",0x02)
           Maps.LayerDefValue(x,y,"Zone_Visibility",lv)
           Maps.DBlockMap(x,y,0)           
           end end -- Once again two fors means two ends.
       if rand(1,1000)==1 then PlaceItem(w.x,w.y) end
       w.x = w.x + dirs[w.d][1]
       w.y = w.y + dirs[w.d][2]    
       end
    end
counter = counter + 1    
until counter > 10 and rand(1,2500)<counter and way[1].x~=px and way[1].y~=py
-- Place the Exit and last items
for ak,w in pairs(way) do
    for x=w.x-1,w.x+1 do for y=w.y-1,w.y+1 do
        Maps.LayerDefValue(x,y,"Floor",0x02)
        Maps.LayerDefValue(x,y,"Zone_Visibility",lv)
        Maps.DBlockMap(x,y,0)
        end end -- Once again two fors means two ends.
     if ak==1 then
        Maps.LayerDefValue(w.x,w.y,"FloorDeco",0x01)
        Maps.LayerDefValue(w.x,w.y,"Zone_Visibility",0xfe)
    else
       PlaceItem(way[ak].x,way[ak].y) 
       end
    end
-- Maps.BuildBlockMap()
-- LAURA.ExecuteGame("CreateDataFromZones")
end

function NextLevel()
local MN = Maps.MapName
CSay("Farewell level #"..Var.C("%ABYSS.LEVEL"))
vInc("%ABYSS.LEVEL")
local e = Sys.Val(right(Var.C("%ABYSS.LEVEL"),1))
CSay("Going to Abyss Level #"..Var.C("%ABYSS.LEVEL"))
plasmacol = pclevel[e] or { r = rand(1,100), g = rand(1,100), b = rand(1,100)}
if e==5 or e==0 then
   ItemMap = ItemMap or {}
   ItemMap[MN] = {}
   CSay("This is a savespot/boss level, so let's set it up by standard in stead of generating a new level")
   Maps.LoadMap(mapself)
   -- LAURA.ExecuteGame('ManualTeleport','Start'..Var.C("%ABYSS.LEVEL"));
   SpawnPlayer("Start"..Var.C("%ABYSS.LEVEL"))
   else
   GenerateLevel()
   end
end
