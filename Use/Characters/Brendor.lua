--[[
/**********************************************
  
  (c) Jeroen Broks, 2014, All Rights Reserved.
  
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
 



Version: 14.09.17

]]

-- @IF IGNOREME
-- All these definitions will be ignored by GALE, but my IDE won't and so I can fool it so it outlines this script the way it should :P
setupchar = {}
char = {}
equip = {}
resistance = {}
APRegen = {}
skilllevelup = {}
PersonalAction = {}
charwalk = {}
-- @FI

function setupchar.Brendor()
char.Brendor = 
  {
  ["Name"] = "$BRENDOR",  
  ["Abilities"] = {}, 
  ["SkillNames"] = {"Hammer Skills"},
  ["SkillLevels"] = {1},
  ["SkillExperience"] = {0}, 
  ["SkillFP"] = {0},  
  ["Experience"] = 4100,
  ["Victory"] = "I'm sorry, this had to be done.",
  ["Perfect"] = "Was this really necessary?",
  ["VicDead"] = "That was quite a battle"
  }
equip.Brendor = 
  {
  ["WEAPON"] = "EQ_BR_WP_HAMMER",
  ["ARMOR"]  = "EQ_SY_AR_ARMOR",
  ["JEWEL"]  = nil
  }
resistance.Brendor =
  {
  ["FIRE"]          = 0,
  ["WIND"]          = 0,
  ["WATER"]         = -.25 * skill,
  ["EARTH"]         = 0,
  ["LIGHT"]         = 0,
  ["DARKNESS"]      = 0,
  ["THUNDER"]       = 0,
  ["FROST"]         = 0,
  ["STPOISON"]      = 0,
  ["STPARALYSIS"]   = 0,
  ["STSLEEP"]       = 0,
  ["STCONFUSION"]   = 0.15,
  ["STSILENCE"]     = 0,
  ["STEXHAUST"]     = 0.90 / skill,
  ["STFEAR"]        = 0.30 - (skill*0.1),
  ["STCURSE"]       = 0.20,
  ["STDEATH"]       = 0.20 - (skill*0.05),
  ["STDESTRUCTION"] = 0.30 / skill
  }
GrabLevelStats('Brendor',25-(skill*5))  
end

APRegen.Brendor = {
    
    Interval = 9000,
    Time = 20000,
    AP = function()
         return 4-skill
         end   
    }

function CharKilled.Brendor()
if upper(Foe[8])=="RONDOMO1" then return end -- Don't get up when Rondomo is the opponent. It's pretty useless anyway :)
BrendorKilled = BrendorKilled or skill
if rand(1,BrendorKilled)==1 then
   char.Brendor.HP[1]=1
   if rand(1,5-skill)~=1 then BrendorKilled = BrendorKilled + rand(1,skill) end
   SerialBattleBoxText("Combat/BrendorGuts.lng","GUTS")  
   end
end

function skilllevelup.Brendor(skillnr)
CSay('Debug: Yeah, Brendor goes a level up in skill: '..skillnr)
char.Brendor.TrophySkill = {"FIGHT"}
local spells = {
      ["SUPASMASH"] = {1,10}
      }
AutoTeach('Brendor',spells)
end

function PersonalAction.Brendor()
if not MoveBlocks[OldZone] then return end
local bl 
local dir = {
                North = { X =  0, Y = -1},
                South = { X =  0, Y =  1},
                East  = { X =  1, Y =  0},
                West  = { X = -1, Y =  0}
            }
local px,py,pw = PlayerCoords()
local X,Y            
for _,bl in ipairs(MoveBlocks[OldZone]) do
    if bl.cx == px + dir[pw].X and bl.cy == py + dir[pw].Y then
       X,Y = bl.cx+dir[pw].X,bl.cy+dir[pw].Y
       if Maps.LayerValue(X,Y,"Zone_Visibility")==bl.zone and (Maps.VBlockMap(X,Y)==0) then 
          bl.cx = bl.cx + dir[pw].X
          bl.cy = bl.cy + dir[pw].Y
          bl.fx = dir[pw].X*32
          bl.fy = dir[pw].Y*32
          end
       end 
    end
MoveBlocksBlockMap()
end
