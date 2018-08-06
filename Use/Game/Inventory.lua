--[[
/* 
  Inventory routines for LAURA

  Copyright (C) 2013, 2014 Jeroen P. Broks
  
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

-- @IF IGNOREME
__consolecommand = {}
-- @FI

inventory = inventory or {["APPLE"]=5,["ANTIDOTE"]=2,["SALVE"]=1}

Image.AssignLoad("UnkItem","GFX/INVENTORY/UNKNOWN.PNG")

function FetchItemBase()
itemdata = FetchDataBase("Data/Items")
end

function imax()
local ret = {100,25,9}
return ret[skill]
end

function itemalticon(item)
itemalts = itemalts or {}
local file = upper(itemdata[item].AltPic)
if not itemalts[file] then
   itemalts[file] = Image.Load("GFX/Inventory/"..file)
   CWrite("Loaded item alticon: "..file,255,180,0)   
   end
CWrite("Altion "..file.." with code "..itemalts[file].." assigned to item: "..item,0,180,255)   
itemiconimg[item]=itemalts[file]   
end


function itemicon(itemp,x,y)
local item = Str.Upper(itemp)
if Str.Left(item,5)=="CASH:" then item="CASH" end
itemiconimg = itemiconimg or {}
if not itemiconimg[Str.Upper(item)] then
   if not itemdata[item] then CWrite("!WARNING! No item data for item "..item,255,180,0) end 
   if itemdata[item] and itemdata[item].AltPic and itemdata[item].AltPic~="" and itemdata[item].AltPic~="AUTO" then
      itemalticon(item)
      else
      itemiconimg[Str.Upper(item)] = Image.Load("GFX/INVENTORY/"..item..".png")
      end 
   if itemiconimg[Str.Upper(item)] == "ERROR" then itemiconimg[Str.Upper(item)] = "UnkItem"; CSay("Loading icon for "..item.." failed, using the unknown icon in stead!") end      
   Image.HotCenter(itemiconimg[Str.Upper(item)])
   end
-- CSay("Drawing "..item)   
Image.Draw(itemiconimg[Str.Upper(item)],x,y)
end

function invsort(t,a,b) -- For use in sorting items only
-- A bug destroyed the inventory list, this feature fixes that!
if not itemdata[a] then Console.Write("Error! Item "..a.." does not exist!",255,0,0); inventory[a]=nil return false end
if not itemdata[b] then Console.Write("Error! Item "..b.." does not exist!",255,0,0); inventory[b]=nil return false end
if Str.Left(a,5)=="CASH:" then inventory[a]=nil; Console.Write("Warning! "..a.." has been removed from the list as cash does not belong here!",255,180,100); return false end
if Str.Left(b,5)=="CASH:" then inventory[b]=nil; Console.Write("Warning! "..b.." has been removed from the list as cash does not belong here!",255,180,100); return false end
-- And this is the sorter itself!
return tabsortstrfirst(itemdata[a].Name,itemdata[b].Name)
end

function PickItem(allowtype,eqch)
local i = {}
local cnt=0
local it,itm
local allow = {}
local P=1
local PM=0
local a_allow
local y
local mx,my,omx,omy
-- @SELECT type(allowtype)
-- @CASE 'string'
   a_allow = {allowtype}
-- @CASE 'nil'
   a_allow = {"Healing"}
-- @CASE 'table'
   a_allow = allowtype
-- @DEFAULT
   Sys.Error("PickItem got an allow type of type '"..type(allowtype).."'. I exepct either a string or a table")
-- @ENDSELECT
local ti,tt
for ti,tt in ipairs(a_allow) do
    Console.Write(ti.."> Item type '"..tt.."' is allowed in this run",255,0,255)
    end
for iID,iNum in spairs(inventory,invsort) do
    if iNum and iNum>0 then
       cnt = cnt + 1
       i[cnt] = iID
       end
    end
omx,omy = mousepos()    
repeat
mx,my = mousepos()
if CancelKeyHit() or Mouse.Hit(2)==1 then SFX('SFX/General/GameMenu/Cancel.ogg'); Key.Flush(); return nil end
if (KeyHit(KEY_UP)   or joydirhit('N')) and P>1 then SFX('SFX/General/GameMenu/ChangeSelection.ogg'); P=P-1 end
if (KeyHit(KEY_DOWN) or joydirhit('S')) and i[P+1] then SFX('SFX/General/GameMenu/ChangeSelection.ogg'); P=P+1 end
if (ActionKeyHit() or Mouse.Hit(1)==1) and allow[P] then Key.Flush(); return i[P] end
-- Base draw
Image.Cls()
if config.bttrans then Image.SetAlpha(.5) end
ARColor(config.btback)
Image.Rect(0,0,800,600)
Image.SetAlpha(1)
Image.Color(0,0,0)
ARColor(config.btfont)
-- Lines
Image.Line(  1,  1,798,  1) -- U
Image.Line(798,  1,798,598) -- R
Image.Line(  1,598,798,598) -- D
Image.Line(  1,  1,  1,598) -- L
Image.Line(  1,570,798,570) -- Div
-- Item list
Image.ViewPort(10,10,700,560)
Image.Origin(10,10)
-- DText(my,700,15,1,0)
for ak,it in ipairs(i) do
    -- Determine position on screen
    y = ((ak-1)*35)-PM
    if P==ak then
       if y>500 then PM=PM+1 end
       if y<0 then PM=PM-1 end
       end
    -- Select by mouse
    if omx~=mx or omy~=my then
       if my>(y+10)-15 and my<(y+10)+15 then 
          P=ak 
          omx = mx
          omy = my
          end
       end
    -- Item code
    itm = itemdata[it]
    if ak == P then
       Image.Font("Fonts/Coolvetica.ttf",32)
       else
       Image.Font("Fonts/Coolvetica.ttf",25)
       end
    Image.Color(255,255,255)
    itemicon(it,20,y+16)
    if tablecontains(a_allow,itm["Item Type"]) then
       allow[ak] = true
       if eqch then
          allow[ak] = allow[ak] and (itm.eqAll or itm["eq"..eqch])
          end
       -- ARColor(config.btfont)
       else
       allow[ak] = false
       -- HARColor(config.btfont)
       end
    if allow[ak] then ARColor(config.btfont) else HARColor(config.btfont) end   
    DText(itm.Name,40,y+10,0,2)
    DText(inventory[it],470,y+10,1,2)    
    end
Image.ViewPort(0,0,800,600)
Image.Origin(0,0)
Image.Font('Fonts/Coolvetica.ttf',20)
Image.Font('Fonts/Coolvetica.ttf',20)
ARColor(config.btfont)
DText(itemdata[i[P]]["Item Type"]..": "..Var.S(itemdata[i[P]].Desc),10,583,0,2)
Image.Color(255,255,255)
Flip()
until false
end

function Stat_Mod(ch,st)
local ret = 0
local i
local k
for _,k in ipairs({"WEAPON","ARMOR","JEWEL"}) do
   i = nil
   if k then i = itemdata[equip[ch][k]] end
   if i then
      -- @SELECT st
      -- @CASE 'Strength'   
         ret = ret + i.ATK 
      -- @CASE 'Intelligence'
         ret = ret + i.INT 
      -- @CASE 'Defense'   
         ret = ret + i.ARM 
      -- @CASE 'Resistance'   
         ret = ret + i.RES 
      -- @ENDSELECT
      end
   end
return ret
end
 
function __consolecommand.LOADEDITEMS()
local k,item,ik,iv
if not itemdata then Console.Write("? Items not loaded!",255,0,0) return end
for k,item in pairs(itemdata) do
    Console.Write("Item: "..k,255,0,255)
    for ik,iv in pairs(item) do
        if type(iv)=='boolean' then
           if iv then Console.Write(ik.." = true",0,255,0) else Console.Write(ik.." = false",255,0,0) end
        else
           Console.Write(ik.." = "..iv,255,255,0)
           end
        end
    end
end    

function __consolecommand.GIMME(a)
local item = upper(a[1] or '?')
local amm = a[2] or 1
if not itemdata[item] then CWrite("? Item '"..item.."' does not appear to exist!",255,0,0) end
CWrite("Adding "..amm.." of item '"..item.."'",255,180,0)
inventory[item] = (inventory[item] or 0) + amm
if inventory[item]>imax() then 
   CWrite("! Over maximum! Set to current setting!",255,180,0)
   inventory[item] = imax()
   end
end
