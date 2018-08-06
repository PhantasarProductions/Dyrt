--[[
/* 
  Flip - Dyrt

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
PlayTime = PlayTime or {day=0,hr=0,mn=0,sc=0}


function UpdateTime()
local time = Time.Time()
OldPlayTimeCheck = OldPlayTimeCheck or time
if OldPlayTimeCheck~=time then
   OldPlayTimeCheck = time
   PlayTime.sc = PlayTime.sc + 1
   if PlayTime.sc>59 then PlayTime.sc=0; PlayTime.mn =PlayTime.mn +1; end
   if PlayTime.mn>59 then PlayTime.mn=0; PlayTime.hr =PlayTime.hr +1; end
   if PlayTime.hr>23 then PlayTime.hr=0; PlayTime.day=PlayTime.day+1; if PlayTime.day>=2 then AwardTrophy('48hours') end end
   end
end

function PlayTimeShow()
local ret = ""
if PlayTime.day==1 then ret = "1 day; "
elseif PlayTime.day>1 then ret = PlayTime.day.." days; " end
ret = ret .. right("0"..PlayTime.hr,2)..":"..right("0"..PlayTime.mn,2)..":"..right("0"..PlayTime.sc,2)
return ret
end


-- This alternate FLIP routine, won't just perform a flip
-- It will also display the recently awarded achievements.
function Flip()
UpdateTime()
if Sys.RequestTerminate()==1 then
   if Sys.Sure("Do you really want to quit?")==1 then Sys.Bye() end
   end
ScrollTrophies()
Combat_LvUpMessage()
Image.Flip()
end
