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
-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps

PopMe = {"Eric","Irravonia","Rebecca","Scyndi","Brendor"}


function EWalk(cycles,h)
local ak
for ak=1,cycles do
    Actors.Walk()
    DrawScreen()
    Flip()
    --for _,h in ipairs(PopMe) do
    Actors.Pick("Pop"..h)
    if Actors.PA_Wind()~="" and (Actors.Moving()==0) then
       -- CSay("Choosing picture: "..activecharacter.."."..Actors.PA_Wind())   
       Actors.ChoosePic(h.."."..Actors.PA_Wind())   
       end
    if Actors.Walking()==1 or Actors.Moving()==1 then
       NextFrame = NextFrame or 4
       NextFrame = NextFrame - 1   
       if NextFrame==0 then Actors.IncFrame() NextFrame = 4 end   
       NFTIME=5 
       else
       if NFTIME and NFTIME>0 then NFTIME=NFTIME-1 else Actors.SetFrame(0) end
       end
    --end -- for          
    end
end



-- Meet Dernor & Merya
function MeetDernorAndMerya()
local ak
Look(0)
Music("Moonlight Hall")
PartyPop("DM_","Left",PopMe)
SpawnActor("DM_Dernor",{['ID']='Dernor',['PicBundle']='Player',['ChosenPic']='DERNOR.EAST',['ChosenFrame']=0})
SpawnActor("DM_Merya" ,{['ID']='Merya' ,['PicBundle']='Player',['ChosenPic']= 'MERYA.EAST',['ChosenFrame']=0})
MapText("INTRODERNORMERYA")
Var.D("$DERNOR",GphInput("Please enter a name for the young man:","Dernor"))
Var.D("$MERYA", GphInput("Please enter a name for the girl:","Merya"))
ReloadMapText()
MapText("INTRODERNORMERYA_B")
Actors.Pick("Dernor"); Actors.WalkTo(25,13)
Actors.Pick("Merya" ); Actors.Walkto(25,15)
for ak=1,250 do
  Actors.Walk()
  Actors.Pick("Dernor"); Actors.IncFrame()
  Actors.Pick("Merya" ); Actors.IncFrame()
  LAURA.ExecuteGame("DrawScreen")
  Flip()
  end
MapText("INTRODERNORMERYA_C")
Maps.LoadRoom("CH2_BLACKDRAGONCAVE")
SpawnPlayer('Start')
Var.D("&DONE.FIRSTMEETDERNOR&MERYA","TRUE")
end


-- Meet Rondomo
function Rondomo()
local ak
Look(0)
Music("Angevin")
PartyPop('RON_','*bundle',PopMe)
Actors.List()
MapText("RONDOMO_START")
Actors.Pick("PopIrravonia"); Actors.MoveTo(2,8); EWalk(50,"Irravonia"); Actors.NewSpot(100,100) -- Byebye Irravonia!
Music("Panic Stations")
MapText("RONDOMO_BYE_IRRA")
Actors.Pick("PopScyndi"); Actors.WalkTo(25,14);  EWalk(450,"Scyndi"); Actors.NewSpot(100,100) -- Byebye Scyndi!
MapText("RONDOMO_BEFORE_POP")
local bang = Image.Load("GFX/Scenario/Explosion.png")
Image.HotCenter(bang)
local ak
local s,v
SFX("SFX/Scenario/OnyxBang.ogg")
for ak = 0,360,5 do
    s = math.abs(Math.Sin(ak))
    DrawScreen()
    Image.Scale(s,s)
    Image.Draw(bang,251,329)
    Image.Scale(1,1)
    Image.Flip()
    if ak==270 then SpawnActor('Rondomo',{['ID']='Rondomo',['SinglePic']='Onyx/Rondomo.png'}) end
    end
Image.Free(bang)
Music("Deadly Deadly Deadly")
MapText("RONDOMO")
NewParty('"Eric","Brendor"')
Actors.Pick("PopRebecca"); Actors.WalkTo(25,14);  EWalk(450,"Rebecca"); Actors.NewSpot(100,100) -- Byebye Becky!
ClearBattleVars()
BattleInit('Enemy8'       ,'RONDOMO1')
BattleInit('Music'        ,'ORDEROFONYX.OGG')
BattleInit('VictoryTune'  ,'VICTORY.OGG')
BattleInit('Arena'        ,'FOREST.PNG')
BattleInit('DefeatAction' ,'RondomoLose')
if StartCombat() then Sys.Error("My aren't you a sophisticated cheater?") end
Var.D("&DONE.RONDOMO1","TRUE")
-- @IF CHAPTER3
   -- NewParty('"Irravonia","Scyndi"')
   -- Maps.LoadMap("NAKEDROCKS")
   LAURA.Shell('StartChapter3.lua')
-- @FI
-- @IF !CHAPTER3
   Var.D("%NEXTCHAPTER",3)
   NewParty("'Rebecca'")
   Maps.LoadMap("WACHTKAMER")   
   SpawnPlayer("Start")
   return
-- @FI
-- Sys.Error("Uh, I don't know how this could happen. How unsophisticated!")   
end

































function ROOM_Run()
Maps.CamX=0
Maps.CamY=0
if not CVV("&DONE.FIRSTMEETDERNOR&MERYA") then MeetDernorAndMerya(); return end
if CVV("&DONE.BLACKDRAGON") and (not CVV("&DONE.RONDOMO1")) then Rondomo(); return end
Maps.LoadMap('CH2_BlackDragonCave')
SpawnPlayer("Start")
end


function GALE_OnLoad()
Var.D("$ROOM.RUN","ROOM_Run")
end
