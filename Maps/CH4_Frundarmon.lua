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
 



Version: 14.09.10

]]
-- @USEDIR Scripts/Use/AnyWay
-- @USEDIR Scripts/Use/Maps



FrundarmonDefeated = "&DONE.FRUNDARMON.DEFEATED"

BossRemoveKids = {"KitchenGirl1","KitchenGirl2","BasementBoy","Huiskamer1","Huiskamer2","Huiskamer3"}

KidPics = {"Fairy Girl","Human Boy","Phelynx Girl","Befindo Boy","Elf Girl"}

function KidFoe(idx) return upper(Str.Replace(KidPics[idx]," ","")) end


--[[
  Here the kids will be met in combat. 
  Please note, the actors on the map will disappear, however, 
  the player will have to fight the kids every time they get back onto this spot regardless if the actor is there or not.
  So that really is not a bug, it's really a feature. No really that is really the way it was supposed to work.
  
  Once the boss Frundarmon is beaten, the kids will no longer be met in battle.
  Regular random encounters can still happen, though.
]]
function MeetKid(p_kids,p_actors,p_arena)
if CVV(FrundarmonDefeated) then return end
local arena = p_arena or "Frundarmon.png"
local kids
local actors 
if type(p_kids)=='string' then 
   kids={p_kids}
   elseif type(p_kids)=="table" then
   kids = p_kids   
   else
   Sys.Error("Invalid value received for kids","Function,MeetKid;kids,"..sval(p_kids)..";arena,"..sval(arena)..";kidstype,"..type(p_kids))
   end
if type(p_actors)=='string' then 
   actors={p_actors}
   elseif type(p_actors)=="table" then
   actors = p_actors
   elseif type(p_actors)=='nil' then
   actors = {}
   else
   Sys.Error("Invalid value received for actors","Function,MeetKid;actors,"..sval(p_actors)..";arena,"..sval(arena)..";actorstype,"..type(p_actors))
   end
local placekids = {}
local kid,poskid
for _,kid in ipairs(kids) do
    repeat
    poskid = rand(1,9)
    until not placekids[poskid]
    placekids[poskid] = kid
    end   
ClearBattleVars()
for poskid,kid in pairs(placekids) do
    BattleInit('Enemy'..poskid,'KIDS_'..kid)
    end    
BattleInit('Music'        ,'*NOCHANGE*')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,arena); CSay("Arena = "..arena..", is this right for the children of Frundarmon")
if StartCombat() then
   if actors then
      for _,kid in ipairs(actors) do
          if (not Done("&DESPAWNED.FRUNDARMON.KID."..kid)) then Actors.Remove(kid,1) end
          end
      end
   Maps.BuildBlockMap()       
   end    
end


function EntranceGirl()
if not Done("&DONE.FRUDARMON.ENTRANCEGIRL") then
   MapText("ENTRANCEGIRL")
   end
MeetKid("ELFGIRL","EntranceGirl")
end

-- Two girls are waiting for you in the kitchen
function Kitchen()
DrawScreen()
Flip()
Time.Sleep(500)
MeetKid({"ELFGIRL","PHELYNXGIRL"},{"KitchenGirl1","KitchenGirl2"},"FRUNDARMON_Kitchen.png")
end

-- Two girls and one boy await you in the living room
function Huiskamer()
DrawScreen()
Flip()
Time.Sleep(500)
MeetKid({"FAIRYGIRL","FAIRYGIRL","BEFINDOBOY"},{"Huiskamer1","Huiskamer2","Huiskamer3"})
end

