--[[
/* 
  Paralysis - Dyrt

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



Version: 14.08.11

]]
-- Paralysis array
StatusData.Paralysis = 
    {
       Img           = Image.Load("GFX/StatusChange/Paralysis.png"),
       Name          = "Paralyzed",
       Interval      = 5,
       IntervalReset = 5,
       IntervalFunc  = function(TG,TT)
                       -- Let's first reset the time gauge while paralyzed
                       -- @SELECT StN[TG]
                       -- @CASE 1
                          CombatTime.Heroes[TT] = -500
                       -- @CASE 2
                          CombatTime.Foes[TT] = -1800/skill
                       -- @ENDSELECT
                       -- Paralysis only lingers for awhile. The exact interval depends on the chosen difficulty.
                       local S = StN[TG]
                       local ch
                       ParaTimer = ParaTimer or {}
                       ParaTimer[S] = ParaTimer[S] or {}
                       if S==2 then ParaTimer[S][TT] = ParaTimer[S][TT] or 6000/skill end
                       if S==1 then ParaTimer[S][TT] = ParaTimer[S][TT] or 1000*skill end
                       ParaTimer[S][TT] = ParaTimer[S][TT] - 1
                       if ParaTimer[S][TT]<=0 or rand(1,ParaTimer[S][TT])<=1 then
                          ch = TT
                          if S==1 then ch=party[TT] end
                          StatusSet[S][ch]=nil
                          ParaTimer[S][TT]=nil
                          end 
                       end,
       Linger        = false,
       GoneHit       = false, 
       ImgBar        = true      -- Show Image on the Health bar (player only)
    }

function __consolecommand.PARATIMERS()
local k1,v1
local k2,v2
if not ParaTimer then Console.Write("? No Paratimer yet set. Nobody was ever paralyzed before!",255,0,0) return end
for k1,v1 in pairs(ParaTimer) do
    for k2,v2 in pairs(v1) do
        CSay('Paratimer '..k1.."["..k2.."] = "..v2)
        end
    end
end


