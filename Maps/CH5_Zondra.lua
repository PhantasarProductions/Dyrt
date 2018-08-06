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
-- @USEDIR Scripts/Use/AnyWay
-- @USEDIR Scripts/Use/Maps

function Zondra_Scroll()
if Maps.CamY>-92 then Maps.CamY=Maps.CamY-1 end
if Maps.CamY<-92 then Maps.CamY=Maps.CamY+1 end
return Maps.CamY==-92
end

function Zondra_Story()
if not Done("&DONE.ZONDRAGRAVE") then
   repeat
   DrawScreen()
   Flip()
   until Zondra_Scroll()
   PartyPop("Zondra","*bundle")
   MapText("ZONDRA")
   PartyUnPop()
   end
end

function ACTOR_JACK()
MapText("JACK."..upper(GetActiveChar()))
end

function GALE_OnLoad()
Music("Grave Matters")
DungeonTitle()
ZA_Cycle(0x02,Zondra_Scroll)
ZA_Enter(0x02,Zondra_Story)
ZA_Enter(0x03,WorldMap)
end

