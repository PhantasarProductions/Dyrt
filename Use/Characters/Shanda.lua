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
 



Version: 14.03.27

]]

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
 



Version: 14.01.22

]]
function setupchar.Shanda()
char.Shanda = 
  {
  ["Name"] = "Queen Shanda",  
  ["Abilities"] = nil, 
  ["SkillNames"] = {"Scepter Skills"},
  ["SkillLevels"] = {30/skill},
  ["SkillExperience"] = {nil}, 
  ["SkillFP"] = {1},  
  ["Experience"] = nil,
  ["Victory"] = "...",
  ["Perfect"] = "....",
  ["VicDead"] = "......"
  }
equip.Shanda = 
  {
  ["WEAPON"] = "EQ_SH_WP_SCEPTRE",
  ["ARMOR"]  = "EQ_SH_AR_QUEENGOWN",
  ["JEWEL"]  = nil
  }
resistance.Shanda =
  {
  ["FIRE"]          = .30/skill,
  ["WIND"]          = .24/skill,
  ["WATER"]         = .18/skill,
  ["EARTH"]         = .12/skill,
  ["LIGHT"]         = .06/skill,
  ["DARKNESS"]      = .60/skill,
  ["THUNDER"]       = .18/skill,
  ["FROST"]         = (rand(1,10)*0.06)/skill,
  ["STPOISON"]      = 0.15,
  ["STPARALYSIS"]   = 0.25,
  ["STSLEEP"]       = 0.70,
  ["STCONFUSION"]   = 0.35,
  ["STSILENCE"]     = 1,
  ["STEXHAUST"]     = 0.12,
  ["STFEAR"]        = 0.30 - (skill*0.1),
  ["STCURSE"]       = 0.10,
  ["STDEATH"]       = 0.60 - (skill*0.2),
  ["STDESTRUCTION"] = 0.80 - (skill*0.25)
  }
GrabLevelStats('Shanda',30/skill)  
end



function levelup.Shanda()
Sys.Error("Cheating with poor queen Shanda. How dare you!?")
end
