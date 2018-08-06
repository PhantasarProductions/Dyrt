--[[
/* 
  Dyrt - New Game

  Copyright (C) 2013, 2014 JP Broks
  
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



Version: 14.06.26

]]
function __NewGame()
Music("Wilkommen")
SetSkill()
MkBInit() -- This has the be re-configured now that the skill is truly known.
Var.D("_SAVE.NAME",GphInput("Please enter your name",LAURA.UserName()))
SetConfig()
--TestShowBox() -- Testing some crap out!
--TestFromLanguage()
setupchar.YoungIrravonia()
LAURA.Shell("PrologueStart.lua")
end

function SetSkill()
local skillname = {"Beginner","Casual Gamer","No-Life Gamer"}
local wkogay = {"What kind of gamer are you?","","Be certain of your selection as you can't change it later."}
local skilldesc = {"In this setting the game is heavily simplified so make it suitable for beginners","This is the setting in which the game is as easy or hard as it's meant to be.","In this setting the game has set you some huge handicaps to make it extra hard."}
local ch = 2
local ak
local chosen=false
local MX=Mouse.X()
local MY=Mouse.Y()
repeat
Sys.TerminateWhenRequested()
Image.Cls()
Image.Color(255,255,255)
Image.Tile("MenuBack",0,0)
Image.SetAlpha(.5)
Image.Color(0,0,0)
Image.Rect(100,200,600,80)
Image.NoFont()
Image.SetAlpha(1)
for ak=1,3 do
    Image.DText(wkogay[ak],402,(ak*15)+2,2,2)
    end
Image.DText("(c) Jeroen P. Broks 2013, All Rights Reserved",400,600,2,1)
Image.DText(skilldesc[ch],402,402,2,2)
Image.Color(255,255,255)
for ak=1,3 do
    Image.DText(wkogay[ak],400,(ak*15),2,2)
    end
Image.DText("(c) Jeroen P. Broks 2013, All Rights Reserved",398,598,2,1)
Image.DText(skilldesc[ch],400,400,2,2)
Image.Font("Fonts/Abigail.ttf",25)
-- @IF $DEBUGBUILD
Image.DText("Mouse ("..MX..","..MY..")",0,0)
-- @FI
local MH = Mouse.Hit(1)==1
for ak=1,3 do
    -- Choosing the menu item with the mouse
    if Mouse.X()~=MX or Mouse.Y()~=MY then
       -- print("Mouse moved")
       local MtX = Mouse.X()
       local MtY = Mouse.Y()
       if MtX>100 and MtX<700 and MtY>175+(ak*25) and MtY<200+(ak*25) then 
       	  ch=ak
       	  -- CSay(ch.." was chosen by mouse")
          end
       end
    -- Choosing the menu item with the keyboard
    if ch>1 and (Key.Hit(KEY_UP)==1   or joydirhit('U')) then ch=ch-1 end
    if ch<3 and (Key.Hit(KEY_DOWN)==1 or joydirhit('D')) then ch=ch+1 end
    if Key.Hit(KEY_ENTER)==1 or Key.Hit(KEY_SPACE)==1 then chosen=true end
    if MH then chosen=true end
    -- Drawing the shit itself
    Image.Color(255,255,255)
    if ch==ak then
    	Image.Color(Math.AlwaysPos(Math.Sin(Time.MSecs()/5))*255,0,Math.AlwaysPos(Math.Cos(Time.MSecs()/5))*255)
    	end
    Image.DText(skillname[ak],400,175+(ak*25),2)
    end
for ak=0,15 do
    chosen = chosen or joyhit(ak) -- Any joypad key will do to make a selection
    end
MX = Mouse.X()
MY = Mouse.Y()
Image.Flip()
if chosen then
   chosen = false
   skill = ch
   skillexptable = alt_experiencetable[skill]
   out = true
   end
until out
end

