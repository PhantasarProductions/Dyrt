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

function Bye()
WorldMap('AERIA')
end



function GALE_OnLoad()
local arrived
if not Done("&DONE.MALABIAENTER.FIRST") then
   Look(2)
   Maps.CamX = 224
   Maps.CamY = 288
   Music("Silence")
   PartyPop("Gordo","*bundle")
   MapText("A") 
   Actors.Pick("PopAziella")
   WalkToExit("WalkAziella","PopAziella")
   arrived = false
   while not arrived do
         Actors.Pick("PopAziella")
         Actors.IncFrame()
         arrived = Actors.PA_X()==21 and Actors.PA_Y()==22
         Actors.Walk()
         DrawScreen()
         Flip()
         end
   Actors.Pick("PopAziella")
   Actors.ChoosePic("Aziella.South")             
   MapText("B")
   PartyUnPop()
   end
if CVV("&BLOCK.GORDO") then
   MapText("NOPE")
   ZA_Enter(2,Bye)
   return
   end   
Music("Angevin")
ZA_Enter(1,Bye)   
end

function ACTOR_GORDO()
local a = GetActiveChar()
-- @SELECT a
-- @CASE 'Eric'
   MapText("ERIC")
-- @CASE 'Scyndi'
   MapText("SCYNDI")
-- @DEFAULT
   MapText("GORDO")   
-- @ENDSELECT   
end

function Malabia()
if not Done("&DONE.MALABIA.SPOKEN.FIRST") then
   PartyPop("Malabia","*bundle")
   MapText("MALABIA_ONE")
   PartyUnPop()
   Look(200)
   MapText("END")
   Done("&DONE.TEAM.ERIC")
   if CVV("&DONE.TEAM.REBECCA") then 
      LAURA.Shell("CH4_Split/BOTHDONE.lua")
      else
      LAURA.Shell("CH4_Split/StartTeamRebecca.lua")
      end
   end
if GetActiveChar()=='Scyndi' and (not Done('&DONE.SCYNDI.MALABIA')) then
   MapText("MALABIA_SCYNDI")
   LAURA.ExecuteGame("Scyndi_Get_Malabia")
   Done("&SCYNDIHAS.MALABIA")
   end   
end
