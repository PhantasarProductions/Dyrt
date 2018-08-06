--[[
/**********************************************
  
  (c) Jeroen Broks, 2013, 2014, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is stricyly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.

  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************/
 



Version: 14.10.22

]]



-- @IF IGNOREME
-- All these definitions will be ignored by GALE, but my IDE won't and so I can fool it so it outlines this script the way it should :P
setupchar = {}
char = {}
equip = {}
resistance = {}
APRegen = {}
-- skilllevelup = {}
-- @FI


-- Standard Eric
function setupchar.Eric()
char.Eric = 
  {
  ["Name"] = "$ERIC",  
  ["Abilities"] = nil,    -- Eric starts without any spells, this will change later in the game.
  ["SkillNames"] = {"Sword Skills"},
  ["SkillLevels"] = {1},
  ["SkillExperience"] = {0}, 
  ["SkillFP"] = {1,1,1,1,1},  
  ["Experience"] = 410,
  ["Victory"] = "Haha! You can't beat me",
  ["Perfect"] = "Yeah, that shows who's the strongest around here!",
  ["VicDead"] = "$REBECCA! Keep your lectures to yourself, will ya!?"
  }
equip.Eric = 
  {
  ["WEAPON"] = "EQ_SY_WP_SHORTSWORD",
  ["ARMOR"]  = "EQ_SY_AR_ARMOR",
  ["JEWEL"]  = nil
  }
resistance.Eric =
  {
  ["FIRE"]          = 0,
  ["WIND"]          = 0,
  ["WATER"]         = 0,
  ["EARTH"]         = 0,
  ["LIGHT"]         = 0,
  ["DARKNESS"]      = 0,
  ["THUNDER"]       = 0.25,
  ["FROST"]         = 0,
  ["STPOISON"]      = 0,
  ["STPARALYSIS"]   = 0.25,
  ["STSLEEP"]       = 0,
  ["STCONFUSION"]   = 0.05,
  ["STSILENCE"]     = 0,
  ["STEXHAUST"]     = 0.12,
  ["STFEAR"]        = 0.30 - (skill*0.1),
  ["STCURSE"]       = 0.10,
  ["STDEATH"]       = 0.60 - (skill*0.2),
  ["STDESTRUCTION"] = 0.80 - (skill*0.25)
  }
GrabLevelStats('Eric',5)  
end

APRegen.Eric = {
    
    Interval = 1000,
    Time = 10000,
    AP = function() return math.floor(char.Eric.Level / (skill*5)) end
    
    }


-- Coup de Grace
function AfterAttack.Eric(TACT)
local TARGET = TACT.Target
CSay("- Coup de Grace")
if TACT["TargetGroup"] == 'Player' or TACT["TargetGroup"] == 'Players' or TACT["TargetGroup"] == 'Hero' or TACT["TargetGroup"] == 'Heroes' then
   G = 'Player'   
   return -- No Coup de Grace on players when confused.
   end
if FoeData[TARGET].HP == 0 then 
   CSay("  = Rejected - Enemy is already dead")
   return
   end   
if FoeData[TARGET].HP > FoeData[TARGET].HPMax*.15 then
   CSay("  = Rejected - Enemy not yet below 15% health")
   return
   end
if FoeData[TARGET].Boss and Foe[TARGET]~="DZGJYMZA" then
   CSay("  = Rejected - Boss enemy which is not lord DZGJYMZA")   
   return
   end
local chnEric
for ak=1,4 do
    if party[ak]=='Eric' then chnEric = ak end
    end
Combat_Message("Coup de Grace")    
Combat_SpriteInAction("Player",chnEric,1) 
Combat_KillFoe(TARGET)
Combat_SpriteInAction("Player",chnEric,2)
end

