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
 



Version: 14.06.26

]]
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps



-- Our fake copy protection easter egg
function CopyProtection()
local page = rand(5,166)
local line = rand(1,30)
local word = rand(1,8)
if CVV("&DONE.EASTEREGG.COPY") then return end
Var.D("$COPY.PAGE",page)
Var.D("$COPY.LINE",line)
Var.D("$COPY.WORD",word)
MapText("COPY")
Var.D("$COPY.ENTEREDWORD",GphInput("Page #"..page.."; Line #"..line.."; Word #"..word))
MapText("ACOPY")
Var.D("&DONE.EASTEREGG.COPY","TRUE")
LAURA.ExecuteGame("AwardTrophy","COPY")
end

function TOE()
Var.D("&TOE.CH3_AIROM","TRUE")
LAURA.ExecuteGame("ResetTOE")
end

-- Brendor's push tutorial
function BrendorTutor()
if CVV("&DONE.BRENDORTUTOR") then return end
Var.D("&DONE.BRENDORTUTOR",'TRUE')
MapText("BRENDORTUTORIAL")
end


-- The Boss
function Kirana()
local ak
local kv = "&DONE.BOSS.KIRANA1"
if CVV(kv) then return end 
CWrite("PartyPopping")
PartyPop("Kir","*bundle",{"Eric","Irravonia","Brendor","Scyndi","Rebecca","Dernor","Merya","Kirana"})
CWrite("Let's start the scenario")
MapText("KIRANA_A")
Actors.Pick("PopKirana")
Actors.ChoosePic("Kirana.Wings")
MapText("KIRANA_B")
ClearBattleVars()
BattleInit('Enemy6'       ,'KIRANA1')
BattleInit('Music'        ,'ORDEROFONYX.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'MINES.PNG')
local victory = StartCombat()
if not victory then return end
Maps.CamX = 2700
Maps.CamY = -64
Var.D(kv,"TRUE")
LAURA.ExtractSwap("MapChanges/CH3_City_Gagolton.lua")
CSay("Gagolton should now be empty")
local bang = Image.Load("GFX/Scenario/Explosion.png")
Image.HotCenter(bang)
local s,v
MapText("KIRANA_C")
SFX("SFX/Scenario/OnyxBang.ogg")
for ak = 0,360,5 do
    s = math.abs(Math.Sin(ak))
    DrawScreen()
    Image.Scale(s,s)
    Image.Draw(bang,378,175)
    Image.Scale(1,1)
    Image.Flip()
    if ak==270 then Actors.Remove("PopKirana") end --SpawnActor('Aldarus',{['ID']='Aldraus',['SinglePic']='Onyx/Aldarus.png'}) end
    end
Image.Free(bang)    
MapText("KIRANA_D")
PartyUnPop()
WorldMap()    
end





-- Standard setup when loading the room.
function GALE_OnLoad()
Music("Dungeon1.ogg")
ZA_Enter(0x0e,BrendorTutor)
ZA_Enter(0x1a,Kirana)
DungeonTitle()
end
