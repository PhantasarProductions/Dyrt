--[[
/* 
  BoxText - Dyrt

  Copyright (C) 2013, 2014 J.P. Broks
  
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

-- @UNDEF BOXTEXTDEBUG

-- @IF IGNOREME
__consolecommand = {}
-- @FI

function HAREA()
areay = areay or 620
toey = toey or 620
if toey<620 then toey = toey + 1 end
if areay<620 then areay = areay + 1 end
end  

function BoxText(BTData)
GrabConfig()
ShowLine = 1
ShowChar = 1
Key.Flush()
--[[ Old way. Linux Compiler tags have been prefixed with a # in order to make the GALE preprocessor ignore them.
DrawScreen()
ShowBox(BTData)
if Flip then Flip() else Image.Flip() end
-- # @IF $LINUX
   print("Flushing key buffer")
   Key.Flush()
   print("Waiting for user to press key")
   Key.Wait()
   print("Key pressed, let's continue...")
-- # @ELSE
   print("Non-Linux key waiting")
   while ButtonPressed() do end
   repeat
   until ButtonPressed()
-- # @FI
DrawScreen() ]]
-- Current way
repeat
if GameScript then HAREA() else LAURA.ExecuteGame("HAREA") end
DrawScreen()
ShowBox(BTData)
if Flip then Flip() else LAURA.ExecuteGame("Flip") end
until ActionKeyHit() or Mouse.Hit(1)~=0 -- ButtonPressed()
DrawScreen()
end

if not GameScript then
   function Combat_DrawScreen() LAURA.ExecuteGame("Combat_DrawScreen") end
   end

function BattleBoxText(BTData)
GrabConfig()
Key.Flush()
ShowLine = 1
ShowChar = 1
while ButtonPressed() do end
repeat
Combat_DrawScreen()
ShowBox(BTData)
if Flip then Flip() else LAURA.ExecuteGame("Flip") end
until ActionKeyHit() or Mouse.Hit(1)~=0 --ButtonPressed()
Combat_DrawScreen()
end


function LBoxText(DataOrFile,Tag)
local BTData
if type(DataOrFile)=="string" then
   Console.Write("Reading language file: "..DataOrFile,200,200,100)
   local BTD = ReadLanguageFile(DataOrFile)
   BTData = BTD.BoxText[Tag]
   -- @IF BoxTextDebug
   for i,v in pairs(BTData) do
       CSay(type(v).." "..i)
       end
   -- @FI
elseif type(DataOrFile)=="table" then
   BTData = DataOrFile.BoxText[Tag]
else
   Sys.Error("Data type for LBoxText Data is incorrect.","It should be either,A 'string' for a Language file;Or,A 'table' containing the data already loaded;But what I got was,"..type(DataOrFile))
   end
BoxText(BTData)
end

function LBattleBoxText(DataOrFile,Tag)
local BTData
if type(DataOrFile)=="string" then
   Console.Write("Reading language file: "..DataOrFile,200,200,100)
   BTData = ReadLanguageFile(DataOrFile)
elseif type(DataOrFile)=="table" then
   BTData = DataOrFile.BoxText[Tag]
else
   Sys.Error("Data type for LBoxText Data is incorrect.","It should be either,A 'string' for a Language file;Or,A 'table' containing the data already loaded;But what I got was,"..type(DataOrFile))
   end
BattleBoxText(BTData)
end

function TrueSerialBoxText(f,DataOrFile,prefix)
local c=1
local voc
if type(DataOrFile)=="string" then
   Console.Write("Reading language file: "..DataOrFile,200,200,100)
   local BTD = ReadLanguageFile(DataOrFile)
   BTData = BTD
elseif type(DataOrFile)=="table" then
   BTData = DataOrFile
else
   Sys.Error("Data type for SerialBoxtext Data is incorrect.","It should be either,A 'string' for a Language file;Or,A 'table' containing the data already loaded;But what I got was,"..type(DataOrFile))
   end
while BTData.BoxText[prefix..c] do
      voc = BTData.VocalDir..prefix..c..".ogg"
      if JCR5.Exist(voc)==1 then SFX(voc) end   
      f(BTData,prefix..c)
      c=c+1
      end   
end

function SerialBoxText(data,prefix)
TrueSerialBoxText(LBoxText,data,prefix)
end

function SerialBattleBoxText(data,prefix)
TrueSerialBoxText(LBattleBoxText,data,prefix)
end

function CountLines(D)
local ret = 0
local i,v
Console.Write("!WARNING! LineCount not properly set! Now counting by myself!",255,0,0)
for i,v in ipairs(D.lines) do
    ret = ret + 1
    end
CSay("==> Result = "..ret)
D.linecount = ret
return ret
end

function BoxQuestion(data,tag,combat)
local pure = not tag
local BTData
local LData
GrabConfig()
ShowLine = 1
ShowChar = 1
if pure then 
   BTData = data
elseif type(data) == 'string' then
   Console.Write("Reading language file: "..data,200,200,100)
   LData = ReadLanguageFile(data)
   BTData = LData.BoxText[tag]
elseif type(data) == 'table' and (not tag) then  
   BTData=data   
elseif type(data) == 'table' then
   BTData = data.BoxText[tag]
   if not BTData then Sys.Error("Tag "..tag.." does not exist!","FN,BoxQuestion;Tag,"..tag) end
else
   Sys.Error("BoxQuestion received data it doesn't understand!")      
   end
BTData.Selection = 1
local bye
repeat
-- DrawScreen()
if combat then 
   Combat_DrawScreen()
   else
   DrawScreen()
   end   
ShowBox(BTData)
if Flip then Flip() else LAURA.ExecuteGame("Flip") end
if (KeyHit(KEY_UP)   or joydirhit('U')) and BTData.Selection>1               then BTData.Selection = BTData.Selection - 1 end
if (KeyHit(KEY_DOWN) or joydirhit('D')) and BTData.lines[BTData.Selection+1] then BTData.Selection = BTData.Selection + 1 end
if ActionKeyHit() then bye = true end
until bye
if combat then 
   Combat_DrawScreen()
   else
   DrawScreen()
   end   
return BTData.Selection
end
    
function BoxPic(BTData)
if BTData.PicImg then return BTData.PicImg end
if BTData.NoPic then return nil end
if not BTData.Pic then return nil end
-- BTData.Pic = Str.Trim(BTData.Pic)
if ((not BTData.SubPic) or BTData.SubPic=="General") and CVV("&ERIC=YASATHAR") and upper(BTData.Pic)=="$ERIC" then BTData.SubPic="Yasathar" end
local i = upper(BTData.Pic .. "/" .. (BTData.SubPic or "General"))
LBPix = LBPix or {}
if LBPix[i] then BTData.PicImg = LBPix[i]; return LBPix[i] end
if JCR5.Exist("GFX/BoxPic/"..i..".png") == 0 then
   BTData.NoPic = true
   return nil
   end
local l = Image.Load("GFX/BoxPic/"..i..".png")
Image.Hot(l,0,Image.Height(l))
CWrite("Loading: GFX/BoxPic/"..i,0,255,255)
LBPix[i] = l
BTData.PicImg = l
return l
end

function __consolecommand.LBPIX()
if not LBPix then CWrite("? No pictures are loaded yet!") return end
local k,v
local c = 0
for k,v in spairs(LBPix) do
    c = c + 1
    CSay(right("          "..c,10).." "..k.."   ref: "..v)
    end
end

function __consolecommand.PORTRETJES()
SerialBoxText("Test/Portretjes","TEST")
end
    
function ShowBox(BTData)
SetLangFont()
ShowLine = ShowLine or 1
ShowChar = ShowChar or 1
if not BTData then Sys.Error("ShowBox received 'nil' for data!") end
if type(BTData)~="table" then Sys.Error("ShowBox received '"..type(BTData).."' for data. I don't understand that!") end
if not BTData.lines then Sys.Error("The ShowBoxData contains no lines") end
local th = Image.TextHeight(BTData.lines[1])
local lc = BTData.linecount or CountLines(BTData)
local tth = th * lc
local tbh = tth + (th*3)
local tby = 600-tbh
local ak,txt
local tshowline,ch
local Lang = Var.C("$LANG")
local bp = BoxPic(BTData)
ARColor(config.btback)
if config.bttrans then Image.SetAlpha(.5) end
Image.Rect(0,600-tbh,800,tbh)
Image.SetAlpha(1)
ARColor(config.bthead)
Image.DText(Var.S(BTData.Head),10,10+tby)
ARColor(config.btfont)
for ak,txt in ipairs(BTData.lines) do
    if BTData.Selection and BTData.Selection~=ak then HARColor(config.btfont) else ARColor(config.btfont) end
    tshowline = Var.S(txt)
    ch = GetActiveChar()
    if Lang and ch and SirMiss[Lang] and SirMiss[Lang][ch] then 
       tshowline = Str.Replace(tshowline,"+SIRMISS",SirMiss[Lang][ch])
       end
    if config.txtspeed=='Instant' or ak<ShowLine then  
       DText(tshowline,10,10+tby+(th*1)+(th*ak))
    elseif ak==ShowLine then
       DText(left(tshowline,ShowChar),10,10+tby+(th*1)+(th*ak))
       end
    -- if BTData.Selection == ak then DText(">",5,10+tby+(th*1)+(th*ak)) end
    end
local function LineCheck() 
  if not BTData.lines[ShowLine] then return end
  if ShowChar>Str.Length(BTData.lines[ShowLine]) then
     ShowChar = 1
     ShowLine = ShowLine + 1
     end
  end    
-- @SELECT config.txtspeed
-- @CASE 'Slow'
   ShowChar = ShowChar + .5
   LineCheck()
-- @CASE 'Medium'
   ShowChar = ShowChar + 1
   LineCheck()        
-- @CASE 'Fast'
   ShowChar = ShowChar + 2
   LineCheck()        
-- @ENDSELECT    
ARColor(config.btfont)    
Image.Line(  5,5+tby,795,5+tby) -- up
Image.Line(  5,5+tby,  5,  595) -- left
Image.Line(  5,  595,795,  595) -- down
Image.Line(795,  595,795,5+tby) -- right
if bp then white(); Image.Draw(bp,5,tby-5) end
end
