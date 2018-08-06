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
 



Version: 14.04.20

]]
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps

function GALE_OnLoad()
Music("AlignmentWithEvil")
SetUpFlasks()
end

function SetUpFlasks()
if CVV("&DONE.GREENDRAGON.FLASK.SETUP") then return end
Var.D("&DONE.GREENDRAGON.FLASK.SETUP","TRUE")
local flasks = {}
flasks.correct = rand(1,5)
flasks.notes = {{1,rand(1,10000)},{2,rand(1,10000)},{3,rand(1,10000)},{4,rand(1,10000)},{5,rand(1,10000)}}
table.remove(flasks.notes,flasks.correct)
flasks.order = {}
local ak,al,note,hinoteval,chosennote,alnote,chosenal
CSay("Compiling flask order")
for ak,note in ipairs(flasks.notes) do
    hinoteval=0
    chosennote = 1
    for al,alnote in ipairs(flasks.notes) do
        CSay(ak.."> Orderval #"..sval(alnote[1]).." is "..sval(alnote[2]).."  |||  hinoteval="..hinoteval.."; chosennote = "..chosennote.."; done="..sval(flasks.notes[al].done))
        if alnote[2]>=hinoteval and (not flasks.notes[al].done) then hinoteval = alnote[2]; chosennote = alnote[1]; chosenal=al end 
        end
    flasks.notes[chosenal].done=true    
    if ak~=4 then CSay("======= ======= ======= =======") end    
    table.insert(flasks.order,chosennote)    
    end
CSay("Outputting compiled data into sys vars")
for ak,note in ipairs(flasks.order) do
    CSay("Note #"..ak.." will refer to flask #"..note)
    Var.D("%PUZZLE.GREENDRAGON.FLASK.NOTE"..ak,note) 
    end
CSay("Leaving flask #"..flasks.correct.." as the correct flask")
Var.D("%PUZZLE.GREENDRAGON.FLASK.CORRECT",flasks.correct) 
CSay("Flask compilation done")        
end

function GetNote(noteid)
if CVV("&REVEALED.GREENDRAGON.FLASK.FLASK"..CVV("%PUZZLE.GREENDRAGON.FLASK.NOTE"..noteid)) then return end
Var.D("%TEMP.FLASK",CVV("%PUZZLE.GREENDRAGON.FLASK.NOTE"..noteid))
MapText("NOTE")
Var.D("&REVEALED.GREENDRAGON.FLASK.FLASK"..CVV("%PUZZLE.GREENDRAGON.FLASK.NOTE"..noteid),"TRUE")
end


function Donker(a)
local alpha = a or .5
LAURA.ExecuteGame('TrueDrawScreen')
Image.Color(0,0,0)
Image.SetAlpha(alpha)
Image.Rect(0,0,800,600)
Image.Color(255,255,255)
Image.SetAlpha(1)
-- @IF DEVELOPMENT
DText("Alpha: "..alpha,0,0)
-- @FI
end

function Flip()
LAURA.ExecuteGame("Flip")
end

function BalletjeBalletje()
local bb = "&DONE.GREENDRAGON.PUZZLE.BALLETJEBALLETJE"
local ak,al,am
-- Heb je dit al gedaan? Opzouten dan!
if CVV(bb) then return end
-- Configureer de puzzle
for ak=0,.5,.01 do Donker(ak); Flip() end
local flask = {}
for ak=1, 5 do
    flask[ak] = { Correct =  CVV("%PUZZLE.GREENDRAGON.FLASK.CORRECT") == ak, Revealed = CVV("&REVEALED.GREENDRAGON.FLASK.FLASK"..ak)}
    end
Key.Flush()    
-- Plaatjes laden
local imgflask = Image.Load("GFX/Scenario/BalletjeBalletje/Flask.png")
local imgskull = Image.Load("GFX/Scenario/BalletjeBalletje/Skull.png")
Image.HotCenter(imgflask)
Image.HotCenter(imgskull)
-- Laat de flesjes maar zien
repeat
 Donker()
 for ak=1,5 do
     Image.Draw(imgflask,(ak*150)-50,200)
     if flask[ak].Revealed and (not flask[ak].Correct) then Image.Draw(imgskull,(ak*150)-50,200) end
     end
 Image.Font("Fonts/Abigail.ttf",45)
 DText("Ready?",400,400,2,2)    
 Flip()    