function skilllevelup.Eric(skillnr)
CSay('Debug: Yeah, Eric goes a level up in skill: '..skillnr)
char.Eric.TrophySkill = {"FIGHT","FIRE","POISON","ICE","DARK"}
if char.Yasathar then char.Yasathar.TrophySkill = char.Eric.TrophySkill end
local ch = "Eric"
if CVV("&ERIC=YASATHAR") then ch="Yasathar" end
local spells = {
      ['FLAME']         = { 2,  1 },
      ['FIREBLAST']     = { 2,  8 },
      ['INFERNO']       = { 2, 16 },
      ['CORONA']        = { 2, 25 },
      ['BIO']           = { 3,  1 },
      ['NEUTRALPOISON'] = { 3, 10 },
      ['VITALIZE']      = { 3, 20 },
      ['BIOHAZARD']     = { 3, 30 },
      ['FROST']         = { 4,  1 },
      ['FREEZE']        = { 4,  5 },
      ['BLIZZARD']      = { 4, 10 },
      ['ZEROKELVIN']    = { 4, 20 },
      ['DARKNESS']      = { 5,  1 },
      ['VOID']          = { 5,  5 },
      ['POWEREVIL']     = { 5, 10 },
      ['DARKVISION']    = { 5, 20 },
      ['DEATH']         = { 5, 12 },
      ['DISINTEGRATE']  = { 5, 18 }
      }
AutoTeach(ch,spells)
local resup = {'BLAHBLAH','FIRE','STPOISON','FROST','DARKNESS'}
if skillnr>1 and skillnr<6 then
   local r = rand(1,100)
   if r>skill*30 or (skillnr==3 and skill~=3) then 
      resistance[ch][resup[skillnr]] = resistance[ch][resup[skillnr]] + 0.01
      if resistance[ch][resup[skillnr]]>1 then resistance[ch][resup[skillnr]]=1 end
      end 
   end   
CSay("Eric level up has been done!")
end

function levelup.Eric()
end

-- Yasathar's power in Eric revealed

function setupchar.Yasathar()
char.Yasathar = char.Eric
char.Yasathar.Victory = "Feel my wrath!"
char.Yasathar.VicDead = "Setbacks won't stop me!"
char.Yasathar.Perfect  = "You shouldn't have challenged me!"
AddItem(equip.Eric.WEAPON)
AddItem(equip.Eric.ARMOR)
equip.Yasathar = {
   WEAPON = "EQ_YASATHAR_BLUEMOON",
   ARMOR  = "EQ_YASATHAR_BLUEARMOR",
   JEWEL  = equip.Eric.JEWEL
   }
local k,v
resistance.Yasathar = {}
local mul = { 2, 1.5, 1 }
for k,v in pairs(resistance.Eric) do
    resistance.Yasathar[k] = v*mul[skill]
    if resistance.Yasathar[k]>1 then resistance.Yasathar[k]=1 end 
    end   
AutoTeach("Yasathar",{YASBLESS = {1,1}})    
GrabLevelStats('Yasathar',char.Yasathar.Level)  
end

AfterAttack.Yasathar = AfterAttack.Eric
skilllevelup.Yasathar = skilllevelup.Eric

function PersonalAction.Yasathar()
if not CVV("&ERIC.RED_STAFF") then return end
local x,y,w = PlayerCoords()
local r=0
local d=1
local her=0
repeat
r=r+d
if     r==25  then d=-1
elseif r==0   then d=1; her=her+1 end
DrawScreen()
Image.SetAlpha(r/100)
Image.Color(255,0,0)
Image.Rect(0,0,800,600)
Image.SetAlpha(1)
Flip()
until her==3
-- @IF DEVELOPMENT
__consolecommand.REDSEALS()
CWrite("x = "..x,0,180,255)
CWrite("y = "..y,0,180,255)
CWrite("BossDone = "..sval(CVV("&REDSEAL."..Maps.MapName)),0,180)
-- @FI 
if MapSealedBoss and MapSealedBoss.X==x and MapSealedBoss.Y==y and (not(CVV("&REDSEAL."..Maps.MapName))) then
   OpenRedSeal()
   else
   RandomEncounters(true)
   end
end
