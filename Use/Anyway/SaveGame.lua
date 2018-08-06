--[[
/* 
  SaveGame menu for Secrets of Dyrt (LAURA)

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



Version: 14.04.22

]]
sgpics = {}

function SaveGame(noscreen)
if not GameScript then Sys.Error("SaveGame(): This function may ONLY be called by the game script") end
local folder = Var.C("_SAVE.NAME")
local ak,ch
local skillname = {"Easy","Normal","Hard"}
folder = Str.Replace(folder,"/","_SLASH_")
folder = Str.Replace(folder,":","_COLON_")
local sg 
local hipos,hinum,thinum
if noscreen then
   sg=0
   SGGetList(folder)
   hinum,hipos=SGGetHI()
   else
   sg,hinum,hipos= SGScreen(folder,"SAVE GAME",1,true)
   end
if hipos ~=sq then -- Update the hipos number if it's not the same as the hinum
   thinum = hinum + 1
   Var.D("_SAVE.HICODE",thinum)
   end
if sg then
  Var.D("_SAVE.TIME",PlayTimeShow())
	Var.D("_SAVE.BR",config.btback.R)
	Var.D("_SAVE.BG",config.btback.G)
	Var.D("_SAVE.BB",config.btback.B)
	Var.D("_SAVE.FR",config.btfont.R)
	Var.D("_SAVE.FG",config.btfont.G)
	Var.D("_SAVE.FB",config.btfont.B)
	if config.bttrans then Var.D("_SAVE.ALPHA","TRUE") else Var.D("_SAVE.ALPHA","FALSE") end
	Var.D("_SAVE.GAME","The Secrets of Dyrt")
	for ak=1,8 do Var.Clear("_SAVE.CH"..ak) Var.Clear("_SAVE.LV"..ak) end
	for ak,ch in ipairs(party) do
	    Var.D("_SAVE.CH"..ak,ch)
	    Var.D("_SAVE.LV"..ak,char[ch].Level) -- Will be subsituted with the actual level later, but now it will just be 1.	  
	    end
	Var.D("_SAVE.SKILL",skillname[skill])
	Var.D("_SAVE.ROOMTITLE",Maps.Title)
	LAURA.SaveGame.Save(folder.."/TSOD_SG."..sg)
	return true
	else
	Console.Write("Savegame cancelled",255,0,0)
	return false
	end
end


function SGGetList(folder)
local ak
SGList = {}
for ak=0,999 do
	if LAURA.SaveGame.Exists(folder.."/TSOD_SG."..ak)==1 then
		SGList[ak] = {}
		SGList[ak].Head = GetSaveGameHeader(folder.."/TSOD_SG."..ak)
		SGList[ak].back = {["R"] = Sys.Val(SGList[ak].Head["BR"]),["G"] = Sys.Val(SGList[ak].Head["BG"]),["B"] = Sys.Val(SGList[ak].Head["BB"])}
		SGList[ak].font = {["R"] = Sys.Val(SGList[ak].Head["FR"]),["G"] = Sys.Val(SGList[ak].Head["FG"]),["B"] = Sys.Val(SGList[ak].Head["FB"])}
		SGList[ak].alpha = (SGList[ak].Head["ALPHA"] == "TRUE")
		end
	end
end

__consolecommand = __consolecommand or {}
function __consolecommand.SHOWSGLIST()
local i,v
local li,lv
local ci,cv
local hi,hv
if not SGList then
   Console.Write("No SGLIST loaded at present time, sir!",255,0,0)
   return
   end
for i,v in pairs(SGList) do
	Console.Write("Slot "..i,255,255,0)
	for li,lv in pairs(v) do
	    Console.Write("- idx: "..li,255,255,0)
	    if li=="back" or li=="font" then 
	    	for ci,cv in pairs(lv) do
	    		Console.Write("  = "..ci.." = "..cv,255,255,0)
	    		end -- for color
	        end -- if back or font
	    if li=="alpha" then
	       if lv then Console.Write("  = TRUE",0,255,0) else Console.Write("  = FALSE",255,0,0) end
	       end -- if alpha
	    if li=="Head" then
	    	for hi,hv in pairs(lv) do
	    		Console.Write("  = "..hi.." = "..hv,255,255,0)
	    		end -- for color
	        end -- if head
	    end -- for li,lv
	end -- for slot   
end -- function

function SGGetHI()
local r1=-1
local r2=nil
local ak
for ak=0,999 do
    if SGList[ak] then
       -- for k,v in pairs(SGList[ak].Head) do print("key = "..k.."; value = "..v) end -- debug line
       SGList[ak].Head.HICODE = SGList[ak].Head.HICODE or '0'
       if r1<Sys.Val(SGList[ak].Head.HICODE) then
          r1 = Sys.Val(SGList[ak].Head.HICODE)
          r2 = ak
          CSay('Selected slot #'..r2..' for HICODE:'..r1)
          end -- Check r1<HICODE
       end -- Did it even exist
    end -- for loop
return r1,r2    
end

function SGScreen(folder,Header,startspot,allowempty)
local chosen = false
local ak,y,col,alpha,fnt
local al
local startat = startspot or 1
local mx,my
local omx,omy = mousepos()
Key.Flush()
local PM=startat
local P=startat
SGGetList(folder)
local hinum,hipos
hinum,hipos = SGGetHI()
if hipos then
   P = hipos
   while P>PM+4 do PM = PM + 1 end
   end
repeat
Image.Cls()
ARColor(config.btback)
if config.bttrans then Image.SetAlpha(.5) end
Image.Rect(0,0,800,50)
Image.Rect(0,550,800,50)
Image.SetAlpha(1)
ARColor(config.btfont)
Image.Font("Fonts/Coolvetica.ttf",40)
Image.DText(Header,400,25,2,2)
Image.NoFont()
Image.DText("Arrows to pick the save game slot and hit enter to perform the action or escape to cancel.",400,575,2,2)
for ak=PM,PM+4 do
    y = ((ak-PM)*100)+50
	if not SGList[ak] then 
		col = config.btback; alpha = config.bttrans
		fnt = config.btfont;
		else
		col = SGList[ak].back
		fnt = SGList[ak].font
		alpha = SGList[ak].alpha
		end
	ARColor(col); if alpha then Image.SetAlpha(.5) end
	Image.Rect(0,y,800,100)
	Image.SetAlpha(1)
	ARColor(fnt)
	Image.Line(  1,y+ 1,798,y+ 1) -- Top line
	Image.Line(  1,y+99,798,y+99) -- Bottom line
	Image.Line(  1,y+ 1,  1,y+99) -- Left line
	Image.Line(798,y+ 1,798,y+99) -- Right line
	Image.Font("Fonts/Coolvetica.ttf",40)
	ARColor(fnt)	
	Image.DText(Str.Right("00"..ak,3),5,y)
	if not SGList[ak] then
		Image.Font("Fonts/Coolvetica.ttf",40)
		Image.DText("<< Empty Slot >>",400,y+50,2,2)
		else
		Image.NoFont()		
		Image.Color(255,255,255)
		for al=1,8 do if SGList[ak].Head["CH"..al] then
			if not sgpics[SGList[ak].Head["CH"..al]] then
				sgpics[SGList[ak].Head["CH"..al]] = Image.Load("GFX/SaveGame/"..SGList[ak].Head["CH"..al]..".png")
				Image.Hot(sgpics[SGList[ak].Head["CH"..al]],Image.Width(sgpics[SGList[ak].Head["CH"..al]])/2,Image.Height(sgpics[SGList[ak].Head["CH"..al]]))
				end
			if sgpics[SGList[ak].Head["CH"..al]] then
				Image.Color(255,255,255)
				Image.Draw(sgpics[SGList[ak].Head["CH"..al]],(al*64)+100,y+64)
				end	
			ARColor(fnt)
			DText("Lv"..SGList[ak].Head["LV"..al],(al*64)+100,y+70,2,2)
			end end
		DText(SGList[ak].Head.ROOMTITLE,30,y+85)
		DText(SGList[ak].Head.SKILL.." mode",770,y+85,1,0)
		DText(SGList[ak].Head.TIME,770,y+70,1,0)
		end
    mx,my = mousepos()  
    if mx~=omx and my~=omy and my>y and my<y+100 then
       P = ak 
       end
	if ak==P then
		Image.Draw("SGPoint",5,y+40)
		end 
	end
if (KeyHit(KEY_DOWN) or joydirhit('D')) and P<999     then P=P+1; if P>PM+4 then PM=P-4; end end
if (KeyHit(KEY_UP)   or joydirhit('U')) and P>startat then P=P-1; if P<PM   then PM=P;   end end
if CancelKeyHit() or Mouse.Hit(2)==1 then Key.Flush(); return nil; end -- KeyHit(KEY_ESCAPE)
if ActionKeyHit() or Mouse.Hit(1)==1 then 
   if SGList[P] or allowempty then chosen=true; end
   end -- KeyHit(KEY_ENTER) or KeyHit(KEY_SPACE) 
Image.Flip()
until chosen
return P,hinum,hipos
end







