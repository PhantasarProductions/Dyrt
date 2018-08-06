--[[
/* 
  General Character values

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



Version: 14.10.14

]]



-- This is just a file with general settings.
-- The word "Algemeen" means "General" in Dutch (as "things in general", not the millitairy rank)
-- The word was chosen, as the scripts in this dir are loaded in alphabetic order and this way, I can be sure this one comes first as no character has a name that comes before "Al" in alphabetic order




char = char or {}
equip = equip or {}
party = party or {"YoungIrravonia"}
resistance = resistance or {}




charwalk = {} -- Perform a certain action at each step done while this character is in the lead.

PersonalAction = {} -- When the player presses the personal action button, let's see what we can do according to the personal action set for that character.

AbilityBreak = {} -- When set on a character he or she might break in a special ability.
AbilityAttackBreak = {} -- When set on a character, that character can break off an ability attack. In Dyrt this was used to enable Irravonia to block off elemental attacks randomly. 

setupchar = {}  -- This one should not be saved, as it contains the init functions for each character

levelup = {} -- This will contain all functions to be executed when a character goes a GENERAL level up.

skilllevelup = {} -- This will contain all functions to be executed when a character goes a SKILL level up.

teachlist = teachlist or {} -- These will contain the new abilities and spells. When a character fills the requirement they will basically learn the new spell or ability the next time they perform a normal attack

activecharacter = activecharacter or "YoungIrravonia"

experiencetable = {100, 200, 400, 700, 1100, 1600, 2200, 2900, 3700, 4600, 5600, 6700, 7900, 9200, 10600, 12100, 13700, 15400, 17200, 19100, 21100, 23200, 25400, 27700, 30100, 32600, 35200, 37900, 40700, 43600, 46600, 49700, 52900, 56200, 59600, 63100, 66700, 70400, 74200, 78100, 82100, 86200, 90400, 94700, 99100, 103600, 108200, 112900, 117700, 122600, 127600, 132700, 137900, 143200, 148600, 154100, 159700, 165400, 171200, 177100, 183100, 189200, 195400, 201700, 208100, 214600, 221200, 227900, 234700, 241600, 248600, 255700, 262900, 270200, 277600, 285100, 292700, 300400, 308200, 316100, 324100, 332200, 340400, 348700, 357100, 365600, 374200, 382900, 391700, 400600, 409600, 418700, 427900, 437200, 446600, 456100, 465700, 475400, 485200, 495100, 505100, 515200, 525400, 535700, 546100, 556600, 567200, 577900, 588700, 599600, 610600, 621700, 632900, 644200, 655600, 667100, 678700, 690400, 702200, 714100, 726100, 738200, 750400, 762700, 775100, 787600, 800200, 812900, 825700, 838600, 851600, 864700, 877900, 891200, 904600, 918100, 931700, 945400, 959200, 973100, 987100, 1001200, 1015400, 1029700, 1044100, 1058600, 1073200, 1087900, 1102700, 1117600, 1132600, 1147700, 1162900, 1178200, 1193600, 1209100, 1224700, 1240400, 1256200, 1272100, 1288100, 1304200, 1320400, 1336700, 1353100, 1369600, 1386200, 1402900, 1419700, 1436600, 1453600, 1470700, 1487900, 1505200, 1522600, 1540100, 1557700, 1575400, 1593200, 1611100, 1629100, 1647200, 1665400, 1683700, 1702100, 1720600, 1739200, 1757900, 1776700, 1795600, 1814600, 1833700, 1852900, 1872200, 1891600, 1911100, 1930700, 1950400, 1970200, 1990100, 2010100, 2030200, 2050400, 2070700, 2091100, 2111600, 2132200, 2152900, 2173700, 2194600, 2215600, 2236700, 2257900, 2279200, 2300600, 2322100, 2343700, 2365400, 2387200, 2409100, 2431100, 2453200, 2475400, 2497700, 2520100, 2542600, 2565200, 2587900, 2610700, 2633600, 2656600, 2679700, 2702900, 2726200, 2749600, 2773100, 2796700, 2820400, 2844200, 2868100, 2892100, 2916200, 2940400, 2964700, 2989100, 3013600, 3038200, 3062900, 3087700, 3112600, 3137600, 3162700, 3187900, 3213200, 3238600}

-- skillexptable = {10, 20, 40, 70, 110, 160, 220, 290, 370, 460, 560, 670, 790, 920, 1060, 1210, 1370, 1540, 1720, 1910, 2110, 2320, 2540, 2770, 3010, 3260, 3520, 3790, 4070, 4360, 4660, 4970, 5290, 5620, 5960, 6310, 6670, 7040, 7420, 7810, 8210, 8620, 9040, 9470, 9910, 10360, 10820, 11290, 11770, 12260, 12760, 13270, 13790, 14320, 14860, 15410, 15970, 16540, 17120, 17710, 18310, 18920, 19540, 20170, 20810, 21460, 22120, 22790, 23470, 24160, 24860, 25570, 26290, 27020, 27760, 28510, 29270, 30040, 30820, 31610, 32410, 33220, 34040, 34870, 35710, 36560, 37420, 38290, 39170, 40060, 40960, 41870, 42790, 43720, 44660, 45610, 46570, 47540, 48520, 49510, 50510, 51520, 52540, 53570, 54610, 55660, 56720, 57790, 58870, 59960, 61060, 62170, 63290, 64420, 65560, 66710, 67870, 69040, 70220, 71410, 72610, 73820, 75040, 76270, 77510, 78760, 80020, 81290, 82570, 83860, 85160, 86470, 87790, 89120, 90460, 91810, 93170, 94540, 95920, 97310, 98710, 100120, 101540, 102970, 104410, 105860, 107320, 108790, 110270, 111760, 113260, 114770, 116290, 117820, 119360, 120910, 122470, 124040, 125620, 127210, 128810, 130420, 132040, 133670, 135310, 136960, 138620, 140290, 141970, 143660, 145360, 147070, 148790, 150520, 152260, 154010, 155770, 157540, 159320, 161110, 162910, 164720, 166540, 168370, 170210, 172060, 173920, 175790, 177670, 179560, 181460, 183370, 185290, 187220, 189160, 191110, 193070, 195040, 197020, 199010, 201010, 203020, 205040, 207070, 209110, 211160, 213220, 215290, 217370, 219460, 221560, 223670, 225790, 227920, 230060, 232210, 234370, 236540, 238720, 240910, 243110, 245320, 247540, 249770, 252010, 254260, 256520, 258790, 261070, 263360, 265660, 267970, 270290, 272620, 274960, 277310, 279670, 282040, 284420, 286810, 289210, 291620, 294040, 296470, 298910, 301360, 303820, 306290, 308770, 311260, 313760, 316270, 318790, 321320, 323860}

alt_experiencetable = {}

alt_experiencetable[1] = {5, 10, 20, 35, 55, 80, 110, 145, 185, 230, 280, 335, 395, 460, 530, 605, 685, 770, 860, 955, 1055, 1160, 1270, 1385, 1505, 1630, 1760, 1895, 2035, 2180, 2330, 2485, 2645, 2810, 2980, 3155, 3335, 3520, 3710, 3905, 4105, 4310, 4520, 4735, 4955, 5180, 5410, 5645, 5885, 6130, 6380, 6635, 6895, 7160, 7430, 7705, 7985, 8270, 8560, 8855, 9155, 9460, 9770, 10085, 10405, 10730, 11060, 11395, 11735, 12080, 12430, 12785, 13145, 13510, 13880, 14255, 14635, 15020, 15410, 15805, 16205, 16610, 17020, 17435, 17855, 18280, 18710, 19145, 19585, 20030, 20480, 20935, 21395, 21860, 22330, 22805, 23285, 23770, 24260, 24755, 25255, 25760, 26270, 26785, 27305, 27830, 28360, 28895, 29435, 29980, 30530, 31085, 31645, 32210, 32780, 33355, 33935, 34520, 35110, 35705, 36305, 36910, 37520, 38135, 38755, 39380, 40010, 40645, 41285, 41930, 42580, 43235, 43895, 44560, 45230, 45905, 46585, 47270, 47960, 48655, 49355, 50060, 50770, 51485, 52205, 52930, 53660, 54395, 55135, 55880, 56630, 57385, 58145, 58910, 59680, 60455, 61235, 62020, 62810, 63605, 64405, 65210, 66020, 66835, 67655, 68480, 69310, 70145, 70985, 71830, 72680, 73535, 74395, 75260, 76130, 77005, 77885, 78770, 79660, 80555, 81455, 82360, 83270, 84185, 85105, 86030, 86960, 87895, 88835, 89780, 90730, 91685, 92645, 93610, 94580, 95555, 96535, 97520, 98510, 99505, 100505, 101510, 102520, 103535, 104555, 105580, 106610, 107645, 108685, 109730, 110780, 111835, 112895, 113960, 115030, 116105, 117185, 118270, 119360, 120455, 121555, 122660, 123770, 124885, 126005, 127130, 128260, 129395, 130535, 131680, 132830, 133985, 135145, 136310, 137480, 138655, 139835, 141020, 142210, 143405, 144605, 145810, 147020, 148235, 149455, 150680, 151910, 153145, 154385, 155630, 156880, 158135, 159395, 160660, 161930}

alt_experiencetable[2] = {6, 13, 26, 46, 73, 106, 146, 193, 246, 306, 373, 446, 526, 613, 706, 806, 913, 1026, 1146, 1273, 1406, 1546, 1693, 1846, 2006, 2173, 2346, 2526, 2713, 2906, 3106, 3313, 3526, 3746, 3973, 4206, 4446, 4693, 4946, 5206, 5473, 5746, 6026, 6313, 6606, 6906, 7213, 7526, 7846, 8173, 8506, 8846, 9193, 9546, 9906, 10273, 10646, 11026, 11413, 11806, 12206, 12613, 13026, 13446, 13873, 14306, 14746, 15193, 15646, 16106, 16573, 17046, 17526, 18013, 18506, 19006, 19513, 20026, 20546, 21073, 21606, 22146, 22693, 23246, 23806, 24373, 24946, 25526, 26113, 26706, 27306, 27913, 28526, 29146, 29773, 30406, 31046, 31693, 32346, 33006, 33673, 34346, 35026, 35713, 36406, 37106, 37813, 38526, 39246, 39973, 40706, 41446, 42193, 42946, 43706, 44473, 45246, 46026, 46813, 47606, 48406, 49213, 50026, 50846, 51673, 52506, 53346, 54193, 55046, 55906, 56773, 57646, 58526, 59413, 60306, 61206, 62113, 63026, 63946, 64873, 65806, 66746, 67693, 68646, 69606, 70573, 71546, 72526, 73513, 74506, 75506, 76513, 77526, 78546, 79573, 80606, 81646, 82693, 83746, 84806, 85873, 86946, 88026, 89113, 90206, 91306, 92413, 93526, 94646, 95773, 96906, 98046, 99193, 100346, 101506, 102673, 103846, 105026, 106213, 107406, 108606, 109813, 111026, 112246, 113473, 114706, 115946, 117193, 118446, 119706, 120973, 122246, 123526, 124813, 126106, 127406, 128713, 130026, 131346, 132673, 134006, 135346, 136693, 138046, 139406, 140773, 142146, 143526, 144913, 146306, 147706, 149113, 150526, 151946, 153373, 154806, 156246, 157693, 159146, 160606, 162073, 163546, 165026, 166513, 168006, 169506, 171013, 172526, 174046, 175573, 177106, 178646, 180193, 181746, 183306, 184873, 186446, 188026, 189613, 191206, 192806, 194413, 196026, 197646, 199273, 200906, 202546, 204193, 205846, 207506, 209173, 210846, 212526, 214213, 215906}

alt_experiencetable[3] = {10, 20, 40, 70, 110, 160, 220, 290, 370, 460, 560, 670, 790, 920, 1060, 1210, 1370, 1540, 1720, 1910, 2110, 2320, 2540, 2770, 3010, 3260, 3520, 3790, 4070, 4360, 4660, 4970, 5290, 5620, 5960, 6310, 6670, 7040, 7420, 7810, 8210, 8620, 9040, 9470, 9910, 10360, 10820, 11290, 11770, 12260, 12760, 13270, 13790, 14320, 14860, 15410, 15970, 16540, 17120, 17710, 18310, 18920, 19540, 20170, 20810, 21460, 22120, 22790, 23470, 24160, 24860, 25570, 26290, 27020, 27760, 28510, 29270, 30040, 30820, 31610, 32410, 33220, 34040, 34870, 35710, 36560, 37420, 38290, 39170, 40060, 40960, 41870, 42790, 43720, 44660, 45610, 46570, 47540, 48520, 49510, 50510, 51520, 52540, 53570, 54610, 55660, 56720, 57790, 58870, 59960, 61060, 62170, 63290, 64420, 65560, 66710, 67870, 69040, 70220, 71410, 72610, 73820, 75040, 76270, 77510, 78760, 80020, 81290, 82570, 83860, 85160, 86470, 87790, 89120, 90460, 91810, 93170, 94540, 95920, 97310, 98710, 100120, 101540, 102970, 104410, 105860, 107320, 108790, 110270, 111760, 113260, 114770, 116290, 117820, 119360, 120910, 122470, 124040, 125620, 127210, 128810, 130420, 132040, 133670, 135310, 136960, 138620, 140290, 141970, 143660, 145360, 147070, 148790, 150520, 152260, 154010, 155770, 157540, 159320, 161110, 162910, 164720, 166540, 168370, 170210, 172060, 173920, 175790, 177670, 179560, 181460, 183370, 185290, 187220, 189160, 191110, 193070, 195040, 197020, 199010, 201010, 203020, 205040, 207070, 209110, 211160, 213220, 215290, 217370, 219460, 221560, 223670, 225790, 227920, 230060, 232210, 234370, 236540, 238720, 240910, 243110, 245320, 247540, 249770, 252010, 254260, 256520, 258790, 261070, 263360, 265660, 267970, 270290, 272620, 274960, 277310, 279670, 282040, 284420, 286810, 289210, 291620, 294040, 296470, 298910, 301360, 303820, 306290, 308770, 311260, 313760, 316270, 318790, 321320, 323860}

skillexptable = alt_experiencetable[skill or 3]

AllyHurt = {} -- Does the character respond after an ally is hurt?

CharKilled = {} -- Does the character have one last resort if he/she gets killed?

APRegen = {}

AfterAttack = {} -- Some characters may perform another action after attacking. What will it be?
--[[ Removed as an other method was used now
function statup(charID,stat,roll,alrange,up)
local r = Math.Rand(1,roll)
local ak,i
for ak,i in ipairs(alrange) do
	if i==r then 
	   char[charID][stat] = char[charID][stat] + up
	   if char[charID][stat]>999 then
	   	char[charID][stat] = 999
	   	end
	   end
	end
end

function HPup(charID,num)
local p = char[charID].HP[1] / char[charID].HP[2]
char[charID].HP[2] = char[charID].HP[2] + num
char[charID].HP[1] = char[charID].HP[2] * p
end
-- ]]

function GrabLevelStats(charID,newlv)
local bt = JCR5.Open('Data/LvStats/'..charID)
local lvl
local line
local splitline
local statname
local value
local r = 14
local g = 29 * 2
local b = 78 * 2
local lv = newlv or char[charID].Level or 1
local lvl = -100
char[charID] = char[charID] or {}
Console.Write('Putting character '..charID..' to level '..sval(lv),r,g,b)
while JCR5.Eof(bt)==0 do
      line = Str.Trim(JCR5.ReadLn(bt))
      -- CSay('line = '..line)
      if Str.Left(line,6)=='LEVEL ' then lvl = Sys.Val(Str.Right(line,Str.Length(line)-6)) end
      -- CSay('level is '..lvl..' and must be ..'..lv)
      if lv==lvl then
         splitline = split(line,' ')
	 -- for ak,v in ipairs(splitline) do CSay(ak..' = "'..v..'"') end
	 if Str.Left(splitline[1],5)=='STAT.' then
	    statname = Str.Right(splitline[1],Str.Length(splitline[1])-5)
	    value = Sys.Val(splitline[2])
	    if statname=='HP' then
	       if char[charID].HP then char[charID].HP[2] = value end
	       char[charID].HP = char[charID].HP or {value,value}
	       else
	       char[charID][statname] = value
	       end
	    Console.Write('Stat "'..statname..'" is now: '..value,r,g,b)
	    end
	 end
      end
JCR5.Close(bt)      
char[charID].Level = lv
end

function __consolecommand.AFTERATTACKS()
local ch,f
for ch,f in spairs(AfterAttack) do
    Console.Write("= "..type(f).." "..ch,30,30,255)
    end
end


function __consolecommand.RELOADCHAR(c)
if not setupchar[c[1]] then
  Console.Write("? Requested charcter does not appear to exist",255,0,0)
  return
  end
setupchar[c[1]]()
Console.Write("Character "..c[1].." is succesfully reloaded!",0,255,0)
end

function __consolecommand.LSCHARS()
Console.Write("- The next characters can be loaded:",Math.Rand(0,255),Math.Rand(0,255),Math.Rand(0,255))
local r = Math.Rand(0,255)
local g = Math.Rand(0,255)
local b = Math.Rand(0,255)
local i,f
for i,f in pairs(setupchar) do
    Console.Write("  = "..i,r,g,b)
    end
end

function __consolecommand.CHARS()
local ak,ch,data
CSay("- Current party")
for ak,ch in pairs(party) do
    CSay("  = "..ch)
    end
CSay("- Loaded characters")
for ch,data in pairs(char) do
    CSay("  = "..ch)
    end
end  

function __consolecommand.SHOWEQUIP(ca)
local c = ca[1]
if (not c) or (c=='') then c="*ALL*" end
local k,v
if not equip then Console.Write("? No equipment loaded at all",255,0,0) return end
if Str.Upper(c)=="*ALL*" then
   Console.Write("Showing the equipment of ALL loaded characters",255,0,255)
   for k,v in pairs(equip) do
       __consolecommand.SHOWEQUIP({k})
       return
       end
   end    
if not equip[c] then Console.Write("? No equipment loaded at character "..c,255,0,0) return end
Console.Write("- Equipment: "..c,0,255,255)
for k,v in pairs(equip[c]) do
    Console.Write("  = "..k.." :> "..v,255,255,0)
    end
end    


function TrueNewParty(partystring)
local f = loadstring('return {'..partystring..'}')
party = f()
activecharacter = party[1] -- Always make the first party member the active one or things may go a little crazy!s
local ak,ch
for ak,ch in pairs(party) do
    if not char[ch] then
       if not setupchar[ch] then Sys.Error("Request made to make a non-existent character join the party","Char,"..sval(ch)) end 
       setupchar[ch]() 
       end
    end
end    

function Teach(ch,ability)
CSay("Teach('"..ch.."','"..ability.."')")
teachlist[ch] = teachlist[ch] or {}
char[ch].Abilities = char[ch].Abilities or {}
if tablecontains(teachlist[ch],ability) or tablecontains(char[ch].Abilities,ability) then 
   Console.Write(ch.." already has the ability "..ability.." so let's skip this, shall we?",50,250,150)
   return 
   end
table.insert(teachlist[ch],Str.Upper(ability))
Console.Write("\""..ability.."\" has been added to "..ch.."'s teachlist",50,150,250)
end    

function AutoTeach(ch,ablist)
local abl,skl,lv,sk
CSay("AutoTeach in action!")
for abl,skl in spairs(ablist) do 
    CSay("Checking: "..abl)
    if char[ch].SkillLevels[skl[1]] and char[ch].SkillLevels[skl[1]]>=skl[2] then
        Teach(ch,abl)
        else
        CWrite("SPELL: "..abl.." REJECTED!",255,0,0)
        end
    end
end

function PartyAllTo1()
local ch
for _,ch in pairs(party) do char[ch].HP[1] = 1 end
end

function __consolecommand.TEACHLIST()
local ch,tl
local idx,ablc
for ch,tl in pairs(teachlist) do
    for idx,ablc in ipairs(teachlist) do
        Console.Write(ch.." has the ability "..ablc.." queued in his or her teachlist on place #"..idx,255,180,20)
        end
    end
end

function __consolecommand.SETSKILL(a)
local ch = a[1]
local sk = Sys.Val(a[2])
local lv = Sys.Val(a[3])
if ch=="" or (not sk) or (not lv) then 
   Console.Write("?ERROR! Invalid number of command arguments",255,0,0)
   return
   end
if not char[ch] then
   Console.Write("?ERROR! Character "..ch.." does not exist!",255,0,0)
   return
   end   
if not char[ch].SkillLevels[sk] then 
   Console.Write("?ERROR! "..ch.." does not have a skill with that number!",255,0,0)
   return
   end   
char[ch].SkillLevels[sk] = lv   
end


function LevelAbsenceUpdate(ch,ch2,sv)
local ol = CVV(sv)
local il = char[ch2].Level - ol
if char[ch].Level<49 then
   CSay(ch.." was level "..char[ch].Level)
   char[ch].Level = char[ch].Level + il
   if char[ch].Level>49 then char[ch].Level = 49 end
   CSay(ch.." is now level "..char[ch].Level)
   GrabLevelStats(ch,char[ch].Level)
   end
end

lvupcol = {
   Eric        = {{255,180,0},{255,255,0}},
   Irravonia   = {{255,0,0},{255,180,0}},
   Brendor     = {{255,180,0},{180,180,180}},
   Scyndi      = {{0,255,0},{255,0,255}},
   Rebecca     = {{255,180,0},{50,180,25}},
   Dernor      = {{0,255,0},{0,100,0}},
   Merya       = {{180,0,255},{90,0,128}},
   Aziella     = {{255,180,180},{128,90,90}},
   NoChar      = {{255,255,255},{0,0,0}}
}
