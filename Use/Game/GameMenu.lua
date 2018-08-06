--[[
/* 
  Game Menu - LAURA

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



Version: 14.09.13

]]

function LoadMenuPics()
local ak,f
local files = {"Items","Abilities","Status & Equipment","Switch","Trophies","Config","Exit"}
MenuPics = {}
for ak,f in ipairs(files) do
	MenuPics[ak] = Image.Load("GFX/Menu/"..f..".png")
	Image.HotCenter(MenuPics[ak])
	end
MenuCursor = Image.LoadAnim("GFX/Menu/Cursor.png",56,56,0,2); Image.HotCenter(MenuCursor)
MenuScreen = Image.Load("GFX/Menu/MenuScreen.png")
end

function GameMenuAllow(choice)
-- @SELECT choice
-- @CASE 1
    if true then return true,1 end
-- @CASE 2
    if party[1]=="YoungIrravonia" then return false,0 else return true,1 end
-- @CASE 3
    if true then return true,1 end
-- @CASE 4
    if not party[5] then return false,0 else return true,1 end
-- @CASE 5
    if true then return true,1 end
-- @CASE 6    
    if true then return true,1 end
-- @CASE 7
    if true then return true,1 end
-- @ENDSELECT
Sys.Error("Unknown menu item in game menu ("..choice..")")
-- The crazy syntax here is because the Lua addon for Eclipse, that I used to create these scripts, is unable to recognize the GALE preprocessor and acted really funny (damn).
end

function GameMenuPickChar(DS)
local omx,omy = mousepos()
local mx,my
local mousemoving
GM_PC_p1 = GM_PC_p1 or 1
GM_PC_p2 = GM_PC_p2 or 0
Key.Flush()
repeat
mx,my = mousepos()
GameMenuDrawBasicScreen()
mousemoving = mx~=omx and my~=omy
GameMenuParty(GM_PC_p1+(GM_PC_p2*4),DS,mousemoving)
if mousemoving then omx=mx; omy=my; end
Image.Flip()
if (KeyHit(KEY_UP)      or joydirhit('N')) and GM_PC_p1>1 then GM_PC_p1 = GM_PC_p1 - 1 end
if (KeyHit(KEY_DOWN)    or joydirhit('S')) and GM_PC_p1<4 then GM_PC_p1 = GM_PC_p1 + 1 end
if (KeyHit(KEY_LEFT)    or joydirhit('W')) then GM_PC_p2 = 0 end
if (KeyHit(KEY_RIGHT)   or joydirhit('E')) then GM_PC_p2 = 1 end
if not party[GM_PC_p1+(GM_PC_p2*4)] then GM_PC_p2=0 end
if not party[GM_PC_p1+(GM_PC_p2*4)] then GM_PC_p1=1 end
if (ActionKeyHit() or Mouse.Hit(1)==1) and party[GM_PC_p1+(GM_PC_p2*4)] then return GM_PC_p1+(GM_PC_p2*4),party[GM_PC_p1+(GM_PC_p2*4)] end
if (CancelKeyHit() or Mouse.Hit(2)==1) then return false,false end
until false
end

function GameMenuSwitch()
local chn1,ch1 = GameMenuPickChar()
local chn2,ch2 = GameMenuPickChar(chn1)
if ch1=='Kirana' or ch2=='Kirana' then return end -- Kirana may not be switched!
if chn1 and chn2 then
   party[chn1]=ch2
   party[chn2]=ch1
   end
end

function GameMenuDrawBasicScreen(choice)
local menx = 400-(60*(7/2))
local ak
Image.Cls()
if config.bttrans then Image.SetAlpha(.5) end
ARColor(config.btback)
Image.Rect(0,0,800,600)
Image.SetAlpha(1)
ARColor(config.btfont)
Image.Draw(MenuScreen,0,0)
Image.Color(255,255,255)
-- local mx = Mouse.X()
-- local my = Mouse.Y()
for ak=1,7 do
    -- if mx>((ak-1)*60)-30 and mx>((ak-1)*60)+30 and my>10 and my<100 then choice=ak end
    if choice==ak then
       allow,allowvalue = GameMenuAllow(ak)
       Image.Draw(MenuCursor ,menx+((ak-1)*60),40,allowvalue)
       end
	Image.Draw(MenuPics[ak],menx+((ak-1)*60),40)
	end
end

function GameMenuAction(choice)
-- @SELECT choice
-- @CASE 1
   GameMenuItems()
-- @CASE 2
   local k,p = GameMenuPickChar()
   if p then Abil_List(p,false) end
-- @CASE 3
   GameMenuStatus()
-- @CASE 4
   GameMenuSwitch()   
-- @CASE 5
   TrophyOverview()
-- @CASE 6
   SetConfig()
-- @CASE 7
   local ch,ascii
   Key.Flush()
   GameMenuDrawBasicScreen(5)
   Image.Font("Fonts/Coolvetica.ttf",45)
   ARColor(config.btfont)
   Image.DText("Do you really want to quit this game?",400,300,2,2)
   Image.DText("Y = Yes, N = No",400,350,2,2)
   Image.Flip()
   repeat
   ascii=Key.GetChar()
   ch = Str.Char(ascii)
   if ch=="y" or ch=="Y" then GameBreak=true end
   until ch=="y" or ch=="Y" or ch=="n" or ch=="N"
   Key.Flush()
-- @ENDSELECT 
end

function GameMenuPartyMember(num,x,y,selected,showAP,swselected)
local ch 
local exp
local ystatus
if type(num)=='number' then ch = party[num] end
if type(num)=='string' then ch = num end
if not ch then return end
gmpics = gmpics or {}
if not gmpics[ch] then gmpics[ch] = Image.Load("GFX/Savegame/"..ch..".png") end
Image.Color(255,255,255)
Image.Draw(gmpics[ch],x,y)
if swselected then
   HARColor(config.btfont)
   Image.Draw("SGPoint",x-23,y+10) 
   end
ARColor(config.btfont)
if selected then
   Image.Draw("SGPoint",x-25,y+10) 
   end
Image.Font("Fonts/Coolvetica.ttf",20)
Image.DText(Var.S(char[ch]["Name"]),x+40,y)
Image.NoFont()
if char[ch].Experience then exp = char[ch].Experience else exp = "---" end
Image.DText("HP  "..char[ch].HP[1].." / "..char[ch].HP[2],x+40,y+30)
if showAP then
   Image.DText("AP  "..char[ch].AP[1].." / "..char[ch].AP[2],x+40,y+45)
   Image.DText("LV  "..char[ch].Level,x+40,y+60)
   Image.DText("EXP "..exp,x+40,y+75)
   ystatus = 90+y
   else
   Image.DText("LV  "..char[ch].Level,x+40,y+45)
   Image.DText("EXP "..exp,x+40,y+60)
   ystatus = 75+y
   end
local stx = x+40   
local sti,sts
StatusSet = StatusSet or {}
StatusSet[StN['Player']] = StatusSet[StN['Player']] or {}
StatusSet[StN['Player']][ch] = StatusSet[StN['Player']][ch] or {}
for sti,sts in pairs(StatusSet[StN['Player']][ch]) do
    white()
    Image.Draw(StatusData[sti].Img,stx,ystatus)
    stx = stx + 20 
    end   
ARColor(config.btfont)    
end

function GameMenuParty(spm,sspm,react2mouse) -- spm = selected party member
local y
local mx,my = mousepos()
for ak=0,3 do
	y = 100 + (ak*114)
	GameMenuPartyMember(1+ak, 50,y,spm==(1+ak),false,sspm==(1+ak))
	GameMenuPartyMember(5+ak,400,y,spm==(5+ak),false,sspm==(5+ak))
	if react2mouse then
	   if my>y and my<y+100 then
	      if mx<400 then GM_PC_p2 = 0 else GM_PC_p2 = 1 end
	      GM_PC_p1 = ak + 1
	      end
	   end
	end
Image.NoFont()
DText("Play Time: "..PlayTimeShow(),20,555)
DText(cash.." shilders",20,570)
DText(stones.." magic stones",780,570,1,0)	
end

--[[ old
function GameMenuItems()
local i = {}
local cnt,iID,iNum
cnt = 0
-- Set up the menu
for iID,iNum in pairs(inventory) do
    if iNum>0 then
       cnt = cnt + 1
       i[cnt] = iID
       end
    end
-- Main Routine
local iP = 1
local iSY = 0
local done = false
local ak
local iY
Key.Flush()
repeat
GameMenuDrawBasicScreen()
Image.ViewPort(50,100,700,470)
-- Image.Cls() -- Debug line
Image.Origin(50,100)
iY = -32
for ak,iID in ipairs(i) do
    iY = iY + 32 --Inc(iY,32)
    if ak==iP then 
       if iY-iSY<0 then Dec(iSY) end
       if iY-iSY>470 then Inc(iSY) end
       Image.Font("Fonts/Coolvetica.ttf",32)
       else
       Image.Font("Fonts/Coolvetica.ttf",25)
       end
    Image.Color(255,255,255)
    itemicon(iID,20,iY+16)
    ARColor(config.btfont)
    Image.DText(itemdata[iID].Name,40,iY+16,0,2)
    Image.DText(inventory[iID],680,iY+16,2)          
    end
Image.ViewPort(0,0,800,600)
Image.Origin(0,0)    
Image.Flip()
if KeyHit(KEY_DOWN) and i[iP+1] then iP = iP + 1 end
if KeyHit(KEY_UP) and iP>1 then iP = iP - 1 end
if KeyHit(config.key.cancel) then done=true end    
until done    
end
]]

function GameMenuItems()
local itname = PickItem({"Healing","Key"})
if not itname then return end
local item = itemdata[itname]
local chnr,ch 
local used = false
local itemscript
local k,v,stat
if item["Item Type"] == "Healing" then
   chnr,ch = GameMenuPickChar()
   while ch do -- repeat   
    used = false
    -- Status Recovery
    for k,v in pairs(item) do
        if StatusSet[StN['Player']][ch][k] and v==true then
              used = true
              StatusSet[StN['Player']][ch][k] = nil
              end 
        end
    -- Heal
    if item.Heal and item.Heal>0 and char[ch].HP[1]<char[ch].HP[2] and inventory[itname] then
       char[ch].HP[1] = char[ch].HP[1] + item.Heal
       if char[ch].HP[1]>char[ch].HP[2] then char[ch].HP[1]=char[ch].HP[2] end
       used = true 
       end        
    if used then 
       inventory[itname] = inventory[itname] - 1
       if inventory[itname]==0 then inventory[itname]=nil end
       local audio = "SFX/ItemUsage/"..itname..".ogg"
       if JCR5.Exist(audio)==1 then 
          SFX(audio) 
          else
          Console.Write("! WARNING: Item sound '"..audio.."' does not exist. Request ignored",255,180,0)
          end
       end   
    chnr,ch = GameMenuPickChar()
    end -- until not ch
   end
if item["Item Type"] == "Key" then
   Actors.Pick("Player")
   local x = Actors.PA_X()
   local y = Actors.PA_Y()
   local ok = (item.X==0 or x==item.X); CSay("Na X:"..sval(ok))
   ok  = ok and (item.Y==0 or item.y==y) CSay("Na Y:"..sval(ok)) 
   ok  = ok and (item.Room=="" or Str.Upper(item.Room)==Str.Upper(Maps.MapName)); CSay("Na Room:"..sval(ok)) 
   ok  = ok and (item.Zone=="" or Sys.Val(item.Zone)==OldZone); CSay("Na Zone:"..sval(ok))
   ok  = ok or item.UseAnywhere; CSay("Na Anywhere:"..sval(ok))
   for ik,iv in pairs(item) do CSay(ik.." = "..sval(iv)) end; CSay("Pos ("..x..","..y..") - "..Maps.MapName.." -- ok:"..sval(ok))
   if ok then
      --[ 
      itemscript = loadstring("local x = "..x.."\nlocal y= "..y.."\n\n"..item.Script)
      CSay("local x = "..x.."\nlocal y= "..y.."\n\n"..item.Script)
      if not itemscript then Console.Write("! WARNING! Key item script not properly compiled!!",255,0,0) else itemscript() end
      -- ]]
      --LAURA.ShellString("local x = "..x.."\nlocal y= "..y.."\n\n"..item.Script)
      GameMenuBreakOff = true
      end
   end   
end

function GameMenu()
local ak
local allow,allowvalue
local choice = 1
local menx = 400-(60*(7/2))
GameMenuBreakOff=false
if not MenuPics then LoadMenuPics() end
Key.Flush()
SFX('SFX/General/GameMenu/Open.ogg')
repeat
local actionhit = ActionKeyHit() or Mouse.Hit(1)==1 -- Key.Hit(config.key.action)==1 
GameMenuDrawBasicScreen(choice,true)
GameMenuParty()
local mx = Mouse.X()
local my = Mouse.Y()
for ak=1,7 do
    if mx>(menx+((ak-1)*60))-10 and mx<(menx+((ak-1)*60))+10 and my>10 and my<100 then
       if choice~=ak then SFX('SFX/General/GameMenu/ChangeSelection.ogg') end 
       choice=ak 
       end
    end
if GameBreak then return end
if (KeyHit(KEY_RIGHT) or joydirhit('R',true))  and choice<7 then choice = choice + 1; SFX('SFX/General/GameMenu/ChangeSelection.ogg') end
if (KeyHit(KEY_LEFT ) or joydirhit('W',false)) and choice>1 then choice = choice - 1; SFX('SFX/General/GameMenu/ChangeSelection.ogg') end		
if actionhit then SFX('SFX/General/GameMenu/Select.ogg'); GameMenuAction(choice);  end
Flip()
if CancelKeyHit() or Mouse.Hit(2)==1 then -- KeyHit(KEY_ESCAPE) then 
   Key.Flush()
   SFX('SFX/General/GameMenu/Close.ogg')  
   return 
   end
until GameMenuBreakOff
end

function GameMenuStatus()
local chi,ch
local ak,st,sk,rs,rsv
local rx = {600,400}
local ry = {300,300}
local eqn = {'WEAPON','ARMOR','JEWEL'}
local P=1
chi,ch = GameMenuPickChar()
if not chi then return end
resistance[ch] = resistance[ch] or {} -- Make sure we got resistances, or this routine will produce and error.
repeat
GameMenuDrawBasicScreen()
Image.Color(255,255,255)
Image.Draw(gmpics[ch],50,100)
ARColor(config.btfont)
Image.Font("Fonts/Coolvetica.ttf",50)
Image.DText(Var.S(char[ch].Name),100,100)
Image.Font("Fonts/Coolvetica.ttf",25)
-- Main data
Image.DText("HP",100,175);         Image.DText(char[ch].HP[1].." / "..char[ch].HP[2],250,175)
Image.DText("LV",100,200);         Image.DText(char[ch].Level,250,200)
Image.DText("Experience",100,225); Image.DText(char[ch].Experience or "---",250,225)
-- Statistics
Image.Font("Fonts/Coolvetica.ttf",20)
for ak,st in ipairs({"Strength","Defense","Intelligence","Resistance","Accuracy","Evasion","Agility"}) do
    Image.DText(st,400,100+(ak*20))
    Image.DText(char[ch][st]+Stat_Mod(ch,st),570,100+(ak*20),1)
    end
-- Skills    
for ak,sk in pairs(char[ch].SkillNames) do
    if char[ch].SkillLevels[ak] then DText(char[ch].SkillLevels[ak],650,100+(ak*40),1) end
    if char[ch].SkillExperience[ak] then 
       local deel       = char[ch].SkillExperience[ak]
       local geheel     = skillexptable[char[ch].SkillLevels[ak]]
       local breuk      = deel / geheel
       local percentage = round(breuk*100)
       Image.Color(0,0,0)
       Image.Rect(675,100+(ak*40),102,22)
       Image.Color(255,0,0)
       Image.Rect(676,101+(ak*40),percentage,20)
       else
       Image.DText('---',675,100+(ak*40))
       end
    ARColor(config.btfont)
    Image.DText(sk,625,80+(ak*40))
    end
-- Resistances
local rsi
local rsn
local rsp
ry = {380,340}
resistance[ch].Dark = nil -- fix for an earlier bug.
for rs,rsv in spairs(resistance[ch]) do
    rsi = 1
    rsn = rs
    if Str.Left(rs,2)=="ST" then
       rsn = Str.Right(rs,Str.Length(rs)-2)
       rsi = 2
       end
    rsn = Str.Left(rsn,1)..Str.Lower(Str.Right(rsn,Str.Length(rsn)-1))
    rsp = round(rsv*100).."%"
    DText(rsn,rx[rsi]    ,ry[rsi])
    DText(rsp,rx[rsi]+170,ry[rsi],1) 
    ry[rsi] = ry[rsi] + 20
    end
-- Equipment
local mx,my = mousepos()
local omx,omy 
omx = omx or mx
omy = omy or my
for ak,k in ipairs(eqn) do 
    local i = equip[ch][k]
    if P==ak then Image.Font("Fonts/Coolvetica.ttf",25) else Image.Font("Fonts/Coolvetica.ttf",20) end
    if i then
       i = Str.Upper(i)
       Image.Color(255,255,255)
       itemicon(i,50,(ak*30)+400)
       ARColor(config.btfont)
       if itemdata[i] then       
          DText(itemdata[i].Name,100,(ak*30)+400,0,2)
          else
          DText("UNKNOWN ITEM -- "..i,100,(ak*30)+400,0,2)
          end       
       else 
       DText("---",100,(ak*30)+400,0,2)
       end
    if omx~=mx or omy~=my then
       if my>(ak*30)+370 and my<(ak*30)+430 then 
          P=ak
          omx,omy = mx,my
          end  
       end   
    end
local item,itname
local itype  = {'WEAPON','ARMOR','JEWEL'}  
local itype2 = {'Weapon','Armor','Jewel'}  
if (KeyHit(KEY_DOWN) or joydirhit('D')) and P<3 then P=P+1 end
if (KeyHit(KEY_UP  ) or joydirhit('U')) and P>1 then P=P-1 end
if ActionKeyHit() and ch ~= "YoungIrravonia" and ch ~= "Shanda" and ch ~= "Kirana" then -- Change the equipment. The temporary characters cannot change their equipment!
   if (not equip[ch][itype[P]]) or inventory[equip[ch][itype[P]]]~=imax() then -- If the item that has to be removed is on max in your inventory, you cannot unequip that item, sorry! 
      itname = PickItem(itype2[P],ch)
      item = itemdata[itname]
      if itname then
         CSay("Putting item back into the inventory if possible")
         CSay("equip."..ch.."."..sval(itype[P]).." = '"..sval(equip[ch][itype[P]]).."'")
         if equip[ch][itype[P]] then AddItem(equip[ch][itype[P]],1) end
         RemoveItem(itname,1)
         equip[ch][itype[P]] = itname
         end
      end
   end
if (KeyHit(config.key.pact) or Joy.Hit(config.joy.pact)==1) and P==3 and ch ~= "YoungIrravonia" and ch ~= "Shanda" and ch ~= "Kirana" then -- Remove item. Only jewels can be removed and guest characters cannot remove them.
   if equip[ch][itype[P]] then AddItem(equip[ch][itype[P]],1) end
   equip[ch][itype[P]]=nil
   end
-- Show the stuff
Image.Flip()    
-- Get outta here    
if CancelKeyHit() or Mouse.Hit(2)==1 then -- KeyHit(config.key.cancel) then
   return 
   end
until false
end

function CheckMenu()
if KeyHit(config.key.menu) or joyhit(config.joy.menu) then GameMenu() end
end
