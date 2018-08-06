--[[
/* 
  Dyrt - Curse Effect

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



Version: 14.10.14

]]
-- @IF IGNOREME
StatusData = {}
-- @FI


StatusData.Curse = 
    {
       Img           = Image.Load("GFX/StatusChange/Curse.png"),
       Name          = "Cursed",
       Interval      = 500,
       IntervalReset = 600,
       IntervalFunc  = function(TG,TT)
                       local ch
                       local ak
                       local statuschanges
                       local stc
                       if Combat_HP(TG,TT,true)<=0 then return end
                       if Combat_HP(TG,TT)<=0 then return end -- In other words", "ignore Curse if the target is already dead!
                       if StN[TG]==1 then ch = party[TT] end
                       local r = rand(1,10)
                       -- @SELECT r
                       -- @CASE 1
                          Combat_Hurt(TG,TT,math.ceil(Combat_HP(TG,TT,true)*0.05))
                       -- @CASE 2
                          if StN[TG]==1 and (rand(1,9/skill)==1) then char[ch].HP[1]=1 end
                       -- @CASE 3
                          if StN[TG]==1 and (rand(1,3*skill)==1) then char[ch].HP[1]=char[ch].HP[2] end
                       -- @CASE 4
                          if StN[TG]==1 and (rand(1,9/skill)==1) then char[ch].AP[1]=1 end
                       -- @CASE 5
                          if StN[TG]==1 and (rand(1,3*skill)==1) then char[ch].AP[1]=char[ch].AP[2] end
                       -- @CASE 6
                          statuschanges = { "Confusion", "Confusion", "Death", "Disease", "Disease", "Fear", "Fear", "Fear", "Paralysis", "Paralysis", "Paralysis", "Sleep", "Sleep", "Sleep","Sleep", "Sleep", "Poison", "Poison"}
                          if StN[TG]==1 then
                             for ak=1,4 do table.insert(statuschanges,"Exhaust") end
                             end
                          stc = statuschanges[ rand(1,#statuschanges) ]
                          Combat_CauseStatus(stc,{G=TG,T=TT})
                       -- @CASE 7
                          if StN[TG]==1 and (rand(1,9/skill)==1) then char[ch].HP[1] = rand(1,char[ch].HP[2]) end                                
                       -- @CASE 8
                          if StN[TG]==1 and (rand(1,9/skill)==1) then char[ch].AP[1] = rand(1,char[ch].AP[2]) end                                
                       -- @ENDSELECT   
                       end,
       Linger        = false,
       GoneHit       = false,
       ImgBar        = true      -- Show Image on the Health bar (player only)
    }
