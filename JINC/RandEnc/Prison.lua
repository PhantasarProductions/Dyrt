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
 



Version: 14.02.07

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
ret.Arena = 'Prison.png'
ret.VictoryTune = 'Victory.ogg'
ret.Music = 'BATTLE.OGG'


ok=true
rtimeout=0

repeat
 ok=true
 r = Math.Rand(0,38) -- Which one shall we pick today?
 for ak=1,9 do ret['Enemy'..ak] = nil end -- Make sure all enemy spots are empty in case a previous attempt to pick a right one failed!

 -- Encounter #0
 if r==0 then
     ret.Migrant=0
     ret.Enemy1 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #1
 if r==1 then
     ret.Migrant=0
     ret.Enemy1 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy2 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #2
 if r==2 then
     ret.Migrant=0
     ret.Enemy1 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy2 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy3 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #3
 if r==3 then
     ret.Migrant=0
     ret.Enemy1 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy2 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy3 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy4 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy5 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy6 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #4
 if r==4 then
     ret.Migrant=0
     ret.Enemy1 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy2 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy3 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy4 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy5 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy6 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy7 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy8 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy9 = 'SLIME'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #5
 if r==5 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #6
 if r==6 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #7
 if r==7 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #8
 if r==8 then
     ret.Migrant=0
     ret.Enemy1 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #9
 if r==9 then
     ret.Migrant=0
     ret.Enemy1 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #10
 if r==10 then
     ret.Migrant=0
     ret.Enemy1 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     ret.Enemy2 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #11
 if r==11 then
     ret.Migrant=0
     ret.Enemy1 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     ret.Enemy2 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #12
 if r==12 then
     ret.Migrant=0
     ret.Enemy1 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     ret.Enemy2 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     ret.Enemy3 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #13
 if r==13 then
     ret.Migrant=0
     ret.Enemy1 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #14
 if r==14 then
     ret.Migrant=0
     ret.Enemy1 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy2 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #15
 if r==15 then
     ret.Migrant=0
     ret.Enemy1 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy2 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy3 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #16
 if r==16 then
     ret.Migrant=0
     ret.Enemy1 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy2 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #17
 if r==17 then
     ret.Migrant=0
     ret.Enemy1 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #18
 if r==18 then
     ret.Migrant=0
     ret.Enemy1 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #19
 if r==19 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #20
 if r==20 then
     ret.Migrant=0
     ret.Enemy1 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     ret.Enemy2 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     ret.Enemy3 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     ret.Enemy4 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     ret.Enemy5 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     ret.Enemy6 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #21
 if r==21 then
     ret.Migrant=0
     ret.Enemy1 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy2 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy3 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy4 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy5 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy6 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #22
 if r==22 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy4 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy5 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy6 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #23
 if r==23 then
     ret.Migrant=0
     ret.Enemy1 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     ret.Enemy4 = 'REDSLIME'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy5 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy6 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #24
 if r==24 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #25
 if r==25 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #26
 if r==26 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #27
 if r==27 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #28
 if r==28 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #29
 if r==29 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #30
 if r==30 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #31
 if r==31 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #32
 if r==32 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #33
 if r==33 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #34
 if r==34 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy3 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #35
 if r==35 then
     ret.Migrant=0
     ret.Enemy1 = 'HIRELING'
     ret.Migrant = ret.Migrant + 8
     ret.Enemy2 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #36
 if r==36 then
     ret.Migrant=0
     ret.Enemy1 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #37
 if r==37 then
     ret.Migrant=0
     ret.Enemy1 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #38
 if r==38 then
     ret.Migrant=0
     ret.Enemy1 = 'SCORPION'
     ret.Migrant = ret.Migrant + 6
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 rtimeout = rtimeout + 1 if rtimeout>200000 and (not ok) then Sys.Error('Random Encounter Timeout','Enounterlist,Prison') end
until ok

-- We got everything, so we're done now!
return ret
