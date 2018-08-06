--[[
/* 
  Script file for the Big Crystal Boss

  Copyright (C) 2014 Jeroen Broks
  
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



Version: 14.08.26

]]
BigCrystal =
{
      Elem = {"Fire","Water","Wind","Earth"},
      Tegen = {Fire="Water",Water="Fire",Wind="Earth",Earth="Wind"},
      CurrentElement = false,
      Spell = {Fire="CH_ERIC_FIREBLAST", Water="CH_IRRAVONIA_TSUNAMI",Wind="CH_IRRAVONIA_HURRICANE",Earth="CH_IRRAVONIA_QUAKE"}
}

function BigCrystalUpdateResistance()
local s,us
for _,s in pairs(BigCrystal.Elem) do
    us = Upper(s)
    if s==BigCrystal.Tegen[BigCrystal.CurrentElement] then
       FoeData[1]["RES_"..us]=-rand(500,5000)
    elseif s==BigCrystal.CurrentElement then
       FoeData[1]["RES_"..us]=500
    else
       FoeData[1]["RES_"..us]=100
       end 
    end
end

function E_AbilityRespond.BigCrystal(EnemyNr,TACT,from)
--local Ability = TACT.Ability
local Abl = Abilities[TACT.Ability]
if not BigCrystal.CurrentElement then
   CSay("BIG CRYSTAL: No element yet picked, so no response to any spell yet!") 
   return 
   end
CSay("BIG CRYSTAL: Abl.Attack  = "..sval(Abl.Attack))
CSay("BIG CRYSTAL: Abl.Element = "..sval(Abl.Element))
CSay("BIG CRYSTAL: Tegen       = "..sval(BigCrystal.Tegen[BigCrystal.CurrentElement]))   
if Abl.Attack and Abl.Element==BigCrystal.Tegen[BigCrystal.CurrentElement] then
   BigCrystal.CurrentElement = false
   BigCrystalUpdateResistance()
   if CombatTime.Foes[1]>10000 then CombatTime.Foes[1]=9995 end
   end
end

function E_IMove.BigCrystal(ACTOR)
local CH_ABL='CH_ERIC_DEATH'
if not BigCrystal.CurrentElement then
   BigCrystal.CurrentElement = BigCrystal.Elem[rand(1,4)]
   CH_ABL = 'BCC_'..upper(BigCrystal.CurrentElement)
   else
   CH_ABL = BigCrystal.Spell[BigCrystal.CurrentElement]
   end
FoeAct = FoeAct or {}
FoeAct[ACTOR]             = {}
FoeAct[ACTOR].Action      = 'ABL'
FoeAct[ACTOR].Ability     = CH_ABL
FoeAct[ACTOR].TargetGroup = "Player"
FoeAct[ACTOR].Target      = Enemy_PickTarget("Player")
FoeAct[ACTOR].ActSpeed    = 200   
end
