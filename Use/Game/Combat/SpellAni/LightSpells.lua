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
function LightEffect(GROUP,TARGETS)
local Targets = TARGETS
if type(Targets)~="table" then Targets = {TARGETS} end
local astart = {0,.75}
local acurr 
local aend   = {.75,0}
local astep  = {.05,-.05}
local c
local ak
local trgt
local x,y
local thickness,thickak
for ak=1,#astart do
    for acurr=astart[ak],aend[ak],astep[ak] do
        Combat_DrawScreen()
        for _,trgt in ipairs(Targets) do
            x,y = Combat_TargetSpot(GROUP,trgt)
            thickness = (ak/.75)*2.5
            white()
            Image.SetAlpha(acurr)
            for thickak=-thickness,thickness do
                Image.Line(400-thickak,0,x-thickak,y) 
                end
            end
        Flip()    
        end
    end
end


-- @IF IGNOREME
SpellAni = {}
-- @FI

function SpellAni.Ray(TG,TT,TA)
LightEffect(TA.TargetGroup,TA.Target)
end

function SpellAni.Solaria(TG,TT,TA)
local ak
local Targets = {}
-- @SELECT StN[TA.TargetGroup]
-- @CASE 1
   for ak=1,4 do 
       if party[ak] then table.insert(Targets,ak) end
       end
-- @CASE 2
   for ak=1,9 do
      if Foe[ak] and FoeData[ak] then table.insert(Targets,ak) end
      end
-- @DEFAULT
   Sys.Error("Invalid target group "..TG)
-- @ENDSELECT
LightEffect(TA.TargetGroup,Targets)
end
