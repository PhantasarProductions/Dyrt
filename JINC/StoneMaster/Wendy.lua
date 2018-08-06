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
 



Version: 14.10.14

]]
local ret = {}
table.insert(ret,{ type='skill', skill=1, char='Eric', charlist = {'Eric',"Yasathar",'Rebecca'}})
if Var.C("&ERIC=YASATHAR")=="TRUE" then table.remove(ret[1].charlist,1) end
--[[
lst = {"Brendor","Scyndi"}
if Var.C("&JOINED.DERNOR" ) then table.insert(lst,"Dernor" ) end
if Var.C("&JOINED.MERYA"  ) then table.insert(lst,"Merya"  ) end
if Var.C("&JOINED.AZIELLA") then table.insert(lst,"Aziella") end
]]
local lst = {"Brendor","Scyndi","Dernor","Merya","Aziella"}
for _,l in ipairs(lst) do
    table.insert(ret,{ type='skill', skill=1, char=l})
    end
return ret    
