--[[
/* 
  Shoot (for Aziella) - Dyrt

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



Version: 14.07.03

]]
-- @IF IGNOREME
SpellAni={}
-- @FI

function SpellAni.AziellaShoot(TG,TT,TA)
local ex,ey = Combat_TargetSpot(TA.TargetGroup,TA.Target)
local sx,sy = Combat_PlayerSpot(TT)
local cx = (ex-sx) / 120
local cy = (ey-sy) / 120
local px,py = sx,sy
local ak
local picbolt = Image.Load("GFX/Combat/SpellAni/Aziella/"..(CurrentShootPic or "Bolt")..".png")
local rad=0
Image.HotCenter(picbolt)
-- SFX("SFX/Combat/SpellAni/Shuriken.ogg")
for ak=0,120,1 do
    Combat_DrawScreen()
    -- Image.Rotate(rad); rad = rad + 1
    Image.Draw(picbolt,px,py)
    -- Image.Rotate(0)
    px = px + cx
    py = py + cy
    Flip()
    end
Image.Free(picbolt)    
end
