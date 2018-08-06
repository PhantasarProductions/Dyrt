--[[
/* 
  Console Script

  Copyright (C) 2013 JP Broks

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



Version: 14.02.03

]]

-- This file needs
-- The GALE API for console usage GALE.LuaConsole
-- And the console module itself  Tricky.Console
-- Both of these have been licensed under the Mozilla Public License 2.0
-- This lua file itself has been licensed under the terms of the zLIB license, see above.

function CSay(T,Show)
Console.Write(T,255,200,180)
if Show then 
   -- local s = Set2D.Status()
   -- Set2D.On()
   Console.Show(); Image.Flip(); 
   -- if s==0 then Set2D.Off(); end
   end
end

function CWrite(T,r,g,b)
Console.Write(T,r or 255,g or 255,b or 255)
end
