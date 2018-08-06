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


switchpuzzle = {
    [ 3] = { A1 = {30,88}, A2 = {32,88}, A3 = {34,88} ,    C1 = {30,91}, C2 = {32,91}, C3 = {34,91} },
    [ 6] = { A1 = {30,42}, A2 = {32,42}, A3 = {34,42}, A4 = {36,42}, A5 = {38,42} },
    [10] = { A1 = {44,56}, A2 = {46,56}, A3 = {48,56},  B1 = {44,58}, B3 = {48,58},   C1 = {44,60}, C2 = {46,60}, C3 = {48,60} },
    [14] = { A1 = {79,52}, A2 = {81,52}, A3 = {83,52},  B1 = {79,54}, B2 = {81,54}, B3 = {83,54},   C1 = {79,56}, C2 = {81,56}, C3 = {83,56} }
}

remswitch = { [3] = {32,85} , [6] = {29,30} , [10] = {46,64}, [14] = {99,53}}

actswitch = { [3] = {}, [6] = {}, [10]= {}, [14] = {} }

function ReSwitch()
posswitch = {}
local ak,d,al,ps
for ak,d in pairs(switchpuzzle) do
    for al,ps in pairs(d) do
        posswitch[ps[1]..","..ps[2]] = al
        end
    end
end


function Switch()
local px,py,pw = PlayerCoords()
local zone = Maps.LayerValue(px,py,"Zone_Visibility")
CSay("Stepped on a switch")
if CVV("&SOLVED.MALABIA.ZONE["..zone.."]") then CWrite("= Puzzle in zone #"..zone.." has already been solved",255,0,0)return end
local cs = posswitch[px..","..py]
if not cs then Sys.Error("No switch at ("..px..","..py..")") end
local la = Str.ASCII(cs)
local ln = Sys.Val(Str.Right(cs,1))
local changelist = {cs}
local ak,p
table.insert(changelist,Str.Char(la-1)..ln)
table.insert(changelist,Str.Char(la+1)..ln)
table.insert(changelist,Str.Char(la)..(ln-1))
table.insert(changelist,Str.Char(la)..(ln+1))
local sp = switchpuzzle[zone]
for _,ak in ipairs(changelist) do
    if sp[ak] then
       CWrite("Changing: "..ak,0,255,255)
       actswitch[zone][ak] = not actswitch[zone][ak]
       if actswitch[zone][ak] then
          CWrite("("..sp[ak][1]..","..sp[ak][2]..") turned green",0,255,0)
          Maps.LayerDefValue(sp[ak][1],sp[ak][2],"FloorDeco",0xf2)
          else
          CWrite("("..sp[ak][1]..","..sp[ak][2]..") turned blue",0,0,255)
          Maps.LayerDefValue(sp[ak][1],sp[ak][2],"FloorDeco",0xf1)
          end
       else
       CWrite("Skipping: "..ak,255,180,0)   
       end
    end
-- Is the puzzle solved or not, and if so open the gate and make the switch setting permanent.
local ok = true
for ak,_ in pairs(sp) do
    ok = ok and actswitch[zone][ak]
    end
if ok then
   for ak,p in pairs(sp) do Maps.LayerDefValue(p[1],p[2],'FloorDeco',0xf2,1) end -- changes are now permanent.
   if not remswitch[zone] then Sys.Error("No remove coordinates set for puzzle in zone #"..zone) end
   Maps.LayerDefValue(remswitch[zone][1],remswitch[zone][2],"Obstacles",0,1)
   Var.D("&SOLVED.MALABIA.ZONE["..zone.."]","TRUE")
   if zone==14 then
      Done("&TOE.CH4_FRUSKBRANDO")
      Done("&TOE.CH4_MALABIACAVE")
      LAURA.ExecuteGame("ResetTOE")
      end
   Maps.BuildBlockMap()
   end           
end

function CompleteDungeon()
WorldMap_Reveal("AERIA","MALABIATEMPLE")
WorldMap("AERIA")
end


function GALE_OnLoad()
Music("Holy Planet")
ReSwitch()
end
