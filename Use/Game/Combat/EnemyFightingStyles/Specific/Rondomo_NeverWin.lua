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
 



Version: 14.04.22

]]
function E_IMove.RondomoNeverWin(ACTOR)
Rondomo_NW_Cnt = (Rondomo_NW_Cnt or 0)+1
FoeAct = FoeAct or {}
FoeAct[ACTOR] = 
{
   Action      = 'ABL',
   Ability     = 'FOE_RONDOMO_BOMB',
   TargetGroup = 'Player',
   Target      = Enemy_PickTarget('Player'),
   ActSpeed    = 500
}
if Rondomo_NW_Cnt>5 then
   -- Maps.Run('BattleMapText','RONDOMO_MOAB')
   SerialBattleBoxText("Maps/CH2_BLACKDRAGONOUTDOOR","RONDOMO_MOAB")
   FoeAct[ACTOR].Ability = 'FOE_RONDOMO_SUPERMOAB'
   FoeAct[ACTOR].ActSpeed = 10
   end
end
