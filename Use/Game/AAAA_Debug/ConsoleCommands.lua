--[[
/* 
  Debug Console Script for LAURA

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



Version: 14.10.14

]]

-- @IF IGNOREME
-- This part makes Eclipse sense all functions well, but the GALE Pre-Processor makes sure this will be ignored!
__consolecommand = {}
-- @FI

function __consolecommand.HELP()
local k,v
local c = 0
local r = rand(1,255)
local g = rand(1,255)
local b = rand(1,255)
local mr = rand(-1,1)
local mg = rand(-1,1)
local mb = rand(-1,1)
while mr==0 do mr=rand(-1,1) end
while mg==0 do mg=rand(-1,1) end
while mb==0 do mb=rand(-1,1) end
Key.Flush()
Console.Write("Command overview 2.0 ;)",255,255,255)
for k,v in spairs(__consolecommand) do 
    c = c + 1
    if c>30 then
       Console.Write("Hit any key...",67,45,123)
       Console.Show()
       Console.Flip()
       Key.Wait()
       c=0
       end
    r = r + mr; if r>=255 then mr=-1 elseif r<=0 then mr=1 end   
    g = g + mg; if g>=255 then mg=-1 elseif g<=0 then mg=1 end   
    b = b + mb; if b>=255 then mb=-1 elseif b<=0 then mb=1 end
    Console.Write("= "..k,r,g,b)  
    if k~=Str.Upper(k) then Console.Write("  = WARNING! Function names must be capitalized. Pleae check the Lua source!",255,0,0) end
    if type(__consolecommand[k])~='function' then Console.Write("  = WARNING! This is not a function! Please check the Lua source!",255,0,0) end
    end
end


function __consolecommand.BLOCKMAP()
local x
local y
local line = ""
for y=0, Maps.BMH() do
	for x=0,Maps.BMW() do
		if Maps.VBlockMap(x,y)==1 then
			line = line .. "X"
			else
			line = line .. "."
			end
		end
	Console.Write(line,255,0,0)
	line = ""	
	end
end

function __consolecommand.SAY(a)
local i,l
if Str.Upper(a[1])=="I WASN'T EXPECTING THE SPANISH INQUISITION" or Str.Upper(a[1])=="I DIDN'T EXPECT THE SPANISH INQUISITION"then
	Console.Write("NOBODY EXPECTS THE SPANISH INQUISITION!!!!",255,0,0) 
	-- We all love Monty Python :)
	else
	for i,l in ipairs(a) do
	    Console.Write(Var.S(l),255,200,150)
	    end
	end
end



function __consolecommand.SCRIPT(a)
local s = ""
local i,l
for i,l in ipairs(a) do
	if s ~="" then s = s ..", " end
	s = s .. l
	end
local f = loadstring(s)
f()
end


function __consolecommand.SAVE()
if CVV("&ABYSS") and right(CVV("%ABYSS.LEVEL"),1)~="0" and right(CVV("%ABYSS.LEVEL"),1)~="5" then 
   return CWrite("ERROR! You cannot save the game in this section of the abyss!",255,0,0)
   end
SaveGame()
end

function __consolecommand.LUADEFS()
local g,v
local cnt = 0
for g,v in pairs(_G) do
    cnt = cnt + 1
    Console.Write(Str.Right("     "..cnt,5).."  "..type(v).." "..g,Math.Rand(1,255),Math.Rand(1,255),Math.Rand(1,255))
    end
end

function __consolecommand.SHELL(a)
local r =  54
local g = 160
local b = 126
Console.Write('Shell Script: '..a[1],r,g,b)
if JCR5.Exist(a[1])==0 then
   Console.Write("? Script was not found!",255,0,0)
   return
   end
LAURA.Shell('/'..a[1],a[2])
Console.Write('Shell Done',r,g,b)
end

function __consolecommand.SETSH(a)
SAVESH = a
CSay('Shell set');
end

function __consolecommand.SH()
if not SAVESH then Console.Write('? Shell not set!',255,0,0) return end
__consolecommand.SHELL(SAVESH)
end

function __consolecommand.MAPTEXT()
Maps.Run("DebugMapText")
end

function __consolecommand.RELOADROOM()
local x,y,w,cx,cy
Actors.Pick("Player")
x = Actors.PA_X()
y = Actors.PA_Y()
w = Actors.PA_Wind()
cx = Maps.CamX
cy = Maps.CamY
Maps.LoadMap(Maps.MapName)
local spot = "**RELOADCHARRESPOT**"
teleporters[spot]      = {}
teleporters[spot].X    = x 
teleporters[spot].Y    = y
teleporters[spot].Wind = w
teleporters[spot].CamX = cx
teleporters[spot].CamY = cy
CSay("Looking for zone: "..sval(OldZone))
TrueSpawnPlayer(spot)
local zone = Maps.MapSpot('Zone_Visibility',x,y)
CSay("Room \""..Maps.MapName.."\"Reloaded!")
end

function __consolecommand.SPELLANI(a)
if not SpellAni[a[1]] then Console.Write("? SpellAni '"..a[1].."' does not exist!",255,0,0) return end
SpellAni[a[1]](a[2],a[3])
end 

function __consolecommand.EXITLIST(a)
if not teleporters then 
   Console.Write("? No exists loaded yet",255,0,0)
   return
   end
local spot,exit,f,v
for spot,exit in spairs(teleporters) do
    Console.Write("- Spot: "..spot,255,0,255)
    for f,v in spairs(exit) do
        Console.Write("  * "..f.." = "..v,255,255,0) 
        end
    end
end   

function __consolecommand.TELEPORT(a)
if not teleporters then 
   Console.Write("? No exists loaded yet",255,0,0)
   return
   end
if not teleporters[a[1]] then 
   Console.Write("? Spot "..a[1].." does not exist!",255,0,0)
   return
   end
Teleport(a[1])
end

function __consolecommand.ITEMMAP(a)
local s
-- @SELECT Str.Upper(a[1])
-- @CASE ''
   s = serialize('ItemMap["'..Maps.MapName..'"]',ItemMap[Maps.MapName])
-- @CASE 'ALL'   
   s = serialize(ItemMap,'ItemMap')
-- @DEFAULT   
   if ItemMap[a[1]] then s = serialize(ItemMap[a[1]],'ItemMap["'..a[1]..'"]') else s = 'That itemmap is currently empty!' end
-- @ENDSELECT
local sps = split(s,'\n')
local l
local r=rand(100,200)
local g=rand(100,200)
local b=rand(100,200)
local rm = 1
local bm = 1
local gm = 1
for _,l in pairs(sps) do
    r = r + rm
    g = g + gm
    b = b + bm
    if r==255 then rm=-1 elseif r==0 then rm=1 end
    if g==255 then gm=-1 elseif r==0 then gm=1 end
    if b==255 then bm=-1 elseif r==0 then bm=1 end
    Console.Write(l,r,g,b)
    end   
end

function __consolecommand.ZA_LIST()
CSay("Listing current zone action setup")
Maps.Run("ZA_ConsoleView")
CSay("EOLIST")
end

function __consolecommand.ACTORLIST()
Actors.List()
end

function __consolecommand.PARTY(a)
local p,np,ak
if a and a[1] and a[1]~='' then
   np = nil
   for _,p in ipairs(a) do
       if Str.Trim(p)~='' then
          if np then np = np .. "," else np="" end
          np = np .. '"'..p..'"'
          end 
       end
   if np then NewParty(np) end    
   end
for ak,p in ipairs(party) do CWrite(ak..">"..p) end  
end

function __consolecommand.MAPRUN(f)
CWrite("Calling map function: "..f[1])
CWrite("Parmeters: "..sval(f[2]))
Maps.Run(f[1],f[2])
CWrite("Operation Complete")
end

function __consolecommand.WALKTO(f)
Actors.Pick("Player")
Actors.WalkTo(Sys.Val(f[1]),Sys.Val(f[2]))
end

function __consolecommand.DEFVAR(f)
local ak,v
local value = ""
local vr = upper(f[1])
if #f<2 then CWrite("At least two parameters needed") end
for ak,v in ipairs(f) do
    if ak~=1 then
       if ak~=2 then value=value.."," end
       value = value .. v
       end
    end
Var.D(vr,value)    
CWrite(vr.. " = "..value,0,255,255)   
end

function __consolecommand.YASBLESSTEACH()
if not char.Yasathar then CWrite("Eric must first be tronsformed, dummy!",255,0,0) return end
LAURA.ExecuteGame("Teach","Yasathar;YASBLESS")
end
