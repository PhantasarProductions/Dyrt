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
 



Version: 14.03.27

]]
function setupchar.YoungIrravonia()
char.YoungIrravonia = 
  {
  ["Name"] = "$IRRAVONIA",  
  ["Strength"] = 10,
  ["Defense"] = 9,
  ["Intelligence"] = 15,
  ["Resistance"] = 14,
  ["Accuracy"] = 10,
  ["Evasion"] = 5,
  ["Agility"] = 8,
  ["Experience"] = nil,   -- This will cause Young Irravonia not to level at all. In her adult state she will gain experience points.
  ["Level"] = 1,
  ["HP"] = {30,30},
  ["Abilities"] = nil,    -- This will make Young Irravonia unable to cast any spells.
  ["SkillNames"] = {"Twiggy Skill"},
  ["SkillLevels"] = {1},
  ["SkillExperience"] = {nil}, -- Young Irravonia cannot gain experience in her skills.
  ["SkillFP"] = {0},  
  }
equip.YoungIrravonia = 
  {
  ["WEAPON"] = "EQ_YI_WP_TWIG",
  ["ARMOR"]  = "EQ_YI_AR_DRESS",
  ["JEWEL"]  = nil
  }
end

function levelup.YoungIrravonia()
Sys.Error("Hey, smartass, how could you level up with a character blocked from that?")
end

