--[[
/* 
  Confusion - Dyrt

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



Version: 14.02.03

]]
StatusData.Confusion = 
    {
       Img      = Image.Load("GFX/StatusChange/Confusion.png"),
       Name     = "Confused",
       AltInput = function(a,b)    -- This function will replace the regular input function.
                  local TG = {"Player","Foe"}
                  local RG = TG[rand(1,2)]
                  local ok
                  local MG = {Player = 4, Foe = 9}
                  local TT
                  local timeout = 0
                  repeat
                  TT = rand(1,MG[RG])
                  ok = Combat_HP(RG,TT) and Combat_HP(RG,TT)>0                  
                  timeout = timeout + 1
                  if timeout > 10000 and (not ok) then Sys.Error("Confusion Move Time-Out") end
                  until ok
                  ret = {}
                  ret.Action      = "ATK"
                  ret.TargetGroup = RG
                  ret.Target      = TT
                  ret.ActSpeed    = rand(1,500)
                  return ret
                  end,
       Linger   = false,
       GoneHit  = true, 
       ImgBar   = true      -- Show Image on the Health bar (player only)
    }
    
