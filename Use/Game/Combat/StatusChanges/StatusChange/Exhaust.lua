--[[
/* 
  Exhaustion - Status Change - Dyrt

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



Version: 14.06.26

]]
-- @IF IGNOREME
StatusData = {}
-- @FI
StatusData.Exhaust = 
    {
       Img           = Image.Load("GFX/StatusChange/Exhaust.png"),
       Name          = "Exhausted",
       Interval      = 5,
       IntervalReset = 5,
       IntervalFunc  = function(TG,TT)
                       -- Combat_Hurt(TG,TT,math.ceil(Combat_HP(TG,TT,1)*0.05))
                       local ch
                       if StN[TG]==1 then
                          ch = party[TT]
                          if char[ch].AP[1]>0 then char[ch].AP[1] = char[ch].AP[1] - 1 end   
                          end 
                       end,
       Linger        = false,
       GoneHit       = false, 
       ImgBar        = true      -- Show Image on the Health bar (player only)
    }
