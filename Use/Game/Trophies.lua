--[[
/* 
  Trophies

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



Version: 14.04.20

]]



function TrophyImage(t,x,y)
local T = Str.Upper(t)
local F = T
TrophyImg = TrophyImg or {}
if not TrophyImg[T] then
   CSay("- Looking for a picture for a trophy.")
   CSay("  = Looking for: "..F)
   CSay("  = Searching for PNG: "..JCR5.Exist("GFX/TROPHIES/"..F..".PNG"))
   CSay("  = Searching for REF: "..JCR5.Exist("GFX/TROPHIES/"..F..".REF"))
   if JCR5.Exist("GFX/TROPHIES/"..F..".PNG")==1 then
      F = T
   elseif JCR5.Exist("GFX/TROPHIES/"..F..".REF")==1 then
      local BT = JCR5.Open("GFX/TROPHIES/"..F..".REF")
      F = Str.Upper(JCR5.ReadLn(BT))
      JCR5.Close(BT)
   else
      F = "__ACHIEVEMENT"
      end
   if TrophyImg[F] then
      TrophyImg[T] = TrophyImg[F]
   else
      TrophyImg[F] = Image.Load("GFX/TROPHIES/"..F..".PNG")
      if T~=F then TrophyImg[T]=TrophyImg[F] end
      end
   end
Image.Draw(TrophyImg[T],x,y)      
end

function ScrollTrophies()
local t,y
for t,y in pairs(justachieved) do
    ARColor(config.btback)
    if config.bttrans then Image.SetAlpha(.5) end
    Image.Rect(25,y,750,100)
    Image.SetAlpha(1)
    Image.Color(255,255,255)
    TrophyImage(t,25,y)
    Image.Font("Fonts/Coolvetica.ttf",30)
    ARColor(config.bthead)
    DText(Var.S(achievements[t].Title),125,y+5)
    Image.Font("Fonts/Coolvetica.ttf",12)
    ARColor(config.btfont)
    DText(Var.S(achievements[t].Description),125,y+50)
    justachieved[t] = justachieved[t] - 1.75
    if justachieved[t] < -200 then justachieved[t] = nil end
    end
end

function TrophyInit()
-- Console.Write("Initizing Achievements",4,(96*2), (27*2))
achievements = FetchDataBase("Data/Achievements")
achievements["GEN"] = nil -- This is just an empty record that is always there as the QuickData routine requires at least ONE record.
achieved = achieved or {} -- Has to be defined this way, or it will overwrite saved data if it exists.
justachieved = {}         -- This is not saved, so we can do it the way we like here :)
category = {}
local k,v,c,i
c=0
for k,v in pairs(achievements) do
    -- categorize
    if not tablecontains(category,v.Category) then
       c=c+1
       category[c]=v.Category
       end   
    -- remove achievements marked as invalid
    if v.Invalid then achievements[k] = nil end
    -- remove achievements which are not attainable in the chosen difficulty setting
    if v['Skill Specific'] then
       if skill==1 and (not v.Easy)   then achievements[k] = nil end
       if skill==2 and (not v.Medium) then achievements[k] = nil end
       if skill==3 and (not v.Hard)   then achievements[k] = nil end
       end
    end
table.sort(category)
for k,v in ipairs(category) do
    Console.Write(Str.Right("  "..k,2)..":>Added achievement category: "..v,2,112,14)
    end
-- init kill achievements
trophykills = {}
trophyoverkills = {}
c = 0
for k,v in pairs(achievements) do
    if Str.Left(k,4)=="KILL" then
       c = c + 1
       i = Sys.Val(Str.Right(k,Str.Length(k)-4))
       trophykills[c] = i
       Console.Write("Trophy for "..i.." kills found",72,136,76)
       end
    if Str.Left(k,5)=="OVERS" then
       c = c + 1
       i = Sys.Val(Str.Right(k,Str.Length(k)-5))
       trophyoverkills[c] = i
       Console.Write("Trophy for "..i.." oversoul kills found",72,136,76)
       end
    end
end

function AwardTrophy(tag,force)
local today = Time.Date()
local TAG = Str.Upper(tag)
if not achievements[TAG] then
   if force then 
      Console.Write("! WARNING: Achievement '"..TAG.."' does not exist. Trophy awarded anyway",255,0,0)
      achieved[TAG] = today
      return
   else
      Console.Write("? ERROR: Achievement '"..TAG.."' does not exist.",255,0,0)
      return
      end
   end
if achieved[TAG] then
   Console.Write("Trophy "..TAG.." has already been awarded before",255,0,0)
   return
   end
achieved[TAG] = today
local y = 620
local k,v
for k,v in pairs(justachieved) do
    while v+119>=y do y = v + 120 end
    end
justachieved[TAG] = y    
Console.Write("Awarded the achievement: "..TAG,255,180,0)
-- @IF *DYRTGAMEJOLT
DYRTGJ.Award(tag)
-- @FI
end

function TrophyOverview()
local catcount=0
local k,v,x,y,s,p,e
local sy = 0
local mclk
local cy
Key.Flush()
for k,v in ipairs(category) do catcount=catcount+1 end -- Count categories :)
local curcat = 1
DefaultNames() -- All character names not defined yet are set to their default values.
repeat
Image.Cls()
-- Categories
for k,v in ipairs(category) do
    if config.btalpha then Image.SetAlpha(.5) end
    if curcat == k then ARColor(config.btback) else HARColor(config.btback) end
    s = (800/catcount)
    x = s*(k-1)
    p = x + (s/2)
    e = x + s
    Image.Rect(x,0,s,18)
    Image.SetAlpha(1)
    if curcat == k then ARColor(config.btfont) else HARColor(config.btfont) end
    Image.Font("Fonts/Coolvetica.ttf",12)
    DText(v,p,8,2,2)
    if mclk and Mouse.X()>x and Mouse.X()<e and Mouse.Y()<18 then
       curcat = k
       end
    end
-- Achievements
y  = -sy
cy = 0
Image.Viewport(0,18,800,600)
Image.Origin(0,18)
for k,v in spairs(achievements) do 
    if v.Category==category[curcat] then
       if y>-100 and y<600 then
          if config.btalpha then Image.SetAlpha(.5) end
          if achieved[k] then ARColor(config.btback) else HARColor(config.btback) end
          Image.Rect(0,y,800,100)
          if achieved[k] then ARColor(config.btfont) else HARColor(config.btfont) end
          Image.Line(  0,    y,799,    y) -- U
          Image.Line(  0,100+y,799,100+y) -- D
          Image.Line(  0,    y,  0,100+y) -- L
          Image.Line(799,    y,799,100+y) -- R
          if achieved[k] then Image.Color(255,255,255) else Image.Color(100,100,100) end
          if not((not achieved[k]) and v.Hidden) then TrophyImage(k,0,y) end
          if achieved[k] then ARColor(config.bthead) else HARColor(config.bthead) end
          Image.Font("Fonts/Coolvetica.ttf",30)
          if not((not achieved[k]) and v.Hidden) then 
             DText(Var.S(v.Title),120,y)
             else
             DText("???",120,y)
             end
          if achieved[k] then 
             ARColor(config.btfont) 
             Image.Draw("T_CHECK",800-Image.Width("T_CHECK"),y)
          else 
             HARColor(config.btfont)              
             end
          Image.Font("Fonts/Coolvetica.ttf",12)
          if not((not achieved[k]) and v.Hidden) then 
             DText(Var.S(v.Description),120,y+50)
             else
             DText("???",120,y+50)
             end
          end
       y = y+100
       cy = cy + 100
       end -- Category
    end -- Achievement list
Image.Viewport(0,0,800,600) 
Image.Origin(0,0)
-- @IF DEVELOPMENT
Image.NoFont()
ARColor(config.btfont)
DText(sy.."/"..cy,0,575)
-- @FI
-- Show it to us
Flip()
-- Move
if (KeyDown(KEY_DOWN) or joyy()==1 )     and sy<cy-(599-18)  then sy=sy+2 end
if (KeyDown(KEY_UP)   or joyy()==-1)     and sy>0            then sy=sy-2 end
if (KeyHit(KEY_LEFT)  or joydirhit('L')) and curcat>1        then SFX('SFX/General/GameMenu/ChangeSelection.ogg'); curcat = curcat - 1; sy=0 end
if (KeyHit(KEY_RIGHT) or joydirhit('R')) and curcat<catcount then SFX('SFX/General/GameMenu/ChangeSelection.ogg'); curcat = curcat + 1; sy=0 end
mclk = MouseHit(1)
-- Close
until CancelKeyHit() or MouseHit(2)
SFX('SFX/General/GameMenu/Cancel.ogg')
Key.Flush()
end

function __consolecommand.AWARDTROPHY(p)
AwardTrophy(p[1],p[2])
end

function __consolecommand.ACHIEVEMENTS()
local k,v
DefaultNames()
Console.Write("==========",0,0,255)
for k,v in spairs(achievements) do
    if achieved[k] then r=0; g=255; b=0 else r=255; g=0; b=0 end
    Console.Write(   "Trophy ID:   "..k,r,g,b)
    Console.Write(   "Title:       "..Var.S(v.Title),r,g,b)
    Console.Write(   "Description: "..Var.S(v.Description),r,g,b)
    Console.Write(   "Category:    "..v.Category,r,g,b)
    if achieved[k] then
       Console.Write("Achieved:    "..achieved[k],r,g,b)
       end
    Console.Write("==========",0,0,255)
    end
end   

function __consolecommand.TROPHYCATLIST()
local k,v
for k,v in ipairs(categories) do
    Console.Write(Str.Right("  "..k, 4)..":> "..v, 120, 48, 26)
    end
end    

 __consolecommand.TROPHYOVERVIEW = TrophyOverview
