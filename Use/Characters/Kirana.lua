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
 



Version: 14.09.13

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

function setupchar.Kirana()
local lmax = {250,100,50}
char.Kirana = 
  {
  ["Name"] = "Kirana",
  ["Abilities"] = {'DISPEL',"SLEEP","SHIELD","BIOHAZARD","BLIZZARD","CORONA","DEATH","INFERNO","POWEREVIL","VITALIZE","VOID","ZEROKELVIN","HURRICANE","MEDITATE","QUAKE","TSUNAMI"},
  --["AblTime"] = {10,10,10,10},
  ["SkillNames"] = {"Scythe Skills","Sorcery"},
  ["SkillLevels"] = {lmax[skill],lmax[skill]},
  ["SkillExperience"] = {}, 
  ["Experience"] = nil,
  ["SkillFP"] = {10,10},
  ["Victory"] = "Die! You filthy freaks!",
  ["Perfect"] = "Of course you didn't stand a chance!",
  ["VicDead"] = "Don't ever come near me!"  
  }
table.sort(char.Kirana.Abilities)  
equip.Kirana = 
  {
  ["WEAPON"] = "KIRANA_SCYTHE",
  ["ARMOR"]  = "EQ_AZ_AR_TOGA",
  ["JEWEL"]  = nil  
  }  
resistance.Kirana =
  {
  ["FIRE"]          = 1,
  ["WIND"]          = 1,
  ["WATER"]         = 1,
  ["EARTH"]         = 1,
  ["LIGHT"]         = 1,
  ["DARKNESS"]      = 2,
  ["THUNDER"]       = 1,
  ["FROST"]         = 1,
  ["STPOISON"]      = 0.2,
  ["STPARALYSIS"]   = 1,
  ["STSLEEP"]       = 1,
  ["STCONFUSION"]   = 1, 
  ["STSILENCE"]     = 1,
  ["STEXHAUST"]     = 1,
  ["STFEAR"]        = 0,
  ["STCURSE"]       = 1,
  ["STDEATH"]       = 1,
  ["STDESTRUCTION"] = 1
  }
GrabLevelStats('Kirana',lmax[skill])     
char.Kirana.HP[1]=1
end  

APRegen.Kirana = {
    
    Interval = 350*(skill or 3),
    Time = 15000,
    AP = function()
         local r={100,50,0}         
         return r[skill]
         end   
    }
