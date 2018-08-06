--[[
/* 
  Healing - Dyrt

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



Version: 14.02.07

]]
function SpellAni.SingleHealing(TGROUP,TACTOR,TACT)
local sx,sy
if TACT.TargetGroup=='Player' or TACT.TargetGroup=='Players' or TACT.TargetGroup=='Hero' or TACT.TargetGroup=='Heroes' then sx,sy = Combat_PlayerSpot(TACT.Target) end
if TACT.TargetGroup=='Enemy'  or TACT.TargetGroup=='Enemies' or TACT.TargetGroup=='Foe'  or TACT.TargetGroup==  'Foes' then sx,sy = Combat_EnemySpot (TACT.Target) end
local ak,x,y,r,g,b
SFX('SFX/Abilities/Heal.ogg')
for ak=1,50 do
    Combat_DrawScreen()    
    for al=1,25 do
        x = rand(sx-16,sx+16)
        y = rand(sy-64,sy)
        r = rand(0,255)
        g = rand(0,255)
        b = rand(0,255)
        Image.Color(r,g,b)
        Image.Draw('SA_GLITTER',x,y)
        end
    Flip()
    end
end

function SpellAni.GroupHeal(TGROUP,TACTOR,TACT,ShowWeniaria)
local sx,sy
local mnx=800
local mny=600
local mxx=0
local mxy=0
local ak
SFX('SFX/Abilities/Heal.ogg')
if ShowWeniaria then
   SAP_Weniaria = SAP_Weniaria or Image.Load('GFX/Combat/SpellAni/Weniaria.png')
   Image.HotCenter(SAP_Weniaria)
   end
-- Which area should we cover?
for ak = 0,9 do
    sx,sy=-1,-1          
    if TACT.TargetGroup=='Player' or TACT.TargetGroup=='Players' or TACT.TargetGroup=='Hero' or TACT.TargetGroup=='Heroes' then
       if ak<=4 and party[ak] and (char[party[ak]].HP[1]>0 or ShowWeniaria) then
          sx,sy = Combat_PlayerSpot(ak)
          end
       end   
    if TACT.TargetGroup=='Enemy'  or TACT.TargetGroup=='Enemies' or TACT.TargetGroup=='Foe'  or TACT.TargetGroup==  'Foes' then
       if FoeData[ak] and FoeData[ak].HP>0 then
          sx,sy = Combat_EnemySpot (ak)
          end 
       end
    if sx<mnx and sx~=-1 then mnx=sx end
    if sy<mny and sx~=-1 then mny=sy end
    if sx>mxx and sx~=-1 then mxx=sx end
    if sy>mxy and sx~=-1 then mxy=sy end      
    end
local x,y,r,g,b    
for ak=1,50 do
    Combat_DrawScreen()
    if ShowWeniaria then
       sx,sy = Combat_PlayerSpot(1)
       Image.SetAlpha(.5)
       Image.Draw(SAP_Weniaria,sx,300)
       Image.SetAlpha(1)
       end
    for al=1,75 do
        x = rand(mnx-16,mxx+16)
        y = rand(mny-64,mxy)
        r = rand(0,255)
        g = rand(0,255)
        b = rand(0,255)
        Image.Color(r,g,b)
        Image.Draw('SA_GLITTER',x,y)
        end
    Flip()
    end    
end

function SpellAni.Weniaria(TG,TT,TA)
SpellAni.GroupHeal(nil,nil,{TargetGroup='Heroes'},true)
end


