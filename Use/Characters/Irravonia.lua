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
 



Version: 14.08.05

]]
function setupchar.Irravonia()
char.Irravonia = 
  {
  ["Name"] = "$IRRAVONIA",
  ["Strength"] = 10,
  ["Defense"] = 9,
  ["Intelligence"] = 15,
  ["Resistance"] = 14,
  ["Accuracy"] = 10,
  ["Evasion"] = 5,
  ["Agility"] = 8,
  ["Experience"] = Math.Rand(10,200),
  -- ["Level"] = 1,
  -- ["HP"] = {35,35},
  ["Abilities"] = {"Flame","Breeze","Heal","LittleRock"},
  ["AblTime"] = {10,10,10,10},
  ["SkillNames"] = {"Wand Waving Skills","Fire Magic","Wind Magic","Water Magic","Earth Magic"},
  ["SkillLevels"] = {1,1,1,1,1},
  ["SkillExperience"] = {0,0,0,0,0}, 
  ["SkillFP"] = {0,2,2,2,2},
  ["Victory"] = "Neeeh-neh neneeeh-neh!",
  ["Perfect"] = "Oh? Did I hurt you?",
  ["VicDead"] = "Ouch! We must be more careful next time!"  
  }
equip.Irravonia = 
  {
  ["WEAPON"] = "EQ_IR_WP_WAND",
  ["ARMOR"]  = "EQ_IR_AR_DRESS",
  ["JEWEL"]  = nil  
  }
resistance.Irravonia =
  {
  ["FIRE"]          = 0.10,
  ["WIND"]          = 0.10,
  ["WATER"]         = 0.10,
  ["EARTH"]         = 0.10,
  ["LIGHT"]         = 0,
  ["DARKNESS"]      = 0,
  ["THUNDER"]       = 0,
  ["FROST"]         = 0,
  ["STPOISON"]      = 0,
  ["STPARALYSIS"]   = 0.05,
  ["STSLEEP"]       = 0,
  ["STCONFUSION"]   = 0.09,
  ["STSILENCE"]     = 0.75 - (skill*0.25),
  ["STEXHAUST"]     = 0.18 - (skill*0.06),
  ["STFEAR"]        = 0.30 - (skill*0.10),
  ["STCURSE"]       = 0.05,
  ["STDEATH"]       = 0.60 - (skill*0.2),
  ["STDESTRUCTION"] = 0.70 - (skill*0.2)
  }
  
-- Earlier stats are due to an earlier setup and I was too lazy to remove them :Ps  
GrabLevelStats('Irravonia',3)  
end

APRegen.Irravonia = {
    
    Interval = 800,
    Time = 10000,
    AP = function()
         local s = char.Irravonia.Level
         local ak,v
         for ak,v in ipairs(char.Irravonia.SkillLevels) do s = s + v end
         return math.floor(s / (skill*7.5))
         end
    
    }



function levelup.Irravonia()
--[[ Old stuff, no longer needed
statup("Irravonia","Strength",6,{1},1)
statup("Irravonia","Defense",6,{1},1)
statup("Irravonia","Intelligence",10,{1,2,3,4},2)
statup("Irravonia","Resistance",10,{1,2,3,4},2)
statup("Irravonia","Accuracy",10,{1,9},1)
statup("Irravonia","Evasion",10,{1,8,9},1)
statup("Irravonia","Agility",3,{1},2)
HPup("Irravonia",3)
]]
end

function skilllevelup.Irravonia(skillnr)
CSay('Debug: Yeah, Irravonia goes a level up in skill: '..skillnr)
char.Irravonia.TrophySkill = {"FIGHT","FIRE","WIND","WATER","EARTH"}
-- 1 Weapon
-- 2 Fire
-- 3 Wind
-- 4 Water
-- 5 Earth
local spells = {
      ['SPLASH']        = { 4,  5 },
      ['TSUNAMI']       = { 4,  8 },
      ['QUAKE']         = { 5,  8 },
      ['FIREBLAST']     = { 2,  8 },
      ['HURRICANE']     = { 3,  8 },
      ['INFERNO']       = { 2, 16 },
      ['BLOWAWAY']      = { 3,  6 },
--    ['INVINCIBILITY'] = { 5, 50 }
      }
AutoTeach('Irravonia',spells)
if char.Irravonia.SkillLevels[2]>=10 and char.Irravonia.SkillLevels[3]>=10 and char.Irravonia.SkillLevels[4]>=10 and char.Irravonia.SkillLevels[5]>=10 then
   Teach('Irravonia','MEDITATE')
   end
local resup = {'BLAHBLAH','FIRE','WIND','WATER','EARTH'}
if skillnr>1 and skillnr<6 then
   local r = rand(1,100)
   if r>skill*30 then 
      resistance.Irravonia[resup[skillnr]] = resistance.Irravonia[resup[skillnr]] + 0.01
      if resistance.Irravonia[resup[skillnr]]>1 then resistance.Irravonia[resup[skillnr]]=1 end
      end 
   end   
end

function PersonalAction.Irravonia()
-- Fly me to the moon
Actors.Pick("Player")
local x = Actors.PA_X()
local y = Actors.PA_Y()
local w = Actors.PA_Wind()
local fx,fy = GetFrontCoords(x,y,w)
local z = Maps.LayerValue(fx,fy,"Zone_Visibility")
local z2
local mx,my
local ww,k,ok
if not IrravoniaFlyZone[z] then
   for k,ww in ipairs({"North","South","East","West"}) do -- If not facing a hole, look around for one.
       fx,fy = GetFrontCoords(x,y,ww)
       z = Maps.LayerValue(fx,fy,"Zone_Visibility")
       if IrravoniaFlyZone[z] then
          Actors.ChoosePic("Irravonia."..ww)          
          w=ww; 
          ok=true 
          end
       end
   -- SFX("IRRASAYSNO")
   if not ok then return end
   end
-- @SELECT w
-- @CASE 'North'
   mx = x 
   my = y - 3
-- @CASE 'South'
   mx = x
   my = y + 3
-- @CASE 'East'
   mx = x + 3
   my = y
-- @CASE 'West'
   mx = x - 3
   my = y
-- @DEFAULT
   Sys.Error("Unknown wind direction. Can't determine where Irravonia has to fly to!","WIND,"..w)
-- @ENDSELECT
z2 = Maps.LayerValue(mx,my,"Zone_Visibility")
if z2 == Maps.LayerValue(x,y,"Zone_Visibility") then
   Console.Write("We should now fly to ("..mx..","..my..")  from ("..x..","..y..")",0,255,0)
   Actors.MoveTo(mx,my)
   else
   Console.Write("Can't fly to ("..mx..","..my.."). Zone mismatch: "..z.." <=> "..Maps.LayerValue(x,y,"Zone_Visibility"),255,0,0)
   end   
end

AbilityBreak.Irravonia = true

function AbilityAttackBreak.Irravonia(TACT)
local elem = {"Fire","Wind","Water","Earth"}
local ret = false
local ak,P
local G = "Player"
for ak=1 ,4 do 
    if party[ak]=="Irravonia" then P=ak end
    end
IrraElemBlock = IrraElemBlock or elem[rand(1,4)]
local abl = Abilities[TACT.Ability]
if IrraElemBlock==abl.Element then
   IrraElemBlock = elem[rand(1,4)]
   HurtP[G][P] = "NULLIFY!"
   HurtT[G][P] = 250
   HurtC[G][P] = {255, 255,  255}
   ret = true
   end
return ret   
end
