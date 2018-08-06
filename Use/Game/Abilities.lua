--[[
/* 
  Abilities - Dyrt

  Copyright (C) 2013, 2014 JP Broks
  
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
function Abil_Init()
CSay(" { Abilities = FetchDataBase('Data/Abilities') } ")
QDFetchDebug = true
Abilities = FetchDataBase('Data/Abilities')
QDFetchDebug = false
CSay(" Done! ")
end

function Abil_List(ch,CanCast)
Key.Flush()
local P = 1
local PM = 0
local ak,abl,y,abc,abi
local allow
local allowcurrent
local mx,my,omx,omy
omx,omy = mousepos(0)
-- Can we actually use spells, if not, then get outta here!
if not char[ch].Abilities then return nil end
if not char[ch].Abilities[1] then return nil end
repeat
-- Keys
if CancelKeyHit() or Mouse.Hit(2)==1 then SFX('SFX/General/GameMenu/Cancel.ogg'); return nil end
if (KeyHit(KEY_UP)   or joydirhit('N')) and P>1 then SFX('SFX/General/GameMenu/ChangeSelection.ogg'); P=P-1 end
if (KeyHit(KEY_DOWN) or joydirhit('S')) and char[ch].Abilities[P+1] then SFX('SFX/General/GameMenu/ChangeSelection.ogg'); P=P+1 end
-- Base draw
Image.Cls()
if config.bttrans then Image.SetAlpha(.5) end
ARColor(config.btback)
Image.Rect(0,0,800,600)
Image.SetAlpha(1)
Image.Color(0,0,0)
GameMenuPartyMember(ch,550,10,false,CanCast)
ARColor(config.btfont)
-- Lines
Image.Line(  1,  1,798,  1) -- U
Image.Line(798,  1,798,598) -- R
Image.Line(  1,598,798,598) -- D
Image.Line(  1,  1,  1,598) -- L
Image.Line(  1,570,798,570) -- Div
-- Abilities
Image.ViewPort(10,10,700,560)
Image.Origin(10,10)
allowcurrent=false
mx,my = mousepos()
for ak,abl in ipairs(char[ch].Abilities) do
    -- Determine position on screen
    y = ((ak-1)*20)-PM
    if y>500 then PM=PM+1 end
    if y<0 then PM=PM-1 end
    -- Select by mouse
    if omx~=mx or omy~=my then
       if my>(y+10)-15 and my<(y+10)+15 then 
          P=ak 
          omx = mx
          omy = my
          end
       end   
    -- ABility Code
    abc = Str.Upper("CH_"..ch.."_"..char[ch].Abilities[ak])
    -- If we can cast then let us see which spells we may cast
    allow = true
    if ak==P then allowcurrent=allow end
    if CanCast then
       if not char[ch] then Sys.Error("Impossible error: Char is empty in ability selector ("..sval(ch)..")") end
       if not Abilities[abc] then Sys.Error("Impossible error: Nil for spell ("..sval(ch)..")") end
       if char[ch].AP[1]<Abilities[abc].APCost then allow = false end
       end
    -- Spell Icons    
    AbilIcons = AbilIcons or {}
    -- CSay(abc)
    if not Abilities[abc] then 
       Image.ViewPort(0,0,800,600)
       Image.Origin(0,0)
       Sys.Error("Ability: "..abc.." does not appear to exist")
       end
    abi = Abilities[abc].Icon
    if not AbilIcons[abi] then AbilIcons[abi] = Image.Load('GFX/SpellIcons/'..abi) end
    Image.Color(255,255,255)
    Image.Draw(AbilIcons[abi],0,y)
    -- Spell Names
    if P==ak then
       Image.Font("Fonts/Coolvetica.ttf",20)
       else
       Image.Font("Fonts/Coolvetica.ttf",15)
       end
    ARColor(config.btfont)
    if not allow then HARColor(config.btfont) end
    DText(Abilities[abc].Name,25,y+10,0,2)
    DText(Abilities[abc].APCost,470,y+10,1,2)    
    end
-- Reset viewport settings    
Image.ViewPort(0,0,800,600)
Image.Origin(0,0)
-- Description
Image.Font('Fonts/Coolvetica.ttf',20)
abc = Str.Upper('CH_'..ch..'_'..char[ch].Abilities[P])
DText(Abilities[abc].Target..": "..Var.S(Abilities[abc].Desc),10,583,0,2)
Flip()
if CanCast and allowcurrent and (ActionKeyHit() or Mouse.Hit(1)==1) then Key.Flush();return Str.Upper("CH_"..ch.."_"..char[ch].Abilities[P]) end
until false
end

function __consolecommand.ABILITIES()
for k,v in spairs(Abilities) do
    Console.Write("- "..k,102,200,104)
    end
end    

-- Kirana will "steal" the next abilities from the party when she's a playable character
function KiranaAbilities()
local kiranaspells = {
  DISPEL='AZIELLA',
  SLEEP='AZIELLA',
  SHIELD='AZIELLA',
  BIOHAZARD='ERIC',
  BLIZZARD='ERIC',
  CORONA='ERIC',
  DEATH='ERIC',
  INFERNO="ERIC",
  POWEREVIL="ERIC",
  VITALIZE="SCYNDI",
  VOID="ERIC",
  ZEROKELVIN="ERIC",
  HURRICANE="IRRAVONIA",
  MEDITATE="IRRAVONIA",
  QUAKE="IRRAVONIA",
  TSUNAMI="IRRAVONIA"  
}
for spell,ochar in spairs(kiranaspells) do
    Abilities["CH_KIRANA_"..spell] = Abilities["CH_"..ochar.."_"..spell]
    CWrite("Kirana copied the spell "..spell.." from "..ochar,0,255,0)
    if not Abilities["CH_KIRANA_"..spell] then CWrite("ERROR! Copying this spell failed!",255,0,0) end
    end
end

function YasatharAbilities()
local k,v,n
for k,v in pairs(Abilities) do
    if Left(k,7)=="CH_ERIC" then
       n = Str.Replace(k,"CH_ERIC","CH_YASATHAR")
       Abilities[n] = v 
       CWrite("Yasathar has copied "..k.." into "..n,0,0,255)
       end
    end   
end
