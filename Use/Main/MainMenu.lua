--[[
/* 
  Main Menu

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
MenuItem = {}
MenuItem[1] = {}
MenuItem[1].Description = "Start a new game"
MenuItem[2] = {}
MenuItem[2].Description = "Continue a game"
MenuItem[3] = {}
MenuItem[3].Description = "Quit"


MenuItem[1].Execute = function()
CSay("Starting a new game")
StopMusic()
Game.NewGame()
-- As soon as the game's __Main function terminates, the main system will continue from here.
end

MenuItem[2].Execute = function()
CSay("Going to restore a saved game")
LoadGame()
end

MenuItem[3].Execute = function()
Sys.Bye()
end


function MainMenu()
local out=false
local ak
local ch = 2
local chosen=false
local MX=Mouse.X()
local MY=Mouse.Y()
CSay("Cue music")
TrueMusic('Wilkommen')
repeat
-- @IF !$LINUX
Sys.TerminateWhenRequested()
-- @FI
Image.Cls()
Image.Color(255,255,255)
Image.Tile("MenuBack",0,0)
Image.Draw("Logo",400-(Image.Width("Logo")/2),5)
Image.SetAlpha(.5)
Image.Color(0,0,0)
Image.Rect(100,200,600,80)
Image.NoFont()
Image.SetAlpha(1)
Image.DText("(c) Jeroen P. Broks 2013, 2014, All Rights Reserved",400,600,2,1)
Image.Color(255,255,255)
Image.DText("(c) Jeroen P. Broks 2013, 2014, All Rights Reserved",398,598,2,1)
-- @IF *DYRTGAMEJOLT
DYRTGJ.DrawAvatar(799-DYRTGJ.AvatarWidth(),0)
Image.NoFont()
Image.DText(DYRTGJ.UserName(),799,DYRTGJ.AvatarHeight()+5,1,0)
-- @FI
Image.Font("Fonts/Abigail.ttf",25)
-- @IF $DEBUGBUILD
Image.DText("Mouse ("..MX..","..MY..")",0,0)
-- @FI
-- @IF $LINUX
local MH = false
-- @ELSE 
local MH = Mouse.Hit(1)==1
-- @FI
for ak=1,3 do
    -- Choosing the menu item with the mouse
    -- @IF !$LINUX
    if Mouse.X()~=MX or Mouse.Y()~=MY then
       -- print("Mouse moved")
       local MtX = Mouse.X()
       local MtY = Mouse.Y()
       if MtX>100 and MtX<700 and MtY>175+(ak*25) and MtY<200+(ak*25) then 
       	  ch=ak
       	  -- CSay(ch.." was chosen by mouse")
          end
       end
    -- @FI
    if MH then chosen=true end
    -- Drawing the shit itself
    Image.Color(255,255,255)
    if ch==ak then
    	Image.Color(Math.AlwaysPos(Math.Sin(Time.MSecs()/5))*255,0,Math.AlwaysPos(Math.Cos(Time.MSecs()/5))*255)
    	end
    Image.DText(MenuItem[ak].Description,400,175+(ak*25),2)
    end
-- Choosing the menu item with the keyboard
if ch>1 and (Key.Hit(KEY_UP)==1   or joydirhit('U')) then ch=ch-1 end
if ch<3 and (Key.Hit(KEY_DOWN)==1 or joydirhit('D')) then ch=ch+1 end
if Key.Hit(KEY_ENTER)==1 or Key.Hit(KEY_SPACE)==1 then chosen=true end
for ak=0,15 do
    chosen = chosen or joyhit(ak) -- Any joypad key will do to make a selection
    end
-- End menu choosing by keyboard
MX = Mouse.X()
MY = Mouse.Y()
Image.Flip()
if chosen then
   chosen = false
   MenuItem[ch].Execute()
   end
until out
end


