--[[
/*
	
	
	
	
	
	(c) , , All rights reserved
	
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
		
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
		
	Exceptions to the standard GNU license are available with Jeroen's written permission given prior 
	to the project the exceptions are needed for.
*/


Version: 14.11.13

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
ret.Arena = 'NakedRocksCave.png'
ret.VictoryTune = nil
ret.Music = '*NOCHANGE*'


ok=true
rtimeout=0

repeat
 ok=true
 r = Math.Rand(0,18) -- Which one shall we pick today?
 for ak=1,9 do ret['Enemy'..ak] = nil end -- Make sure all enemy spots are empty in case a previous attempt to pick a right one failed!

 -- Encounter #0
 if r==0 then
     ret.Migrant=0
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #1
 if r==1 then
     ret.Migrant=0
     ret.Enemy1 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #2
 if r==2 then
     ret.Migrant=0
     ret.Enemy1 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #3
 if r==3 then
     ret.Migrant=0
     ret.Enemy1 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #4
 if r==4 then
     ret.Migrant=0
     ret.Enemy1 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy5 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #5
 if r==5 then
     ret.Migrant=0
     ret.Enemy1 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy5 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy6 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #6
 if r==6 then
     ret.Migrant=0
     ret.Enemy1 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy5 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy6 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy7 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #7
 if r==7 then
     ret.Migrant=0
     ret.Enemy1 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy5 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy6 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy7 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy8 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #8
 if r==8 then
     ret.Migrant=0
     ret.Enemy1 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy5 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy6 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy7 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy8 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy9 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #9
 if r==9 then
     ret.Migrant=0
     ret.Enemy1 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #10
 if r==10 then
     ret.Migrant=0
     ret.Enemy1 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #11
 if r==11 then
     ret.Migrant=0
     ret.Enemy1 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #12
 if r==12 then
     ret.Migrant=0
     ret.Enemy1 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #13
 if r==13 then
     ret.Migrant=0
     ret.Enemy1 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #14
 if r==14 then
     ret.Migrant=0
     ret.Enemy1 = 'Raven'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #15
 if r==15 then
     ret.Migrant=0
     ret.Enemy1 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #16
 if r==16 then
     ret.Migrant=0
     ret.Enemy1 = 'Skeleton'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'Skeleton'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'Skeleton'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy4 = 'Skeleton'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy5 = 'Skeleton'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy6 = 'Skeleton'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy7 = 'Skeleton'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy8 = 'Skeleton'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy9 = 'Skeleton'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #17
 if r==17 then
     ret.Migrant=0
     ret.Enemy1 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Mummy'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #18
 if r==18 then
     ret.Migrant=0
     ret.Enemy1 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'Lich'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 rtimeout = rtimeout + 1 if rtimeout>200000 and (not ok) then Sys.Error('Random Encounter Timeout','Enounterlist,DeathCave') end
until ok

-- We got everything, so we're done now!
return ret
