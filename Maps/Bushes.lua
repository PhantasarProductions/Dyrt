--[[
/* 
  Bushes

  Copyright (C) 2013, 2014 Jeroen P. Broks
  
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
-- @USE Use.lua
function RejoinAfterZondra()
Music("Dance of the sugar plum fairy")
Look(0)
Maps.CamX=1856
Maps.CamY=1400
NewParty("'Yasathar','Irravonia','Brendor','Scyndi','Rebecca','Dernor','Merya','Aziella'")
PartyPop("Zondra","*bundle")
Actors.Pick("PopYasathar")
Actors.WalkTo(63,55)
Actors.Pick("PopBrendor")
Actors.WalkTo(64,55)
Actors.Pick("PopDernor")
Actors.WalkTo(65,55)
local boys={"Yasathar","Brendor","Dernor"}
local Ok
local boy,ak
repeat
Ok = true
for ak,boy in ipairs(boys) do
    Actors.Pick("Pop"..boy)
    Actors.ChoosePic(boy.."."..Actors.PA_Wind())
    Ok = Ok and Actors.PA_X()==62+ak and Actors.PA_Y()==55
    Actors.IncFrame()
    Actors.Walk()
    -- @IF DEVELOPMENT 
    Image.NoFont()
    DText(boy.." ("..Actors.PA_X()..","..Actors.PA_Y()..")", 790,ak*25,1,1)
    -- @FI
    end
DrawScreen()
Flip()    
until Ok
for ak,boy in ipairs(boys) do Actors.Pick("Pop"..boy) Actors.ChoosePic(boy..".South") end
MapText("ZONDRA")
DrawScreen ()
Time.Sleep(500)
Actors.Pick("PopRebecca")
Actors.ChoosePic("Rebecca.Faint")
DrawScreen()
Flip()
Time.Sleep(1500)
MapText("ZONDRAFAINT")
PartyUnPop()
WorldMap_Reveal("DELISTO","MERMAID")
WorldMap()
end

-- On(un)load functions
function GALE_OnLoad()
Console.Write("Welcome to the forest",0,125,0)
if CVV("&DONE.ZONDRAGRAVE") and (not Done("&DONE.ZONDRAREJOIN")) then
   ZA_Enter(0,RejoinAfterZondra)
   return
   end
-- Music("Disco4")
Music("Evergreen Dreams")
if Var.C("&CHAPTER.ONE.ANNOUNCED")~="TRUE" then 
   Chapter(1)
   Var.D("&CHAPTER.ONE.ANNOUNCED","TRUE")
   end
DungeonTitle()   
end



function GALE_OnUnload()
Console.Write("Byebye, have a nice journey",0,125,0)
end

-- Map specific functions
function ExitBush(b)
Console.Write('Exit Bush received parameter: '..b,76,16,116)
if Var.C('&BUSHESCOMPLETE') == 'TRUE' then 
   -- Sys.Error('This part is not yet coded. Waiting for the world map to be coded.')
   WorldMap()
   return
   end
if Str.Upper(b)=='BOSS' then
   -- Sys.Error('This part is not yet coded')
   ClearBattleVars()
   BattleInit('Num'    ,2)
   BattleInit('Enemy1'       ,'BSLIME')
   BattleInit('Enemy2'       ,'BSLIME')
   BattleInit('Music'        ,'BATTLE.OGG')
   BattleInit('Arena'        ,'FOREST.PNG')
   BattleInit('VictoryAction','YoungIrravoniaBoss')
   BattleInit('DefeatAction' ,'YoungIrravoniaBoss')
   StartCombat()
   if Var.C('&BIGMAMASLIME','TRUE') then 
      LAURA.Shell('/Scripts/Shell/ENDYOUNGIRRAVONIA.LUA','main','')
      end
   else
   SerialBoxText("Chapter1/Bushes_Don't_wanna_go_home","A")
   Actors.Pick("Player")
   Actors.WalkTo(Actors.PA_X()-1,Actors.PA_Y())
   end
end
   
-- @USEDIR Scripts/Use/Anyway/
