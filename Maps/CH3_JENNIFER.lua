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
function GALE_OnLoad()
Music("Moonlight Hall")
end

function ToCave()
Maps.LoadMap("CH3_NAKEDROCKSCAVE")
SpawnPlayer("FromJennifer")
end


function Bye()
if CVV("&DONE.SPOKENJENNIFER1") then 
   WorldMap()
   else   
   MapText('NOEXIT')
   end
end

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



function ACTOR_JENNIFER_BUITEN()
Music("Calm Indoors")
Var.D("&DONE.SPOKENJENNIFER1","TRUE")
WorldMap_Reveal("DELISTO","GRASSPLAINS")
WorldMap_Reveal("DELISTO","JENNIFER")
MapText("JEN1A")
Actors.Remove('Jennifer_Buiten',1)
Actors.Pick("Player")
LAURA.ExecuteGame('ManualTeleport','Binnen');
Look(1)
PartyPop("Jen","*bundle",{"Scyndi","Irravonia"})
MapText("JEN1B")
Look(3)
MapText("JEN1C")
Actors.Pick("PopIrravonia")
Actors.WalkTo(40,9)
EWalk(150,"Irravonia")
MapText("JEN1D")
PartyUnPop()
end

function ACTOR_JENNIFER()
if CVV('&DONE.CHAPTER3') then
   if not Done('&DONE.JENNIFERREVEALS') then
      PartyPop("Dz","*bundle")
      MapText("DZGJYMZA")
      MapText("DZGJYMZA_PART_TWO")
      PartyUnPop()
      WorldMap_Reveal("DELISTO","DARKSTORAGE")
      return
      else
      MapText("JEN2A")
      return
      end 
   end
MapText("JEN1E")
end

function PartyRejoin()
Music("Moonlight Hall")
if CVV("&DONE.JENNIFERPARTYREJOIN") then return end
Var.D("&DONE.JENNIFERPARTYREJOIN","TRUE")
LAURA.ExecuteGame("LevelAbsenceUpdate","Rebecca;Irravonia;%CH3.IRRASTARTLEVEL")
--[[
local il = CVV("%CH3.IRRASTARTLEVEL")
if char.Rebecca.Level<49 then
   CSay("Rebecca was level "..char.Rebecca.Level)
   char.Rebecca.Level = char.Rebecca.Level + il
   if char.Rebecca.Level>49 then char.Rebecca.Level = 49 end
   CSay("Rebecca is now level "..char.Rebecca.Level)
   end
]]   
NewParty("'Irravonia','Scyndi','Rebecca','Dernor','Merya'")
PartyPop("Rejoin","*bundle",{'Irravonia','Scyndi','Rebecca','Dernor','Merya'})
MapText("REB1A")
PartyUnPop()
end


-- @USEDIR Scripts/Use/AnyWay
-- @USEDIR Scripts/Use/Maps
