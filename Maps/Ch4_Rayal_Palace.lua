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
 



Version: 14.10.14

]]
-- @USEDIR Scripts/Use/AnyWay
-- @USEDIR Scripts/Use/Maps


function ACTOR_SCHARUM()
MapText("SCHARUM")
local go = BoxQuestion(MapTextArray,"SCHARUM.DUEL1")
if go~=1 then return end
SaveParty("Scharum")
local ch = GetActiveChar()
NewParty("'"..ch.."'")
ClearBattleVars()
BattleInit('Enemy8'       ,'SCHARUM')
BattleInit('Music'        ,'Battle_chapter4.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'ExamRuins.PNG')
BattleInit('DefeatAction' ,'ScharumLose')
local win = StartCombat()
local abilities = {
     Aziella   = "DOUBLE_BOLT",
     Brendor   = "FOCUS",
     Dernor    = "WILLPOWER",
     Eric      = "BACT",   
     Irravonia = "MAGICSTRIKE",
     Merya     = "VERYFASTDRAW", -- Ability name visible to the viewers is the Japanese translation to that, according to Google Translate.
     Rebecca   = "FOCUS",
     Scyndi    = "CURSEDHEALING",
     Yasathar  = "BACT"
   }
if win then
   MapText("SCHARUM.WIN")
   if abilities[ch] then LAURA.ExecuteGame("Teach",ch..";"..abilities[ch]) end
   else
   MapText("SCHARUM.LOSE")
   end
RestoreParty("Scharum")
end

function ACTOR_HERONDO()
local kathapic = "NPC/Katha.png"
if not Done("&HERONDO.FIRST") then
   LAURA.ExecuteGame("DefDefeatRespawn")
   PartyPop("King","*bundle")
   MapText("KONINGSTORY")
   if JCR5.Exist("GFX/Actors/SinglePic/"..kathapic)==0 then kathapic = "PH_FEMALE.PNG" end -- Will automatically use the placeholder until Katha is in the game, then it will automatically use Katha's actual graphic. (at least that's how it's supposed to work)   
   SpawnActor("Katha",{ ID = 'Katha',SinglePic=kathapic})
   MapText("KONINGKATHA")
   PartyUnPop()
   NewParty("'Eric'")
   Maps.LoadMap("CH4_Rayal_Palace_Upstairs_NIGHT")
   SpawnPlayer("Start")
   Look(1)
   MapText("NOSLEEP")
   -- Sys.Error("The rest of the scenario has not been scripted yet.")
   return
   end
-- If the king has no scenario value, then he will just say some crap to regular characters and act as a stone master when Aziella speaks to him.
if GetActiveChar()=='Aziella' then
   MapText("KONINGSTONE")
   StoneMaster("Herondo")
   else
   MapText("KONINGALG")
   end   
end

function ACTOR_GUARD1() MapText("GUARD") end ACTOR_GUARD2 = ACTOR_GUARD1

function ACTOR_PRIVATEGUARD()
   if GetActiveChar()=="Aziella" then 
      MapText("PRIVATEAZIELLA")
      else
      MapText("PRIVATE")
      end 
   end

function ESCHARUM()
Music("Prisoner of War - Jail - Widzy")
end

function LSCHARUM()
Music("Castle")
end

function ACTOR_MARIANA()
MapText("MARIANA")
end

function Leave()
WorldMap("AERIA")
end



function Start_Chapter5()
SpawnPlayer("VoorKoning")
PartyPop("King","*bundle")
Look(4)
MapText("START_CHAPTER_FIVE_")
local ch,x,y,Ok
local girls = {"Irravonia","Scyndi","Rebecca","Merya","Aziella"}
local boys = {"Yasathar","Brendor","Dernor"}
for _,ch in ipairs(girls) do
    Actors.Pick("Pop"..ch)
    x = Actors.PA_X()
    Actors.WalkTo(x,98)
    end
for _,ch in ipairs(boys) do Actors.ChoosePic(ch..".South") end
repeat
Ok=true
Actors.Walk()
   NextFrame = NextFrame or 4
   NextFrame = NextFrame - 1
for _,ch in ipairs(girls) do 
    Actors.Pick("Pop"..ch)
    Actors.ChoosePic(ch.."."..Actors.PA_Wind())
    if NextFrame==0 then Actors.IncFrame() end
    Ok = Ok and Actors.PA_Y()==98      
    end
if NextFrame==0 then NextFrame = 4 end  
DrawScreen()
Flip()    
until Ok 
PartyUnPop()
NewParty("'Yasathar','Brendor','Dernor'")
WorldMap_Reveal("DELISTO","ZONDRA")   
end




function GALE_OnLoad()
Music("Castle")
DungeonTitle()
ZA_Enter(0x06,ESCHARUM)
ZA_Leave(0x06,LSCHARUM)
if CVV("&DONE.ORACLE") then ZA_Enter(0xff,Leave) end
end
