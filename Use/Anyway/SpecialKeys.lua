--[[
/* 
  Special Keys Manager

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



Version: 14.02.25

]]
function KEYALT(f)
LAURA.ExecuteGame(f,"ALT")
return Var.C("&KEYALT")=='TRUE'
end

function KAV(a)
if a then return 'TRUE' else return 'FALSE' end
end

function ActionKeyHit(ALT)
if not config then return KEYALT('ActionKeyHit') end
ret = KeyHit(config.key.action) or KeyHit(config.key.action2) or (Joy.Hit(config.joy.action)==1)
if ALT=='ALT' then Var.D('&KEYALT',KAV(ret)) end
return ret
end

function CancelKeyHit(ALT)
if not config then return KEYALT('CancelKeyHit') end
ret = KeyHit(config.key.cancel) or (Joy.Hit(config.joy.cancel)~=0) or (Mouse.Hit(2)~=0)
if ALT=='ALT' then Var.D('&KEYALT',KAV(ret)) end
return ret
end

