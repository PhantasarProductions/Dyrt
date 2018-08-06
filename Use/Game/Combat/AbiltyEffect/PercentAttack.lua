--[[
/* 
  Dyrt - % attack

  Copyright (C) 2014 JP Broks
  
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



Version: 14.11.02

]]
-- @IF IGNOREME
Combat_AbilityEffect = {}
-- @FI


function PercentAttack(TG,TT,PC,MX)
local bhp = Combat_GetHP(TG,TT,MX)
local dmg = math.ceil(bhp*(PC/100))
local ele = upper(Str.Trim(Combat_AbilityOptions[1]))
local res
local vv = {'H','F'}
local victim = vv[StN[TG]]
local r,g,b=255,255,0
local ch
local target=TT
if ele and ele~=1 then
   if victim == 'F' then
      if not FoeData[target]["RES_"..ele] then 
         Console.Write("WARNING.... 'RES_"..ele.."' is not properly set!!! Expect an error!",255,0,0)
         end
      res = (FoeData[target]["RES_"..ele] or 0)/ 100
      else
      ch = party[target]
      if not ch then Sys.Error("Resistance for empty character","VictimGroup,"..sval(victim).."; Target,"..sval(target)..";".."TargetGroup,"..sval(act.TargetGroup)..";ch,"..sval(ch)) end
      resistance[ch] = resistance[ch] or {}
      resistance[ch][ele] = resistance[ch][ele] or 0
      res = resistance[ch][ele]
      end
   dmg = dmg - math.floor(dmg*res)   
   if res< 0 then r=255; g=0;   b=0   end -- weakness 
   if res> 0 then r=180; g=180; b=180 end -- resistant or higher resistance
   if res> 1 then r=0;   g=255; b=0   end -- absorbing
   if res==0 then r=255; g=255; b=0   end -- no special effects
   end
Combat_Hurt(TG,TT,dmg,r,g,b)
return true
end

function InitPercentAttack()
local a = {5,10,25,50,75,100,150}
local ak
for _,ak in ipairs(a) do
    Combat_AbilityEffect['PercentAttack'..ak]    = function(TG,TT) return PercentAttack(TG,TT,ak)      end
    Combat_AbilityEffect['MaxPercentAttack'..ak] = function(TG,TT) return PercentAttack(TG,TT,ak,true) end
    CSay("Percent attack created for setting: "..ak.."%")
    end
end

InitPercentAttack()
