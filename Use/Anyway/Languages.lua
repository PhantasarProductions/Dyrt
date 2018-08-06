--[[
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 2.0
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is (c) Jeroen P. Broks.
 *
 * The Initial Developer of the Original Code is
 * Jeroen P. Broks.
 * Portions created by the Initial Developer are Copyright (C) 2013, 2014
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 * -
 *
 * ***** END LICENSE BLOCK ***** */



Version: 14.08.15

]]

-- @UNDEF LANGUAGEDEBUG

Lang      = {}
LangFont  = {}
LangName  = {}
LangSys   = {}

SirMiss   = {}

StandardFont = "Coolvetica.ttf"

-- @USEDIR Languages

-- This should import all language settings files. As this file will always be imported first before the language settings are imported no conflicts should arise (I hope)

-- If you want to make a version of this game in your own language, please check out the Languages/English/Settings.Lua file


-- And now some functions to make it all happen



function GetLanguageCodes() -- Used in the configuration program
local c=1
local ret = {}
local a,n
if not Lang.EN then Sys.Error("English must at least be properly defined in the language table.") end
for a,n in pairs(Lang) do
    ret[c] = a
    c = c + 1
    end
return ret    
end

function SetLangFont()
local SL = Var.C("$LANG")
Image.Font(LangFont[SL] or StandardFont,25)
end

function ReadLanguageFile(LangFile)
local ret = {}
local Lang = Var.C("$LANG") -- config.language
local File = "Languages/"..Lang.."/"..LangFile --..".LNG"
if upper(right(File,4))~='.LNG' then File = File ..".LNG" end
local EFil = "Languages/EN/"..LangFile..".LNG"
local DFil = File
local rlin = 0
local TLC,ID,tpe,Line
local woord,regel,woorden,regels,regel
ret.VocalDir = "Vocals/"..LangFile..'/'
SetLangFont()
if JCR5.Exist(File)==0 then
   if Lang~="EN" then
      Console.Write("!WARNING!",255,0,0)
      Console.Write("File "..Lang.." not found, trying English variant in stead!")
      if JCR5.Exist(EFil)==1 then
         DFil = EFil
         else
         Sys.Error("Language file not found in selected language, neither in English","Language,"..Lang..";File,",LangFile)
         end
      else
      Sys.Error("Language file not found in English","Language,"..Lang..";File,"..LangFile..";Full File,"..File)
      end
   end
 local BT = JCR5.Open(DFil)
 tpe  = "Unknown"
 ID   = "Unknown"
 while JCR5.Eof(BT)==0 do
    Line = JCR5.ReadLn(BT)
    -- TLC  
    rlin = rlin + 1
    ret.Unknown = {}
    ret.Unknown.Unknown = {}
    if Line ~= "" then
       local Tag = Str.Left(Line,1)
       local Txt = Str.Right(Line,Str.Length(Line)-1)
       -- @IF LANGUAGEDEBUG
          Console.Write("LanguageDebug> Tag("..Tag..") => "..Txt,255,255,0)
       -- @FI
       -- @SELECT Tag
       -- @CASE "@"
          ret.BoxText = ret.BoxText or {}
          ret.BoxText[Txt] = ret.BoxText[Txt] or {}
          tpe = 'BoxText'
          ID = Txt
          TLC = 1
          regels = {}
       -- @CASE "!"
          ret[tpe][ID].Head = Var.S(Txt)
          ret[tpe][ID].Pic  = Txt
          if JCR5.Exist("DATA/BOXPICREDIRECT/"..Txt)==1 then
             local bt = JCR5.Open("DATA/BOXPICREDIRECT/"..Txt)
             ret[tpe][ID].Pic = Str.Trim(JCR5.ReadLn(bt))
             CSay(Txt.." boxpic has been redirected to "..ret[tpe][ID].Pic)
             JCR5.Close(bt) 
             end 
          -- @IF LANGUAGEDEBUG
          CSay("Header set to: "..Txt.." => "..Var.S(Txt))
          -- @FI
       -- @CASE "*"
          if Txt=="NOPIC" then ret[tpe][ID].NoPic = true
             else
             ret[tpe][ID].SubPic = Txt
             end          
       -- @CASE "#"            
          local T=Var.S(Txt)
          woorden = {} 
          woord = 1
          for ak=0,Str.Length(T) do
              woorden[woord] = woorden[woord] or ""
              -- @IF BTDBG
              CSay("Word: "..woord..">>"..woorden[woord])
              -- @FI
              if Mid(T,ak,1)==" " then woord = woord + 1 else woorden[woord] = woorden[woord] .. Mid(T,ak,1) end
              end
          -- Put in the lines
          regel = TLC or 1
          regels = regels or {}
          if not regel then
             Sys.Error("Something went wrong in reading the language file","Text,"..T..";Language file line,"..rlin..";Problem,Somehow the boxtextlinenumber got itself to 'nil'")
             end
          for ak,woord in ipairs(woorden) do -- No worries, the 'woord' variable no longer has the function it had above ;)
              regels[regel] = regels[regel] or ""
              if Image.TextWidth(regels[regel].." "..woord) > 780 then
                 regel = regel + 1
                 regels[regel]=woord    	
                 else    	
                 if regels[regel]~="" then
                    regels[regel] = regels[regel] .. " " .. woord
                    else    	    
                    regels[regel] = woord
                    end
                 end -- if line too long or not?	        
              end -- for
          TLC = regel + 1
          ret[tpe][ID].lines = regels
          ret[tpe][ID].linecount = regel    
          -- @IF LANGUAGEDEBUG
          CSay('BoxTextData["'..tpe..'"]["'..ID..'"].lines['..regel..'] = "'..regels[regel]..'"')
          -- @FI
       -- @ENDSELECT
       end -- if we got a line       
    end -- while
-- CSay(serialize("ret",ret))
JCR5.Close(BT)   
if not ret.BoxText then Sys.Error('Requested language file does not have any BOXTEXT data!','Requested,'..LangFile..';Full,'..DFil) end
return ret    
end -- function


function DefaultCharName(name)
local L = Var.C("$LANG")
if L=="" or (not LangName[L]) or (not LangName[L][name]) then L="EN" end
return LangName[L][name]
end

function SysText(name)
local L = Var.C("$LANG")
if L=="" or (not LangSys[L]) or (not LangSys[L][name]) then L="EN" end
return LangSys[L][name]
end
