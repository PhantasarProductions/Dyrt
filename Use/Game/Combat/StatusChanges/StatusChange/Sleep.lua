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
 



Version: 14.08.11

]]
-- Sleep array
StatusData.Sleep = 
    {
       Img           = Image.Load("GFX/StatusChange/Sleep.png"),
       Name          = "Sleeping",
       Interval      = 5,
       IntervalReset = 5,
       IntervalFunc  = function(TG,TT)
                       -- Let's first reset the time gauge while paralyzed
                       -- @SELECT StN[TG]
                       -- @CASE 1
                          CombatTime.Heroes[TT] = -500
                       -- @CASE 2
                          CombatTime.Foes[TT] = -1800/skill
                       -- @ENDSELECT
                       -- Paralysis only lingers for awhile. The exact interval depends on the chosen difficulty.
                       local S = StN[TG]
                       local ch
                       ParaTimer = ParaTimer or {}
                       ParaTimer[S] = ParaTimer[S] or {}
                       if S==2 then ParaTimer[S][TT] = ParaTimer[S][TT] or 6000/skill end
                       if S==1 then ParaTimer[S][TT] = ParaTimer[S][TT] or 1000*skill end
                       ParaTimer[S][TT] = ParaTimer[S][TT] - 1
                       if ParaTimer[S][TT]<=0 or rand(1,ParaTimer[S][TT])<=1 then
                          ch = TT
                          if S==1 then ch=party[TT] end
                          StatusSet[S][ch]=nil
                          ParaTimer[S][TT]=nil
                          end 
                       end,
       Linger        = false,
       GoneHit       = true, 
       ImgBar        = true      -- Show Image on the Health bar (player only)
    }
