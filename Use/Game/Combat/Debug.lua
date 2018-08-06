--[[
/* 
  Combat Debugger

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



Version: 14.08.05

]]
tBattle = tBattle or {}

-- @IF IGNORETHISLINE
__consolecommand = {}
-- @FI

function __consolecommand.TBSETUP()
repeat
tBattle["Num"] = Sys.Val(GphInput("How many enemies should be there in the TestBattle",tBattle["Num"]))
until tBattle["Num"]>=1 and tBattle["Num"]<=9
local ak
for ak=1,tBattle["Num"] do
    tBattle["Enemy"..ak] = GphInput("Enemy #1 will be:",tBattle["Enemy"..ak])
    end
tBattle["Music"] = GphInput("Music will be:",tBattle["Music"] or "Battle.ogg")
tBattle["VictoryTune"] = GphInput("Victory tune will be:",tBattle["VictoryTune"] or "Victory.ogg")
tBattle["Arena"] = GphInput("Arena picture will be:",tBattle["Arena"])    
tBattle["Initiative"] = Sys.Val(GphInput("Initiative (0=None, 1=Player, 2=Enemy): ",tBattle["Initiative"]))
end

function __consolecommand.TB()
local k,v
for k,v in pairs(tBattle) do
    CSay(k.." = '"..v.."';")
    end
end    

function __consolecommand.TBSTART()
local ini
local ak
if CombatRunning then Console.Write("? Combat is already running. Finish it first before starting another!",255,0,0); return; end
if not tBattle["Num"] then Console.Write("? Before you run this one, run TBSETUP first!",255,0,0) return end 
if tBattle["Num"]<1 or tBattle["Num"]>9 then Console.Write("? Incorrect number of enemies. This must be a number between 1 and 9!",255,0,0) return end
-- CSay("Battle engine not yet scripted!")     
Combat(tBattle)
end

__consolecommand.TBRUN = __consolecommand.TBSTART  -- Alias


function __consolecommand.TBARENA()
Console.Write("- Found the next arena pictures!",110,150,10)
local dir = JCR_GetDir()
local f,d
local dr = "GFX/ARENA/"
local cnt=0
for f,d in pairs(dir) do 
    if Str.Left(f,Str.Length(dr))==dr then Console.Write("  = "..f,180,44,32); cnt=cnt+1; end
    end
Console.Write(" = "..cnt.." Arena pictures found!",40,80,130)
end


function __consolecommand.TBD_FOES()
local ak,f
local i,d
if not CombatRunning then Console.Write("? Combat must be running in order to use this command!",255,0,0); return end
for ak,f in pairs(Foe) do
    Console.Write('Foe #'..ak,255,0,0)
    if not FoeData[ak] then 
       Console.Write("!!! WARNING !!! No Foe Data Loaded For This Foe!",255,0,0)
       else
       for i,d in spairs(FoeData[ak]) do
           if type(d)=='boolean' then
	      if d then Console.Write(i.." = TRUE",255,255,0) else Console.Write(i.." = FALSE",255,255,0) end
	      else
	      Console.Write(i.." = "..sval(d),255,255,0)
	      end
	   end
       end
    end	   
end

function __consolecommand.TBD_FOEHP()
if not CombatRunning then Console.Write("? Combat must be running in order to use this command!",255,0,0); return end
for ak,f in pairs(Foe) do
    if not FoeData[ak] then 
       Console.Write("!!! WARNING !!! No Foe Data Loaded For This Foe!",255,0,0)
       else
       Console.Write(f.." >> "..FoeData[ak].HP.."/"..FoeData[ak].HPMax,180,0,255)
       end
    end    
end

function __consolecommand.TBD_FHP(a)
if not CombatRunning then Console.Write("? Combat must be running in order to use this command!",255,0,0); return end
local f = Sys.Val(a[1])
local h = Sys.Val(a[2])
if not FoeData[f] then Console.Write("? There is no foe on slot #"..f,255,0,0) return end
FoeData[f].HP = h
CSay("Foe #"..f.." now has "..h.." hitpoints left")
end

function __consolecommand.TBD_HHP(a)
local ch
if not CombatRunning then Console.Write("? Combat must be running in order to use this command!",255,0,0); return end
if type(a[1])=='number' then ch = party[a[1]] end
if type(a[1])=='string' then ch = a[1] end
if (not ch) or (not char[ch]) then
   Console.Write('? That character does not exist!',255,0,0)
   return 
   end
char[ch].HP[1]=Sys.Val(a[2])
Console.Write(ch..' now has '..char[ch].HP[1]..' hitpoints!')   
end    

function __consolecommand.TBD_EXP()
if not CombatRunning then Console.Write("? Combat must be running in order to use this command!",255,0,0); return end
local k,v
Console.Write("Currently awarded experience would be: "..earnexperience,178,134,16)
for k,v in pairs(party) do
    Console.Write("Partymember #"..k..": "..v,98,16,112)
    end
for k,v in pairs(multiplier) do
    Console.Write(k.." now has a modifier of "..v.." and would earn "..round(v*earnexperience).." experience points!",160,180,14)
    end
for k,v in pairs(participated) do
    if v then  Console.Write(k.." did participate in this fight",0,255,0) else Console.Write(k.." did NOT YET participate in this fight!",255,0,0) end
    end    
end 

function __consolecommand.SKILLFULL(a)
local chrs,skills,ak,al,e
-- Preparations is key
if Str.Upper(a[1])=='ALL' then chrs=party else chrs={a[1]} end
if Sys.Val(a[2])<1 and Str.Upper(a[2])~='ALL' then Console.Write('? Invalid input in second parameter!',255,0,0); return end
for ak,ch in pairs(chrs) do
    if not char[ch] then Console.Write("? Character '"..ch.."' does not exist. Mind spelling and LoWeR aNd UpPeR cAsE!",255,0,0); return end
    if Str.Upper(a[2])=='ALL' then
       skills = {}
       for al,e in pairs(char[ch].SkillExperience) do 
           table.insert(skills,al)
           end 
       else
       skills = {a[2]}
       end
    for e,al in ipairs(skills) do
        Console.Write('Setting skill #'..al..' for '..ch..' to the maximum',194,18,166)
        if not char[ch] then 
           Console.Write('! WARNING! Character '..ch..' does not exist!',255,0,0)
           else
           char[ch].SkillExperience[al] = skillexptable[char[ch].SkillLevels[al]]
           end
        end    
    end
end

function __consolecommand.OVERSOUL(a)
local e,v
if (not a) or (not a[1]) or a[1]=='' then
  for e,v in spairs(CountOversoul) do 
      Console.Write(e.." >>> "..v,255,255,0)
      end
  CWrite(sval(TotalOverKills)..' oversoul enemies were killed.')    
  return
  end
CountOversoul[Str.Upper(a[1])] = Sys.Val(a[2])
Console.Write('Oversoul count for '..Str.Upper(a[1])..' has been set to '..Sys.Val(a[2]))
if skill==11 then CWrite("NOTE! Oversoul is not available in the easy mode! :P",255,0,0) end
end

function __consolecommand.OVERSOULKILLS(a)
if a[1] and a[1]~='' then TotalOverKills = Sys.Val(a[1]) end
CWrite(sval(TotalOverKills)..' oversoul enemies were killed.')
end
