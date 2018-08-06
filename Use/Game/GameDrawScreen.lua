--[[
/* 
  GameDrawScreen

  Copyright (C) 2013, 2014 Jeroen P. Broks
  
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



Version: 14.09.10

]]
messages = {}

DSX = {}

function ShowAreaNumber()
Image.Font("Fonts/scribish.ttf",25)
local a = "Area: "
local x,y
Image.Color(0,0,0)
for x=0,2 do
    for y=areay-1,areay+1 do
        Image.DText(a,x,y)
        Image.DText(Str.Right("00"..sval(OldZone),3),Image.TextWidth(a)+x,y)
        Image.DText(ZoneTitle[OldZone],x+Image.TextWidth(a.."000  "),areay)
        end
    end
Image.Color(255,255,0)
Image.DText(a,1,areay)
Image.Color(0,255,255)
Image.DText(Str.Right("00"..sval(OldZone),3),Image.TextWidth(a)+1,areay)
Image.Color(255,0,255)
Image.DText(ZoneTitle[OldZone],1+Image.TextWidth(a.."000  "),areay)
end

function ShowToe()
-- toey=toey or 700
local oo 
local e = "Enc: "
if RandEncOff then oo="OFF" else oo="ON" end
Image.Color(0,0,0)
for x=739,741 do
    for y=toey-1,toey+1 do
        Image.DText(e,x,y,1)
        Image.DText(oo,x,y)
        end
    end
Image.Color(255,255,0)
Image.DText( e,740,toey,1)
Image.Color(255,  0,255)
Image.DText(oo,740,toey)
end

function __Map_AfterDrawFloor() 
-- Items
local ak,item,it
local x,y
local izone
for ak,item in pairs(ItemMap[Maps.MapName]) do
    izone =  Maps.MapSpot('Zone_Visibility',item.X,item.Y)
    -- if izone == OldZone then
    if Maps.SpotVisible(item.X,item.Y)==1 then 
       x = (item.X*Maps.Map.GridX)+(Maps.Map.GridX/2)-Maps.CamX
       y = (item.Y*Maps.Map.GridY)+(Maps.Map.GridY/2)-Maps.CamY
       it = item.Item
       itemicon(it,x,y)
       end
    end
-- SaveSpots
local k,k2,v
for k,v in pairs(SaveSpots) do
    k2=isplit(k,",")
    izone =  Maps.MapSpot('Zone_Visibility',k2[1],k2[2])
    x=(k2[1]*Maps.Map.GridX)+(Maps.Map.GridX/2)-Maps.CamX
    y=(k2[2]*Maps.Map.GridY)+(Maps.Map.GridY  )-Maps.CamY
    --[[
    -- @SELECT v
    -- @CASE 'RED'
    Image.Color(255,0,0)
    -- @CASE 'GREEN'
    Image.Color(0,255,0)
    -- @CASE 'BLUE'
    Image.Color(0,0,255)
    -- @ENDSELECT
    if izone==OldZone then Image.Draw('SaveSpot',x,y) end
    ]]
    if Maps.SpotVisible(k2[1],k2[2])==1 then
       local codes = {RED='Save_Red',GREEN='Save_Grn',BLUE='Save_Blue'}
       Image.Draw(codes[v],x,y)
       end       
    end
-- Dernor Spots
if DernorCheckSpots then DernorCheckSpots(true) end        
end

function __Map_AfterDrawWalls()
local bx,by,bl,f
-- Movable Blocks
if MoveBlocks[OldZone] then
   for _,bl in ipairs(MoveBlocks[OldZone]) do
       f = "MB_"
       bx,by = Map2ScreenPos(bl.cx,bl.cy)
       if bl.push then f = f .. "PUSH" end
       if bl.pull then f = f .. "PULL" end 
       -- Image.Draw(f,bx,by)
       Maps.XPicW(f,bl.cx,bl.cy,bl.fx,bl.fy,"BC")
       if bl.fx>0 then bl.fx=bl.fx-2 elseif bl.fx>0 then bl.fx=bl.fx+2 end
       if bl.fy>0 then bl.fy=bl.fy-2 elseif bl.fy>0 then bl.fy=bl.fy+2 end
       end
   end
-- Dernor Spots
if DernorCheckSpots then DernorCheckSpots(false) end           
end


function DrawECN()
-- Let's do the ECN Bar first. The first time it's not defined, so we'll have to make do somehow.
-- @SELECT skill
-- @CASE 1
   ECNBarMax = 40
-- @CASE 2
   ECNBarMax = 20
-- @CASE 3
   ECNBarMax = 10
-- @ENDSELECT
ECNBar = ECNBar or ECNBarMax
-- Let's draw it now
local bary = 10+Image.Height("ECN1")
Image.Color(0,0,0)
Image.Rect(4,bary-1,102,12)
Image.Color(255,255,0)
Image.Rect(5,bary,math.floor((ECNBar/ECNBarMax)*100),10)
-- Now let's show the migrant level
MigrantLevel = MigrantLevel or 1
local ak
local nx = 10
for ak=1,Str.Length(MigrantLevel) do
    Image.Draw("ECN"..Str.Mid(MigrantLevel,ak,1),nx,10)
    nx = nx + Image.Width("ECN"..Str.Mid(MigrantLevel,ak,1))
    end
end    

function Msg(txt,x,y)
local tx = x
local ty = y
local altered
local ak,m
repeat
altered = false
for ak,m in pairs(messages) do
    if m.X > x-10 and m.X > x + 10 and m.Y >= ty and m.Y <= ty+15 then ty = ty + 20; altered = true end
    end
until not altered
local r
repeat 
r = Math.Rand(1,Time.MSecs())
until not messages[r]
messages[r] = { ["M"] = txt, ["X"] = tx, ["Y"] = ty, ["Time"] = 500}
Console.Write("Ingame message: "..txt.." at ("..tx..","..ty..")   index:"..r,180,134,143)
end

function DrawMsg()
local ak,m
local ax,ay
Image.NoFont()
for ak,m in pairs(messages) do
    Image.Color(0,0,0)
    -- for ax=m.X-1 , m.X+1 do for ay=m.Y-1 , m.Y+1 do Image.DText(m.M,ax,ay,2,2) end end
    Image.Color(Math.Rand(0,255),Math.Rand(0,255),Math.Rand(0,255))
    Image.DText(m.M,m.X,m.Y)
    messages[ak].Y = messages[ak].Y-.25 
    messages[ak].Time = messages[ak].Time - 1
    if messages[ak].Time<=0 then messages[ak] = nil end
    end
Image.Color(255,255,255)    
end

function __consolecommand.GAMEMESSAGES()
local ak,m
for ak,m in pairs(messages) do
    CSay(ak..":> ("..m.X..","..m.Y..")    '"..m.M.."'")
    end
end    

function __consolecommand.LOOK(b,v)
local z=Sys.Val(b[1])
local v1 = v or 1
Maps.IamSeeing(z,v1)
end

function NewDSX(Tag,X,Y,Img)
DSX[Tag] = 
   {
      X = Sys.Val(X),
      Y = Sys.Val(Y),
      r = 255,
      g = 255,
      b = 255,
      Img = Img
   }
end

function MoveDSX(Tag,X,Y,StepX,StepY)
if not DSX[Tag] then CSay("No DSX named '"..Tag.."' found. Request ignored") return end
DSX[Tag].MoveToX = Sys.Val(X)
DSX[Tag].MoveToY = Sys.Val(Y)
DSX[Tag].StepX   = Sys.Val(StepX or 1)
DSX[Tag].StepY   = Sys.Val(StepY or 1)
end

function RemoveDSX(Tag)
DSX[Tag] = nil
end

function DrawDSX()
local d
for _,d in pairs(DSX) do
    if d.MoveToX and d.MoveToX<d.X then d.X = d.X - d.StepX or 1 end
    if d.MoveToY and d.MoveToY<d.Y then d.Y = d.Y - d.StepY or 1 end
    if d.MoveToX and d.MoveToX>d.X then d.X = d.X + d.StepX or 1 end
    if d.MoveToY and d.MoveToY>d.Y then d.Y = d.Y + d.StepY or 1 end
    if not d.Before then
       if d.Img then
          Image.Color(d.r,d.g,d.b)
          Image.Draw(d.Img,d.X,d.Y)
          end
       end    
    end
end

function DoAfterDrawMap()
local room=upper(Maps.MapName)
if AfterDrawMap[room] then 
   AfterDrawMap[room]()
   -- else CWrite("No AfterDrawMap for '"..room.."' present",255) -- debug line, must be on REM in release!!! 
   end
end


function TrueDrawScreen()
Image.Cls()
Maps.Run("BackDrawScreen")
Maps.DrawMap()
DoAfterDrawMap()
DrawECN()
--DrawMsg()
ShowMiniMessages('Game')
GameFieldMessages()
AutoResetMoveBlocks()
DrawDSX()
ShowAreaNumber()
ShowToe()
end

