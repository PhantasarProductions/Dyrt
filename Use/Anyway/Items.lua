--[[
/* 
  Items.lua

  Copyright (C) 2014 JPB
  
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



Version: 14.09.13

]]
function RemoveItem(Item,Amount)
if not inventory then
   Var.D("$ITEM.REQITEM",Item)
   Var.D("&ITEM.AMOUNT",Amount)
   LAURA.ExecuteGame("RemoveItem","*SYSVAR*")
   return
   end
local it,am = Item,(Amount or 1)    
if Item == "*SYSVAR*" then
   it = Var.C("$ITEM.REQITEM",Item)
   am = Sys.Val(Var.C("&ITEM.AMOUNT"))
   end
if not inventory[it] then
   Console.Write("! WARNING: Request to remove "..am.." from item "..sval(it).." is not possible. The item doesn't exist!",255,180,0) 
   return
   end   
CSay("Removing "..am.." copies of item "..it)   
inventory[it] = inventory[it] - am
if inventory[it]<0  then Console.Write("! WARNING: More items removed from record "..it.." then the player had at that moment") end
if inventory[it]<=0 then CSay("All items gone, so let's remove it!"); inventory[it]=nil end 
end

function AddItem(Item,Amount)
if not inventory then
   Var.D("$ITEM.REQITEM",Item)
   Var.D("&ITEM.AMOUNT",Amount)
   LAURA.ExecuteGame("AddItem","*SYSVAR*")
   return
   end
local it,am = Item,(Amount or 1)    
if Item == "*SYSVAR*" then
   it = Var.C("$ITEM.REQITEM",Item)
   am = Sys.Val(Var.C("&ITEM.AMOUNT"))
   end
CSay("Adding "..am.." copies of the item "..sval(it))
inventory[it] = (inventory[it] or 0) + am
end

function HaveItem(item)
if not inventory then
    LAURA.ExecuteGame("HaveItem",item)
    return Sys.Val(Var.C("%HAVEITEMRETURN"))
    end
local ret = inventory[upper(item)] or 0
Var.D("%HAVEITEMRETURN",ret)
__consolecommand.HAVEITEM = function(it) CWrite("You have "..HaveItem(it[1]).."x "..it[1]) end
return ret
end    

