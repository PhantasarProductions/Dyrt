--[[
/* 
  Darkness - SpellAni - Dyrt

  Copyright (C) 2014 J.P. Broks
  
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

-- Dark, dark, dark
function SpellAniDarkness(x,y,ak)
SpellAniExplosion = SpellAniExplosion or Image.LoadAnim('GFX/Combat/SpellAni/Rondomo/Explosion.png',64,64,0,16)           
Image.Hot(SpellAniExplosion,32,64)
Image.Color(0,0,0)
Image.Draw(SpellAniExplosion,x,y,ak)
Image.Color(255,255,255)
end


function SpellAni.Darkness(TG,TT,TA)
local ak
local x,y = Combat_TargetSpot(TA.TargetGroup,TA.Target)
for ak=0,15 do
    Combat_DrawScreen()
    SpellAniDarkness(x,y,ak)
    Flip()
    end
end

function SpellAni.AllDarkness(TG,TT,TA)
local x,y
local tlist = {}
local t
-- @SELECT StN[TA.TargetGroup]
-- @CASE 1
   for ak=1,4 do
       x,y = Combat_PlayerSpot(ak)   
       if party[ak] and char[party[ak]].HP[1]>0 then table.insert(tlist,{x=x,y=y}) end
       end
-- @CASE 2
   for ak=1,9 do
       x,y = Combat_EnemySpot(ak)
       if FoeData[ak] and FoeData[ak].HP>0 then table.insert(tlist,{x=x,y=y}) end 
       end       
-- @ENDSELECT       
for ak=0,15 do
    Combat_DrawScreen()
    for _,t in ipairs(tlist) do
        --Image.Draw(SAP_Flame,t.x,t.y,ak)
        SpellAniDarkness(t.x,t.y,ak)
        end
    Flip()
    --Time.Sleep(75)
    end 
end
