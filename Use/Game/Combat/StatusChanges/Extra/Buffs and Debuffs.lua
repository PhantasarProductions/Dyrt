--[[
/* 
  Buffs and Debuffs - Dyrt

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



Version: 14.09.10

]]
Permanence = {}

function MkB(st)
StatusData[st.."Up"] =
   {
       Img           = Image.Load("GFX/StatusChange/"..st.."Up.png"),
       Name          = st.." up",
       Interval      = 2500/(skill or 1),
       IntervalReset = 2500/(skill or 1),
       IntervalFunc  = function(TG,TT)
                       if skill==1 then return end -- In easy mode, stat up does not expire.
                       if StN[TG]==2 then return end -- enemies have all these buffs permanently.
                       local ch = party[TT]
                       if not ch then return end -- Character doesn't exist.... Crash prevention (this should not be needed, though).   
                       --[[ Permanence effect has been removed. It was too buggy and I didn't want to set it right any more as it was more trouble than it was worth!                    
                       Permanence[ch] = Permanence[ch] or {}
                       if Permanence[ch][st] then return end 
                       if rand(1,6/skill)==1 then
                          StatusSet[1][ch]=nil
                          end        ]]
                       end,
       Linger        = false,
       GoneHit       = false, 
       StatUp        = st,
       Cancel        = st..'Down',
       ImgBar        = false      -- Show Image on the Health bar (player only)
    }
StatusData[st.."Down"] =
   {
       Img           = Image.Load("GFX/StatusChange/"..st.."Down.png"),
       Name          = st.." up",
       Linger        = false,
       GoneHit       = false, 
       StatDown      = st,
       Cancel        = st..'Up',
       ImgBar        = false      -- Show Image on the Health bar (player only)
    }
end


function MkBInit()
local stats = {
                  'Strength',"Defense","Intelligence","Resistance","Agility","Accuracy","Evasion"
              }
for _,st in ipairs(stats) do
    MkB(st)
    end
end
MkBInit()
