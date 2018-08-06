--[[
/* 
  Load Game

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



Version: 14.03.27

]]
-- This config setting is needed for the savegame menu, otherwise it won't be used.
config = {
  ["btback"] = {
     ["R"] = 0,
     ["G"] = 0,
     ["B"] = 255
     },
  ["btfont"] = {
     ["R"] = 255,
     ["G"] = 255,
     ["B"] = 255    
     },  
  ["bthead"] = {
     ["R"] = 255,
     ["G"] = 255,
     ["B"] = 0
     },
  ["bttrans"] = true   ,
  key = {action = 32, action2 = 13, cancel=27},
  joy = {action = 1, cancel = 2}
  }
  
function LoadGame()
local folder = LGSelectFolder()
if not folder then return end
local sg 
local hps,hnm  -- Not needed to loadgame, but to make sure all values are caught properly. Bug prevention, or so to speak :)
sg,hnm,hps = SGScreen(folder,"CONTINUE A GAME",0,false)
if not sg then return end
StopMusic()
Game.LoadGame(folder.."/TSOD_SG."..sg)
end 

function LGSelectFolder()
local fa = SavedGameFolders()
local my = 0,y
local ak,f
local P=1
local bc=255
if (not fa) or (not fa[1]) then
	Image.Cls()
	Image.Color(255,255,255)
	Image.DText("No saved games are there yet")
	Image.Flip()
	Time.Sleep(1500)
	return nil
	end
Key.Flush()
repeat
if KeyHit(KEY_ESCAPE) or joyhit(2) then return nil end
Image.Cls()
if bc>150 then bc=bc-.5 end
DText(bc,0,0)
Image.Color(bc,bc,bc)
Image.Tile("MenuBack",0,0)
-- Image.Color(255,255,255)
-- Image.Tile("MenuBack",0,0)
Image.NoFont()
Image.DText("Under which name did you store your saved game?",400,0,2,0)
Image.ViewPort(0,30,800,600)
Image.Origin(0,30)
Image.NoFont()
for ak,f in ipairs(fa) do
    y = (ak*15)-my
	if ak==P then
	   if y>530 then my=my-1 end
	   if y<0 then my=my+1 end
	   Image.Color(255,0,0)
	   Image.SetAlpha(.5)
	   Image.Rect(0,y,800,15)
	   Image.SetAlpha(1)
	   Image.Color(255,255,0)
	   else
	   Image.Color(255,255,255)
	   end
	Image.DText(f,400,y,2,0)
	end
Image.ViewPort(0,0,800,600)
Image.Origin(0,0)
if KeyHit(KEY_ENTER) or KeyHit(KEY_SPACE) or joyhit(1) then return fa[P] end
if (KeyHit(KEY_UP)   or joydirhit('U')) and P>1 then P=P-1 end
if (KeyHit(KEY_DOWN) or joydirhit('D')) and fa[P+1] then P=P+1 end 
Image.Flip()
until false -- This should basically make this shit loop forever until a breakout is done.
end	
	