-- A random set of kids will await you in the bed room as long as the puzzle there has not been solved.
function Slaapkamer()
if CVV(FrundarmonDefeated) or CVV("&DONE.FRUNDARMON.PUZZLE") then return end
local kids = { Pic = {}, Foe={}}
local ak
local kidnumber
local kid
for ak=1,5 do
    kidnumber = rand(1,#KidPics)
    kids.Pic[ak] = KidPics[kidnumber]
    kids.Foe[ak] = KidFoe(kidnumber)
    end    
for ak=1,5 do
    SpawnActor('SleepKid'..ak,{ID='SleepKid'..ak,SinglePic='Kids/'..kids.Pic[ak]..".png"})
    end
DrawScreen()
Flip()
Time.Sleep(150)
MapText("SLEEPKID."..upper(GetActiveChar()))
MeetKid(kids.Foe)
for ak=1,5 do
    Actors.Remove('SleepKid'..ak)
    end             
end

function Puzzle()
local Genders = {HUMAN=1,BEFINDO=1,FAIRY=2,PHELYNX=2,ELF=2}
local Order = {}
local answers
local correct = true
local g,r,v
if CVV("&DONE.FRUNDARMON.PUZZLE") then return end
for g,v in spairs(Genders) do
    repeat
    r = rand(1,5)
    until not(Order[r])
    Order[r]=g
    end
MapText("PUZZLE."..upper(GetActiveChar()))
MapText("PUZZLE.TUT")
for _,g in ipairs(Order) do
    correct = (BoxQuestion(MapTextArray,"PUZZLE."..g.."1")==Genders[g]) and correct
    end
if correct then
   MapText("PUZZLE.YES")
   Done("&DONE.FRUNDARMON.PUZZLE")
   Maps.LayerDefValue(44,41,'Walls',0,1)
   SpawnActor('3Kid1',{ID='3KID1',SinglePic='kids/human boy.png'})
   SpawnActor('3Kid2',{ID='3KID2',SinglePic='kids/phelynx girl.png'})      
   else
   MapText("PUZZLE.NOPE")
   end
end

-- Meet the motherfucker himself!
function Boss()
PartyPop("Frun","*bundle")
MapText("BOSS")
PartyUnPop()
ClearBattleVars()
BattleInit('Music'        ,'Day of Chaos')
BattleInit("Arena"        ,"Frundarmon.png")
BattleInit('Enemy5'       ,'Frundarmon')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
if not StartCombat() then return end
PartyPop("Frun","*bundle")
MapText("AFTER_BOSS_A")
WalkToExit('Dairy',"PopRebecca")
Actors.Pick("PopRebecca")
local rqx,rqy = CVV("%EXITWALK.X"),CVV('%EXITWALK.Y')
local x,y,w
repeat
Actors.Pick("PopRebecca")
x = Actors.PA_X()
y = Actors.PA_Y()
w = Actors.PA_Wind()
Actors.Walk()
Actors.ChoosePic("Rebecca."..w)
Actors.IncFrame()
DrawScreen()
Flip()
until rqx==x and rqy==y
Actors.ChoosePic("Rebecca.North")
MapText("AFTER_BOSS_B")
Look(0xf0)
MapText("END")
Done("&DONE.TEAM.REBECCA")
Done(FrundarmonDefeated)
if CVV("&DONE.TEAM.ERIC") or CVV("&DONE.MALABIA.SPOKEN.FIRST") then
   LAURA.Shell("CH4_Split/BOTHDONE.lua")
   else
   LAURA.Shell("CH4_Split/StartTeamEric.lua")
   end
-- Sys.Error("After Boss scriptnot yet implemented!")
end


-- Children guarding the first stairway
--
-- Oh yeah "Trap" is the Dutch word for "Stairway", this has nothing to do with boobytraps. :)
function ACTOR_TRAP1_1()
MeetKid({"HUMANBOY","PHELYNXGIRL"},{"TRAP1_1","TRAP1_2"})
end; ACTOR_TRAP1_2 = ACTOR_TRAP1_1


--[[
 This kid guards the stairway to the secret basement.
 
 Of course if the player decides not to kill him but to go straight for the boss, he'll disappear anyway. :P
]]
function ACTOR_BASEMENTBOY()
MeetKid("BEFINDOBOY","BasementBoy")
end

-- Kids waiting for you upstairs. Only two can be spoken to, but the others are shown just to be complete. ;)
function ACTOR_UPSTAIRS1() 
MeetKid({"BEFINDOBOY","FAIRYGIRL","HUMANBOY","PHELYNXGIRL"},{"Upstairs1","Upstairs2","Upstairs3","Upstairs4"})
end; ACTOR_UPSTAIRS2 = ACTOR_UPSTAIRS1

function ACTOR_3KID1()
MeetKid({"HUMANBOY","PHELYNXGIRL"},{'3KID1','3KID2'})
end; ACTOR_3KID2 = ACTOR_3KID1

function GALE_OnLoad()
Music("Tempting Secrets")
ZA_Enter(0x05,Kitchen)
ZA_Enter(0x04,Huiskamer)
ZA_Enter(0x07,Slaapkamer)
if not CVV(FrundarmonDefeated) then ZA_Enter(0x09,Boss) end
CSay("Welcome to Frundarmon's mansion")
end

-- Secret basement
function Basement()
Maps.LoadMap("CH4_FrundarmonBasement")
SpawnPlayer("Start")
end

-- Leave this place
function Bye()
WorldMap("CAT-ISLAND")
end

function GALE_OnUnLoad()
CSay("Byebye, you are now leaving Frundarmon's mansion!")
end
