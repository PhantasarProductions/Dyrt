--[[
/* 
  

  Copyright (C) 2014 JP Broks
  
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



Version: 14.02.15

]]
-- Written for the Secrets of Dyrt
-- If this file contains references to characters or other files
-- directly related to the main story line, usage is only allowed
-- by an unmodified version of the game.
-- If this file does not contain such references you may use it under
-- the terms of the zLib license!



-- This script was generated automatically from a setup database!

ret = {}

-- General data
ret.Arena = 'ExamRuins.png'
ret.VictoryTune = 'Victory.ogg'
ret.Music = 'BATTLE.OGG'


ok=true
rtimeout=0

repeat
 ok=true
 r = Math.Rand(0,14) -- Which one shall we pick today?
 for ak=1,9 do ret['Enemy'..ak] = nil end -- Make sure all enemy spots are empty in case a previous attempt to pick a right one failed!

 -- Encounter #0
 if r==0 then
     ret.Migrant=0
     ret.Enemy1 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #1
 if r==1 then
     ret.Migrant=0
     ret.Enemy1 = 'BSLIME'
     ret.Migrant = ret.Migrant + 0
     ret.Enemy2 = 'BSLIME'
     ret.Migrant = ret.Migrant + 0
     ret.Enemy3 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #2
 if r==2 then
     ret.Migrant=0
     ret.Enemy1 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy2 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy3 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy4 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy5 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy6 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #3
 if r==3 then
     ret.Migrant=0
     ret.Enemy1 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy2 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #4
 if r==4 then
     ret.Migrant=0
     ret.Enemy1 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy2 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy3 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #5
 if r==5 then
     ret.Migrant=0
     ret.Enemy1 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy2 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy3 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy4 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #6
 if r==6 then
     ret.Migrant=0
     ret.Enemy1 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy2 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy3 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy4 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy5 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy6 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy7 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy8 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy9 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     s = Sys.Val(Var.C('%SKILL'))
     if Var.C('&NEWGAME+')~='TRUE' then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #7
 if r==7 then
     ret.Migrant=0
     ret.Enemy1 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy2 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy3 = 'LGOB'
     ret.Migrant = ret.Migrant + 0
     ret.Enemy4 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy5 = 'LGOB'
     ret.Migrant = ret.Migrant + 0
     ret.Enemy6 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy7 = 'LGOB'
     ret.Migrant = ret.Migrant + 0
     ret.Enemy8 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy9 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #8
 if r==8 then
     ret.Migrant=0
     ret.Enemy1 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #9
 if r==9 then
     ret.Migrant=0
     ret.Enemy1 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #10
 if r==10 then
     ret.Migrant=0
     ret.Enemy1 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #11
 if r==11 then
     ret.Migrant=0
     ret.Enemy1 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #12
 if r==12 then
     ret.Migrant=0
     ret.Enemy1 = 'BSLIME'
     ret.Migrant = ret.Migrant + 0
     ret.Enemy2 = 'BSLIME'
     ret.Migrant = ret.Migrant + 0
     ret.Enemy3 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #13
 if r==13 then
     ret.Migrant=0
     ret.Enemy1 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy2 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy3 = 'SGOB'
     ret.Migrant = ret.Migrant + 3
     ret.Enemy4 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy5 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy6 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #14
 if r==14 then
     ret.Migrant=0
     ret.Enemy1 = 'TIGER'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy2 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 rtimeout = rtimeout + 1 if rtimeout>200000 and (not ok) then Sys.Error('Random Encounter Timeout','Enounterlist,examruins') end
until ok

-- We got everything, so we're done now!
return ret
