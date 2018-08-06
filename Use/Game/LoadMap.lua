--[[
/* 
  LoadMap - Dyrt

  Copyright (C) 2013, 2014 JP Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
  the restrictions of this file are removed and will automatically become
  zLib licensed (see below).
  
  Please note that doing so counts as a modification and must be marked as such
  in accordance to the zLib license.
  ===========================


  zLib license terms:

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



Version: 14.10.22

]]

-- @IF IGNORE
-- This part is just to fool the IDE, as GALE will always ignore it :P (as this definition has already been made elsewhere)
__consolecommand = {}
-- @FI

function CreateTeleporterExits()
teleporters = {}
telefrom = {}
CSay("- Creating teleport exits")
local w = Maps.Map.SizeX
local h = Maps.Map.SizeY
local x
local y
local ID
for x=0,w,1 do for y=0,h,1 do
	if Maps.Obj.Exist(x,y,"%TeleportExit")==1 then
	   Maps.Obj.ListStart(x,y,"%TeleportExit")
	   while Maps.Obj.ListNext()==1 do
	     if Maps.Obj.CO.Cl("ID")=="" then Sys.Error("ID-Less teleporter Exit!","X,"..x..";Y,"..y) end
	     ID = Maps.Obj.CO.Cl("ID")
	     teleporters[ID] = {
	          ["X"] = x,
	          ["Y"] = y,
	          ["Wind"] = Maps.Obj.CO.Cl("Wind"), 
	          ["CamX"] = Sys.Val(Maps.Obj.CO.Cl("CamX")),
	          ["CamY"] = Sys.Val(Maps.Obj.CO.Cl("CamY"))
	       }
	     CSay("  = ("..x..","..y..") "..Maps.Obj.CO.Cl("Wind") .. " >> "..ID)
	   	 end
	   end
	if Maps.Obj.Exist(x,y,"%Teleport")==1 then
     Maps.Obj.ListStart(x,y,"%Teleport")
	   while Maps.Obj.ListNext()==1 do
	         telefrom[x..','..y] = Maps.Obj.CO.Cl("Exit")
	         Console.Write("Teleporter at ("..x..","..y..") leads to exit: "..telefrom[x..","..y])
	         end
	   end
	end end -- end the 2x for statement
end

function CreateItemMap(IgnoreTravelEmblem)
local MN = Maps.MapName
local c = 0
local x,y
local item
ItemMap = ItemMap or {}
if ItemMap[MN] then return end
ItemMap[MN] = {}
for x=0,Maps.Map.SizeX do
    for y=0,Maps.Map.SizeY do
        if Maps.Obj.Exist(x,y,"%Item")==1 then
           Maps.Obj.ListStart(x,y,"%Item")
           while Maps.Obj.ListNext()==1 do
                 item = Str.Upper(Maps.Obj.CO.Cl("Item"))
                 if item=="" then Sys.Error("Empty item on map","X,"..x..";Y,"..y) end
                 if (not (item=='TRAVEL' and IgnoreTravelEmblem)) then
                    c = c + 1
                    ItemMap[MN][c] = {["Item"] = item, ["X"] = x, ["Y"] = y}
                    Console.Write("Added item "..item.." on spot ("..x..","..y..")",143,114,173)
                    else
                    Console.Write("Traveler's Emblem at ("..x..","..y..") ignored as requested",255,255,255)
                    end
                 end        
           end
        end
    end
end

function EmptyItemMap(MN)
ItemMap = ItemMap or {}
ItemMap[MN] = {}
end

function PlaceItem(MN,x,y,item)
ItemMap = ItemMap or {}
ItemMap[MN] = ItemMap[MN] or {}
table.insert(ItemMap[MN], { X = Sys.Val(x), Y = Sys.Val(y), Item=item})
end


function __consolecommand.RELOADITEMS(a)
local MN = Maps.MapName
Console.Write("Reloading items for map: "..MN,255,0,255)
ItemMap[MN] = nil
Console.Write(a[1],100,100,100)
if a[1]=='ITE' then Console.Write("Traveler's Emblem should be ignored",255,0,0) end
CreateItemMap(Str.Upper(a[1])=='ITE')
end

function CreateMapData()
EncounterTable = Maps.Data("Encounters")
Console.Write("Encounter table: "..EncounterTable,56,74,6)
end

function CreateSaveSpots()
SaveSpots = {}
for x=0,Maps.Map.SizeX do
    for y=0,Maps.Map.SizeY do
        if Maps.Obj.Exist(x,y,"%SaveSpot")==1 then
	   Maps.Obj.ListStart(x,y,"%SaveSpot")
	   Maps.Obj.ListNext() -- Only the first savespot in the list will be taken, even if there are (for any reason) more savespots on this tile!
	   SaveSpots[x..","..y] = Str.Upper(Maps.Obj.CO.Cl("Type"))
     if skill==1 and Str.Upper(Maps.Obj.CO.Cl("Type"))=="RED" then SaveSpots[x..","..y] = "GREEN" end
	   CSay("Save Spot placed at ("..x..","..y..")")
	   Maps.DBlockMap(x,y,1)
	   if Maps.Obj.ListNext()==1 then Console.Write("WARNING! Multiple savespots on ("..x..","..y..")!",255,0,0) end
	   end
        end
    end
end

function RemoveSaveSpots() -- Used by the Abyss level generator and strongly recommended against using it anywhere else
SaveSpots = {}
end


function CreateWalkOverEvents()
WalkOverEvents = {}
for x=0,Maps.Map.SizeX do
    for y=0,Maps.Map.SizeY do
        if Maps.Obj.Exist(x,y,"WOEvent")==1 then
           Maps.Obj.ListStart(x,y,"WOEvent")
           while Maps.Obj.ListNext()==1 do
                 WalkOverEvents[x..","..y] = {}
		 table.insert(WalkOverEvents[x..","..y],{ ['X']=x, ['Y']=y, ['MapFunction']=Maps.Obj.CO.Cl('CallFunction'), ['GameFunction']=Maps.Obj.CO.Cl('GameFunction'),['Parameter']=Maps.Obj.CO.Cl('Parameter')})
		 end
           end
        end
    end	 
end

function SetIrravoniaFlyZone(z)
local x,y
IrravoniaFlyZone[z] = true
for x=0,Maps.Map.SizeX do for y=0,Maps.Map.SizeY do
    if Maps.LayerValue(x,y,"Zone_Visibility")==z then 
       IrravoniaFlySpot[x..","..y] = true
       Maps.DBlockMap(x,y,1) 
       end
    end end -- We used for twice, so we also must end twice :)
Console.Write("Irravonia Fly Zone set to zone: "..z,255-z,0,z)    
end

function YouShallNotPass(z)
for x=0,Maps.Map.SizeX do for y=0,Maps.Map.SizeY do
    if Maps.LayerValue(x,y,"Zone_Visibility")==z then 
       Maps.DBlockMap(x,y,1) -- If zone is NP, Gandalf will say "YOU SHALL NOT PASS!" :P
       end
    end end
end    

function CreateDataFromZones()
local ak,al,tag
local ZnSplit    = {}
ZoneName         = {}
NoCombatZone     = {}
NoScrollZone     = {}
MaxRandEncnt     = {}
NoHScrollZone    = {}
NoVScrollZone    = {}
IrravoniaFlyZone = {}
IrravoniaFlySpot = {}
ZoneShowZone     = {}
ZoneTitle        = {}
ZoneScrollBound  = {}
Console.Write('Fetching Zone Data',14,88,90)
for ak = 0 , 255 do 
    ZoneName[ak] = Maps.ZoneName(ak)
    ZnSplit = split(Str.Upper(ZoneName[ak]),'::')
    for al,tag in ipairs(ZnSplit) do
        if tag=='NE'  then NoCombatZone[ak] =true end
        if tag=='NS'  then NoScrollZone[ak] =true end
        if tag=="NHS" then NoHScrollZone[ak]=true end
        if tag=="NVS" then NoVScrollZone[ak]=true end
        if tag=="IFZ" then SetIrravoniaFlyZone(ak) end
        if tag=="NP"  then YouShallNotPass(ak) end 
        if Str.Left(tag,4)=="MINX" or Str.Left(tag,4)=="XMIN" then
           ZoneScrollBound[ak] = ZoneScrollBound[ak] or {}
           ZoneScrollBound[ak].MinX = Sys.Val(Str.Right(tag,Str.Length(tag)-4))
           end  
        if Str.Left(tag,4)=="MINY" or Str.Left(tag,4)=="YMIN" then
           ZoneScrollBound[ak] = ZoneScrollBound[ak] or {}
           ZoneScrollBound[ak].MinY = Sys.Val(Str.Right(tag,Str.Length(tag)-4))
           end  
        if Str.Left(tag,4)=="MAXX" or Str.Left(tag,4)=="XMAX" then
           ZoneScrollBound[ak] = ZoneScrollBound[ak] or {}
           ZoneScrollBound[ak].MaxX = Sys.Val(Str.Right(tag,Str.Length(tag)-4))
           end  
        if Str.Left(tag,4)=="MAXY" or Str.Left(tag,4)=="YMAX" then
           ZoneScrollBound[ak] = ZoneScrollBound[ak] or {}
           ZoneScrollBound[ak].MaxY = Sys.Val(Str.Right(tag,Str.Length(tag)-4))
           end  
        if Str.Left(tag,2)=="ME" then MaxRandEncnt[ak] = Sys.Val(Str.Right(tag,Str.Length(tag)-2)) end
        if Str.Left(tag,2)=="SZ" then
           ZoneShowZone[ak] = ZoneShowZone[ak] or {}
           table.insert(ZoneShowZone[ak],Sys.Val("$"..right(tag,2)))
           CSay("When you are in zone #"..ak.." then zone $".."$"..right(tag,2).." should also be visible!")
           end
        if Str.Left(tag,3)=="LC>" or Str.Left(tag,3)=="LZ>" then ZoneTitle[ak]=Str.Right(tag,len(tag)-3) end   
        end
    end
Console.Write('No combat zones are:',14,88,90)
for ak,al in pairs(NoCombatZone) do
    Console.Write(" = "..ak,90,88,14)
    end    
Console.Write('No scroll zones are:',14,88,90)
for ak,al in pairs(NoScrollZone) do
    Console.Write(" = HZ "..ak,90,88,14)
    end    
for ak,al in pairs(NoHScrollZone) do
    Console.Write(" = H  "..ak,90,88,14)
    end    
for ak,al in pairs(NoVScrollZone) do
    Console.Write(" = V  "..ak,90,88,14)
    end        
end

function __consolecommand.SZLIST()
local i,z,i2,z2
for i,z in pairs(ZoneShowZone) do
    Console.Write("- Zone #"..z,0,255,255)
    for i2,z2 in ipairs(z) do
        Console.Write("  = "..z2)
        end
    end
end

function __consolecommand.SCROLLBOUND()
local c = 0
local z,s,vkey,vval
for z,s in spairs(ZoneScrollBound) do
    CWrite("Zone #"..z)
    for vkey,vval in spairs(s) do
        CWrite(vkey.." = "..vval,255,180,0)
        end
    end
end

function UberLook(azone) 
local zone = azone
if type(zone)~="number" then zone = Sys.Val(zone) end
if not ZoneShowZone[zone] then return end
local i,z
for i,z in ipairs(ZoneShowZone[zone]) do
    Maps.IamSeeing(z,1)
    end
end

function CreateAKEvents()
AKEvents = {}
local x,y
Console.Write("Configuring AK Events",123,45,67)
for x=0,Maps.Map.SizeX do
    for y=0,Maps.Map.SizeY do
        if Maps.Obj.Exist(x,y,"%AKEvent")==1 then
           Maps.Obj.ListStart(x,y,"%AKEvent")
           while Maps.Obj.ListNext()==1 do
                 table.insert(AKEvents,{
                             ['x'] = x,
                             ['y'] = y,
                             ['MapFunction']    = Maps.Obj.CO.Cl('MapFunction'),
                             ['GameFunction']   = Maps.Obj.CO.Cl("GameFunction"),
                             ['Parameter']      = Maps.Obj.CO.Cl("Parameter"),
                             ['ShellFile']      = Maps.Obj.CO.Cl("ShellFile"),
                             ['ShellFunction']  = Maps.Obj.CO.Cl("ShellFunction"),
                             ['KeyMustFace']    = Maps.Obj.CO.Cl("KeyMustFace"),
                             ['StartMouseX']    = Sys.Val(Maps.Obj.CO.Cl("StartMouseX")),
                             ['StartMouseY']    = Sys.Val(Maps.Obj.CO.Cl("StartMouseY")),
                             ['EndMouseX']      = Sys.Val(Maps.Obj.CO.Cl("EndMouseX")),
                             ['EndMouseY']      = Sys.Val(Maps.Obj.CO.Cl("EndMouseY"))
                             })
                 Console.Write("= AKEvent added at position ("..x..','..y..')',123,45,67)                             
                 end
           end
        end
    end
end

function CreateRemovalTags()
local x,y
RemovalTags = {}
for x=0,Maps.Map.SizeX do
    for y=0,Maps.Map.SizeY do
        if Maps.Obj.Exist(x,y,"%RemoveTag")==1 then
           Maps.Obj.ListStart(x,y,"%RemoveTag")
           while Maps.Obj.ListNext()==1 do
                 RemovalTags[Maps.Obj.CO.Cl('Tag')] = 
                    {
                       x = x,
                       y = y,
                       Layer = Maps.Obj.CO.Cl('Layer'),
                       Scroll = upper(Maps.Obj.CO.Cl("Scroll"))=='YES' or upper(Maps.Obj.CO.Cl("Scroll"))=='JA' or upper(Maps.Obj.CO.Cl("Scroll"))=='TRUE' or Maps.Obj.CO.Cl("Scroll")==""
                    } 
                 if RemovalTags[Maps.Obj.CO.Cl('Tag')]=="" then RemovalTags[Maps.Obj.CO.Cl('Tag')]="Walls" end
                 end
           end
        end
    end
for x,y in spairs(RemovalTags) do
    Console.Write("Removal Tag '"..x.."' => "..y.Layer.."("..y.x..","..y.y..")",255,255,0)
    end        
end

function CreateRemovalSwitches()
local x,y
RemovalSwitches = {}
for x=0,Maps.Map.SizeX do
    for y=0,Maps.Map.SizeY do
        if Maps.Obj.Exist(x,y,"%RemoveSwitch")==1 then
           Maps.Obj.ListStart(x,y,"%RemoveSwitch")
           while Maps.Obj.ListNext()==1 do
                 RemovalSwitches[x..","..y] = ( 
                    {
                        x      = x,
                        y      = y,
                        tag    = Maps.Obj.CO.Cl("RemoveTag"),
                        tot    = Maps.LayerValue(x,y,"Obstacles")+1   ,     
                        ort    = Maps.LayerValue(x,y,"Obstacles")                 
                    })                     
                 end
           end
        end
    end
end
 
-- Scyndi. Can you hook on anything?
function CreateScyndiHookSpots()
local x,y
ScyndiHook = {}
for x=0,Maps.Map.SizeX do
    for y=0,Maps.Map.SizeY do
        if Maps.Obj.Exist(x,y,"%WhipHookPoint")==1 then
           -- Maps.Obj.ListStart(x,y,"%RemoveSwitch")
           ScyndiHook[x..","..y] = true           
           end
        end
    end       
end 

-- Merya. Can you find something?
function CreateRogueSpots()
local x,y
local ax,ay
RogueSpots = {}
for x=0,Maps.Map.SizeX do
    for y=0,Maps.Map.SizeY do
        if Maps.Obj.Exist(x,y,"%RogueSpot")==1 then
           Maps.Obj.ListStart(x,y,"%RogueSpot")
           while Maps.Obj.ListNext()==1 do
                 RogueSpots[x..","..y] = ( 
                    {
                        x      = x,
                        y      = y,
                        level  = Sys.Val(Maps.Obj.CO.Cl("Level")),
                        zones  = {}
                    })                     
                 for ax=x-1,x+1 do for ay=y-1,y+1 do 
                     table.insert(RogueSpots[x..","..y].zones,Maps.LayerValue(ax,ay,"Zone_Visibility"))
                     end end  -- 2x for = 2x end :)  
                 end
           end
        end
    end
end

function __consolecommand.ROGUESPOTS()
local r,g,b = randomcolor()
local spot
CWrite("Merya can find the next spots:              ("..r..","..g..","..b..")")
for _,spot in pairs(RogueSpots) do
    CWrite()
    CWrite("Position:     ("..spot.x..","..spot.y..")",r,g,b)
    CWrite("Level:        "..spot.level,r,g,b)
    CWrite("Zones:        "..itablejoin(spot.zones),r,g,b)
    end
CWrite()
if char.Merya.SearchPenalty then CWrite("Merya suffers a penalty of "..char.Merya.SearchPenalty,b,g,r) end    
end

function __consolecommand.SCYNDIHOOKS()
local k
local c = 0
for k,_ in pairs(ScyndiHook) do
    c = c + 1
    CWrite('Spot found at ('..k..')')
    end
if c==1 then
   CWrite("  1 spot found")
   else
   CWrite("  "..c.." spots found")
   end    
end

function CreateMoveBlocks()
MoveBlocks = {}
--BlockZones = {}
local zone
for x=0,Maps.Map.SizeX do
    for y=0,Maps.Map.SizeY do
        if Maps.Obj.Exist(x,y,"%MoveBlock")==1 then
           Maps.Obj.ListStart(x,y,"%MoveBlock")
           while Maps.Obj.ListNext()==1 do
                 zone = Maps.LayerValue(x,y,"Zone_Visibility")
                 MoveBlocks[zone] = MoveBlocks[zone] or {}
                 table.insert(MoveBlocks[zone],{
                                 cx   = x,
                                 cy   = y,
                                 ox   = x,
                                 oy   = y,
                                 fx   = 0,
                                 fy   = 0,
                                 --push = upper(Left(Maps.Obj.CO.Cl("AorD"),1))=="Y" or upper(Left(Maps.Obj.CO.Cl("AorD"),1))=="T" or upper(Left(Maps.Obj.CO.Cl("AorD"),1))=="J",
                                 push = upper(Left(Maps.Obj.CO.Cl("Pushable"),1))=="Y" or upper(Left(Maps.Obj.CO.Cl("Pushable"),1))=="T" or upper(Left(Maps.Obj.CO.Cl("Pushable"),1))=="J",                                 
                                 pull = upper(Left(Maps.Obj.CO.Cl("Pullable"),1))=="Y" or upper(Left(Maps.Obj.CO.Cl("Pullable"),1))=="T" or upper(Left(Maps.Obj.CO.Cl("Pullable"),1))=="J",
                                 zone = zone
                              })
                 end -- List next
           end -- exist
        end -- for y
    end -- for x         
end

function __consolecommand.MOVEBLOCKS()
local ak,al,bl
local k,v
for ak=0,255 do
    if MoveBlocks[ak] then
       CWrite("Zone #"..ak,255,0,255)
       for al,bl in ipairs(MoveBlocks[ak]) do
           CWrite("- Block #"..al,0,255,255)
           for k,v in spairs(bl) do
               CWrite("  = "..Right("    "..k,4).." = "..sval(v),255,255,0)
               end
           end
       end
    end
end

-- The forest doesn't fool Dernor!
function CreateDernorSpots()
DernorSpots = {}
for x=0,Maps.Map.SizeX do
    for y=0,Maps.Map.SizeY do
        if Maps.Obj.Exist(x,y,"%NatureBarrier")==1 then
           Maps.Obj.ListStart(x,y,"%NatureBarrier")
           while Maps.Obj.ListNext()==1 do
                 table.insert(DernorSpots,{
                         x       = x,
                         y       = y,
                         zone    = Maps.LayerValue(x,y,"Zone_Visibility"),
                         appear  = upper(Left(Maps.Obj.CO.Cl("AorD"),1))=="Y" or upper(Left(Maps.Obj.CO.Cl("AorD"),1))=="T" or upper(Left(Maps.Obj.CO.Cl("AorD"),1))=="J" or upper(Left(Maps.Obj.CO.Cl("AorD"),1))=="A",
                         texture = Sys.Val("$"..Maps.Obj.CO.Cl("PicNum"))
                      })
                 end
           end
        end
    end
end

function CreateSealedBoss()
MapSealedBoss = nil
for x=0,Maps.Map.SizeX do
    for y=0,Maps.Map.SizeY do
        if Maps.Obj.Exist(x,y,"%SealedBoss")==1 then
           Maps.Obj.ListStart(x,y,"%SealedBoss")
           while Maps.Obj.ListNext()==1 do
                 if MapSealedBoss then Sys.Error("Multiple Sealed bosses in one map found. Only 1 allowed!") end
                 MapSealedBoss = {
                      X        = x,
                      Y        = y,
                      Boss     = Maps.Obj.CO.Cl("Boss"),
                      Arena    = Maps.Obj.CO.Cl("Arena"),
                      Music    = Maps.Obj.CO.Cl("Music"),
                      Char     = Maps.Obj.CO.Cl("Character"),
                      Ability  = Maps.Obj.CO.Cl("Ability")                 
                 }
                 if (not MapSealedBoss.Music) or MapSealedBoss.Music=="" then MapSealedBoss.Music="BOSS.ogg" end
                 end
           end
        end
    end
end

function __consolecommand.DERNORSPOTS()
local ak,al,bl
local k,v,rec
for ak,rec in ipairs(DernorSpots) do
    CWrite("Record:"..Dec2Hex(ak))
    for k,v in spairs(rec) do
        CWrite(Right("          "..k,10).." = "..sval(v),180,180,180)
        end
    end
CWrite("Total number of spots:"..#DernorSpots)    
end
 
 

 
function __LoadMap()
CreateTeleporterExits()
CreateMapData()
CreateItemMap()
CreateWalkOverEvents()
CreateDataFromZones()
CreateSaveSpots()
CreateAKEvents()
CreateRemovalTags()
CreateRemovalSwitches()
CreateScyndiHookSpots()
CreateRogueSpots()
CreateMoveBlocks()
CreateDernorSpots()
CreateSealedBoss()
--CreateScrollBoundaries()
OldZone = nil
RandEncOff=false
AllowTOE=CVV("&TOE."..Str.Upper(Maps.MapName))
CSay("Map: "..Str.Upper(Maps.MapName).." >> AllowTOE = "..sval(AllowTOE))
end

function ResetTOE()
AllowTOE=CVV("&TOE."..Str.Upper(Maps.MapName))
end
