--[[
/* 
  Autoscroller for use in LAURA

  Copyright (C) 2013, 2014 Jeroen P. Broks

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
function AutoScroll()
local x,y,gox,goy,zone
if Actors.Pick("Player",1)~=1 then return end
zone = Maps.MapSpot('Zone_Visibility',Actors.PA_X(),Actors.PA_Y())
if NoScrollZone[zone] then return end -- When the player is in a no Scroll Zone, don't scroll.
local AHS = not NoHScrollZone[zone]
local AVS = not NoVScrollZone[zone]
-- Are there any scrolling boundaries to this zone, if so, override the scroll settings if needed.
local ZSB = ZoneScrollBound[zone]
--[[
if ZoneScrollBound[zone] then
   -- if ZSB.MinX and Maps.CamX==ZSB.MinX then AVS=false end
   if ZSB.MinX and Maps.CamX< ZSB.MinX then Maps.CamX = Maps.CamX+1 AHS=false end
   if ZSB.MinY and Maps.CamY< ZSB.MinY then Maps.CamY = Maps.CamY+1 AVS=false end
   if ZSB.MinX and Maps.CamX> ZSB.MinX then Maps.CamX = Maps.CamX-1 AHS=false end
   if ZSB.MinY and Maps.CamY> ZSB.MinY then Maps.CamY = Maps.CamY-1 AVS=false end
   end
-- ]]   
-- Smooth Scroll
if config.smoothscroll then
   x = (Actors.PA_X()*Maps.Map.GridX)
   y = (Actors.PA_Y()*Maps.Map.GridY)
   gox = x-400
   goy = y-300
   -- X
   -- Out of screen, let's scroll that by
   if     x>Maps.CamX+800 and AHS then Maps.CamX = Maps.CamX+8
   elseif x<Maps.CamX     and AHS then Maps.CamX = Maps.CamX-8
   -- In screen but in danger of getting out
   elseif x>Maps.CamX+600 and AHS then Maps.CamX = Maps.CamX+4
   elseif x<Maps.CamX+200 and AHS then Maps.CamX = Maps.CamX-4
   -- In screen but going slowly
   elseif Maps.CamX<gox   and AHS then Maps.CamX = Maps.CamX+1
   elseif Maps.CamX>gox   and AHS then Maps.CamX = Maps.CamX-1 end
   -- Y
   -- Out of screen, let's scroll that by
   if AVS then
     if     y>Maps.CamY+600 then Maps.CamY = Maps.CamY+8
     elseif y<Maps.CamY     then Maps.CamY = Maps.CamY-8
     -- In screen but in danger of getting out
     elseif y>Maps.CamY+400 then Maps.CamY = Maps.CamY+4
     elseif y<Maps.CamY+200 then Maps.CamY = Maps.CamY-4
     -- In screen but going slowly
     elseif Maps.CamY<goy   then Maps.CamY = Maps.CamY+1
     elseif Maps.CamY>goy   then Maps.CamY = Maps.CamY-1 end
     end
   else -- if not smoothscroll
   x = (Actors.PA_X()*Maps.Map.GridX)+Actors.PA_MvX()
   y = (Actors.PA_Y()*Maps.Map.GridY)+Actors.PA_MvY()
   gox = x-400
   goy = y-300
   if AHS then Maps.CamX=gox end       
   if AVS then Maps.CamY=goy end
   end
-- Override if bounderies are set.   
if ZoneScrollBound[zone] then
   -- if ZSB.MinX and Maps.CamX==ZSB.MinX then AVS=false end
   if ZSB.MinX and Maps.CamX< ZSB.MinX then Maps.CamX = ZSB.MinX end
   if ZSB.MinY and Maps.CamY< ZSB.MinY then Maps.CamY = ZSB.MinY end
   if ZSB.MaxX and Maps.CamX> ZSB.MaxX then Maps.CamX = ZSB.MaxX end
   if ZSB.MaxY and Maps.CamY> ZSB.MaxY then Maps.CamY = ZSB.MaxY end
   end   
end

function __consolecommand.POS()
local x,y,gox,goy,rx,ry
if Actors.Pick("Player",1)==1 then
   rx = Actors.PA_X()
   ry = Actors.PA_Y()
   x = (Actors.PA_X()*Maps.Map.GridX)+Actors.PA_MX()
   y = (Actors.PA_Y()*Maps.Map.GridY)+Actors.PA_MY()
   gox = x-400
   goy = y-300
   Console.Write("Player is at raw position ("..rx..","..ry..")",255,255,255)
   Console.Write("Player is at true position ("..x..","..y..") and the cam should go to ("..gox..","..goy..")",255,255,255)
   else
   Console.Write("Player is NOT present on this map",255,0,0)
   end
Console.Write("Cam is currently positioned at ("..Maps.CamX..","..Maps.CamY..")",255,255,255)
end

function __consolecommand.LOOK(a)
Maps.IamSeeing(Sys.Val(a[1]),1)
end
