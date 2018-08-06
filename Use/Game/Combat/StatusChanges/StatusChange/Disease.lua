--[[
/* 
  Disease - Status Change - Dyrt

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



Version: 14.07.03

]]
-- @IF IGNOREME
StatusData = {}
-- @FI


function InitDisease(TG,TT)
disease = disease or {}
disease[TG] = disease[TG] or {}
disease[TG][TT] = Combat_GetHP(TG,TT)
end

StatusData.Disease = 
    {
       Img           = Image.Load("GFX/StatusChange/Disease.png"),
       Name          = "Diseased",
       Interval      = 5,
       IntervalReset = 5,
       Receive       = function(TG,TT) InitDisease(TG,TT) end,
       IntervalFunc  = function(TG,TT)
                       -- Combat_Hurt(TG,TT,math.ceil(Combat_HP(TG,TT,1)*0.05))
                       if not (disease and disease[TG] and disease[TG][TT]) then InitDisease(TG,TT) end 
                       local ch
                       local mx = disease[TG][TT] or 5
                       if StN[TG]==1 then
                          ch = party[TT]
                          if char[ch].HP[1]>mx then char[ch].HP[1] = char[ch].HP[1] - 1 end
                          if char[ch].HP[1]<mx then disease[TG][TT] = char[ch].HP[1] end
                          else
                          if not Foe[TT] then return end
                          if not FoeData[TT] then return end
                          if FoeData[TT].HP>mx then FoeData[TT].HP=FoeData[TT].HP-1 end
                          if FoeData[TT].HP<mx then disease[TG][TT]=FoeData[TT].HP end
                          end 
                       end,
       Linger        = true,
       GoneHit       = false,
       Resistnace    = "Poison", 
       ImgBar        = true      -- Show Image on the Health bar (player only)
    }
