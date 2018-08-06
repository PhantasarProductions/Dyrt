--[[
/* 
  PartyPop - Dyrt

  Copyright (C) 2014 Jeroen P. Broks
  
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



Version: 14.05.24

]]

-- Array containing the current party. You can either define this or set it in a variable. Either one of them must be set or.... CRASH!
PartyPopArray = nil
PartyPopped = nil

function GetParty(n)
local ret
if GameScript then
   Var.D('$REQUEST.GPARTY',sval(party[Sys.Val(n)]))
   return party[Sys.Val(n)]
   else
   LAURA.ExecuteGame('GetParty',n)
   ret = Var.C('$REQUEST.GPARTY')
   CSay('GetParty('..n..') will return '..ret)
   if ret=='nil' then ret=nil end
   return ret
   end
end

function GetFullParty()
local ret = {}
local ak
for ak=1,8 do
    ret[ak]=GetParty(ak)
    end
return ret
end    


-- This function moves the player out of sight and shows the party
function PartyPop(pprefix,pdirsuffix,parrayparty,ptemppos)
if GameScript then GSParty = Party else GSParty=GetFullParty() end
local prefix     = pprefix or ""
local dirsuffix  = pdirsuffix or ""
local arrayparty = parrayparty or PartyPopArray or GSParty or Sys.Error("Party Popping is not possible when no party data is set!")
local temppos    = ptemppos or {100,100}
local bundle     = lower(dirsuffix)=='*bundle'
if PartyPopped then Sys.Error("Cannot Party Pop, as that's already done before. Unpop first!") end
PartyPopped = {}
if Actors.Pick("Player",1)==1 then
   PartyPopped.GotPlayer = true
   PartyPopped.X = Actors.PA_X()
   PartyPopped.Y = Actors.PA_Y()
   Actors.NewSpot(temppos[1],temppos[2],Actors.PA_Wind())
   else
   PartyPopped.GotPlayer = false
   end
local h
for _,h in ipairs(arrayparty) do
    if bundle then
       local t = GrabTeleporter(prefix..h)
       local w = t.Wind
       SpawnActor(prefix..h,{ ID = 'Pop'..h, PicBundle='Player', ChosenPic = h.."."..w})       
       -- @IF DEVELOPMENT
       -- CSay("Spawn: "..prefix..h.."; chosenpic: "..h.."."..w)
       -- @FI
     else
       SpawnActor(prefix..h,{['ID']="Pop"..h,['SinglePic']='Heroes/'..h..dirsuffix..'.png'})
       end 
    end
PartyPopped.Party = arrayparty   
end

-- And undo the PartyPop function
function PartyUnPop()
if not PartyPopped then
  Console.Write("WARNING! Party unpop requested while party wasn't popped!",255,180,0)
  return
  end
local P = Actors.Permanent
local ch
Actors.Permanent = 0
for _,ch in ipairs(PartyPopped.Party) do Actors.Despawn("Pop"..ch) end
Actors.Permanent = P
if PartyPopped.GotPlayer then
   Actors.Pick("Player")
   Actors.NewSpot(PartyPopped.X,PartyPopped.Y,Actors.PA_Wind())
   end
PartyPopped = nil   
Maps.BuildBlockMap()
end
