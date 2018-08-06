--[[
/* 
  New Spell Group - Dyrt

  Copyright (C) 2014 J.P. Broks
  
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



Version: 14.03.27

]]
function NewSpellGroup(pch,pGroupNumber,pGroup,plevel)
if not GameScript then
   Var.D("$NEWSPELLGROUP.CH",pch) 
   Var.D("%NEWSPELLGROUP.GROUPNUMBER",pGroupNumber)
   Var.D("$NEWSPELLGROUP.GROUP",pGroup)
   Var.D("%NEWSPELLGROUP.LEVEL",plevel or 1)
   CSay("Transferring data to Game Script to create a new spell group!")
   CSay("$NEWSPELLGROUP.CH = "..CVV("$NEWSPELLGROUP.CH"))
   CSay("%NEWSPELLGROUP.LEVEL = "..CVV("%NEWSPELLGROUP.LEVEL"))
   CSay("$NEWSPELLGROUP.GROUP = "..CVV("$NEWSPELLGROUP.GROUP"))
   CSay("%NEWSPELLGROUP.GROUPNUMBER = "..CVV("%NEWSPELLGROUP.GROUPNUMBER"))   
   LAURA.ExecuteGame('NewSpellGroup')
   return   
   end 
local ch = pch or CVV("$NEWSPELLGROUP.CH")
local GroupNumber = pGroupNumber or CVV("%NEWSPELLGROUP.GROUPNUMBER")
local Group = Group or CVV("$NEWSPELLGROUP.GROUP")
local level = pGroupNumber or CVV("%NEWSPELLGROUP.LEVEL") or 1
if ch=="" then ch = CVV("$NEWSPELLGROUP.CH") end
if not char[ch] then Sys.Error("NewSpellGroup > Character "..ch.." does not exist!") end
char[ch].SkillNames[GroupNumber] = Group
char[ch].SkillLevels[GroupNumber] = level
char[ch].SkillExperience[GroupNumber] = 0
if skilllevelup[ch] then skilllevelup[ch](GroupNumber) end
Console.Write("Character "..ch.." gained the extra skill group "..Group.." at #"..GroupNumber.." at level "..level)
end
