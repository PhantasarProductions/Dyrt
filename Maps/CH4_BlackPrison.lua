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

Guards = 12

ActorList = {
       "FIrravonia",
       "FBrendor",
       "FScyndi",
       "FDernor",
       "FAziella",
       "FRebecca",
       "FKirana"       
  }


function IniPos()
return CVV("%BP.RS_X"),CVV("%BP.RS_Y"),CVV("$BP.RS_W")
end
  
function NewZone()
local x,y,w = PlayerCoords()
Var.D("%BP.RS_X",x)
Var.D("%BP.RS_Y",y)
Var.D("$BP.RS_W",w)
end  

-- When the player moves in a room with guards, let's see if any of them can see Merya
function ScanGuard()
local G
local kx,ky,ak
local gx,gy,gw
local D = { North = {x=0,y=-1}, South = {x=0,y=1}, East = {x=1,y=0}, West = {x=-1,y=0} }
local hit
local px,py = PlayerCoords()
local z = Maps.LayerValue(px,py,"Zone_Visibility")
local shotby = {},sb
if not GuardZone[z] then
   CSay("No zone at "..sval(z)) 
   return 
   end
for _,G in ipairs(GuardZone[z]) do
    Actors.Pick(G)
    gx = Actors.PA_X()
    gy = Actors.PA_Y()
    gw = Actors.ChosenPic()
    --[[
    for ky = gy-1,gy+1 do for kx = gx-1,gy+1 do
        if  (kx==px and ky==py) then table.insert(shotby,G.." (around)") end
        hit = hit or (kx==px and ky==py)
        end end
    ]]
    if px>=gx-1 and px<=gx+1 and py>=gy-1 and py<=gy+1 then
       hit = true        
       table.insert(shotby,G.." (around)")
       end
    kx = gx
    ky = gy
    for ak=1,5 do
        if not D[gw] then
           --if      G=="Guard6" or G=="Guard7" then gw="South"
           --elseif  G=="Guard8" then gw="North"
           --else Sys.Error("Invalid direction for "..G.." >> '"..sval(gw).."'") end 
           end
        kx = kx + D[gw].x
        ky = ky + D[gw].y
        hit = hit or (kx==px and ky==py)
        if  (kx==px and ky==py) then table.insert(shotby,G.." (line)") end
        end    
    end
if hit then
   Actors.Pick("Player")
   Actors.ChoosePic("Merya.Dead")
   SFX("SFX/GunShot.ogg")
   MapText("OOPS")
   for _,sb in ipairs(shotby) do CSay("Shot by: "..sb) end
   local nx,ny,nw = IniPos()
   Actors.NewSpot(nx,ny,nw)
   end    
end
  
function InitGuards()
local x,y,z  
if CVV("&DONE.BLACKPRISON") then return end
GuardZone = {}  
for ak=1,Guards do 
    if Actors.Pick("Guard"..ak)==1 then
       table.insert(ActorList,"Guard"..ak)
       x = Actors.PA_X()
       y = Actors.PA_Y()
       z = Maps.LayerValue(x,y,"Zone_Visibility")
       GuardZone[z] = GuardZone[z] or {}
       table.insert(GuardZone[z],"Guard"..ak)
       CWrite("Guard #"..ak.." registered at zone "..z.."      ("..x..","..y..")")
       end
    end   
for ak,_ in pairs(GuardZone) do
    ZA_Enter(ak,NewZone)
    ZA_Move (ak,ScanGuard)
    CSay("Adding guard functions to zone #"..ak)              
    end  
end

function DEBUGGUARDS()
local b = serialize("GuardZone",GuardZone)
local l,k
local ms = Time.MSecs()
for k,l in ipairs(split(b,"\n")) do
   local r,g = math.abs(math.sin(ms+k))*255,255-math.abs(((math.sin(ms+k))*255)),0
   CWrite(l,r,g,0)
   end
end

function SneakTut()
if Done("&DONE.BLACKPRISON.SNEAKTUTORIAL") then return end
MapText("SNEAKTUT")
end

function Enter()
if CVV("&DONE.BLACKPRISON") then return end
NewParty("'Merya'")
LAURA.ExecuteGame("Walk") -- This should make sure, Merya appears and not the last active character.
LAURA.ExecuteGame("DefDefeatRespawn")
if Done("&DONE.BLACKPRISON.ENTER") then return end
MapText("ENTER")
end

