--[[
/* 
  A few silly functions set up for lazy people like me :)

  Copyright (C) 2013, 2014 JP Broks

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



Version: 14.09.17

]]
function KeyDown(code)
return Key.Down(code)==1
end

function KeyHit(code)
return Key.Hit(code)==1
end

function MouseDown(code)
return Mouse.Down(code)==1
end

function MouseHit(code)
return Mouse.Hit(code)~=0
end


function DText(txt,x,y,ax,ay)
Image.DText(txt,x,y,ax,ay)
end

function Inc(v,b) -- Does not appear to work correctly :(
v = v + (b or 1)
end

function Dec(v,b) -- Same
v = v - (b or 1)
end


function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function rand(a,b)
if a and b then return Math.Rand(a,b) end
if a and (not b) then return Math.Rand(1,a) end
Sys.Error('Random Definition invalid')
end

function tablecontains(ptable, element)
-- print("Searching for element: "..element)
  for _, value in pairs(ptable) do
    if value == element then
      return true
    end
  end
  return false
end

function GameFlip()
if Flip then
   Flip()
   else
   LAURA.ExecuteGame('Flip','')
   end
end

function NewParty(partystring)
if TrueNewParty then
   TrueNewParty(partystring)
   else
   LAURA.ExecuteGame('TrueNewParty',partystring)
   end
end

function Look(zone)
local ak
Console.Write('Looking to zone: '..zone,130,124,196)
for ak=0,255 do
    if ak==zone then
       Maps.IamSeeing(ak,1)
       else
       Maps.IamSeeing(ak,0,-1)
       end
    end
if UberLook then UberLook(zone) else LAURA.ExecuteGame("UberLook",zone) end    
end    


function sval(b)
local ret
-- @SELECT type(b)
-- @CASE "string"
   ret =  b
-- @CASE "number"
   ret = b
-- @CASE "boolean"
   if b then ret="true" else ret="false" end
-- @CASE "function"
   ret = "function"
-- @CASE "table"
   ret = "table"
-- @CASE "nil"
   ret = "nil"   
-- @DEFAULT
   ret = "UNKNOWN: ("..type(b)..")"
-- @ENDSELECT
return ret
end

function left(s,l)
return Str.Left(s,l)
end; Left = left

function right(s,l)
return Str.Right(s,l)
end; Right = right

function upper(s)
return string.upper(s or '')
end
Upper = upper

function lower(s)
return string.lower(s or '')
end

function len(s)
return Str.Length(s)
end

function fnxor(a,b)
local ret
ret = a or b
ret = ret and (not(a and b))
return ret
end

function mousepos()
return Mouse.X(),Mouse.Y()
end

function joyx()
return round(Joy.X())
end

function joyy()
return round(Joy.Y())
end

function joyxy()
return joyx(),joyy()
end

function joyhit(b)
return Joy.Hit(b)~=0
end

function joydown(b)
return Joy.Down(b)~=0
end

function joydirhit(b,reset)
oldjoydirx = oldjoydirx or {}
oldjoydiry = oldjoydiry or {}
oldjoydirx[b] = oldjoydirx[b] or joyx()
oldjoydiry[b] = oldjoydiry[b] or joyy()
local x,y = joyxy()
local ret = false
if oldjoydirx[b]==x and oldjoydiry[b]==y then return false end
oldjoydirx[b],oldjoydiry[b] = x,y
-- @SELECT Str.Upper(b)
-- @CASE 'U'
   ret =  y== -1
-- @CASE 'N'
   ret =  y== -1
-- @CASE 'D'
   ret =  y==  1
-- @CASE 'S'
   ret =  y==  1
-- @CASE 'L'
   ret =  x== -1
-- @CASE 'W'
   ret =  x== -1
-- @CASE 'R'
   ret =  x==  1
-- @CASE 'E'
   ret =  x==  1
-- @DEFAULT
   Sys.Error('Unknown direction for joydirhit ('..sval(b)..')')
-- @ENDSELECT
--[[ Test... May NOT be anything else but comment in the final version.
CSay('b = '..sval(b)..'  old = ('..oldjoydirx..','..oldjoydiry..')..... current ('..x..','..y..')')
-- End Test ]]  
return ret
end


function PlayerCoords()
Actors.Pick("Player")
local x = Actors.PA_X()
local y = Actors.PA_Y()
local w = Actors.PA_Wind()
return x,y,w
end

function Map2ScreenPos(mx,my)
    local x=(mx*Maps.Map.GridX)+(Maps.Map.GridX/2)-Maps.CamX
    local y=(my*Maps.Map.GridY)+(Maps.Map.GridY  )-Maps.CamY
    return x,y
end 

function randomcolor()
return rand(0,255),rand(0,255),rand(0,255)
end

function white()
Image.Color(255,255,255)
end

function black()
Image.Color(0,0,0)
end

function itablejoin(t)
if type(t)~='table' then return "<INCORRECT INPUT>" end
local r 
local v
for _,v in ipairs(t) do
    if r then r = r ..", " else  r = "" end
    r = r .. sval(v)
    end
return r    
end    

function Pythagoras(x1,y1,x2,y2)
local rz1 = math.abs(x1-x2)
local rz2 = math.abs(y1-y2)
local hypotenusa = math.sqrt((rz1*rz1)+(rz2*rz2))
return hypotenusa
end

function abs(a)
return math.abs(a)
end

sin = math.sin
cos = math.cos
tan = math.tan

function vInc(v)
if left(v,1)~="%" then return CWrite("WARNING! vInc does not support var "..v,255,180,0) end
Var.D(v,CVV(v)+1)
end

function vDec(v)
if left(v,1)~="%" then return CWrite("WARNING! vDec does not support var "..v,255,180,0) end
Var.D(v,CVV(v)-1)
end

function Done(v)
local ret = Var.C(v)=="TRUE"
if not ret then Var.D(v,"TRUE") end
return ret
end

function Meanwhile()
local screen = Image.GrabScreen()
local mwimg  = Image.Load("GFX/Scenario/Meanwhile.png"); Image.HotCenter(mwimg)
local scra   = 1
local mwia   = 0
local ak
for ak=1,1000 do
    Image.Cls()
    Image.SetAlpha(scra)
    Image.Show(screen,0,0)
    if scra>0 and ak>250 then scra = scra - .05 end
    Image.SetAlpha(mwia)
    Image.Show(mwimg,400,300)
    if mwia<1 then mwia = mwia + .05 end
    Image.Flip()
    end
-- Make sure the Alpha is correct    
Image.SetAlpha(1)
-- We no longer need these images, so let's clear them up before they eat up all the memory for no reason at all :)
Image.Free(screen)
Image.Free(mwia)    
end

function SlowScroll(tx,ty,sx,sy)
local spx = sx or 1
local spy = sy or 1
repeat
if Maps.CamY>spy then
   if Maps.CamY<=ty+spy then Maps.CamY=ty else Maps.CamY=Maps.CamY-spy end
elseif Maps.CamY<spy then
   if Maps.CamY>=ty-spy then Maps.CamY=ty else Maps.CamY=Maps.CamY+spy end
   end
if Maps.CamX>spx then
   if Maps.CamX<=tx+spx then Maps.CamX=tx else Maps.CamX=Maps.CamX-spx end
elseif Maps.CamX<spx then
   if Maps.CamX>=tx-spx then Maps.CamX=tx else Maps.CamX=Maps.CamX+spx end
   end
DrawScreen()
Flip()   
until Maps.CamX==tx and Maps.CamY==ty
end
