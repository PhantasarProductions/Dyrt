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
-- Written for the Secrets of Dyrt
-- If this file contains references to characters or other files
-- directly related to the main story line, usage is only allowed
-- by an unmodified version of the game.
-- If this file does not contain such references you may use it under
-- the terms of the zLib license!



-- This script was generated automatically from a setup database!

ret = {}

-- General data
ret.Arena = 'Forest.png'
ret.VictoryTune = 'Victory.ogg'
ret.Music = 'BATTLE_Chapter4.OGG'


ok=true
rtimeout=0

repeat
 ok=true
 r = Math.Rand(0,14) -- Which one shall we pick today?
 for ak=1,9 do ret['Enemy'..ak] = nil end -- Make sure all enemy spots are empty in case a previous attempt to pick a right one failed!

 -- Encounter #0
 if r==0 then
     ret.Migrant=0
     ret.Enemy1 = 'Shroom'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #1
 if r==1 then
     ret.Migrant=0
     ret.Enemy1 = 'Hawk'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #2
 if r==2 then
     ret.Migrant=0
     ret.Enemy1 = 'Tiger'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy2 = 'Tiger'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy3 = 'Tiger'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy4 = 'Tiger'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy5 = 'Tiger'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy6 = 'Tiger'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy7 = 'Tiger'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy8 = 'Tiger'
     ret.Migrant = ret.Migrant + 4
     ret.Enemy9 = 'Tiger'
     ret.Migrant = ret.Migrant + 4
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #3
 if r==3 then
     ret.Migrant=0
     ret.Enemy1 = 'hawk'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy2 = 'Hawk'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #4
 if r==4 then
     ret.Migrant=0
     ret.Enemy1 = 'Wolf'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'Wolf'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'Wolf'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #5
 if r==5 then
     ret.Migrant=0
     ret.Enemy1 = 'Hawk'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy2 = 'Hawk'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #6
 if r==6 then
     ret.Migrant=0
     ret.Enemy1 = 'Hawk'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy2 = 'HellHound'
     ret.Migrant = ret.Migrant + 22
     ret.Enemy3 = 'Wolf'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #7
 if r==7 then
     ret.Migrant=0
     ret.Enemy1 = 'Hag'
     ret.Migrant = ret.Migrant + 21
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #8
 if r==8 then
     ret.Migrant=0
     ret.Enemy1 = 'Death Cap'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy2 = 'Death Cap'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy3 = 'Death Cap'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #9
 if r==9 then
     ret.Migrant=0
     ret.Enemy1 = 'Hawk'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy2 = 'Hoodlum'
     ret.Migrant = ret.Migrant + 21
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #10
 if r==10 then
     ret.Migrant=0
     ret.Enemy1 = 'Hoodlum'
     ret.Migrant = ret.Migrant + 21
     ret.Enemy2 = 'hoodlum'
     ret.Migrant = ret.Migrant + 21
     ret.Enemy3 = 'HoodLum'
     ret.Migrant = ret.Migrant + 21
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #11
 if r==11 then
     ret.Migrant=0
     ret.Enemy1 = 'Ninja'
     ret.Migrant = ret.Migrant + 10
     ret.Enemy2 = 'Ninja'
     ret.Migrant = ret.Migrant + 10
     ret.Enemy3 = 'Ninja'
     ret.Migrant = ret.Migrant + 10
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #12
 if r==12 then
     ret.Migrant=0
     ret.Enemy1 = 'hawk'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy2 = 'Hawk'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy3 = 'Hawk'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #13
 if r==13 then
     ret.Migrant=0
     ret.Enemy1 = 'cheetah'
     ret.Migrant = ret.Migrant + 15
     ret.Enemy2 = 'tiger'
     ret.Migrant = ret.Migrant + 4
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #14
 if r==14 then
     ret.Migrant=0
     ret.Enemy1 = 'Hoodlum'
     ret.Migrant = ret.Migrant + 21
     ret.Enemy2 = 'Ninja'
     ret.Migrant = ret.Migrant + 10
     ret.Enemy3 = 'Highwayman'
     ret.Migrant = ret.Migrant + 10
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 rtimeout = rtimeout + 1 if rtimeout>200000 and (not ok) then Sys.Error('Random Encounter Timeout','Enounterlist,FrendorBushes') end
until ok

-- We got everything, so we're done now!
return ret