function ACTOR_FIRRAVONIA() MapText("IRRAVONIA") end
function ACTOR_FBRENDOR()   MapText("BRENDOR")   end
function ACTOR_FSCYNDI()    MapText("SCYNDI")    end
function ACTOR_FAZIELLA()   MapText("AZIELLA")   end
function ACTOR_FKIRANA()    MapText("KIRANA")    end
function ACTOR_FREBECCA()   MapText("REBECCA")   end

function ACTOR_FDERNOR()
MapText("DERNOR")
local go = BoxQuestion(MapTextArray,"DERNORLEAVE1")
if go==2 then 
   NewParty("'Kirana','Irravonia','Brendor','Scyndi','Rebecca','Dernor','Merya','Aziella'")
   WorldMap()
   return
   end
end

function MortWelcome()
if Done("&DONE.MORT.WELCOME") then return end
MapText("MORTWELCOME")
end

function ACTOR_MORT()
MapText("MORT")
ClearBattleVars()
BattleInit('Music'        ,'Boss')
BattleInit("Arena"        ,"BlackPrison.png")
BattleInit('Enemy5'       ,'MORT')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
if not StartCombat() then return end
Actors.Remove("Mort",1)
Maps.BuildBlockMap()
end

function ACTOR_ERIC()
MapText("ERIC_A")
Var.D("&BPRISON.DZGJYMZASHOW","TRUE")
Actors.Remove("Eric",1)
NewParty("'Merya','Eric'")
end

function Dzgjymza()
if not CVV("&BPRISON.DZGJYMZASHOW") then return end
SpawnActor("Dzgjymza",{ID="Dzgymza",SinglePic="NPC/Lord Dzgjymza.png"})
SlowScroll(1088,1776)
MapText("DZGJYMZA")
Teleport("Exit")
Look(0x01)
PartyPop("Exit","*bundle")
MapText("ERIC_B")
-- 331,322
local bang = Image.Load("GFX/Scenario/Explosion.png")
local s
Image.HotCenter(bang)
SFX("SFX/Scenario/OnyxBang.ogg")
-- SFX("SFX/Scenario/JerakosEntrance.ogg")
for ak = 0,360,5 do
    s = math.abs(Math.Sin(ak))
    DrawScreen()
    Image.Scale(s,s)
    Image.Draw(bang,331,322)
    Image.Scale(1,1)
    Image.Flip()
    if ak==270 then Actors.Remove("FKirana") end
    end
Image.Free(bang)    
MapText("ERIC_C")
PartyUnPop()
Var.D("&BLOCK.GORDO","FALSE")
local a
for _,a in ipairs(ActorList) do Actors.Remove(a,1) end
Done("&DONE.BLACKPRISON")
Var.D("&BPRISON.DZGJYMZASHOW","FALSE")
NewParty("'Eric','Irravonia','Brendor','Scyndi','Rebecca','Dernor','Merya','Aziella'")
Maps.LoadMap("CH4_MALABIATEMPLE")
SpawnPlayer("TempleIn")
Look(0x03)
PartyPop("Malabia","*bundle")
MapText("MALABIA")
PartyUnPop()
Done("&ERIC=YASATHAR")
NewParty("'Yasathar','Irravonia','Brendor','Scyndi','Rebecca','Dernor','Merya','Aziella'")   
LAURA.ExecuteGame("AwardTrophy","CHAPTER4")
LAURA.ExecuteGame("Teach","Yasathar;YASBLESS")
PartyPop("Malabia","*bundle")
MapText("MALABIA_B")
-- @IF !CHAPTER5
if true then -- This looks silly, but the "return" command would otherwise spook up my IDE.
   Var.D("%NEXTCHAPTER",5)
   Maps.LoadMap("WACHTKAMER")   
   SpawnPlayer("Start")
   return
   end
-- @FI
LAURA.Shell("StartChapter5.lua")
end

function GALE_OnLoad()
Music("Prisoner of War - Jail - Widzy")
InitGuards()
ZA_Enter(0x01,Enter)
ZA_Enter(0x06,MortWelcome)
end
