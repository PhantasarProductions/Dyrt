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
 



Version: 14.08.26

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
ret.VictoryTune = 'Victory.ogg'
ret.Music = 'BATTLE_Chapter4.OGG'


ok=true
rtimeout=0

repeat
 ok=true
 r = Math.Rand(0,7) -- Which one shall we pick today?
 for ak=1,9 do ret['Enemy'..ak] = nil end -- Make sure all enemy spots are empty in case a previous attempt to pick a right one failed!

 -- Encounter #0
 if r==0 then
     ret.Migrant=0
     ret.Enemy1 = 'Vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy2 = 'Vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy3 = 'Vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy4 = 'Vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy5 = 'Vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy6 = 'Vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy7 = 'Vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy8 = 'Vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy9 = 'Vleermuis'
     ret.Migrant = ret.Migrant + 30
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #1
 if r==1 then
     ret.Migrant=0
     ret.Enemy1 = 'brownslime'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy2 = 'brownslime'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #2
 if r==2 then
     ret.Migrant=0
     ret.Enemy1 = 'EarthElemental'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #3
 if r==3 then
     ret.Migrant=0
     ret.Enemy1 = 'raven'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy2 = 'raven'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy3 = 'raven'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #4
 if r==4 then
     ret.Migrant=0
     ret.Enemy1 = 'vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy2 = 'brownslime'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy3 = 'raven'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #5
 if r==5 then
     ret.Migrant=0
     ret.Enemy1 = 'croc'
     ret.Migrant = ret.Migrant + 10
     ret.Enemy2 = 'vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy3 = 'brownslime'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     ret.Initiative = -1
     end
 -- Encounter #6
 if r==6 then
     ret.Migrant=0
     ret.Enemy1 = 'EarthElemental'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy2 = 'EarthElemental'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     ret.Initiative = -1
     end
 -- Encounter #7
 if r==7 then
     ret.Migrant=0
     ret.Enemy1 = 'vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy2 = 'brownslime'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy3 = 'raven'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy4 = 'vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy5 = 'brownslime'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy6 = 'raven'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy7 = 'vleermuis'
     ret.Migrant = ret.Migrant + 30
     ret.Enemy8 = 'brownslime'
     ret.Migrant = ret.Migrant + 20
     ret.Enemy9 = 'raven'
     ret.Migrant = ret.Migrant + 20
     s = Sys.Val(Var.C('%SKILL'))
     if s==1 then ok=false end
     if s==2 then ok=false end
     ret.Initiative = -1
     end
 rtimeout = rtimeout + 1 if rtimeout>200000 and (not ok) then Sys.Error('Random Encounter Timeout','Enounterlist,Malabia') end
until ok

-- We got everything, so we're done now!
return ret
