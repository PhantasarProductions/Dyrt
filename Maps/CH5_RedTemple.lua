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
 



Version: 14.10.14

]]
-- @USE use.lua



-- This function will correct the X-Axis, as room 4 can mess this up a little
function ScrollCorrect()
if Maps.CamX>1232 then Maps.CamX=Maps.CamX-1 end
end

function ACTOR_MONK()
local c = upper(GetActiveChar())
MapText("MONK."..c)
if c=="MERYA" and (not Done("&STOLEN.RED_KEY")) then
   MapText("MERYASTEAL")
   LAURA.ExecuteGame("AddItem","RED_KEY")
   end
end

function Boss()
local b="&DONE.DOOMSWEEPER"
if CVV(b) then return end
DrawScreen()
Flip()
ClearBattleVars()
BattleInit('Music'        ,'Boss')
BattleInit("Arena"        ,"RedTemple.png")
BattleInit('Enemy5'       ,'DOOMSWEEPER')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
if not StartCombat() then return end
Done(b)
end

function Red_Staff()
if not Done("&ERIC.RED_STAFF") then
   MapText("RED_STAFF")
   LAURA.ExecuteGame("AwardTrophy","SD_REDTEMPLE")
   end
end





function GALE_OnLoad()
Music("Angevin")
ZA_Cycle(1,ScrollCorrect)
ZA_Cycle(2,ScrollCorrect)
ZA_Cycle(3,ScrollCorrect)
ZA_Cycle(5,ScrollCorrect)
ZA_Enter(3,Boss)
end
