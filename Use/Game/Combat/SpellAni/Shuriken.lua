--[[
/* 
  SpellAni: Shuriken - Dyrt

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



Version: 14.04.20

]]
function SpellAni.Shuriken(TG,TT,TA)
local sx,sy = Combat_EnemySpot(TT)
local ex,ey = Combat_PlayerSpot(TA.Target)
local cx = (ex-sx) / 200
local cy = (ey-sy) / 200
local px,py = sx,sy
local ak
local picshuriken = Image.Load("GFX/Combat/SpellAni/Shuriken.png")
local rad=0
Image.HotCenter(picshuriken)
SFX("SFX/Combat/SpellAni/Shuriken.ogg")
for ak=0,200,1 do
    Combat_DrawScreen()
    Image.Rotate(rad); rad = rad + 1
    Image.Draw(picshuriken,px,py)
    Image.Rotate(0)
    px = px + cx
    py = py + cy
    Flip()
    end
Image.Free(picshuriken)    
end
