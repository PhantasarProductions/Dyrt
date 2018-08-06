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
 



Version: 14.09.13

]]
function E_IMove.Kirana(ACTOR)
local ak,ch
local anyfull
for ak=1 , 4 do
    ch = party[ak]
    anyfull = anyfull or char[ch].HP[1]==char[ch].HP[2]
    end
if anyfull then
   FoeAct = FoeAct or {}
   FoeAct[ACTOR] = 
   {
     Action      = 'ABL',
     TargetGroup = 'Player',
     Target      = Enemy_PickTarget('Player'),
     Ability     = 'FOE_DEMONSOULBREAKER',
     ActSpeed    = 1000
   }
else
  E_IMove.Default(ACTOR)
  end
end
