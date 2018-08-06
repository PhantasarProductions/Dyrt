--[[
/* 
  Stone Master Script - Dyrt

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



Version: 14.10.14

]]

-- How many stones do we require?
function SM_NeedStones(num)
local nd = {15,10,5}
local ret = 1
if num<0 then
   ret = math.ceil((num*-1)/nd[skill])
   else
   ret = math.ceil((num+ 2)/nd[skill])
   end
if ret < 1 then ret = 1 end
return ret   
end

function SM_NeedCash(tpe,num)
local ret = 0
local max = {10^5,10^6,10^9}
-- @SELECT tpe
-- @CASE "res"
   ret = num * 25
-- @CASE "skl"
   ret = num * num
   if ret<num *50 then ret = num * 50 end
-- @ENDSELECT
if ret>max[skill] then ret = max[skill] end
return math.abs(ret)
end

-- Upgrade this shit!
function SM_Upgrade(data,rec,charnum)
local ch = data[rec].charlist[charnum]
CSay("- SM_Upgrade!")
CSay("  = Upgrading character: "..ch)
CSay("  = Upgrade type"..data[rec].type)
if not tablecontains(party,ch) then CWrite("  = REJECTED! Character not in party at present time!",255,0,0) return end
-- @SELECT data[rec].type
-- @CASE 'skill'
   local skn = data[rec].skill
   local maxlv = {249,99,49}
   if char[ch].SkillLevels[skn]<maxlv[skill] and stones>=SM_NeedStones(char[ch].SkillLevels[skn]) and cash>=SM_NeedCash('skl',char[ch].SkillLevels[skn]) then
      stones = stones - SM_NeedStones(char[ch].SkillLevels[skn])
      cash = cash - SM_NeedCash('skl',char[ch].SkillLevels[skn])
      char[ch].SkillLevels[skn] = char[ch].SkillLevels[skn] + 1
      if skilllevelup[ch] then skilllevelup[ch](skn) end
      end
-- @CASE "resistance"
   local rsn = data[rec].resistance
   CSay("  = Updating resistance field: "..rsn)
   local need = SM_NeedStones(resistance[ch][rsn]*100)
   local needcash = SM_NeedCash("res",resistance[ch][rsn])
   local r = rand(4-skill,(4-skill)*2)
   if resistance[ch][rsn]<1 and need<=stones and needcash<=cash then
      stones = stones - need
      cash = cash - round(needcash)
      cash = round(cash)      
      resistance[ch][rsn] = resistance[ch][rsn] + (r/100)
      if resistance[ch][rsn]>1 then resistance[ch][rsn]=1 end
      end      
-- @ENDSELECT
end


-- Character list
function SM_MakeCharList(masterdata)
local ret = masterdata
local ak,d,al,ch
for ak,d in ipairs(masterdata) do    
    if d.type=='skill' then 
       ret[ak].charlist = ret[ak].charlist or {d.char} 
    else
       ret[ak].charlist = {}
       for al,ch in ipairs(party) do 
           if ch~="Kirana" then table.insert(ret[ak].charlist,ch) end 
           end
       end
    end
return ret    
end


-- Main StoneMaster routine
function StoneMaster(Master)
local tut
if not CVV("&TUTOR.STONEMASTER") then
   tut = ReadLanguageFile("Tutorial/MagicStone")
   SerialBoxText(tut,"TUT")
   Var.D("&TUTOR.STONEMASTER","TRUE")
   end 
local masterdata = JINC("StoneMaster/"..Master..".lua")
local ak,s
-- local items = SM_SplitData(masterdata)
masterdata = SM_MakeCharList(masterdata)
-- @IF DEVELOPMENT
local mdout = serialize("masterdata",masterdata)
for ak,s in ipairs(split(mdout,"\n")) do
    Console.Write(s,255,255,200)
    end
-- @FI
local P = {1,1}
local R = 1
local d
local shuptxt
local rsn
Key.Flush()
repeat
Image.Cls()
if config.bttrans then Image.SetAlpha(.5) end
ARColor(config.btback)
Image.Rect(0,0,800,600)
Image.SetAlpha(1)
ARColor(config.btfont)
Image.Line(   5,   5, 795,   5) -- U
Image.Line(   5, 595, 795, 595) -- D
Image.Line(   5,   5,   5, 595) -- L
Image.Line( 795,   5, 795, 595) -- R
-- Master Data
for ak,d in ipairs(masterdata) do
    if R==1 then ARColor(config.bthead) else ARColor(config.btfont) end
    if P[1]==ak then Image.Font("fonts/CoolVetica.ttf",20) else Image.Font("Fonts/Coolvetica.ttf",15) end
    rsn = "nil"
    -- @SELECT d.type
    -- @CASE 'skill'
    if char[d.char] then rsn = char[d.char].SkillNames[d.skill] else table.remove(masterdata,ak); rsn=".." end    
    -- @CASE 'resistance'
    if Str.Left(d.resistance,2)=="ST" then
       rsn = Str.Right(d.resistance,Str.Length(d.resistance)-2)
       else
       rsn = d.resistance
       end
    rsn = Str.Left(rsn,1)..Str.Lower(Str.Right(rsn,Str.Length(rsn)-1))       
    -- @ENDSELECT           
    DText(rsn,10,ak*30,0,2)
    end    
-- Character List
local clr
local curval
local cost = 0
local cashcost = 0
local max = 100
local maxreached
for ak,d in ipairs(masterdata[P[1]].charlist) do
    if tablecontains(party,d) then clr = ARColor else clr = HARColor end
    if R==2 then clr(config.bthead) else clr(config.btfont) end
    if R==2 and P[2]==ak then Image.Font("fonts/CoolVetica.ttf",20) else Image.Font("Fonts/Coolvetica.ttf",15) end
    if d=="Yasathar" then
       DText(Var.C("$ERIC"),300,ak*30,0,2)    
       else
       DText(Var.C("$"..Str.Upper(d)),300,ak*30,0,2)
       end
    -- @SELECT masterdata[P[1]].type
    -- @CASE 'skill'
       local skn = masterdata[P[1]].skill
       curval = "Lv"..char[d].SkillLevels[skn]
       cost = SM_NeedStones(char[d].SkillLevels[skn])
       cashcost = SM_NeedCash('skl',char[d].SkillLevels[skn])
       maxreached = (skill==1 and char[d].SkillLevels[skn]>=250) or (skill==2 and char[d].SkillLevels[skn]>=100) or (skill==3 and char[d].SkillLevels[skn]>=50)
    -- @CASE 'resistance'
       local r = sval(resistance[d][masterdata[P[1]].resistance])
       if type(r)=='number' then r=round(r*100) end
       curval = round(r).."%"
       cost = SM_NeedStones(r)
       cashcost = SM_NeedCash('res',r)
       max = 100
    -- @ENDSELECT   
    DText(curval,450,ak*30,0,2)
    if not maxreached then
       if cost == 1 then 
          DText("Need 1 stone + "..cashcost.." sh",795,ak*30,1,2)                    
          else
          DText("Need "..cost.." stones + "..cashcost.." sh",795,ak*30,1,2)
          end
       end   
    end     
Image.Font("Fonts/Coolvetica.ttf",15)
ARColor(config.btfont)
DText("You have "..sval(stones).." magic stones left",795,595,1,1)
DText("Cash: "..cash.." shilders",795,580,1,1)    
Flip()
if (joydirhit("U") or KeyHit(KEY_UP)) and P[R]>1 then P[R] = P[R] - 1 end
if (joydirhit("D") or KeyHit(KEY_DOWN)) and ((R==1 and masterdata[P[1]+1]) or (R==2 and masterdata[P[1]].charlist[P[2]+1])) then P[R] = P[R] + 1 end
if ActionKeyHit() then
   -- @SELECT R
   -- @CASE 1
      R = 2
   -- @CASE 2
      SM_Upgrade(masterdata,P[1],P[2])
   -- @ENDSELECT      
   end
if CancelKeyHit() then R=R-1 end
until R==0
end



