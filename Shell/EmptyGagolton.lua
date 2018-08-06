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
 



Version: 14.08.05

]]



--[[

  This shell script is called by the swap file which is created by the Kirana-Boss event.
  It will remove all actors from Gagolton. There is a plan to make it pop in a guy who opens
  a sidequest during the New Game +, however this plan is not yet certain.

]]



-- List of townspeople
peeps = {
  "Kirana",
  "Rosetta",
  "JUGGUARD1","JUGGUARD2",
  "ARYA","Arya",
  "ELENA","Elena",
  "SAMANTHA","Samantha",
  "HANS","Hans",
  "JOHN","John",
  "XENETHOR","Xenethor",
  "GRELDIR","Greldir",
  "FRYDA","Fryda",
  "DOG","Dog",
  "CYNTHIA","Cynthia",
  "WESLEY","Wesley",
  "ARJEN","Arjen"
  
}


-- Remove them all
function Start()
Console.Write("SHELL: Iedereen opzouten!!!!",255,180,0)    
for _,guy in ipairs(peeps) do
    Actors.Remove(guy,0)
    end
end
    
-- Checking this file because you want to know the people's fate?
-- Naughty, naughty. Just play chapter 4 and you'll find out eventually :P

