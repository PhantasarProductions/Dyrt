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
 



Version: 14.08.05

]]
function NoStatue()
if CVV("&DONE.BOSS.MOUNTAINKING") then return end
PartyPop("Yas","*bundle")
MapText("YAS")
ClearBattleVars()
BattleInit('Enemy8'       ,'MountainKing')
BattleInit('Music'        ,'Hall of the mountain king.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'YasatharTemple.PNG')
PartyUnPop()
local victory = StartCombat()
if victory then
   WorldMap_Reveal("DELISTO","GAGOLTON")
   Var.D("&DONE.BOSS.MOUNTAINKING",'TRUE')
   end
end

function GALE_OnLoad()
CSay("Welcome to the temple of Holy Yasathar!")
Music("The Complex")
ZA_Enter(6,NoStatue)
end

-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps
