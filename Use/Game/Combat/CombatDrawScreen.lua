--[[
/* 
  Combat Draw Screen. If you want your own combat layout, but you don't want to change the battle engine.... Well, then this is the file to hack or even replace ;)

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



Version: 14.11.02

]]

-- @IF IGNOREME
__consolecommand = {}
-- @FI



function Combat_SayNumbers(T,x,y)
local a = {}
local ak
local cnt = 0
local C
local F = -1
-- Get all frames
for ak=1,Str.Length(T) do
    F = -1
    C = Str.Mid(T,ak,1)
    if Str.ASCII(C)>=48 and Str.ASCII(C)<58 then F = Str.ASCII(C) - 48
    -- elseif C=='0' then F = 9
    elseif C==' ' then F = 10
    elseif C=='/' then F = 11 end
    if F>=0 then
       cnt = cnt + 1
       a[cnt] = F
       end
    end 
-- Let's now display it all. It will be aligned from the right
for ak=1,cnt do
    Image.Draw("C_Numbers",x-(ak*8),y,a[(cnt+1)-ak])
    end    
end

function Combat_DrawInterface()
local ak
local ch
local gx
CombatStatPic = CombatStatPic or {}
CombatTimePic = CombatTimePic or {}
if StuffY>0 then StuffY = StuffY - 1 end
-- Draw Combat
-- HP Bars
for ak=1, 4 do
  Image.Origin((ak-1)*200,0-StuffY)
  if party[ak] then
     Image.Color(255,255,255)
     Image.Draw("C_ChStat",0,0)
     ch = party[ak]
     if not CombatStatPic[ch] then 
        CombatStatPic[ch] = Image.Load("GFX/Combat/StatBarIcons/"..ch..".png") 
        if CombatStatPic[ch]=="ERROR" then Console.Write("!!WARNING!! 'GFX/Combat/StatBarIcons/"..ch..".png' wasn't loaded!",255,255,0) end
        end
     -- Color HP bar based on % of HP left	
     col = (char[ch].HP[1]/char[ch].HP[2])*255
     Image.Color(255-col,col,0)
     -- Draw HP bar
     Image.Rect(38,1,(char[ch].HP[1]/char[ch].HP[2])*161,13)	
     Image.Color(255,255,255)
     -- Draw MP bar
     char[ch].AP = char[ch].AP or {1,100} -- Make sure AP is set!
     if char[ch].AP[1]>char[ch].AP[2] then char[ch].AP[1] = char[ch].AP[2] end
     Image.Color(0,0,255)
     Image.Rect(38,16,(char[ch].AP[1]/char[ch].AP[2])*161,13)
     -- Char Picture
     Image.Color(255,255,255)
     Image.Draw(CombatStatPic[ch],36,0) -- Character's pic, should be after blittling the layout and bars, but BEFORE the points
     -- HP Numbers
     Image.Color(255,255,0)
     Combat_SayNumbers(char[ch].HP[1].." / "..char[ch].HP[2],195,2)
     -- AP Numbers
     Image.Color(0,255,255)
     Combat_SayNumbers(char[ch].AP[1].." / "..char[ch].AP[2],195,17)
     -- Status changes
     local sti,sts,std
     local stx = 0
     local sty = 35
     StatusSet[StN["Player"]][ch] = StatusSet[StN["Player"]][ch] or {}
     Image.Color(255,255,255)
     for sti, sts in pairs(StatusSet[StN["Player"]][ch]) do 
         std = StatusData[sti]
         if std.ImgBar then 
            Image.Draw(std.Img,stx,sty)
            stx = stx + 20
            if stx>=200 then stx=0; sty = sty+20 end
            end
         end
     end
  end
-- Time Gauge
Image.Color(255,255,255)
Image.Origin(0,540+StuffY)
Image.Draw("C_Time",0,0)
for ak=1,4 do -- Heroes on the time bar
  if party[ak] then
     ch = party[ak]
     if not CombatTimePic[ch] then 
        CombatTimePic[ch] = Image.Load("GFX/Combat/GaugeIcons/"..ch..".png") 
        if CombatTimePic[ch]=="ERROR" then Console.Write("!!WARNING!! 'GFX/Combat/GaugeIcons/"..ch..".png' wasn't loaded!",255,255,0) end
        end     
     if CombatTime.Heroes[ak]<=10000 then gx = (CombatTime.Heroes[ak]/10000)*327 Image.Color(0,0,255) else gx = (((CombatTime.Heroes[ak]-10000)/10000)*72)+328; Image.Color(255,0,0) end
     Image.Draw("C_HTPoint",gx,0)
     Image.Color(255,255,255)   
     Image.Draw(CombatTimePic[ch],gx,-25)
     end    
    end
for ak=1,9 do -- Foes on the time bar
    if Foe[ak] then
       if CombatTime.Foes[ak]<=10000 then gx = (CombatTime.Foes[ak]/10000)*327 Image.Color(0,0,255) else gx = (((CombatTime.Foes[ak]-10000)/10000)*72)+328; Image.Color(255,0,0) end
       Image.Draw("C_FTPoint",gx,11)
       Image.Color(255,255,255)   
       Image.NoFont()
       Image.DText(Str.Char(ak+64),gx,55,1,1)
       end
    end         
-- Reset Origin  
Image.Origin(0,0)  
-- Enemy Names
local vkf_y = 50
local akfoe,vlfoe
for akfoe,vlfoe in spairs(FoeShowList) do
    if vlfoe.Count>=1 then
       if vlfoe.X>10    then vlfoe.X=vlfoe.X - 10 end
       if vlfoe.Y>vkf_y then vlfoe.Y=vlfoe.Y -  1 end; vkf_y=vkf_y+25
       Image.Font("Fonts/Coolvetica.ttf",20)
       vlfoe.Count = Combat_CountFoe(akfoe)
       Image.Color(0,0,0)
       DText(vlfoe.Name.."  x"..vlfoe.Count,vlfoe.X-1,vlfoe.Y-1)
       DText(vlfoe.Name.."  x"..vlfoe.Count,vlfoe.X+1,vlfoe.Y+1)
       Image.Color(255,255,255)
       DText(vlfoe.Name.."  x"..vlfoe.Count,vlfoe.X,vlfoe.Y)
       end
    -- if vlfoe.Count<1 then FoeShowList[akfoe]=nil end
    end
end

function Combat_ShowName(TGROUP,TARGET,x,y,color)
local ch
if TGROUP=='Player' or TGROUP=='Hero' or TGROUP=='Players' or TGROUP=='Heroes' then
   ch = party[TARGET]
   Image.Color(255,255,255)
   if (not CombatTimePic[ch]) or (CombatTimePic[ch]=="") then
      color = color or {255,255,255}
      Sys.Error("WOAH!!!!! Combat Time Pic is missing!!!!","Function,Combat_ShowName;Group,"..TGROUP..";TARGET,"..TARGET..";X,"..x..";Y,"..y..";Color.R,"..color.R..";Color.G,"..color.G..";Color.B,"..color.B)
      end
   Image.Draw(CombatTimePic[ch],x+20,y+15)
   ARColor(color)
   Image.DText(Var.S(char[ch]["Name"]),x+25,y)
elseif TGROUP=='Enemy' or TGROUP=='Foe' or TGROUP=='Enemies' or TGROUP=='Foes' then
   ARColor(color)
   ch=TARGET
   Image.DText(Str.Char(ch+64)..". "..FoeData[TARGET]['Name'],x,y)
else
   Sys.Error('Unknown target group',"Function,Combat_ShowName;Target Group,"..TGROUP..";TARGET,"..TARGET)
   end
end

function Combat_ShowTargetName(TGROUP,TARGET,x,y)
local ret = 'Nobody'
local act
local ch
PlayAct = PlayAct or {}
FoeAct = FoeAct or {}
if TGROUP=='Player' or TGROUP=='Hero' or TGROUP=='Players' or TGROUP=='Heroes' then player=true; act = PlayAct[TARGET]
elseif TGROUP=='Enemy' or TGROUP=='Foe' or TGROUP=='Enemies' or TGROUP=='Foes' then enemy=true;  act = FoeAct[TARGET]
else Sys.Error("Combat_ShowTarget('"..TGROUP.."',"..TARGET.."): Unknown player group!")  end
if not act then
  DText('Nobody',x,y)
  return
  end
if act.TargetGroup=='Player' or act.TargetGroup=='Hero' or act.TargetGroup=='Players' or act.TargetGroup=='Heroes' then
   ch = party[act.Target]
   if (not ch) or act.Target>4 then
      DText('?????',x,y)
      return 
      end       
elseif act.TargetGroup=='Enemy' or act.TargetGroup=='Foe' or act.TargetGroup=='Enemies' or act.TargetGroup=='Foes' then
   if (not FoeData[act.Target]) then
      DText('?????',x,y)
      return
      end
else
   DText('Unknown',x,y)
   return
   end
Combat_ShowName(act.TargetGroup,act.Target,x,y,config.btfont)
end


function Combat_ShowInfo(TGROUP,TARGET)
Image.NoFont()
local th  = 15 --Image.TextHeight("ABC")
local lc  = 5
local tth = th * lc
local tbh = tth + (th*1)
local tby = 600-tbh
local ak,txt
local ch
local p
Bestiary = Bestiary or {}
ARColor(config.btback)
if config.bttrans then Image.SetAlpha(.5) end
Image.Rect(500,600-tbh,300,tbh)
Image.SetAlpha(1)
Combat_ShowName(TGROUP,TARGET,505,tby+5,config.btfont)
local player = TGROUP=='Player' or TGROUP=='Hero' or TGROUP=='Players' or TGROUP=='Heroes'
local enemy  = TGROUP=='Enemy'  or TGROUP=='Foe'  or TGROUP=='Enemies' or TGROUP=='Foes'
-- Health
if player then
   ch = party[TARGET]
   if not ch then Sys.Error("Combat_ShowInfo('"..TGROUP..','..TARGET..'): Call to empty target spot') end
   DText("HP:     "..char[ch].HP[1].." / "..char[ch].HP[2],505,tby+20)
   else
   if FoeData[TARGET].Boss then
      if skill==1 then
         p = (FoeData[TARGET].HP/FoeData[TARGET].HPMax)*100
	 DText("Health: "..round(p).."%",505,tby+20)
	 end
    else
      if skill==1 or (skill~=3 and Bestiary[Str.Upper(Foe[TARGET])]) then 
         DText("HP:     "..FoeData[TARGET].HP.." / "..FoeData[TARGET].HPMax,505,tby+20) 
	 end
      end
  end
-- Move
DText("Action: "..Combat_ShowAct(TGROUP,TARGET),505,tby+35)
-- Target
DText("Target: ",505,tby+50)
Combat_ShowTargetName(TGROUP,TARGET,505+Image.TextWidth("Target: "),tby+50)
-- Status 	 
DText("Status: ",505,tby+65)
local stx = 505+Image.TextWidth("Status: ")
local sts,sti,chi
if player then chi = party[TARGET] end
if enemy  then chi = TARGET end
StatusSet[StN[TGROUP]][chi] = StatusSet[StN[TGROUP]][chi] or {}
for sti,sts in pairs(StatusSet[StN[TGROUP]][chi]) do
    Image.Color(255,255,255)
    if StatusData[sti].Img=="ERROR" then DText("?"..sti,stx,tby+65) else Image.Draw(StatusData[sti].Img,stx,tby+65) end
    stx = stx + 20 
    end
Image.Color(255,255,255)
end

Combat_TargetInfo = Combat_ShowInfo -- Just a silly alias :P

function __consolecommand.TBD_HGP(p)
if not CombatRunning then
   Console.Write("? This command only works in combat!",255,0,0)
   return
   end
CombatTime.Heroes[Sys.Val(p[1])]=Sys.Val(p[2])
CSay("Combat Hero "..p[1].." gauge point is now " ..p[2])
end

function __consolecommand.TBD_FGP(p)
if not CombatRunning then
   Console.Write("? This command only works in combat!",255,0,0)
   return
   end
CombatTime.Foes[Sys.Val(p[1])]=Sys.Val(p[2])
CSay("Combat Foe "..p[1].." gauge point is now " ..p[2])
end

function Combat_DrawMessageBox()
if not Combat_Message_Stuff.Timer then return end
if Combat_Message_Stuff.Timer<=0 then return end
Combat_Message_Stuff.Timer = Combat_Message_Stuff.Timer - 1
ARColor(config.btback)
if config.bttrans then Image.SetAlpha(.5) end
Image.Rect(0,50,800,50)
Image.SetAlpha(1)
ARColor(config.btfont)
Image.Line(  3,53,796,53)   -- U
Image.Line(  3,97,796,97)   -- D
Image.Line(  3,53,  3,97)   -- L
Image.Line(796,53,796,97)   -- R
if upper(Combat_Message_Stuff.Message) == "@@IMG@@" then
   if not Combat_Message_Stuff.Loaded then
      Image.AssignLoad("COMBATMESSAGE","GFX/PhantasarSpellNames/"..Str.Replace(Combat_Message_Stuff.Filename,"JUG_","")..".png")
      Image.HotCenter("COMBATMESSAGE")
      Combat_Message_Stuff.Loaded=true
      end
   Image.Draw("COMBATMESSAGE",400,75)   
  else
   Image.Font('Fonts/Coolvetica.ttf',40)
   DText(Combat_Message_Stuff.Message,400,75,2,2)
   Image.Color(255,255,255)
  end 
end

function Combat_AddLvUpMessage(msg,col)
LvUpMessages = LvUpMessages or {}
local y = 850
local ent
-- Determine start y position
for _,ent in pairs(LvUpMessages) do
    if ent.y+50>=y then y=ent.y+50 end
    end
local gcol = lvupcol[col or 'NoChar'] or lvupcol.NoChar    
table.insert(LvUpMessages,{
       y   = y,
       fg  = {R=gcol[1][1],G=gcol[1][2],B=gcol[1][3]},
       bg  = {R=gcol[2][1],G=gcol[2][2],B=gcol[2][3]},
       msg = msg
    })
CWrite("LUM> "..msg,gcol[1][1],gcol[1][2],gcol[1][3])    
end

function Combat_LvUpMessage()
if not LvUpMessages then return end
local ent,ak,x,y
for ak,ent in ipairs(LvUpMessages) do
    ent.y = ent.y - 1
    if ent.y<-100 then 
       table.remove(LvUpMessages,ak)
       else
       Image.Font("Fonts/Coolvetica.ttf",40)
       ARColor(ent.bg)
       for x=399,401 do for y=ent.y-1 , ent.y+1 do DText(ent.msg,x,y,2,2) end end
       ARColor(ent.fg)
       DText(ent.msg,400,ent.y,2,2)
       end     
    end
end

function __consolecommand.LUM(a)
if a[1]~="" then Combat_AddLvUpMessage(a[1],a[2]) end
if not LvUpMessages then CWrite('?ERROR! No LUM yet set by the game.',255,0,0) return end
for ak,ent in ipairs(LvUpMessages) do
    CWrite("LUM"..ak.."> "..sval(ent.msg).." -- "..sval(ent.y),ent.fg.R or 255,ent.fg.G or 255,ent.fg.B or 255)
    end
end

function Combat_AfterEffect()
local arena = upper(Combat_Arena)
if Combat_DS_AfterEffect[arena] then
   Combat_DS_AfterEffect[arena]()
   -- else CWrite("No effect for '"..arena.."'",255)  -- Must not be active in release. This is only a debug line!
   end
end


-- Draw the combat screen whole
function Combat_DrawScreen(TGROUP,TARGET)
Image.Cls()
-- @IF DEVELOPMENT
if KeyHit(KEY_F1) then
  LAURA.Console()
  end
-- @FI
Image.Color(255,255,255)
Image.Draw("Arena",0,0)
Combat_DrawFighters(TGROUP,TARGET)
Combat_AfterEffect()
Combat_DrawInterface()
Combat_DrawMessageBox()
ShowMiniMessages('Combat')
-- Combat_LvUpMessage()
end
