--[[
/* 
  Bank - Dyt

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



Version: 14.04.20

]]
-- Let's determine what to do based on the user's choices.
BankFunctions = {
   
   function() -- Deposit 
   local dep1 = GphInput("You have "..cash.." in cash. How much do you deposit? (A = All money)")
   local dep2 = Sys.Val(dep1)
   if upper(left(dep1,1))=="A" then dep2 = cash end
   if dep2>cash then
      SerialBoxText(banktext,"BANKTOOMUCH")
   elseif dep2<0 then
      SerialBoxText(banktext,"BANKNONEGATIVE")
   else         
      cash = cash - dep2
      banksaldo = banksaldo + dep2
      end
   end,  -- The , MUST be present!
   
   function() -- Withdraw
   local dep1 = GphInput("You have "..banksaldo.." on the bank. How much do you withdraw? (A = All money)")
   local dep2 = Sys.Val(dep1)
   if upper(left(dep1,1))=="A" then dep2 = banksaldo end
   if dep2>banksaldo then
      SerialBoxText(banktext,"BANKTOOMUCH")
   elseif dep2<0 then
      SerialBoxText(banktext,"BANKNONEGATIVE")
   else         
      cash = cash + dep2
      banksaldo = banksaldo - dep2
      end
   end, -- The , MUST be present!
   
   function() -- Leave. Nothing goes here, but the game will crash if not present.
   end

   }




-- The Bank. No robberies please :P
function Bank()
-- What babbling must we have for the bank?
banktext = ReadLanguageFile("General/Bank")
if (not CVV("&TUTORIAL.BANK")) then
   Var.D("&TUTORIAL.BANK","TRUE")
   SerialBoxText(banktext,"TUTORIAL")
   end
-- How much money do we have on our bank account?   
banksaldo = banksaldo or 0
local ch
repeat   
Var.D("%BANK",banksaldo)
ch = BoxQuestion("General/Bank","BANKMAINQ")
BankFunctions[ch]()
until ch==3   
end
