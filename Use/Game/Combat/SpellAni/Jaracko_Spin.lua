--[[
/* 
  Jeracko Spin - Dyrt

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
function JSDEBUG(rot,speed,act)
-- @IF DEVELOPMENT
Image.Rotate(0)
Image.NoFont()
DText("Rotation:    "..rot,0,0)
DText("Speed:       "..speed,0,15)
DText("Act:         "..act,0,30)
if KeyHit(KEY_ESCAPE) then Sys.Error("User Breakout in spinning!") end
-- @FI
end


function SpellAni.JerackoSpin(G,T)
local screen = Image.GrabScreen()
Image.HotCenter(screen)
local rot = 0
local rotspeed
Image.Color(255,255,255)
SFX("SFX/Abilities/JerackoSpin.ogg")
for rotspeed=0,10 do
    rot = rot + rotspeed
    if rot>360 then rot = rot - 360 end
    Image.Rotate(rot)
    Image.Cls()
    Image.Draw(screen,400,300)
    JSDEBUG(rot,rotspeed,"Speed Up")
    Flip()
    end
for rotspeed=0,120 do
    rot = rot + 10
    if rot>360 then rot = rot - 360 end
    Image.Rotate(rot)
    Image.Cls()
    Image.Draw(screen,400,300)
    JSDEBUG(rot,rotspeed,"Keep Spinning")
    Flip()
    end
rotspeed = 10
repeat
if rotspeed>1 then rotspeed = rotspeed - 1 end
rot = rot + rotspeed
while rot>=360 do rot = rot - 360 end
Image.Rotate(rot)
Image.Cls()
Image.Draw(screen,400,300)
JSDEBUG(rot,rotspeed,"Slow Down")
Flip()
until rot==0 and rotspeed==1
Image.Free(screen)
Image.Rotate(0) -- Make sure Rotation is 0, or we won't be happy :)
end

function __consolecommand.JERACKODOESJERACKOSPIN()
local ak,FD
for ak,FD in pairs(FoeData) do
    if FD.Name=="Jeracko" then
       FoeAct = FoeAct or {}
       FoeAct[ak]              = {}
       FoeAct[ak].Action       = "ABL"
       FoeAct[ak].Ability      = "FOE_BOSS_JERACKO_SPIN"
       FoeAct[ak].ActSpeed     = 200
       FoeAct[ak].TargetGroup  = "Player"
       FoeAct[ak].Target       = 1
       CombatTime["Foes"][ak]  = 19000
       end
    end
end
