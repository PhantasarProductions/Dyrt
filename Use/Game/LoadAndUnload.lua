--[[
/* 
  Load & Unload

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



Version: 14.09.17

]]
function GALE_OnLoad()
Console.Write("Game Script Succesfully loaded, so let's rock, baby!",0,255,0)
Console.Write("Fetching Item Database",0,255,0)
FetchItemBase()
Console.Write("Fetching Achievements",0,255,0)
TrophyInit()
-- Console.Write("Fetching Abilities",0,255,0)
-- Abil_Init()
KiranaAbilities()
YasatharAbilities()
Console.Write("Checking config",0,0,255)
DefaultConfig()
end



function GALE_OnUnload()
local ak,f,id
if MenuPics then
   for ak,f in ipairs(MenuPics) do
       Image.Free(f)
       end
   end
for f,id in pairs(itemiconimg) do
    Console.Write("Releaseing item icon: "..f.."    ("..id..")",255,0,0)
    Image.Free(id)
    end
Image.Free(MenuCursor)
Image.Free(MenuScreen)   
Console.Write("Old Game Script has been removed from the memory",255,0,0)
end