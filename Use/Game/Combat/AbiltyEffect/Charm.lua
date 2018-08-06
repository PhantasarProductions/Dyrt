--[[
/* 
  Charm - Dyrt

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



Version: 14.06.26

]]
-- IMPORTANT!
-- THIS MOVE MAY ONLY BE PERFOMED BY DERNOR OR THE SYSTEM WON'T LIKE YOU AND CRASH TO PUNISH YOU!!!!
function Combat_AbilityEffect.Charm(TGROUP,TARGET)
CSay("Charming time!")
--if StN[TGROUP]~=1 then Sys.Error("Charm by enemy???") end
--if party[ACTOR]~='Dernor' then Sys.Error("Dernor is the only one charming enough for charm :P") end
if StN[TGROUP]==1 then Sys.Error("Only enemies can be charmed") end
if not char.Dernor then Sys.Error("Where the fuck is Dernor?") end
local abc = FoeData[TARGET].CharmAbility
if (not abc) then CSay("No ability found in the database at all. Field does not exist!") return nil end
if abc=="" then CSay("No ability picked here. So let's get outta here") return nil end
abc = upper(abc)
teachlist.Dernor = teachlist.Dernor or {}
if tablecontains(teachlist.Dernor,abc) then CSay("Dernor already has this ability in his teachlist, so this charm won't work!") return nil end
if tablecontains(char.Dernor.Abilities,abc) then CSay("Dernor already has this ability in his main list, so this charm won't work!") return nil end
local G='Foe' 
HurtP[G][TARGET] = 'Charmed!'
HurtT[G][TARGET] = 250
HurtC[G][TARGET] = {255,200,200}
char.Dernor.CharmPic = char.Dernor.CharmPic or {}
char.Dernor.CharmPic[abc] = upper(Foe[TARGET])
CWrite("char.Dernor.CharmPic['"..abc.."'] = '"..sval(Foe[TARGET]).."'")
Combat_Message(FoeData[TARGET].Name.." has been charmed!") 
CWrite(FoeData[TARGET].Name.." has been charmed!",255,200,200)
Foe[TARGET]=nil
FoeData[TARGET].HP=0
Teach('Dernor',abc)
return true
end
