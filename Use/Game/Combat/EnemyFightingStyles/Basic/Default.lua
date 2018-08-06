--[[
/* 
  Default Fighting Style - Dyrt

  Copyright (C) 2013, 2014 JP Broks
  
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



Version: 14.02.15

]]
function E_IMove.Default(ACTOR)
local r
local ok = false
local timeout = 0
local tgt = 0
repeat 
r = rand(1,3)
if r==1 or r==2 then -- attack
   FoeAct = FoeAct or {}
   FoeAct[ACTOR]                 = {}
   FoeAct[ACTOR].Action          = 'ATK'
   FoeAct[ACTOR].TargetGroup     = 'Heroes'
   FoeAct[ACTOR].Target          = rand(1,4)
   FoeAct[ACTOR].ActSpeed        = 250
   tgt = FoeAct[ACTOR].Target
   if party[tgt] then
      -- CSay('Considering an attack on hero #'..tgt)
      ok = char[party[tgt]].HP[1]>0 
      end
   end
if r==3 then -- abilities
   ok = EnemyPickRandomAbility(ACTOR)
   end
timeout = timeout + 1
-- This should prevent the game freezing the entire system,
-- when the computer doesn't manage to think of a valid move.
if timeout > 100000 then Sys.Error('Enemy move timeout','E_IMove,Default;ACTOR,'..ACTOR) end 
until ok
end

function EnemyPickRandomAbility(ACTOR)
local maxabl = FoeData[ACTOR]["AblMax"] or 10
local abln = rand(1,maxabl)
local ret
local abl = Abilities[FoeData[ACTOR]["Abl_"..abln]]
local r = rand(1,255)
local g = rand(1,255)
local b = rand(1,255)
local timeout
Console.Write("Foe #"..ACTOR.." wants to cast ability #"..abln.." which is "..sval(FoeData[ACTOR]["Abl_"..abln]),r,g,b)
local percent = rand(1,100)
if not FoeData[ACTOR]["Abl_"..abln] then
   Console.Write("!WARNING! Actor tried to use nil as ability. Request ignored!",255,180,100)
   return false
   end
if percent > FoeData[ACTOR]["AblUseRate_"..abln] then Console.Write("= Rejected ... "..percent.." > "..FoeData[ACTOR]["AblUseRate_"..abln],r,g,b) return false end -- Only a certain precentage if the enemy will use this move or not!
if Str.Mid(FoeData[ACTOR]["AblSkill_"..abln],skill,1)~=""..skill then Console.Write("= Rejected ... Not part of this difficulty setting! (skill="..sval(skill).."; Setting = "..sval(FoeData[ACTOR]["AblSkill_"..abln])..")",r,g,b) return false end -- Some abilities are only allowed at certain skill settings
if Str.Mid(FoeData[ACTOR]["AblSkill_"..abln],skill,4)=="N" and (not CVV("&NEWGAME+")) then Console.Write("= Rejected ... Not in New Game +") return false end -- Some abilities are only allowed in a "New Game+" setting
if FoeData[ACTOR]["Abl_"..abln]=="* NONE *" then Console.Write("= Rejected. Not a valid spell") return false end -- There was not even a valid ability chosen
if not abl then
   Console.Write("!WARNING! Actor tried to use a non-existent ability. Request ignored!",255,180,100)
   return false
   end
FoeAct = FoeAct or {}
FoeAct[ACTOR] = {}
-- Let's determine the target first    
-- @SELECT abl.Target
-- @CASE 'OS'
   FoeAct[ACTOR].TargetGroup = "Foes"
   FoeAct[ACTOR].Target      = ACTOR
-- @CASE 'EV'   
   FoeAct[ACTOR].TargetGroup = "Foes"
   FoeAct[ACTOR].Target      = ACTOR
   -- This data will be ignored, but it simply has to be defined!
-- @CASE "AF"
   FoeAct[ACTOR].TargetGroup = "Heroes"
   FoeAct[ACTOR].Target      = ACTOR
-- @CASE "AA"
   FoeAct[ACTOR].TargetGroup = "Foes"
   FoeAct[ACTOR].Target      = ACTOR
-- @CASE "1F"
   timeout = 0
   repeat
   FoeAct[ACTOR].TargetGroup = "Heroes"
   FoeAct[ACTOR].Target      = rand(1,4)
   timeout = timeout + 1
   if timeout>10000 then Sys.Error("Hero target selector timeout!") end
   until party[FoeAct[ACTOR].Target] and char[party[FoeAct[ACTOR].Target]].HP[1]>0
-- @CASE "1A"
   timeout = 0
   repeat
   FoeAct[ACTOR].TargetGroup = "Foes"
   FoeAct[ACTOR].Target      = rand(1,9)
   timeout = timeout + 1
   if timeout>10000 then Sys.Error("Foe target selector timeout!") end
   until FoeData[FoeAct[ACTOR].Target] and FoeData[FoeAct[ACTOR].Target].HP>0
-- @DEFAULT
   Sys.Error('Unknown target type: '..sval(abl.Target))   
-- @ENDSELECT
FoeAct[ACTOR].Action          = 'ABL'
FoeAct[ACTOR].Ability         = FoeData[ACTOR]["Abl_"..abln]
FoeAct[ACTOR].ActSpeed        = abl.Speed
return true    
end
