--[[
/* 
  Slime Storm - For Optional Boss - Slime King

  Copyright (C) 2014 J.P. Broks
  
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



Version: 14.11.02

]]
function SpellAni.SlimeStorm()
local slime = {}
local num = rand(50,100)
local ak
local aslime
local img = Image.Load("GFX/Combat/Foes/WhiteSlime.png")
for ak=1,num do
    table.insert(slime,{
       X=-rand(100,800),
       Y= rand(50,600),
       S= rand(2,5),
       R= rand(25,255),
       G= rand(25,255),
       B= rand(25,255)
    })
    end
repeat
Image.Color(255,255,255)
Combat_DrawScreen()
for ak,aslime in ipairs(slime) do 
    Image.Color(aslime.R,aslime.G,aslime.B)
    Image.Draw(img,aslime.X,aslime.Y)
    aslime.X = aslime.X + aslime.S
    if aslime.X>810 then table.remove(slime,ak) end
    end 
Flip()    
until #slime==0    
Image.Free(img)
end
