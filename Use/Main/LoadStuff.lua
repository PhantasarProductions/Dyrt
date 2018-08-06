--[[
/* 
  Load the stuff into the memory

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



Version: 14.06.26

]]

function LoadGraphics()
local ak
-- Abyss BlopPlasma
CWrite('Init Blop Plasma')
BlopPlasma.InitBlopPlasma(30,800,600,520)
-- General
LoadImage("MenuBack"  ,"Menu/Back.jpg")
LoadImage("Logo"      ,"Menu/Logo.png")
LoadImage("SGPoint"   ,"SG/Pointer.png")
LoadImage("SaveSpot"  ,"Objects/SaveSpot.png") Image.Hot("SaveSpot",Image.Width("SaveSpot")/2,Image.Height("SaveSpot"))
LoadImage("Save_Red"  ,"Objects/SaveSpotRed.png") Image.Hot("Save_Red",Image.Width("Save_Red")/2,Image.Height("Save_Red"))
LoadImage("Save_Grn"  ,"Objects/SaveSpotGreen.png") Image.Hot("Save_Grn",Image.Width("Save_Grn")/2,Image.Height("Save_Grn"))
LoadImage("Save_Blue" ,"Objects/SaveSpotBlue.png") Image.Hot("Save_Blue",Image.Width("Save_Blue")/2,Image.Height("Save_Blue"))
-- ECN Bar
for ak=0,9 do
    LoadImage("ECN"..ak,"GameUI/ECN/"..ak..".png")
    end
-- Combat
LoadImage("C_ChStat"   ,"Combat/CharStat.png")
LoadImage("C_Time"     ,"Combat/TimeGauge.png")    
LoadImage("C_HTPoint"  ,"Combat/HeroTimePointer.png")
LoadImage("C_FTPoint"  ,"Combat/FoeTimePointer.png")
LoadAnim ("C_Numbers"  ,"Combat/Numbers.png",8,16,0,12)
LoadImage("C_Menu"     ,"Combat/GoldMenu.png")
LoadAnim ("C_MCursor"  ,"Combat/Cursor.png",56,56,0,2)
LoadImage("C_PPoint"   ,"Combat/PlayPointer.png")
LoadImage("C_FPoint"   ,"Combat/FoePointer.png")
-- Trophies / Achievements
LoadImage("T_CHECK"    ,"Trophies/XTRA/Check.png")
-- Random Encounters exclamation marks
LoadImage("E_GREEN"    ,"Exclamation Mark/Green.png")     Image.HotCenter("E_GREEN")
LoadImage("E_YELLOW"   ,"Exclamation Mark/Yellow.png")    Image.HotCenter("E_YELLOW")
LoadImage("E_RED"      ,"Exclamation Mark/Red.png")       Image.HotCenter("E_RED")
-- SpellAni (only pics regularly used, such as in healin g spells, are loaded here)
LoadImage("SA_GLITTER" ,"Combat/SpellAni/Glitter.png")    Image.HotCenter("SA_GLITTER")
LoadImage("SA_BANG"    ,"Combat/SpellAni/Bang.png")       Image.HotCenter("SA_BANG")
LoadImage('SA_ROCK'    ,"Combat/SpellAni/Rock.png")       Image.Hot("SA_ROCK",Image.Width('SA_ROCK')/2,Image.Height('SA_ROCK'))
LoadImage('SA_ICE'     ,'Combat/SpellAni/IceCrystal.png') Image.HotCenter('SA_ICE')
-- Movable Blocks
LoadImage("MB_PUSH"    ,"MoveBlocks/PUSH.png")            Image.Hot("MB_PUSH",Image.Width("MB_PUSH")/2,Image.Height('MB_PUSH'))
LoadImage("MB_PUSHPULL","MoveBlocks/PUSHPULL.png")        Image.Hot("MB_PUSHPULL",Image.Width("MB_PUSHPULL")/2,Image.Height('MB_PUSHPULL'))
end

function LoadAudioFiles()
-- Combat
LoadAudio("C_Signal" ,"Combat/Signal.ogg")
end


function LoadImage(tag,file)
local img = Image.Load("GFX/"..file)
if img == "ERROR" then Sys.Error("Image could not be loaded","Function,LoadImage;Tag,"..tag..";File,"..file) end
Image.Assign(img,tag)
Console.Write("Loaded image "..file.." at slot "..tag,255,200,180)
end

function LoadAnim(tag,file,w,h,s,fr)
local img = Image.LoadAnim("GFX/"..file,w,h,s,fr)
if img == "ERROR" then Sys.Error("Animated Image could not be loaded","Function,LoadAnim;Tag,"..tag..";File,"..file) end
Image.Assign(img,tag)
Console.Write("Loaded AnImg "..file.." at slot "..tag,200,255,180)
end

function LoadAudio(tag,file)
local au = Audio.Load("SFX/"..file,tag)
if au=='ERROR' then Sys.Error("Audio file could not be loaded","Function,LoadAudio;Tag,"..tag..";File,"..file) end
Console.Write("Loaded Audio "..file.." at slot "..tag,180,200,255)
end

