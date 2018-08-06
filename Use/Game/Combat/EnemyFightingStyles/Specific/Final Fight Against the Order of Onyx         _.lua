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
-- @IF IGNOREME
E_IMove = {}
E_Die = {}
-- @FI





-------------
-- Aldarus --
-------------
function E_Die.Final_Aldarus() SerialBattleBoxText("Combat/OnyxDie","ALDARUS") end
E_IMove.Final_Aldarus = E_IMove.Default

-------------
-- Jeracko --
-------------
function E_Die.Final_Jeracko() SerialBattleBoxText("Combat/OnyxDie","JERACKO") end
E_IMove.Final_Jeracko = E_IMove.Default


------------
-- Kirana --
------------
function E_Die.Final_Kirana() SerialBattleBoxText("Combat/OnyxDie","KIRANA") end

function E_IMove.Final_Kirana(ACTOR)
local spots = {1,7,9}
local wounded
local dead
local i
for _,i in ipairs(spots) do
  wounded = wounded or (FoeData[i] and FoeData[i].HP~=FoeData[i].HPMax)
  dead = dead or ((not FoeData[i]) or FoeData[i].HP==0)  
  end
if dead then
   SerialBattleBoxText('Combat/OnyxDie','KIRANAHELL')
   FoeAct = FoeAct or {}
   FoeAct[ACTOR] = 
   {
     Action      = 'ABL',
     TargetGroup = 'Player',
     Target      = Enemy_PickTarget('Player'),
     Ability     = 'FOE_KIRANA_HELLFIRE',
     ActSpeed    = 1000
   }
   return
   end
if wounded then     
   FoeAct = FoeAct or {}
   FoeAct[ACTOR] = 
   {
     Action      = 'ABL',
     TargetGroup = 'Foe',
     Target      = Enemy_PickTarget('Foe'),
     Ability     = 'FOE_KIRANA_HEAL',
     ActSpeed    = 1000
   }
   return
   end
E_IMove.ABILITIESONLY(ACTOR)   
end


-------------
-- Rondomo --
-------------
function E_Die.Final_Rondomo() SerialBattleBoxText("Combat/OnyxDie","RONDOMO") end
E_IMove.Final_Rondomo = E_IMove.ABILITIESONLY