until ActionKeyHit()
-- Schuif alles maar door elkaar
local skill = CVV("%SKILL")
local speed = {5,10,15}
local switches = {10,15,20}
local swapval
local r1,r2
for ak = 1, switches[skill] do
    repeat
    r1,r2 = rand(1,4),rand(2,5)
    until r1<r2
    swapval = flask[r1]
    flask[r1] = flask[r2]
    flask[r2] = swapval
    CSay("Swapping "..r1.." and "..r2)
    for al = speed[skill],(r2-r1)*150,speed[skill] do
        Donker() 
        for am=1,5 do
            local mod=0
            if am==r1 then mod=al elseif am==r2 then mod=al*(-1) end
            Image.Draw(imgflask,((am*150)-50)+mod,200)
            end
        Flip()    
        end    
    end
-- Kies het juiste flesje!
local P=1
Key.Flush()
repeat
Donker()
for ak=1,5 do
    if ak==P then Image.Color(255,255,255) else Image.Color(100,100,100) end
    Image.Draw(imgflask,(ak*150)-50,200)
    end
Image.Color(0xff,0xff,0xff)    
Flip()    
if (KeyHit(KEY_LEFT)  or joydirhit("L")) and P>1 then P = P - 1 end
if (KeyHit(KEY_RIGHT) or joydirhit("R")) and P<5 then P = P + 1 end     
until ActionKeyHit()
-- Welk flesje is de juiste?
for ak=1,5 do
    Image.Draw(imgflask,(ak*150)-50,200)
    if (not flask[ak].Correct) then Image.Draw(imgskull,(ak*150)-50,200) end
    end
Flip()
Time.Sleep(1000)
-- Release the pictures
Image.Free(imgflask)
Image.Free(imgskull)
-- Als je het onjuiste flesje hebt: STERF!!!!
local ch
if not flask[P].Correct then
   -- for _,ch in pairs({"Eric","Irravonia","Brendor","Scyndi","Rebecca"}) do LAURA.ExecuteGame("PartyAll") end
   LAURA.ExecuteGame("PartyAllTo1")
   return
   end
-- Oh, heb je het goede flesje? Dan hebben we een andere verrassing voor je!
if not CVV('&BOSS.GREENGUARDIAN') then
   ClearBattleVars()
   BattleInit('Num'    ,2)
   BattleInit('Enemy5'       ,'GREENGUARDIAN')
   BattleInit('Music'        ,'BOSS.OGG')
   BattleInit('VictoryTune'  ,'VICTORY.OGG')
   BattleInit('Arena'        ,'GREENDRAGONCAVE.PNG')
   if not StartCombat() then return end
   Var.D("&BOSS.GREENGUARDIAN","TRUE")
   end 
-- Baas verslagen? Dan gaan we naar het volgende deel van de dungeon ;)
LAURA.ExecuteGame('ManualTeleport','AfterBoss');
SetDefeatRespawn()
Var.D(bb,"TRUE")
Var.D("&TOE.CH2_GREENDRAGONCAVE","TRUE")
LAURA.ExecuteGame("ResetTOE")
end



function Dragon()
local heroes = {'Eric','Irravonia','Brendor','Scyndi','Rebecca'}
local P = Actors.Permanent
Actors.Permanent = 0
Actors.Despawn('Player')
Actors.Permanent = P
Maps.CamX = 1936  
Maps.CamY = 1936
local h
for _,h in ipairs(heroes) do
    SpawnActor(h,{['ID']=h,['SinglePic']='Heroes/'..h..'Right.png'}) 
    end
MapText("DRAGON_A")
NewParty('"Eric"')
ClearBattleVars()
BattleInit('Num'    ,1)
BattleInit('Enemy5'       ,'GREENDRAGON')
BattleInit('Music'        ,'BOSSDRAGON.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'GREENDRAGONCAVE.PNG')
local victory = StartCombat()
NewParty('"Eric","Irravonia","Brendor","Scyndi","Rebecca"')
if not victory then return end
MapText("DRAGON_B")
Var.D("&DONE.GREENDRAGON","TRUE")
NewSpellGroup("Eric",3,"Green Dragon",1)
SpawnPlayer("Start")
end


function Bye()
Maps.LoadMap("CH2_HiddenBush")
SpawnPlayer("FromGreen")
end
