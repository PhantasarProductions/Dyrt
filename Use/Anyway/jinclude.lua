--[[
/* 
  J - Include

  Copyright (C) 2013 J.P. Broks
  
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



Version: 13.12.26

]]
-- This function is supposed to read an entire lua function from a JCR file
-- and return the value it returns.
function jinc(a)
local s = ''
local bt = JCR5.Open("Scripts/JINC/"..a)
while JCR5.Eof(bt)==0 do
      s = s .. Str.Char(JCR5.ReadB(bt))
      end
JCR5.Close(bt) 
print("\n\nJ_INCLUDED SCRIPT:\n"..s.."END J_INCLUDE!\n\n")
local fn = loadstring(s)
return fn()
end

JINC = jinc

if __consolecommand then
   function __consolecommand.JINCTEST()
    local a = jinc("Test.lua")
    Console.Write("Returned: "..a,rand(1,255),rand(1,255),rand(1,255))
    end
   end
