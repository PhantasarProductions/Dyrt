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
 



Version: 14.03.27

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
ret.Arena = 'MadHouse.png'
ret.VictoryTune = 'Victory.ogg'
ret.Music = 'BATTLE_Chapter2.OGG'


ok=true
rtimeout=0

repeat
 ok=true
 r = Math.Rand(0,60) -- Which one shall we pick today?
 for ak=1,9 do ret['Enemy'..ak] = nil end -- Make sure all enemy spots are empty in case a previous attempt to pick a right one failed!

 -- Encounter #0
 if r==0 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #1
 if r==1 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #2
 if r==2 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #3
 if r==3 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #4
 if r==4 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #5
 if r==5 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #6
 if r==6 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #7
 if r==7 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #8
 if r==8 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #9
 if r==9 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #10
 if r==10 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #11
 if r==11 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #12
 if r==12 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #13
 if r==13 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #14
 if r==14 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #15
 if r==15 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #16
 if r==16 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #17
 if r==17 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #18
 if r==18 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #19
 if r==19 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #20
 if r==20 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #21
 if r==21 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #22
 if r==22 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #23
 if r==23 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #24
 if r==24 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #25
 if r==25 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #26
 if r==26 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #27
 if r==27 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #28
 if r==28 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #29
 if r==29 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #30
 if r==30 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #31
 if r==31 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #32
 if r==32 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #33
 if r==33 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #34
 if r==34 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #35
 if r==35 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #36
 if r==36 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #37
 if r==37 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #38
 if r==38 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #39
 if r==39 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #40
 if r==40 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #41
 if r==41 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #42
 if r==42 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #43
 if r==43 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy5 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #44
 if r==44 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy5 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy6 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #45
 if r==45 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy5 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy6 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy7 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy8 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #46
 if r==46 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy5 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy6 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy7 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy8 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #47
 if r==47 then
     ret.Migrant=0
     ret.Enemy1 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy2 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy3 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy4 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy5 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy6 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy7 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy8 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     ret.Enemy9 = 'ClownFace'
     ret.Migrant = ret.Migrant + 25
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #48
 if r==48 then
     ret.Migrant=0
     ret.Enemy1 = 'Lemming'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy2 = 'Lemming'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy3 = 'Lemming'
     ret.Migrant = ret.Migrant + 5
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #49
 if r==49 then
     ret.Migrant=0
     ret.Enemy1 = 'Lemming'
     ret.Migrant = ret.Migrant + 5
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #50
 if r==50 then
     ret.Migrant=0
     ret.Enemy1 = 'Slime'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #51
 if r==51 then
     ret.Migrant=0
     ret.Enemy1 = 'RedSlime'
     ret.Migrant = ret.Migrant + 5
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #52
 if r==52 then
     ret.Migrant=0
     ret.Enemy1 = 'Tiger'
     ret.Migrant = ret.Migrant + 4
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #53
 if r==53 then
     ret.Migrant=0
     ret.Enemy1 = 'Ignis'
     ret.Migrant = ret.Migrant + 10
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #54
 if r==54 then
     ret.Migrant=0
     ret.Enemy1 = 'Skeleton'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #55
 if r==55 then
     ret.Migrant=0
     ret.Enemy1 = 'BSLIME'
     ret.Migrant = ret.Migrant + 0
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #56
 if r==56 then
     ret.Migrant=0
     ret.Enemy1 = 'LGOB'
     ret.Migrant = ret.Migrant + 0
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #57
 if r==57 then
     ret.Migrant=0
     ret.Enemy1 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy2 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy3 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy4 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy5 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy6 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy7 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy8 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     ret.Enemy9 = 'GOB'
     ret.Migrant = ret.Migrant + 1
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #58
 if r==58 then
     ret.Migrant=0
     ret.Enemy1 = 'redslime'
     ret.Migrant = ret.Migrant + 5
     ret.Enemy2 = 'Redslime'
     ret.Migrant = ret.Migrant + 5
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #59
 if r==59 then
     ret.Migrant=0
     ret.Enemy1 = 'wolf'
     ret.Migrant = ret.Migrant + 8
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #60
 if r==60 then
     ret.Migrant=0
     ret.Enemy1 = 'IGNIS'
     ret.Migrant = ret.Migrant + 10
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 rtimeout = rtimeout + 1 if rtimeout>200000 and (not ok) then Sys.Error('Random Encounter Timeout','Enounterlist,madhouse') end
until ok

-- We got everything, so we're done now!
return ret
