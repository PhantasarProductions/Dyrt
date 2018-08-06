--[[
/* 
  Walk Engine for LAURA

  Copyright (C) 2013, 2014 Jeroen P. Broks

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.

*/



Version: 14.09.10

]]

function WalkActorAction(tag)
Actors.Pick(tag)
Actors.Action()
end

function __consolecommand.AKEVENTS()
local ak,AKEV,k,v
for ak,AKEV in ipairs(AKEvents) do
    Console.Write("AK Event #"..ak,255,255,255)
    for k,v in pairs(AKEV) do
        Console.Write(k..' = '..v,rand(1,255),rand(1,255),rand(1,255))
        end
    end
end

function WalkClickAKEvent(mx,my)
local ak,AKEV
for ak,AKEV in ipairs(AKEvents) do
    --[[ Debug
    CSay("Range       = ("..AKEV.StartMouseX..","..AKEV.StartMouseY..") - ("..AKEV.StartMouseX..","..AKEV.EndMouseY..")") 
    CSay("Mouse Click = ("..mx..","..my..")")
    -- End Debug ]]
    if mx>=AKEV.StartMouseX and my>=AKEV.StartMouseY and mx<=AKEV.EndMouseX and my<=AKEV.EndMouseY then
       arrival = {['x']=AKEV.x,['y']=AKEV.y}
       if AKEV.GameFunction~=""  then arrival.gamefunction = AKEV.GameFunction end
       if AKEV.MapFunction ~=""  then arrival.mapfunction  = AKEV.MapFunction  end  
       arrival.arg = AKEV.Parameter
       if AKEV.KeyMustFace~=""   then arrival.wind = AKEV.KeyMustFace end
       if AKEV.ShellFile~=""     then 
          arrival.shellfile    = AKEV.ShellFile
          if AKEV.ShellFunction~="" then arrivalshellfunction = AKEV.ShellFunction end
          end
       return AKEV.x,AKEV.y          
       end 
    end
return mx,my    
end

function WalkTeleportDo() 
local x = Actors.PA_X()
local y = Actors.PA_Y()
local tp
local r = 42
local g = 16
local b = 110
-- No need to pick as this function should only be called by Walk() which should have done this already ;)
if telefrom[x..','..y] then
   tp = teleporters[telefrom[x..','..y]]
   if not tp then
      Sys.Error("Cannot teleport character. Exit does not appear to exist","From X,"..x..";From Y,"..y..";Exit,"..telefrom[x..','..y])
      end
   Console.Write("Going to exit:     "..telefrom[x..','..y],r,g,b)
   Console.Write("Coordinates:       ("..tp.X..","..tp.Y..")",r,g,b)
   Console.Write("Wind:              "..tp.Wind,r,g,b)
   Console.Write("Cam:               ("..tp.CamX..","..tp.CamY..")",r,g,b)      
   Actors.NewSpot(tp.X,tp.Y,tp.Wind)
   if tp.CamX~=0 and tp.CamY~=0 then
      Maps.CamX = tp.CamX
      Maps.CamY = tp.CamY
      end
   end
end

function ManualTeleport(exit)
local r = 42
local g = 16
local b = 110
   local tp = teleporters[exit]
   local x,y
   if not tp then
      Sys.Error("Cannot teleport character. Exit does not appear to exist","From X,"..sval(x)..";From Y,"..sval(y)..";Exit,"..exit)
      end
   Console.Write("Going to exit:     "..exit,r,g,b)
   Console.Write("Coordinates:       ("..tp.X..","..tp.Y..")",r,g,b)
   Console.Write("Wind:              "..tp.Wind,r,g,b)
   Console.Write("Cam:               ("..tp.CamX..","..tp.CamY..")",r,g,b)      
   Actors.NewSpot(tp.X,tp.Y,tp.Wind)
   if tp.CamX~=0 and tp.CamY~=0 then
      Maps.CamX = tp.CamX
      Maps.CamY = tp.CamY
      end
end

function WalkToExit(exit,actor)
if not exit then Sys.Error("To which exit must I walk?") end
local tp = teleporters[exit]
if not tp then Sys.Error("I cannot walk to exit "..exit.." as it apparantly doesn't exist") end
Actors.Pick(actor or "Player")
Actors.WalkTo(tp.X,tp.Y)
Var.D("%EXITWALK.X",tp.X)
Var.D("%EXITWALK.Y",tp.Y)
CWrite("Actor '"..(actor or "Player").."' is now walking to exit '"..exit.."' at spot ("..tp.X..","..tp.Y..")")
end

