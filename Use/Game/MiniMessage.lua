--[[
/* 
  Mini Message - Dyrt

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



Version: 14.03.27

]]
MiniMessage = { Combat={}, Game={} }
MiniMinY = {Combat=50,Game=5}


function AddMiniMessage(tag,Message,x,y)
if not MiniMessage[tag] then Sys.Error("Unknown MiniMessage Tag: "..tag) end
Image.NoFont()
table.insert(MiniMessage[tag], 
    {
        x      = x,
        y      = y,
        Msg    = Message,
        XOffs  = Image.TextWidth(Message)/2,
        Timer1 = 50,
        Timer2 = 500 
    } )
Console.Write("New Message:",255,0,255)
Console.Write(" = "..tag,255,255,0)    
Console.Write(" = "..Message,255,255,0)    
Console.Write(" = ("..x..","..y..")",255,255,0)    
end


function ShowMiniMessages(tag)
if not MiniMessage[tag] then Sys.Error("ShowMiniMessage:Unknown MiniMessage Tag: "..tag) end
local cy = MiniMinY[tag]
local ak,m
local ax,ay
local mx,my
local clr = math.abs(math.sin(Time.MSecs()/150))*255
Image.NoFont()
for ak,m in ipairs(MiniMessage[tag]) do
    Image.Color(0,0,0)
    mx = m.x - m.XOffs
    my = m.y
    for ax=mx-1,mx+1 do for ay=my-1,my+1 do
        DText(m.Msg,mx,my)
        end end -- Twice a for, so twice and end.
    Image.Color(clr,clr,clr)
    DText(m.Msg,mx,my)
    if m.Timer1>0 then
       MiniMessage[tag][ak].Timer1 = m.Timer1 - 1
    elseif m.Timer2>0 then
       MiniMessage[tag][ak].Timer2 = m.Timer2 - 1
       if m.XOffs<Image.TextWidth(m.Msg) then MiniMessage[tag][ak].XOffs = m.XOffs + 1 end
       -- Regular adeption
       if m.x < 795 then MiniMessage[tag][ak].x = m.x + 2 end
       if m.y >  cy then MiniMessage[tag][ak].y = m.y - 2 end
       -- Fine tuning if needed  
       if m.x > 795 then MiniMessage[tag][ak].x = m.x - 1 end
       if m.y <  cy then MiniMessage[tag][ak].y = m.y + 1 end
    else
       if m.Timer1==0 and m.Timer2==0 then table.remove(MiniMessage[tag],ak) end
       end
    cy = cy + 20   
    end
Image.Color(0xff,0xff,0xff)    
end

function __consolecommand.MINIMESSAGES()
local lns = split(serialize('MiniMessage',MiniMessage),'\n')
local k,ln
for k,ln in ipairs(lns) do
    CSay(ln)
    end
end
