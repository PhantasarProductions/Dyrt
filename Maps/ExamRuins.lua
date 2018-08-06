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



romandie = {"I","II","III","IV","V","VI"}
buttons = {}
setbuttons = {
                  {"B2"}, -- 1
                  {"A1","C3"}, -- 2
                  {"A1","B2","C3"}, -- 3
                  {"A1","C1","A3","C3"}, -- 4
                  {"A1","C1","A3","C3","B2"}, -- 5
                  {"A1","A2","A3","C1","C2","C3"} -- 6
             }
coords = {["A"]=49,["B"]=51,["C"]=53,    ["1"]=39,["2"]=41,["3"]=43}             

function GALE_OnLoad()
Console.Write("Examination time",rand(1,255),rand(1,255),rand(1,255))
if (Var.C("&DONE.STARTEXAM")~="TRUE") then
   Music('Rebeccas theme - Dramatanic')
   SpawnPlayer("Start")
   SetDefeatRespawn()
   NewParty('"Eric","Rebecca"')
   SetActive("Eric")
   Actors.NewWind('North')
   SpawnActor('Irravonia',{['ID']='IRRAVONIA',['SinglePic']='Heroes/Irravonia.png'})
   SpawnActor('Rebecca',{['ID']='REBECCA',['SinglePic']='Heroes/Rebecca.png'})
   Look(1)
   SerialBoxText('Chapter1/StartExam',"A")
   Actors.Despawn("REBECCA")
   Var.D("&DONE.STARTEXAM","TRUE")
   end
if (Sys.Val(Var.C("&DUNG.EXAMRUINS.DIE"))==0) then
   Var.D("&DUNG.EXAMRUINS.DIE",rand(1,6))
   end
dievalue = Sys.Val(Var.C("&DUNG.EXAMRUINS.DIE"))
Var.D("%EXAM.DIE",romandie[dievalue])
Music("Spy vs Spy")   
DungeonTitle()
end

function GALE_OnUnload()
Console.Write("Exams are over!",rand(1,255),rand(1,255),rand(1,255))
end

function Exit()
if CVV("&DONE.CHAPTER1") then WorldMap(); return end
if Var.C('&DONE.EXAMS')~="TRUE" then
   MapText("NOEXIT"..Str.Upper(GetActiveChar()))
   Actors.Pick("Player")
   Actors.WalkTo(Actors.PA_X(),Actors.PA_Y()-2)
   else
   WorldMap()
   end
end

function DieSign()
CSay("The Die-Sign is being red")
MapText("SIGN")
end

function Button(but)
local x = coords[Str.Left (but,1)]
local y = coords[Str.Right(but,1)]
if Var.C("&DONE.EXAMS.DIE") == "TRUE" then return end
buttons[but] = not buttons[but]
local v = 0xf0
if buttons[but] then v=0xf1 end
Maps.LayerDefValue(x,y,"FloorDeco",v)
Console.Write("Button:  "..but,200,100,50)
Console.Write("Coords:  ("..x..","..y..")",100,50,200)
Console.Write("Value:   "..v,50,100,200) 
local solved=true
local pos
local b = ""
local sb = ""
for _,pos in ipairs({"A1","A2","A3","B1","B2","B3","C1","C2","C3"}) do
    -- solved = solved and (((not buttons[pos]) and (not tablecontains(setbuttons[dievalue],but))) or (buttons[pos] and tablecontains(setbuttons[dievalue],but)))
    if buttons[pos]                            then  b =  b .. " "..pos end 
    if tablecontains(setbuttons[dievalue],pos) then sb = sb .. " "..pos end
    solved = (b==sb) 
    end
           --  123456789
Console.Write("Buttons: "..b, 50,200,100)
Console.Write("Required:"..sb,100,50,200) 
if solved then
   CSay("Die puzzle has been solved!")
   Var.D("&DONE.EXAMS.DIE","TRUE")
   Maps.LayerDefValue(51,36,"Walls",0,1)
   Maps.BuildBlockMap() 
   end    
end

function ACTOR_IRRAVONIA()
MapText("IRRAVONIA+"..Str.Upper(GetActiveChar()))
end 

function ACTOR_ZACK()
MapText("ZACK")
end

