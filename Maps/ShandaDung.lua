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
 



Version: 14.09.17

]]
function GALE_OnLoad()
CSay("Entering Dungeon")
Music("Ooze")
DungeonTitle()
end

function GALE_OnUnload()
CSay("Leaving dungeon, byebye!")
end

function UitlegIrraVlieg()
if not (CVV("&TUTOR.IRRAVLIEG")) then
   Var.D("&TUTOR.IRRAVLIEG","TRUE")
   SerialBoxText("Tutorial/IrraVlieg","VLIEG")
   end
end   

function Boss()
local langtext = ReadLanguageFile("Chapter1/Blenchy")
Look(0xFE)
Maps.CamX = 816
Maps.CamY = -96
SerialBoxText(langtext,"A")
local bang = Image.Load("GFX/Scenario/Explosion.png")
Image.HotCenter(bang)
local ak
local s,v
-- SFX("SFX/Scenario/JerakosEntrance.ogg")
SFX("SFX/Scenario/OnyxBang.ogg")
for ak = 0,360,5 do
    s = math.abs(Math.Sin(ak))
    DrawScreen()
    Image.Scale(s,s)
    Image.Draw(bang,128,338)
    Image.Scale(1,1)
    Image.Flip()
    if ak==270 then SpawnActor('JERACKO',{['ID']='JERACKO',['SinglePic']='Onyx/Jeracko.png'}) end
    end
Image.Free(bang)
SerialBoxText(langtext,"B")
Actors.Permanent = 0
Actors.Despawn("BLENCHY")
Actors.Permanent = 1
SFX("SFX/Scenario/Jeracko makes Blenchy Disappear.ogg")
SerialBoxText(langtext,"C")
ClearBattleVars()
BattleInit('Num'    ,9)
BattleInit('Enemy8'       ,'JERACKO1')
BattleInit("Enemy1"       ,"ORC")
BattleInit("Enemy2"       ,"SKELETON")
BattleInit("Enemy3"       ,"GHOST")
BattleInit('Music'        ,'ORDEROFONYX.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'SHANDA.PNG')
v = StartCombat() 
if not v then return end
SerialBoxText(langtext,"D")
-- This seems a bit double, but it was done because there is always a possibility the player loses from Jeracko and this way I am sure that the memory is always in order no matter what happens.
bang = Image.Load("GFX/Scenario/Explosion.png")
Image.HotCenter(bang)
SFX("SFX/Scenario/OnyxBang.ogg")
-- SFX("SFX/Scenario/JerakosEntrance.ogg")
for ak = 0,360,5 do
    s = math.abs(Math.Sin(ak))
    DrawScreen()
    Image.Scale(s,s)
    Image.Draw(bang,128,338)
    Image.Scale(1,1)
    Image.Flip()
    if ak==270 then Actors.Remove("JERACKO") end -- Replace "Despawn" by "Remove" as "Despawn" has been deprecated.
    end
Image.Free(bang)    
Maps.LoadMap("Prison")
Maps.IamSeeing(0x01,1)
Maps.CamY = 928
Maps.CamX = 0
SerialBoxText(langtext,"E")
Maps.LoadRoom("MysteriousCrypt")
NewParty('"Brendor"')
SetActive("Brendor")
SpawnPlayer("Start")
SetDefeatRespawn()
end

-- @USEDIR Scripts/Use/Anyway
