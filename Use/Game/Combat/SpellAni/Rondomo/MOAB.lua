--[[
/* 
  MOAB - SpellAni - Dyrt

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



Version: 14.05.24

]]
function SpellAni.MOAB(TG,TT,TA)
local sx,sy = Combat_EnemySpot(TT)
local ex,ey = Combat_PlayerSpot(TA.Target)
local ay,ak,m
local sbomb = Image.Load('GFX/Combat/SpellAni/Rondomo/SmallBomb.png')
if sbomb=='ERROR' then Sys.Error("No small bomg?") end
Image.HotCenter(sbomb)
local bbomb = Image.Load('GFX/Combat/SpellAni/Rondomo/BigBomb.png')
if bbomb=='ERROR' then Sys.Error("No Big bomg?") end
Image.HotCenter(bbomb)
local bm = { 
             { start = sy,      einde = sy-1000, move=-25, x = sx,  img = sbomb },
             { start = -1000,   einde = 300    , move=  5, x = 400, img = bbomb }
           }
local explosion = Image.Load('GFX/Combat/SpellAni/Rondomo/Moab_Explosion.png')           
Image.Hot(explosion,Image.Width(explosion)/2,Image.Height(explosion))
for ak,m in ipairs(bm) do
    for ay=m.start,m.einde,m.move do
        Combat_DrawScreen()
        Image.Color(0xff,0xff,0xff)
        Image.Draw(m.img,m.x,ay)
        Flip()
        end
    end
for ak=1,2 do
  Combat_DrawScreen()
  Flip(0)
  end    
quakeimage={Img = explosion,X=400,Y=500}
SpellAni.Quake()    
Image.Free(sbomb)
Image.Free(bbomb)
Image.Free(explosion)    
end    

-- A second style of MAOB,let's see if this is better!
function SpellAni.MOAB2(TG,TT,TA)
local sx,sy = Combat_EnemySpot(TT)
local ex,ey = Combat_PlayerSpot(TA.Target)
local ay,ak,m
local sbomb = Image.Load('GFX/Combat/SpellAni/Rondomo/SmallBomb.png')
if sbomb=='ERROR' then Sys.Error("No small bomg?") end
Image.HotCenter(sbomb)
local explosion = Image.LoadAnim('GFX/Combat/SpellAni/Rondomo/Explosion.png',64,64,0,16)           
Image.Hot(explosion,32,64)
local bm = { 
             { start = sy,      einde = sy-1000, move=-25, x = sx,  img = sbomb }
           }
-- Throw up
for ak,m in ipairs(bm) do
    for ay=m.start,m.einde,m.move do
        Combat_DrawScreen()
        Image.Color(0xff,0xff,0xff)
        Image.Draw(sbomb,m.x,ay)
        Flip()
        end
    end
-- Prepare go down
local bombsdown = {}
for ak=1,250 do
    table.insert(bombsdown,{
       x     =  rand(0,800),
       y     = -rand(0,6400),
       ey    = rand(400,550),
       exf   = 0,
       fall  = true
    })
    end
-- falling down
repeat
Combat_DrawScreen()
for ak,bomb in ipairs(bombsdown) do
    if bomb.fall then
       bombsdown[ak].y = bomb.y + 15
       bombsdown[ak].fall = bomb.y < bomb.ey
       Image.Draw(sbomb,bomb.x,bomb.y)
       else
       Image.Draw(explosion,bomb.x,bomb.y,bomb.exf)
       bombsdown[ak].exf = bomb.exf + 1
       if bombsdown[ak].exf>15 then table.remove(bombsdown,ak) end 
       end
    end
-- @IF DEVELOPMENT
DText("Bombs:"..#bombsdown,0,150)   
-- @FI    
Flip()    
until #bombsdown==0    
end
