--[[
/*


   The file you are currently accessing is a file released in the public
   domain, meaning you can freely alter it distribute it without any means of
   restriction whatsoever, and the only thing you cannot do is claim ownsership
   on it.
   
   Please note, Public Domain means no restriction at all, you may mention me
   (Jeroen Broks) as the original programmer, but you don't have to (if you
   find anything on the internet claiming to be public domain forcing you to
   name the source you obtained it from, then it simply ain't public domain,
   meaning the one who told you so is lying about its license type).
   
   Please note, that should any file in the public domain be a clear referrence
   to a real person (either dead or alive) the restrictionless status of the
   public domain gets a restriction as you may not give out references to 
   real people out without that person's permission (which is not a copyright
   issue), and that is one of the many examples that could void the freedom
   of public domain. The file must fulfill the rules of other laws. I guess
   that was pretty obvious.
   
   This file is released "AS IS", meaning that the creator of this file 
   dislaims any form of warranty, without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
   
   In other words, you're using this file at your own risk.
   
*/
   


Version: 13.12.26

]]
-- This is nothing more than a test file, it serves no purpose whatsoever in the project


function TestShowBox()
local tb = {
   ["linecount"] = 5,
   ["lines"]     = {"Hello World","I'm currently testing this routine","To see if it all works","When this message appears clearly","I suppose it does...."},
   ["Head"]      = "TESTING 1-2-3"
   }
ShowBox(tb)
Image.Flip()
Key.Wait()
end

function TestFromLanguage()
-- LBoxText("Prologue/Start","A1")
SerialBoxText("Prologue/Start","A")
end
