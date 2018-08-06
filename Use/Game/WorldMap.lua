--[[
/* 
  Dyrt - World Map

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



Version: 14.10.14

]]
WM_Available = WM_Available or {
   DELISTO = { DOUBLINE = 1, PRISON = 1, DRAGONCRACK = 1},
   AERIA = {},
   ['CAT-ISLAND'] = {}
   }
   
WM_Visited = WM_Visited or { DOUBLINE = 1, PRISON = 1 , JENNIFER = 1, RAYAL_PALACE = 1}   
   
-- Which music on which worldmap?   
WM_Music = { DELISTO = 'World.ogg', AERIA = "Dance of the Sugar Plum Fairy", ['CAT-ISLAND'] = 'Pippin the hunchback', DYRT = 'Silence'}   

function __consolecommand.WORLDMAP(a)
if WM_Run then Console.Write("? Worldmap already running!",255,0,0) return end
if a[1]=='' then WorldMap('Delisto') else WorldMap(a[1]) end
end



function WorldMap(AMap)
local k,v
local Map = AMap or 'Delisto' -- When no map is entered, assume that it's "Delisto" as that's the continent where most locations are anyway.
local UMap = Str.Upper(Map)
local sx=0
local sy=0
local PM=0
local P=1
local ak,y
local px,py = 0,0
local tx,ty = 0,0
local omx,omy = mousepos()
local mx,my = mousepos()
WM_Available.DELISTO["ZZZZZ_TRAINING"] = WM_Available.DELISTO["TRAINING"] -- This line was (alas) needed because of an earlier mistake. This line fixes that.
Key.Flush()
WM_Run = true
-- Load Map Picture if it's not loaded yet.
WM_Pic = WM_Pic or {}
WM_Pic[UMap] = WM_Pic[U_Map] or Image.Load("GFX/WorldMap/"..UMap..".png")
if WM_Pic[UMap]=="ERROR" then Sys.Error("Word Map Picture '"..UMap..".PNG' could not be loaded properly!") end
WM_Pointer = WM_Pointer or Image.Load('GFX/GameUI/WorldMap/Pointer.png')
-- Load the list of locations of the current map
local WM_Data = jinc("WorldMap/"..Map..".lua")
-- Make a sorted list of the locations
local WM_List = {}
for k,v in spairs(WM_Data) do
    if WM_Available[UMap][k] then
       CSay(k .. " is available and will be added to the list!")
       table.insert(WM_List,k)
       else
       CSay(k .. " is NOT available and will be skipped!")
       end
    end
-- Cue Music Please!
Music(WM_Music[UMap])    
-- Now for the REAL stuff
repeat
-- Draw Screen
mx,my = mousepos()
Image.Cls()
Image.Color(255,255,255)
Image.Draw(WM_Pic[UMap],sx,sy)
Image.Draw(WM_Pointer,px,py)
if config.bttrans then Image.SetAlpha(.5) end
ARColor(config.btback)
Image.Rect(0,0,200,600)
Image.SetAlpha(1)
ARColor(config.btfont)
Image.Line(  5,  5,195,  5) -- U
Image.Line(  5,595,195,595) -- D
Image.Line(  5,  5,  5,595) -- L
Image.Line(195,  5,195,595) -- R
Image.ViewPort(10,10,180,580)
Image.Origin(10,10-PM)
for ak,v in ipairs(WM_List) do
    y = ((ak-1)*20)+10
    if mx<190 and my>y+10 and my<y+30 and mx~=omx and my~=omy then 
       P=ak 
       omx,omy = mx,my
       end
    if ak==P then Image.Font('Fonts/Coolvetica.ttf',20) else Image.Font('Fonts/Coolvetica.ttf',15) end
    if WM_Visited[WM_List[ak]] then
       ARColor(config.btfont)
       Image.DText(WM_Data[WM_List[ak]].Caption,0,y,0,2)
       else
       ARColor(config.bthead)
       Image.DText("New: "..WM_Data[WM_List[ak]].Caption,0,y,0,2)       
       end
    if ak==P and (y-10)<(PM    ) then PM=PM-1 end
    if ak==P and (y+10)>(PM+580) then PM=PM+1 end
    end
Image.ViewPort(0,0,800,600)
Image.Origin(0,0)
Flip()
-- Keyboard shit
if (joydirhit('U') or KeyHit(KEY_UP  )) and P>1          then P = P - 1 end
if (joydirhit('D') or KeyHit(KEY_DOWN)) and WM_List[P+1] then P = P + 1 end     
-- @IF DEVELOPMENT
if KeyHit(KEY_F1) then
  LAURA.Console()
  end
-- @FI  
-- CSay("WM_List["..P.."] = "..sval(WM_List[P]))  
tx = WM_Data[WM_List[P]].X
ty = WM_Data[WM_List[P]].Y
-- Adjust pointer
if px~=tx then
   px = px + ((tx-px)/100) 
   end
if py~=ty then
   py = py + ((ty-py)/100) 
   end
if ActionKeyHit() or Mouse.Hit(1)==1 then
   WM_Visited[WM_List[P]] = true
   Key.Flush()
   Maps.LoadMap(WM_Data[WM_List[P]].Map)
   if teleporters["WMStart"] then SpawnPlayer("WMStart")
   elseif teleporters["Start"] then SpawnPlayer("Start")
   else Sys.Error("Cannot spawn player in map "..WM_Data[WM_List[P]].Map) end
   if WM_Data[WM_List[P]].MapEvent  then Maps.Run(WM_Data[WM_List[P]].MapEvent) end
   if WM_Data[WM_List[P]].GameEvent then LAURA.ExecuteGame(WM_Data[WM_List[P]]) end
   WM_Run = false
   return
   end   
until false -- In other words forever :)    
WM_Run = false
end


function WorldMap_Reveal(EMap,ETag)
local Map = Str.Upper(EMap)
local Tag = Str.Upper(ETag)
local T
CSay("EMap = "..sval(EMap))
if left(Map,1)=="*" then
  Map = right(Map,Str.Length(Map)-1)
  T = split(Map,";")
  Map = T[1]
  Tag = T[2]
  CSay("Map = "..sval(Map)..'; Tag = '..sval(Tag))
  end
if (not Map) or (not Tag) then Sys.Error("???? How could a nil value come in?","EM,"..EMap..";ET,"..ETag.."; M,"..sval(Map)..";T,"..sval(Tag)) end  
-- if not WM_Available[Map] then Sys.Error("Hey, I can't reveal stuff on a map that doesn't exist!","Map,"..Map..";Tag,"..Tag) end -- This error just popped up for error's sake (as there was no error, but still things crashed).
WM_Available[Map] =  WM_Available[Map] or {}
WM_Available[Map][Tag] = true
CSay("On world map "..Map.." tag "..Tag.." has been made available")
end
