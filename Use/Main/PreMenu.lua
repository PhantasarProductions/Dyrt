--[[
/* 
  Pre Game Credits - Dyrt

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



Version: 14.03.27

]]
function PreGame()
local t = {0,0,{"A game by:","Jeroen Broks"},{"With additional help by:","Man of Steel"},{"And:","Widzy"},0}
local pb = {[6]=true}
local pics = {}
local ak
local p 
local hit
local flash
for ak,_ in ipairs(t) do
    pics[ak] = Image.Load("GFX/PreGame/"..right("00"..ak,3)..".png")
    if pics[ak]=="ERROR" then Console.Write("ERROR! Could not load: ".."GFX/PreGame/"..right("00"..ak,3)..".png",255,0,0) end
    Image.HotCenter(pics[ak])
    end
local c=function() return Key.Hit(KEY_ENTER)==1 or Key.Hit(KEY_SPACE)==1 or Mouse.Hit(1)==1 or Joy.Hit(1)==1 end    
local a=function(t,pics)
        local ak
        local al
        local tx  , txx      
        for ak,txx in ipairs(t) do
            if txx==0 then tx=nil else tx=txx end
            CSay(type(tx))
            for al=0,126,1 do
                if not tx then Image.Color(al*2,al*2,al*2) else Image.Color(al,al,al) end
                Image.Cls()
                Image.Draw(pics[ak],400,300)
                Image.Flip()
                if c() then return end
                end
            for al=0,500 do
                Image.Cls()
                if tx then Image.Color(126,126,126) else Image.Color(255,255,255) end
                Image.Draw(pics[ak],400,300)
                if c() then return end
                if tx then
                   Image.Color(255,255,255) 
                   Image.Font('Fonts/Scribish.ttf',15)
                   Image.DText(tx[1],400,280,2,1)
                   Image.Font('Fonts/Scribish.ttf',30)
                   Image.DText(tx[2],400,300,2,0)
                   end
                Image.Flip()
                end   
            if pb[ak] then
                Key.Flush()
                repeat
                Image.Cls()
                if tx then Image.Color(126,126,126) else Image.Color(255,255,255) end
                Image.Draw(pics[ak],400,300)
                if c() then return end
                if tx then
                   Image.Color(255,255,255) 
                   Image.Font('Fonts/Scribish.ttf',15)
                   Image.DText(tx[1],400,280,2,1)
                   Image.Font('Fonts/Scribish.ttf',30)
                   Image.DText(tx[2],400,300,2,0)
                   end
                flash = math.floor(Time.MSecs()/75)
                if right(flash,1)=='1' or right(flash,1)=='2' or right(flash,1)=='3' or right(flash,1)=='4' or right(flash,1)=='5' then
                   Image.Font("Fonts/Abigail.ttf",35)
                   Image.Color(math.abs(255*flash),0,255)
                   Image.DText("Hit any key/button",400,550,2,2)
                   end
                hit = false
                for al=0,255 do
                    hit = hit or Key.Hit(al)~=0
                    if al<16 then hit = hit or Joy.Hit(al)~=0 end
                    if al<4  then hit = hit or Mouse.Hit(al)~=0 end 
                    end   
                Image.Flip()
                until hit
               end    
            for al=126,0,-1 do
                Image.Cls()
                if not tx then Image.Color(al*2,al*2,al*2) else Image.Color(al,al,al) end
                Image.Draw(pics[ak],400,300)
                Image.Flip()
                if c() then return end
                end
            end
        end
TrueMusic("Epicity",true)        
a(t,pics)
for ak,p in ipairs(pics) do Image.Free(p) end
StopMusic()
end
