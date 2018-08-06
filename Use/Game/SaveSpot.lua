--[[
/* 
  SaveSpot

  Copyright (C) 2013, 2014 Jeroen P. Broks
  
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



Version: 14.10.14

]]
function SaveSpot(Color)
Actors.Pick("Player")
local x = Actors.PA_X()
local y = Actors.PA_Y()
if Color~='BLUE' and Color~='RED' and Color~='GREEN' then
   Console.Write("WARNING! Unknown Savegame color ("..Color..")",255,82,91)
   else
   SFX('SFX/SaveSpot/'..Color..".ogg")
   end
-- Blue Save Spots will move the point where you resume the game when defeated
if Color=='BLUE' then
   DefDefeatRespawn()
   --[[ Old
   DefeatRespawn = {
      ['Room'] = Maps.MapName,
      ['X']    = x,
      ['Y']    = y      
     }
   ]]
   Console.Write("Defeat Respawn Spot is now: "..DefeatRespawn.Room.."("..DefeatRespawn.X..","..DefeatRespawn.Y..")",14,118,156)
   end
local ak,ch   
-- Recover at Green or Blue savespots or at the Easy Skill
if Color=='GREEN' or Color=='BLUE' or skill==1 then 
   ECNBar = ECNBarMax   
   SerialBoxText("General/SaveSpot","RECOVER")
   for ak,ch in pairs(party) do
       CSay("Recovery on: "..ch)
       char[ch].HP[1] = char[ch].HP[2]
       end
   StatusSet[1]={}    
   end
-- Save the game   
SerialBoxText("General/SaveSpot","SAVESPOT")
local saved = SaveGame(skill==3) -- This won't cause the game to show the savegame menu in the hard mode!
if saved then
   SerialBoxText("General/SaveSpot","SAVEDONE")
   else
   SerialBoxText("General/SaveSpot","SAVECANCELED")
   end
end   


function DefDefeatRespawn(setifnotset)
if setifnotset and setifnotset~="" and DefeatRespawn then return end
Actors.Pick("Player")
local x = Actors.PA_X()
local y = Actors.PA_Y()
DefeatRespawn = {
      ['Room'] = Maps.MapName,
      ['X']    = x,
      ['Y']    = y,      
      ['CamX'] = Maps.CamX,
      ['CamY'] = Maps.CamY
     }
Console.Write("Defeat Respawn Spot is now: "..DefeatRespawn.Room.."("..DefeatRespawn.X..","..DefeatRespawn.Y..")",14,118,156)     
end     

function __consolecommand.DEFRESPAWN()
local k,v
for k,v in pairs(DefeatRespawn) do
    Console.Write(Str.Right("    "..k,4).. " = "..v,0,255,255)
    end
end

function __consolecommand.DEFDEFRESPAWN()
DefDefeatRespawn()
Console.Write("DEFEAT RESPAWN is now redefined to the next values:",255,255,0)
__consolecommand.DEFRESPAWN()
end
