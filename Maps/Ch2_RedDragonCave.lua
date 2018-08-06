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
-- @USEDIR Scripts/Use/AnyWay
-- @USEDIR Scripts/Use/Maps
function GALE_OnLoad()
CSay("Welcome to the Red Dragon Cave")
Music("Holy Planet")
end

function GALE_OnUnLoad()
CSay("Byebye. You will never return to the Red Dragon Cave again!")
end

function Panel(Kleur)
-- Yeah, I'm gonna speak Dutch in this puzzle.
-- You got a problem with that?
Goed = { Rood = 2, Wit = 1, Blauw = 9}
Ingevoerd = Ingevoerd or { Rood = 0, Wit = 0, Blauw = 0 }
Opmerking = Opmerking or {}
MapText("TABLET")
local ch = Str.Upper(GetActiveChar())
if not Opmerking[ch] then 
   MapText("TABLET."..ch)
   Opmerking[ch] = true 
   end 
Cijfer = BoxQuestion(MapTextArray,"TABLETQ") - 1
if Cijfer<10 then Ingevoerd[Kleur] = Cijfer end -- 10 is cancel, so that should be ignored.
local k,v
AntwoordGoed = true
for k,v in pairs(Goed) do
    AntwoordGoed = AntwoordGoed and v==Ingevoerd[k] 
    end
if AntwoordGoed then
   -- Sys.Error("You solved the puzzle, but the next part has not yet been scripted!")
   ClearBattleVars()
   BattleInit('Num'    ,1)
   BattleInit('Enemy5'       ,'REDGUARDIAN')
   BattleInit('Music'        ,'BOSS.OGG')
   BattleInit('VictoryTune'  ,'VICTORY.OGG')
   BattleInit('Arena'        ,'FIREDRAGONCAVE.PNG')
   if StartCombat() then LAURA.ExecuteGame('ManualTeleport','AfterBoss'); SetDefeatRespawn() end      
   end
end


function Dragon()
local heroes = {'Eric','Irravonia','Brendor','Scyndi','Rebecca'}
local P = Actors.Permanent
Actors.Permanent = 0
Actors.Despawn('Player')
Actors.Permanent = P
Maps.CamX = 2352
Maps.CamY = 2288
local h
for _,h in ipairs(heroes) do
    SpawnActor(h,{['ID']=h,['SinglePic']='Heroes/'..h..'Right.png'}) 
    end
MapText("END_A")
NewParty('"Eric"')
ClearBattleVars()
BattleInit('Num'    ,1)
BattleInit('Enemy5'       ,'REDDRAGON')
BattleInit('Music'        ,'BOSSDRAGON.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'FIREDRAGONCAVE.PNG')
local victory = StartCombat()
NewParty('"Eric","Irravonia","Brendor","Scyndi","Rebecca"')
if not victory then return end
MapText("END_B")
Maps.LoadRoom("CH2_DragonCrackForest")
Var.D("&DONE.TOREDDRAGON","TRUE")
SpawnPlayer("AfterRedDragon")
Maps.CamX = 2704
Maps.CamY = 2388
MapText("END_C")
WorldMap_Reveal("DELISTO","TRAINING")
WorldMap_Reveal("DELISTO","ISKAFOREST")
WorldMap_Reveal("DELISTO","XROADS")
NewSpellGroup("Eric",2,"Red Dragon",1)
end
