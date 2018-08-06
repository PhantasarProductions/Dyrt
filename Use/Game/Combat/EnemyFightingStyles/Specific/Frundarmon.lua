--[[
/**********************************************
  
  (c) Jeroen Broks, 2014, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is stricyly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.

  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************/
 



Version: 14.09.10

]]
-- @IF IGNOREME
E_IMove = {}
E_AbilityRespond = {}
E_Die = {}
Combat_AbilityEffect = {}
-- @FI

--[[

  Below is the fighting strategy of Frundarmon.
  This is one of the bosses with a more complicated approach.
  
  First an ability effect here, summon kids. 
  There was simply no need to make that one in a separate file, as the ability effects are loaded before the fighting styles, I could safely do it this way.
  
  after that the rest of this shit.
  
  Important note, Frundarmon MUST be on spot 5 and the kids will circle around him. If he's on any other spot this script will display very UNDESIRABLE behavior.
  
]]



-- We need to be able to summon a kid, well, this routine should have to do
function Combat_AbilityEffect.Frundarmon_SummonKid()
local rspot 
repeat
rspot = rand(1,9)
until rspot~=5
CWrite('- Summoning kid',0,255,255)
CWrite('  = Spot: '..rspot,255,255,0)
if Foe[rspot] then CWrite("  = REJECTED. Spot has already been taken!") return nil end
local kids = {"ELFGIRL","BEFINDOBOY","PHELYNXGIRL","HUMANBOY","FAIRYGIRL"}
local rkid = rand(1,#kids)
CWrite("  = Kid: "..kids[rkid],255,255,0)
Combat_LoadFoes({ ['Enemy'..rspot] = "KIDS_"..kids[rkid] },true) -- Only summon new kid, don't affect enemies who are already there. The 'true' value must see to that!
Combat_Reset_Enemy_List()
SpellAni.SingleHealing("Foes",5,{TargetGroup='Foes',Target=rspot})
return true
end


-- Too lazy to define everything all the time, just let's get moving :P
function FrundarmonSpell(spell,TG,TT)
local ACTOR=5  -- Obvious, but Frundarmon MUST always be at spot 5, which is the middle of the of the battle field. The kids will pop up around him :) 
FoeAct = FoeAct or {}
FoeAct[ACTOR]             = {}
FoeAct[ACTOR].Action      = 'ABL'
FoeAct[ACTOR].Ability     = spell
FoeAct[ACTOR].TargetGroup = TG or 'Foes'
FoeAct[ACTOR].Target      = TT or 5
FoeAct[ACTOR].ActSpeed    = 250
end


-- Well and here I'm gonna brew up the way Frundarmon fights.
-- I gotta note that this will surely differ depending on the chosen difficulty.
function E_IMove.Frundarmon()
local maxforsummon=9/skill
local ak
FrundarmonTurnCount = (FrundarmonTurnCount or 0) + 1
-- When no kid is present Frundarmon will always summon one.
local foundkids=false
for ak=1,9 do
    if ak~=5 then -- Ignore frundarmon himself
       foundkids = foundkids or Foe[ak]
       end
    end
if not foundkids then FrundarmonSpell("FRUNDARMON_SUMMON") return end
-- If the count is higher or equal than the maxforsummon value, summon a kid and reset the counter.
if FrundarmonTurnCount>=maxforsummon then
   FrundarmonSpell("FRUNDARMON_SUMMON")
   FrundarmonTurnCount=0
   return
   end
-- Occasionally, Frundarmon may try to make the party fall asleep, however he will not do this in the easy mode.
if skill>1 and rand(1,30/skill)==1 then FrundarmonSpell("CH_AZIELLA_SLEEP","Heroes",rand(1,4)) return end
-- When there's nothing left to do, just do nothing at all
FrundarmonSpell('FOE_SKIPTURN')
end


-- As the kids are kept in their undead state by Frundarmon's magic, they will finally rest when Frundarmon dies.
--
-- In other words, kill Frundarmon and all kids die with him.
function E_Die.Frundarmon()
local ak
for ak=1,9 do
    if ak~=5 and Foe[ak] and FoeData[ak] then Combat_Hurt('Foes',ak,Combat_HP('Foes',ak)) end
    end
end
