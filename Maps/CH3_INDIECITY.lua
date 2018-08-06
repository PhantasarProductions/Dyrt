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
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps

function Welcome()
local ak
-- Entering town
Look(3)
Maps.CamX = 2016
Maps.CamY = 2760
PartyPop("Ent","*bundle")
MapText("ENTREE")
PartyUnPop()
-- Party time
Maps.LoadMap("CH3_INDIECITYNIGHT")
PartyPop("Party","*bundle")
Look(0x3)
Maps.CamX = 1760
-- Maps.CamY = 2560
for ak=2240,2608 do
   Maps.CamY=ak
   DrawScreen()
   Flip()
   end
MapText("PARTY__A")
SFX("SFX/GENERAL/CookSing.ogg")
Time.Sleep(500)
MapText("PARTY__B")   
PartyUnPop()
-- At night on the beach
Maps.LoadRoom("CH3_NachtStrand")
NewParty("'Dernor'")
SpawnPlayer('Dernor')
Look(0x01)
MapText('NIGHT__A')
Look(0x02)
MapText("NIGHT__B")
-- Scyndi picks a new name
local ok
local cnt = 0
local scyndi
repeat
scyndi = GphInput("Please give "..Var.C("!seelahgandra").." a new name:","Scyndi")
local leetcon = {  {" ",""}, {"!","L"}, {"1","l"}, {";","L"}, {":","L"}, {"2","Z"}, {"@","A"}, {"3","E"}, {"#","H"}, {"$","S"}, {"5","S"}, {"4","A"}, {"^","A"}, {"|_","L"}, {"/\\","A"},{"|","L"}, {"_",""} }
local scyndicap = upper(scyndi)
local scyndileet = scyndicap
for _,lc in ipairs(leetcon) do
    scyndileet = Str.Replace(scyndileet,lc[1],lc[2]) 
    end 
if scyndileet == "SEELAHGANDRA" then
   cnt = cnt + 1
   if cnt<3 then
      MapText("SNEAKSEELAH")
      else
      MapText("STOPSNEAK")
      scyndi = "Scyndi"
      ok=true
      end
   else
   ok = true
   end        
until ok
Var.D("$SCYNDI",scyndi)
Var.D("!scyndi",scyndi)
MapText("NIGHT__C")
Music("There is Romance")
-- Dernor fucks Scyndi
MapText("SEX_A")
local cy=Maps.CamY
local ak
for ak=cy,0,-1 do
    Maps.CamY=ak
    DrawScreen()
    Flip()
    end
MapText("SEX_B")
DrawScreen()
Flip()
Time.Sleep(2500)
MapText("SEX_C")
DrawScreen()
Flip()
Time.Sleep(2500)
MapText("SEX_D")
Image.Cls()
Flip()
Look(0xff)
Time.Sleep(2500)
-- In the morning
MapText("MORNING")
Maps.LoadMap("CH3_INDIECITY")
SpawnPlayer("Beach")
NewParty('"Eric","Irravonia","Brendor","Scyndi","Rebecca","Dernor","Merya"')
PartyPop("Beach","*bundle")    
MapText("KLAARVOORVERTREK")
PartyUnPop()
WorldMap_Reveal("DELISTO","MARSHES")
-- Temp Error when not finished
-- Sys.Error("Unfinished Scenario")
end

function TrixiaTellsAboutAziella()
if CVV("&DONE.HANDOSTILLOR") and (not Done("&DONE.TRIXIATELLABOUTAZIELLA")) then 
   Look(3)
   Maps.CamX = 2016
   Maps.CamY = 2760
   PartyPop("Ent","*bundle")
   MapText("TRIXIATELLSABOUTAZIELLA")
   PartyUnPop()
   end
end

function ACTOR_TRIXIA()
MapText("TRIXIA."..upper(GetActiveChar()))
end

function ACTOR_ROSETTA() -- Stone Master
if not Done("&DONE.ROSETTA.INDIE.ABOUTGAGOLTON") then
   PartyPop("Ros","*bundle")
   MapText("ROSETTA_GAGOLTON")
   PartyUnPop()
   else
   MapText("ROSETTA")
   StoneMaster("ROSETTA")
   end
end   

function ACTOR_FLORA() -- Stone Master
if not CVV('&DONE.FLORADERNOR') then
   if GetActiveChar()=='Dernor' then
      MapText('FLORA.DERNOR')
      Var.D('&DONE.FLORADERNOR','TRUE')
      else
      MapText('FLORA.NODERNOR')
      end
   else
   MapText('FLORA')
   StoneMaster('FLORA')
   end
end   

function ACTOR_SYLIA() -- Merchant
MapText("SYLIA")
Shop("SYLIA")
end

function ACTOR_PAROZA()
MapText("PAROZA")
end