function WalkArrival()
if not arrival then Sys.Error("Arrival check requested when no arrival data has been set") end
local k,v 
--for k,v in pairs(arrival) do
--    if not v then Console.Write(k..' = nil',255,0,0) end
--    Console.Write(k..' = "'..v..'"',110,20,10)
--    end
if arrival.wind             then Actors.Pick("Player"); Actors.NewWind(arrival.wind) end
if arrival.gamefunction     then if type(arrival.gamefunction)=='function'  then arrival.gamefunction(arrival.arg)  else LAURA.ExecuteGame(arrival.gamefunctionname,arrival.arg) end end
if not arrival then return end
if arrival.mapfunction      then Maps.Run(arrival.mapfunction,arrival.arg) end
if not arrival then return end
if arrival.shellfile        then Maps.Shell(arrival.shellfile,arrival.shellfunction,arrival.arg) end
-- if arrival.gamefunctionname then LAURA.ExecuteGame(arrival.gamefunctionname,arrival.arg) end -- Emergency backup function....
arrival = nil
end

function WalkOverEventsDo(x,y,wox,woy)
if x==wox and y==woy then return end -- Missing this line will cause the same function to go over and over for awhile, so we really need this one :)
local key = x..','..y
if not WalkOverEvents[key] then return end -- Let's not waste our time when there's nothing to do. (And prevent ourselves an error in the process).
local k,ev
for k,ev in ipairs(WalkOverEvents[key]) do
    if x==ev.X and y==ev.Y then
       if ev.MapFunction ~="" then          Maps.Run( ev.MapFunction,ev.Parameter) end
       if ev.GameFunction~="" then LAURA.ExecuteGame(ev.GameFunction,ev.Parameter) end
       end
    end
end


function WalkCheckItems()
local ak,item
local iname
local getcash
Actors.Pick("Player")
local x = Actors.PA_X()
local y = Actors.PA_Y()
local added
for ak,item in pairs(ItemMap[Maps.MapName]) do
    if item.X==x and item.Y==y then
       if (not itemdata[item.Item]) and Str.Left(Str.Upper(item.Item),5)~="CASH:" then Sys.Error("Item '"..item.Item.."' not found in database","Coords,("..x.."/"..y..")") end
       if Str.Left(Str.Upper(item.Item),5)~="CASH:" then iname = itemdata[item.Item].Name end
       added = false
       if Str.Left(Str.Upper(item.Item),5)=="CASH:" then
          getcash = Sys.Val(Str.Right(item.Item,Str.Length(item.Item)-5))
          if cash < 1000000000 then
             cash = cash + getcash
             iname = getcash.." shilders"
             added = true
             end 
          end
       if item.Item=="TRAVEL" then       
          added = true   
          MigrantLevel = MigrantLevel + 1
          ECNBar = ECNBarMax
          if MigrantLevel<3 then
             SerialBoxText("Tutorial/Migrant","A")
             end
          if MigrantLevel==20 then AwardTrophy("TRAVEL") end            
       elseif not inventory[item.Item] then
          inventory[item.Item] = 1
          added = true
       elseif inventory[item.Item]<imax() then
          inventory[item.Item] = inventory[item.Item] + 1
          added = true
       elseif inventory[item.Item]>=imax() and not CVV('&TUTORIAL.MAXITEM') then
          Var.D('&TUTORIAL.MAXITEM','TRUE')
          SerialBoxText('Tutorial/MaxItems',"MAX")   
          end   
       if added then
          if JCR5.Exist('SFX/Item/'..item.Item..".ogg")==1 then
             SFX('SFX/Item/'..item.Item..".ogg")
             else
             Console.Write("No sound effect for item "..item.Item.." found, playing general effect in stead",255,0,0)
             SFX('SFX/Item/GeneralPickup.ogg') 
             end
          --Msg(iname.." acquired",(x*Maps.Map.GridX)-Maps.CamX,(y*Maps.Map.GridY)-Maps.CamY)
          AddMiniMessage("Game",iname.." acquired",(x*Maps.Map.GridX)-Maps.CamX,(y*Maps.Map.GridY)-Maps.CamY)
          ItemMap[Maps.MapName][ak] = nil
          TreasureCollected = (TreasureCollected or 0) + 1
          if achievements["TREASURE"..TreasureCollected] then AwardTrophy("TREASURE"..TreasureCollected) end
          end   
       end 
    end
end

function __consolecommand.TREASURECOLLECTED(a)
if a[1] and a[1]~="" then TreasureCollected = Sys.Val(a[1]) end
CSay("Treasures collected: "..sval(TreasureCollected))
end



