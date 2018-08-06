--[[
/* 
  Pilfer - Dyrt

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
-- @IF IGNOREME
Combat_AbilityEffect = {}
-- @FI

-- @UNDEF PLAYERSTEALDEBUG


function Combat_AbilityEffect.PlayerSteal(TG,TT)
local hiscore = 0
local score
local slot = 0
local item = nil
local ak
local ok
local lv = char.Merya.SkillLevels[2]
if not Foe[TT] then return end
if not FoeData[TT] then return end
if FoeData[TT].HP==0 then return end
for ak=1,9 do
    -- @IF PLAYERSTEALDEBUG
    CSay("Stealing attempt:\nFoeData["..TT.."] = {\n  Item_"..ak..' = "'..sval(FoeData[TT]["Item_"..ak])..'",\n  Steal_'..ak..' = '..sval(FoeData[TT]["Steal_"..ak]..",\n  StolenFrom = "..sval(FoeData[TT].StolenFrom).."\n}\nlv = "..lv.."\n"))
    -- @FI
    ok = FoeData[TT]["Item_"..ak] and FoeData[TT]["Item_"..ak]~='' and FoeData[TT]['Steal_'..ak] and FoeData[TT]['Steal_'..ak]~=0 and FoeData[TT]['Steal_'..ak]+lv>0 
    ok = ok and (not FoeData[TT].StolenFrom)    
    if ok then
       score = rand(0,FoeData[TT]['Steal_'..ak]+lv)
       if score>hiscore then
          slot=ak
          hiscore=score
          item = FoeData[TT]["Item_"..ak]
          end
       -- @IF PLAYERSTEALDEBUG
       CSay("Steal values:  score = "..score.."; hiscore = "..hiscore.."; slot = "..slot.."; item = "..item.."  succesful takeover: "..sval(slot==ak))
       else
       CSay("Variable 'ok' is false, so no deal now")
       -- @FI     
       end
    end
if slot>0 then
   if inventory[item] and inventory[item]>=imax() then 
      slot=0 
      -- @IF PLAYERSTEALDEBUG
      CSay("Player already has "..sval(inventory[item]).."x "..item.." out of a max of "..imax())
      -- @FI
      else
      Combat_Message("You stole a "..itemdata[item].Name)
      inventory[item] = (inventory[item] or 0) + 1
      FoeData[TT]["Drop_"..slot]=0 -- A stolen item may not drop any more :P
      FoeData[TT].StolenFrom = true
      char.Merya.Stolen = (char.Merya.Stolen or 0) + 1
      if char.Merya.Stolen>= 2 then AwardTrophy("STEAL2" ) end
      if char.Merya.Stolen>=10 then AwardTrophy("STEAL10") end
      end
   end
if slot==0 then
   Combat_Message("Your stealing attempt failed!")
   end 
FoeData[TT].OnyxInvincibility = false   
return true    
end

function Combat_AbilityEffect.EnemySteal()
end
