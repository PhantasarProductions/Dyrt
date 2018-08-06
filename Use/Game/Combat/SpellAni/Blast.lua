--[[
/* 
  Blast - SpellAni - Dyrt

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
SpellAni = {}
-- @FI

function LoadSpellAniBlast()
local ret = Image.Load("GFX/Combat/SpellAni/Blast/Star.png")
Image.HotCenter(ret)
return ret
end

function SpellAniBlastStar(sx,sy,ex,ey)
local r,g,b = randomcolor()
ImgSpellAniBlast = ImgSpellAniBlast or LoadSpellAniBlast()
Combat_DrawScreen()
local x = rand(sx,ex)
local y = rand(sy,ey)
local s = rand(1,50)/100
Image.Scale(s,s)
Image.Color(r,g,b)
Image.Draw(ImgSpellAniBlast,x,y)
Image.Scale(1,1)
white()
Flip()
end

function SpellAni.Blast(TG,TT,TA)
--ImgSpellAniBlast = ImgSpellAniBlast or LoadSpellAniBlast()
local x,y = Combat_TargetSpot(TA.TargetGroup,TA.Target)
local sx = x - 16
local sy = y - 16
local ex = x + 16
local ey = y
local ak
for ak=1,30 do SpellAniBlastStar(sx,sy,ex,ey) end  
end

function SpellAni.Devistate(TG,TT,TA)
--ImgSpellAniBlast = ImgSpellAniBlast or LoadSpellAniBlast()
local sx,sy
local mnx=800
local mny=600
local mxx=0
local mxy=0
local ak
for ak = 0,9 do
    sx,sy=-1,-1          
    if TA.TargetGroup=='Player' or TA.TargetGroup=='Players' or TA.TargetGroup=='Hero' or TA.TargetGroup=='Heroes' then
       if ak<=4 and party[ak] and (char[party[ak]].HP[1]>0 or ShowWeniaria) then
          sx,sy = Combat_PlayerSpot(ak)
          end
       end   
    if TA.TargetGroup=='Enemy'  or TA.TargetGroup=='Enemies' or TA.TargetGroup=='Foe'  or TA.TargetGroup==  'Foes' then
       if FoeData[ak] and FoeData[ak].HP>0 then
          sx,sy = Combat_EnemySpot (ak)
          end 
       end
    if sx<mnx and sx~=-1 then mnx=sx end
    if sy<mny and sx~=-1 then mny=sy end
    if sx>mxx and sx~=-1 then mxx=sx end
    if sy>mxy and sx~=-1 then mxy=sy end      
    end
for ak=1,30 do SpellAniBlastStar(mnx,mny,mxx,mxy) end      
end
