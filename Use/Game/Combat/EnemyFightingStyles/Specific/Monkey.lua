--[[
/* 
  Monkey see, monkey do - Dyrt

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
function E_AbilityRespond.Monkey(EnemyNr,TACT,from)
local reverse = { Heroes = 'Foes',   Hero    = 'Foes',   Player = 'Foes',   Players = 'Foes',
                  Enemy  = 'Heroes', Enemies = 'Heroes', Foe    = 'Heroes', Foes = 'Heroes' } 
local banned = {"CH_IRRAVONIA_BLOWAWAY","CH_ERIC_VOID","CH_MERYA_SMOKEBOMB","CH_SCYNDI_NEUTRALPOISON","CH_DERNOR_NEUTRALPOISON","CH_ERIC_NEUTRALPOISON","CH_BRENDOR_SUPASMASH","CH_SCYNDI_RAISEDEAD","CH_SCYNDI_WENIARIA","CH_SCYNDI_WHIZZY","CH_DERNOR_CHARM","CH_MERYA_PILFER","CH_MERYA_MYSTIC","CH_MERYA_SMOKEBOMB"}             
local spl
CSay("Monkey: Enemy #"..EnemyNr.." is responding to the spell you cast!")
for _,spl in ipairs(banned) do 
  if upper(TACT.Ability)==spl then CSay("  = Rejected, spell is in the banned list.") return end
  end     
TactMonkey = 
   {
   Ability = TACT.Ability,
   TargetGroup = reverse[TACT.TargetGroup],
   From = from
   }
CSay("  = Spell succesfully copied")   
end

function E_IMove.Monkey(ACTOR)
local timeout = 0
local ok
-- Nothing to copy? Okay, let's then just perform a normal attack.
if not TactMonkey then
   repeat
   FoeAct = FoeAct or {}
   FoeAct[ACTOR]                 = {}
   FoeAct[ACTOR].Action          = 'ATK'
   FoeAct[ACTOR].TargetGroup     = 'Heroes'
   FoeAct[ACTOR].Target          = rand(1,4)
   FoeAct[ACTOR].ActSpeed        = 250
   timeout = timeout + 1
   local tgt = FoeAct[ACTOR].Target
   -- This should prevent the game freezing the entire system,
   -- when the computer doesn't manage to think of a valid move.
   if timeout > 100000 then Sys.Error('Enemy move timeout','E_IMove,Default;ACTOR,'..ACTOR) end 
   ok = char[party[tgt]].HP[1]>0
   until ok
   return
   end
-- Monkey see, monkey do!
FoeAct = FoeAct or {}
FoeAct[ACTOR]             = {}
FoeAct[ACTOR].Action      = 'ABL'
FoeAct[ACTOR].Ability     = TactMonkey.Ability
FoeAct[ACTOR].TargetGroup = TactMonkey.TargetGroup
FoeAct[ACTOR].Target      = Enemy_PickTarget(TactMonkey.TargetGroup)
FoeAct[ACTOR].ActSpeed    = 500
end
