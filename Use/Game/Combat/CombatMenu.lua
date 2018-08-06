--[[
/* 
  Combat Menu - Dyrt

  Copyright (C) Jeroen Broks 2013, 2014
  
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
CMCP = { ["ATK"] = {52,52}, ["ITM"] = {0,52}, ["ABL"] = {52,0}, ["GRD"] = {104,52}, ["SWT"] = {52,104} }  -- Screen positions cursor in battle menu.
CMMP = { ["ATK"] = { {103,153},{150,199} },
         ["ITM"] = { { 49,154},{101,199} },
	       ["ABL"] = { {104,103},{152,146} },
	       ["GRD"] = { {152,147},{201,199} },
	       ["SWT"] = { {104,207},{156,251} }}

function Combat_MainMenu(chn)
local ok=false
local choice = "ATK"
local MPC,MPP
local ch
ch = party[chn]
local pic = BoxPic({ Pic = char[ch].Name})
Key.Flush()
repeat
-- @IF DEVELOPMENT
if KeyHit(KEY_NUMMULTIPLY) then 
  Sys.Bye()
  -- LAURA.Console()
  end
-- @FI
-- Keyboard input
if     KeyDown(KEY_UP   ) or joyy()==-1 then choice="ABL"
elseif KeyDown(KEY_LEFT ) or joyx()==-1 then choice="ITM"
elseif KeyDown(KEY_RIGHT) or joyx()== 1 then choice="GRD"
elseif KeyDown(KEY_DOWN ) or joyy()== 1 then choice="SWT"
else                                         choice="ATK" end
-- if     KeyDown(KEY_ENTER) then ok = true end
if ActionKeyHit() then
   if choice=="SWT" then 
      Combat_PartySwitch(chn)
      ch = party[chn]
      pic = BoxPic({ Pic = char[ch].Name})
      else       
      ok=true
      end 
   end
-- Mouse input
for MPC,MPP in pairs(CMMP) do
    if Mouse.X()>MPP[1][1] and Mouse.Y()>MPP[1][2] and Mouse.X()<MPP[2][1] and Mouse.Y()<MPP[2][2] and Mouse.Hit(1)>0 then
       choice = MPC
       ok=true
       end
    end
-- Let's show the icons and stuff
local menx = 250
local meny = 250
Image.Cls()
Combat_DrawScreen()
Image.Color(255,255,255)
if pic then Image.Draw(pic,menx+175,meny+125) end
Image.Draw("C_Menu",menx,meny)
Image.Font("Fonts/Coolvetica.ttf",40)
cmnxp = cmnxp or (menx + (Image.Width("C_Menu")/2))
black()
local ax,ay
for ax=cmnxp-1,cmnxp+1 do for ay=meny-51,meny-49 do Image.DText(Var.S(char[ch]["Name"]),ax,ay,2,0) end end
white()
Image.DText(Var.S(char[ch]["Name"]),cmnxp,meny-50,2,0)
Image.NoFont()
Combat_ShowInfo('Hero',chn)
-- Let's show the keyboard cursor
allow = 1
if (not char[ch].Abilities) and (choice=="ABL") then allow=0 end
if (not party[5]) and (choice=="SWT") then allow=0 end
Image.Draw("C_MCursor",(menx-4)+CMCP[choice][1],(meny-4)+CMCP[choice][2],allow)
-- @IF DEVELOPMENT
-- Image.DText("Mouse: ("..Mouse.X()..","..Mouse.Y()..")    choice = "..choice)
-- @FI
Flip()
until ok and allow==1
return choice
end

function Combat_PartySwitch(chn)
if not party[5] then return CSay("Cannot switch as there are no party members to switch with") end
if party[chn]=="Kirana" then return CSay("Kirana may not be switched!") end
local q = { }
local ak,ch,opt
for ak=5,8 do
    ch = party[ak]
    if party[ak] then
       -- @IF DEVELOPMENT
       CSay("DEV: Adding: { "..ch..", "..chn..", "..Var.S(char[ch].Name).."}")
       -- @FI 
       table.insert(q,{CodeName=ch,chn=chn,Name=Var.S(char[ch].Name)}) 
       end
    end
table.insert(q,{Name="Cancel"})
local qbox = { 
   Head="Which character do you want to come into the battle?",
   lines = {}
   }
for ak,opt in ipairs(q) do 
    table.insert(qbox.lines,q[ak].Name) 
    -- @IF DEVELOPMENT
    CSay("DEV: Added question line"..q[ak].Name)
    -- @FI 
    end
local newch = BoxQuestion(qbox,false,true)
ch = party[chn]
if q[newch].chn and q[newch].CodeName then
   CSay("Switching "..ch.." with "..party[newch])
   party[newch+4] = ch
   party[chn]     = q[newch].CodeName
   end
end
