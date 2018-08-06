--[[
/* 
  Abyss Map Script

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
-- @USE /Scripts/Use/XTRA/Abyss.lua

mapself = "Abyss"

AllowItems = {
                -- Level 1 - 5
                { "APPLE","ANTIDOTE","MAGICDUST","MAGICDISC","PEPPER" },
                -- Level 6 - 10
                { "APPLE","ANTIDOTE","MAGICDUST","MAGICDISC","SALVE","APPLE","ANTIDOTE","MAGICDUST","MAGICDISC","SALVE","APPLE","ANTIDOTE","MAGICDUST","MAGICDISC","SALVE","APPLE","ANTIDOTE","MAGICDUST","MAGICDISC","SALVE","POTION","PANACEA","PEPPER","PEPPER","PEPPER","PEPPER" }                
             }

function Intro()
if not IntroDone then
   MapText("INTRO")
   IntroDone = true
   end
Var.D("%ABYSS.LEVEL",0)
Var.D("&ABYSS","TRUE")   
DungeonTitle()

end

function Bye()
Var.D("&ABYSS","FALSE")
Var.Clear("%ABYSS.LEVEL")
WorldMap()
end

function Boss()
if CVV("&DONE.BOSS.SUPERPINK") then return end
ClearBattleVars()
BattleInit('Num'    ,2)
BattleInit('Enemy5'       ,'SUPERPINK')
BattleInit('Music'        ,'BOSS.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'ABYSS.PNG')
if not StartCombat() then return false end
Var.D("_SAVE.ACCESSTOABYSS","TRUE")
Var.D("&DONE.BOSS.SUPERPINK","TRUE")
LAURA.ExecuteGame("AwardTrophy","SD_ABYSS")
end

function GALE_OnLoad()
Music('Space 1990')
ZA_Enter(0x00,Intro)
ZA_Enter(0xfc,Boss)
ZA_Enter(0xfd,Bye)
ZA_Enter(0xfe,NextLevel)
end


   