letsgo = {
   function() Maps.LoadMap("CH4_Aeria_Beach") SpawnPlayer('FlyStart') end,
   function() Maps.LoadMap("CH4_CatBeach")  SpawnPlayer('FlyStart') end,
   function() end
}


function ACTOR_AZIELLAGUARD()  -- Go to Aeria
MapText("AZIELLA_GUARD")
if CVV('&DONE.CHAPTER3') then
   local go = BoxQuestion(MapTextArray,"WHERETO1")
   letsgo[go]()
   return
   end 
local go2aeria = BoxQuestion(MapTextArray,"READY1")
if go2aeria~=1 then return end
-- @IF !CHAPTER4
if true then -- This looks silly, but the "return" command would otherwise spook up my IDE.
   Var.D("%NEXTCHAPTER",4)
   Maps.LoadMap("WACHTKAMER")   
   SpawnPlayer("Start")
   return
   end
-- @FI
if not CVV('&DONE.CHAPTER3') then LAURA.Shell("StartChapter4.lua") return end
Maps.LoadRoom("CH4_AERIA_BEACH")
SpawnPlayer("FlyStart")   
end

function AziellaWalk(exit)
WalkToExit(exit,"PopAziella")
Actors.Pick("PopAziella")
local rqx,rqy = CVV("%EXITWALK.X"),CVV('%EXITWALK.Y')
repeat
LAURA.ExecuteGame("Walk","nil")
Actors.Pick("PopAziella")
Look(0x0a)
DrawScreen()
Maps.CamY=16
-- @IF DEVELOPMENT
Image.NoFont()
Actors.Pick("PopAziella")
local lines = {
       "Aziella is walking",
       "Her position is now ("..Actors.PA_X()..","..Actors.PA_Y()..")",
       "She is walking to ("..rqx..","..rqy..")"
    }
local ak,s
Image.Color(rand(0,255),rand(0,255),rand(0,255))
for ak,s in ipairs(lines) do DText(s,800,ak*15,1,0) end    
-- @FI
Flip()
Actors.Pick("PopAziella")
until Actors.PA_X()==rqx and Actors.PA_Y()==rqy
Actors.ChoosePic("Aziella.South")
DrawScreen()
Maps.CamY=16
Flip()
end

function ToBeach()
LAURA.ExecuteGame("ManualTeleport","ToBeach")
if (not CVV("&DONE.HANDOSTILLOR")) or (Done("&DONE.AZIELLAJOIN")) then return end
NewParty("'Eric','Irravonia','Brendor','Scyndi','Rebecca','Dernor','Merya','Aziella'")
Look(0x0a)
PartyPop("Az","*bundle")
MapText("AZIELLA_FIRSTSEEN")
AziellaWalk("AWDernor")
MapText("AZIELLA_DERNOR")
AziellaWalk("AWScyndi")
MapText("AZIELLA_SCYNDI")
local aziella = GphInput("Please enter the name of this winged girl:","Aziella")
Var.D("$AZIELLA",aziella)
Var.D("$CAPAZIELLA",upper(aziella))
ReloadMapText()
MapText("AZIELLA_AZIELLA")
AziellaWalk("AWEric")
MapText("AZIELLA_ERIC")
AziellaWalk("AWRebecca")
MapText("AZIELLA_REBECCA")
AziellaWalk("AWBrendor")
MapText("AZIELLA_BRENDOR")
AziellaWalk("AWIrravonia")
MapText("AZIELLA_IRRAVONIA")
AziellaWalk("AWAziella")
MapText("AZIELLA_ENDSTORY")
PartyUnPop()
LAURA.ExecuteGame("AwardTrophy","CHAPTER3")
Maps.CamY=16
end

function LeaveBeach()
LAURA.ExecuteGame("ManualTeleport","Beach")
end

function ACTOR_CAT()
if GetActiveChar()=="Scyndi" then
   MapText("CATSCYNDI")
   WorldMap_Reveal("DELISTO","REDTEMPLE")
   else
   MapText("CAT")
   end
end


function GALE_OnLoad()
if not Done("&DONE.FIRSTVISIT.INDEPENDENCE") then ZA_Enter(0x03,Welcome) end
if CVV("&DONE.HANDOSTILLOR") and (not CVV("&DONE.TRIXIATELLABOUTAZIELLA")) then ZA_Enter(0x03,TrixiaTellsAboutAziella) end
ZA_Enter(0x01,ToBeach)
ZA_Enter(0x0b,LeaveBeach)
if not CVV("&DONE.HANDOSTILLOR")  then Actors.Remove('AziellaGuard',0) end
if not CVV("&CATININDEPENEDENCE") then Actors.Remove("Cat",0) end
Music("Thatched Villagers")
DungeonTitle()
end