function Walk(ANoChange)
local NoChange = ANoChange and ANoChange~="nil" and ANoChange~="" and ANoChange~="false"
DefDefeatRespawn(true) -- Make sure this is set or nasty things may happen!
Actors.Pick("Player")
local x = Actors.PA_X()
local y = Actors.PA_Y()
local akx,aky,akcoords,coords,chosencoords,ak
if Actors.Walking()==0 and Actors.Moving()==0 and (not NoChange) then
   -- Walk by keyboard
   if KeyDown(KEY_UP)    or joyy()==-1 then Actors.WalkTo(x,y-1); Actors.NewWind('North') end
   if KeyDown(KEY_DOWN)  or joyy()== 1 then Actors.WalkTo(x,y+1); Actors.NewWind('South') end
   if KeyDown(KEY_LEFT)  or joyx()==-1 then Actors.WalkTo(x-1,y); Actors.NewWind('West' ) end
   if KeyDown(KEY_RIGHT) or joyx()== 1 then Actors.WalkTo(x+1,y); Actors.NewWind('East' ) end
   -- Walk by joypad
   -- Walk by mouse
   if M1 then
      -- Get the clicked spot
      local mx = math.floor((Mouse.X()+Maps.CamX)/Maps.Map.GridX)
      local my = math.floor((Mouse.Y()+Maps.CamY)/Maps.Map.GridY)
      -- Was a savespot clicked by chance?
      if SaveSpots[mx..","..my] then
         coords = {{mx,my+1},{mx,my-1},{mx-1,my},{mx+1,my}}
         chosencoords=nil
         for ak,akcoords in ipairs(coords) do
             if (not chosencoords) and Maps.VBlockMap(akcoords[1],akcoords[2])==0 then chosencoords=akcoords end
             end
         if chosencoords then    
            arrival = { ['gamefunction']=SaveSpot,['arg']=SaveSpots[mx..","..my], ['x']=chosencoords[1], ['y']=chosencoords[2]}
            mx = chosencoords[1]
            my = chosencoords[2]
            end
         -- my = my + 1 -- Old code
         end
      -- Action Key Events
      mx,my = WalkClickAKEvent(mx,my)
      -- Removal Switch
      if RemovalSwitches[mx..","..my] then
         coords = {{mx,my+1},{mx,my-1},{mx-1,my},{mx+1,my}}
         chosencoords=nil
         for ak,akcoords in ipairs(coords) do
             if (not chosencoords) and Maps.VBlockMap(akcoords[1],akcoords[2])==0 then chosencoords=akcoords end
             end
         if chosencoords then    
            arrival = { ['gamefunction']=RemovingSwitch,['arg']=mx..","..my, ['x']=chosencoords[1], ['y']=chosencoords[2]}
            mx = chosencoords[1]
            my = chosencoords[2]
            end
         -- my = my + 1 -- Old code
         end      
      -- Actors
      local tag
      tag = Actors.AnybodyThere(mx,my,1)
      if tag=="*NOBODY*" or  tag=="Player" then tag = Actors.AnybodyThere(mx,my+1,1) end
      if tag~="*NOBODY*" and tag~="Player" then 
         arrival = { ["gamefunction"]=WalkActorAction,['arg']=tag,['x']=Actors.PA_X(),['y']=Actors.PA_Y()+1}
         my = Actors.PA_Y()+1
         end
      Actors.Pick("Player")   
      -- Banzai
      CSay("User wants to walk to ("..mx..","..my..")")
      Actors.WalkTo(mx,my)
      end
   -- Activate by pressing the action button
   if PressAction then GameAction() end
   -- end walking input
   end
-- Execute walking
Actors.Walk()
-- Change sprite direction
-- CSay(Actors.PA_Wind())
if Actors.PA_Wind()~="" and (Actors.Moving()==0) then
   -- CSay("Choosing picture: "..activecharacter.."."..Actors.PA_Wind())
   Actors.ChoosePic(activecharacter.."."..Actors.PA_Wind())
   end
if Actors.Walking()==1 or Actors.Moving()==1 then
   NextFrame = NextFrame or 4
   NextFrame = NextFrame - 1
   if NextFrame==0 then Actors.IncFrame() NextFrame = 4 end  
   NFTIME=5 
   else
   if NFTIME and NFTIME>0 then NFTIME=NFTIME-1 else Actors.SetFrame(0) end
   end   
if wox~=x or woy~=y then RandomEncounters() end
if arrival then
   if arrival.x==x and arrival.y==y then WalkArrival() end
   end
WalkOverEventsDo(x,y,wox,woy)   
WalkTeleportDo()
WalkCheckItems()   
-- Update Zone
local zone = Maps.MapSpot('Zone_Visibility',Actors.PA_X(),Actors.PA_Y())
if zone ~= OldZone and (not IrravoniaFlyZone[zone]) then
   if OldZone then Maps.Run('ZA_doLeave',OldZone) end 
   OldZone = zone
   Look(zone)
   Maps.Run("ZA_doEnter",zone)
   elseif wox~=x or woy~=y then
   Maps.Run("ZA_doMove",zone) 
   end
wox=x
woy=y
end