function Boss()
local v = false
local etxt
if CVV("&DONE.CHAPTER1") then return end
CSay("Do we need to call the boss?")
if not CVV('&BOSS.TIGER') then
   ClearBattleVars()
   BattleInit('Num'    ,2)
   BattleInit('Enemy5'       ,'BOSSBIGTIGER')
   BattleInit('Music'        ,'BOSS.OGG')
   BattleInit('VictoryTune'  ,'VICTORY.OGG')
   BattleInit('Arena'        ,'EXAMRUINS.PNG')
   v = StartCombat() 
   end
if v then
   NewParty("Rebecca")
   SetActive("Rebecca")
   Actors.ChoosePic("Rebecca."..Actors.PA_Wind())
   Actors.Pick("Player")
   Actors.NewSpot(50,75,"North")
   Var.D("$CAPERIC",Str.Upper(CVV("$ERIC")))
   Actors.Despawn("ZACK")
   SpawnActor('AfterBossZack',{['ID']='ZACK2',['SinglePic']='Zack.png'})
   SpawnActor('AfterBossEric',{['ID']='ERIC',['SinglePic']='Heroes/EricBack.png',["IgnoreBlockMap"]=true})
   etxt = ReadLanguageFile("Chapter1/EndExam")
   SerialBoxText(etxt,"A")   
   local x,y = Actors.PA_X(),Actors.PA_Y()
   local ak
   local toy = { 74,77 }
   local ok
   for ak=1,2 do
    Actors.Pick('Player')
    if ak==1 then Actors.WalkTo(49,74) end
    if ak==2 then 
       Actors.WalkTo(49,77)
       Actors.Pick("ERIC") 
       Actors.WalkTo(49,78)
       Actors.Pick("Player")
       ok=false
       end
    while not ok do
      Actors.Walk()
      LAURA.ExecuteGame('DrawScreen')
      -- @IF DEVELOPMENT
      DText("Player pos: ("..x..","..y..")",0,0)
      -- @FI
      LAURA.ExecuteGame('Flip')
      x = Actors.PA_X()
      y = Actors.PA_Y()
      ok = (x==49 and y==toy[ak]) or (y==74 and x==49) or (y==77)
      end
    end   
   Maps.LayerDefValue(48,72,"Walls",0,1)
   LAURA.ExecuteGame('DrawScreen')
   LAURA.ExecuteGame('Flip')
   Time.Sleep(500)
   SerialBoxText(etxt,"B") 
   Maps.LoadMap("Prison")
   Maps.IamSeeing(0x01,1)
   Maps.CamY = 928
   Maps.CamX = 0
   SerialBoxText(etxt,"C")
   Maps.LoadMap("BushesNorth")
   NewParty('"Eric","Irravonia","Rebecca"')
   SetActive("Eric")
   SpawnPlayer("Start")
   Maps.CamY=2528
   SpawnActor('Irravonia',{['ID']='IRRA',['SinglePic']='Heroes/Irravonia.png'})
   SpawnActor("Fish",{['ID']='FISH',['SinglePic']='TownPeople/HumanMale.png'})
   SpawnActor("Rebecca",{['ID']='REBECCA',['SinglePic']='Heroes/REBECCABACK.png'})
   SerialBoxText(etxt,"D")   
   for y=2528,2464,-1 do
       Maps.CamY = y
       -- LAURA.ExecuteGame("GameDrawScreen")
       DrawScreen()
       Image.Flip()
       Time.Sleep(50)
       end
   SerialBoxText(etxt,"E")
   for y=2464,2528 do    
       Maps.CamY = y
       -- LAURA.ExecuteGame("GameDrawScreen")
       DrawScreen()
       Image.Flip()
       Time.Sleep(50)
       end
   SerialBoxText(etxt,"EB")
   for y=2528,2800 do -- 2624 do    
       Maps.CamY = y
       -- LAURA.ExecuteGame("GameDrawScreen")
       DrawScreen()
       Image.Flip()
       Time.Sleep(5)
       end
   SerialBoxText(etxt,"F")       
   -- Sys.Error("This part is not yet coded!")
   Actors.Despawn("IRRA")
   Actors.Despawn("REBECCA")
   Actors.Despawn("FISH")  
   SetDefeatRespawn()
   end   
end

-- @USEDIR Scripts/Use/Anyway
-- @USEDIR Scripts/Use/Maps
