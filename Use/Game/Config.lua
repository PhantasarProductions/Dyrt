--[[
/* 
  Dyrt - Configuration

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



Version: 14.08.05

]]
function DefaultConfig(force)
if force then config = {} end
config            = config or {}
config.music      = true -- (config.music~=nil) or musicavailable
config.sfx        = (config.sfx~=nil)  or true
if config.smoothscroll == nil then config.smoothscroll=true end
if config.bttrans == nil then config.bttrans = true end
config.key        = config.key         or {}
config.key.action = config.key.action  or KEY_SPACE
config.key.action2= config.key.action2 or KEY_RETURN
config.key.cancel = config.key.cancel  or KEY_ESCAPE
config.key.menu   = config.key.menu    or KEY_TAB
config.key.char   = config.key.char    or KEY_C
config.key.pact   = config.key.pact    or KEY_P
config.key.toe    = config.key.toe     or KEY_T
config.key.reset  = config.key.reset   or KEY_R
config.joy        = config.joy         or {}
config.joy.action = config.joy.action  or 1
config.joy.cancel = config.joy.cancel  or 2
config.joy.menu   = config.joy.menu    or 3
config.joy.char   = config.joy.char    or 7
config.joy.pact   = config.joy.pact    or 0
config.joy.toe    = config.joy.toe     or 6
config.joy.reset  = config.joy.reset   or 8
config.language   = config.language    or "EN"
config.btback     = config.btback      or {["R"] =   0, ["G"] =   0, ["B"] = 255}
config.btfont     = config.btfont      or {["R"] = 255, ["G"] = 255, ["B"] = 255}
config.bthead     = config.bthead      or {["R"] = 255, ["G"] = 255, ["B"] =   0}
config.txtspeed   = config.txtspeed    or "Fast"
end 

function __consolecommand.CONFIG()
if not config then Console.Write("? No Config Set!") end
local s = serialize("config",config)
local lns = split(s,'\n')
for _,ln in ipairs(lns) do
    CSay(ln)
    end
end

function __consolecommand.RESETCONFIG()
DefaultConfig(true)
CSay("Config reset to default values")
end

function SetConfig()
local ok=false
local items  = {"Sound Effects","Smooth Scroll","Action Key","Alternate Action Key","Cancel Key","Menu Key","Change character key","Personal Action Key" ,"Combat on/off key","Reset Push Blocks key","Action Joypad Button","Cancel Joypad Button","Menu Joypad Button","Change Character Button","Personal Action Button","Combat On/Off button","Reset push blocks button","Language","Transparent Textbox","Textbox colors","Text speed","End"}
local itemfd = {"sfx"          ,"smoothscroll" ,"action"    ,"action2"             ,"cancel"    ,"menu"    ,"char"                ,"pact"                ,"toe"              ,"reset"                ,"action"              ,"cancel"              ,"menu"              ,"char"                   ,"pact"                  ,"toe"                 ,"reset"                   ,"",        "bttrans",            ""              ,"txtspeed"  ,"end"}
local itemdo = {"bool"         ,"bool"         ,"key"       ,"key"                 ,"key"       ,"key"     ,"key"                 ,"key"                 ,"key"              ,"key",                  "joy"                 ,"joy"                 ,"joy"               ,"joy"                    ,"joy"                   ,"joy"                 ,"joy"                     ,"lang",    "bool",               "btcol"         ,"array"     ,"end"}
local itemfn = { txtspeed = function() ShowLine = 1; ShowChar = 1; end}
local arrayitems = { txtspeed = { "Slow","Medium","Fast","Instant"}} 
local ak,desc,al
local ch = 1
local lch = 0
local minch = 1
local y
local lc = GetLanguageCodes()
local cnt
local bc = 255
DefaultConfig()
cnt = 0
repeat
lch = lch + 1
if lch>2000000 then Sys.Error("Language check overflow") end
if not lc[lch] then
   config.language = "EN"
   lch=1
   cnt = cnt + 1
   if cnt >= 3 then Sys.Error("There seems to be a problem locating the English language.") end
   Console.Write("!!WARNING!!",255,0,0)
   Console.Write("Requested language not located, automatically put back to English")
   end
until lc[lch] == config.language
CSay("Language index - "..lch)
CSay("Language code  - "..lc[lch])
CSay("Language cfg   - "..config.language)
CSay("Language name  - "..Lang[lc[lch]])
if not musicavailable then ch=2; minch=2 end
Image.NoFont()
Key.Flush()
repeat
local actionhit = ActionKeyHit() -- Key.Hit(config.key.action)==1 or Mouse.Hit(1)==1 
Image.Cls()
Image.Color(bc,bc,bc)
if bc>150 then bc=bc-.5 end
Image.Tile("MenuBack",0,0)
for ak,desc in ipairs(items) do
    y=ak*15
    if ak==1 and (not musicavailable) then 
       Image.Color(80,80,80)
    elseif ak==ch then
       Image.Color(255,0,0)
       Image.SetAlpha(.5)
       Image.Rect(0,ak*15,800,15)
       Image.SetAlpha(1)
       Image.Color(255,255,0)
    else
       Image.Color(255,255,255)
       end
    Image.DText(desc,10,y)   
    -- @SELECT itemdo[ak]
    -- @CASE "bool"
       Image.DText(OnOff(config[itemfd[ak]]),300,y,2)
       if actionhit and ak==ch then config[itemfd[ak]] = not config[itemfd[ak]] end
    -- @CASE "key"
       Image.DText(KEYNAME[config.key[itemfd[ak]]],300,y,2)
       if actionhit and ak==ch then config.key[itemfd[ak]] = AskKey(desc) end
    -- @CASE "joy"
       CSay('ak = '..sval(ak)..";")
       CSay("itemfd["..ak.."] = "..sval(itemfd[ak]))
       Image.DText("B"..config.joy[itemfd[ak]],300,y,2) 
       local old =  config.joy[itemfd[ak]]
       if actionhit and ak==ch then config.joy[itemfd[ak]] = AskJoy(desc) or old end
    -- @CASE "lang"
       Image.DText(lc[lch].." ("..Lang[lc[lch]]..")",300,y,2)
       if actionhit and ak==ch then
          lch = lch + 1
          if not lc[lch] then lch = 1 end
          config.language = lc[lch] 
          end -- ah
    -- @CASE "btcol"
       if actionhit and ak==ch then configcolors() end
    -- @CASE "array"
       Image.DText(config[itemfd[ak]],300,y,2)
       if actionhit and ak==ch then
          local r -- = arrayitems[itemfd[ak]][1]
          local av
          local lastitem
          local itsdone
          if itemfn[itemfd[ak]] and ak==ch then itemfn[itemfd[ak]]() end
          CSay("Request to change the setting "..itemfd[ak])
          itsdone=false
          --[[
          for al,av in ipairs(arrayitems[itemfd[ak] ]) do
              -- if lastitem==config[itemfd[ak] ] and (not itsdone) then config[itemfd[ak] ] = av; itsdone=true end
              -- listitem = av
              -- @IF DEVELOPMENT
              CSay(ak.."> Current value: "..sval(config[itemfd[ak] ]).."; al: "..sval(al).."; av: "..sval(av))
              -- @FI
              if config[itemfd[ak] ] == arrayitems[itemfd[ak] ][al] and (not itsdone) then
                 -- r = av --arrayitems[itemfd[ak] ][al];
                 r = arrayitems[itemfd[ak ] ][al+1]
                 if not r then r = arrayitems[itemfd[ak] ][1] end
                 itsdone=true 
                 CSay("Redefine to:"..r) 
                 end
              config[itemfd[ak] ] = r
              end
          -- ]]    
          config.citem = config.citem or {}
          config.citem[itemfd[ak]] = (config.citem[itemfd[ak]] or 0) + 1
          if not arrayitems[itemfd[ak]][config.citem[itemfd[ak]]] then config.citem[itemfd[ak]]=1 end
          config[itemfd[ak]] = arrayitems[itemfd[ak]][config.citem[itemfd[ak]]] 
          
          end
    -- @CASE "end"
       if actionhit and ak==ch then ok=true end
    -- @ENDSELECT
    end
if CancelKeyHit() then ok=true end    
ShowBox({["Head"] = "Configuration", ["lines"] = {"Set your preferred settings right","UP/DOWN to select what to change","Action button to alter the value","When you are done, select 'End' to exit"}, ["linecount"]=4})
Flip()
if (Key.Hit(KEY_UP)==1   or joydirhit('U')) and ch>minch    then ch=ch-1 end
if (Key.Hit(KEY_DOWN)==1 or joydirhit('D')) and items[ch+1] then ch=ch+1 end
Image.NoFont()
until ok
Var.D("$LANG",config.language)
end

function OnOff(b)
if b then 
   return "On"
   else
   return "Off"
   end
end

function AskKey(d)
local k
Key.Flush()
Console.Write("Asking key for "..d)
Image.Cls()
Image.Color(255,255,255)
Image.Tile("MenuBack",10,10)
Image.DText("Please hit the desired key for "..d)
Image.Flip()
repeat
k = Key.Wait()
until k~=KEY_UP and k~=KEY_DOWN and k~=KEY_LEFT and k~=KEY_RIGHT 
Key.Flush()
return k
end

function AskJoy(d)
local ak
Key.Flush()
Key.Flush()
Console.Write("Asking joybutton for "..d,255,255,0)
Image.Cls()
Image.Color(255,255,255)
Image.Tile("MenuBack",20,20)
Image.DText("Please hit the desired joypad/joystick button for "..d,255,255,0)
Image.Flip()
repeat
for ak=0,15 do
    if Joy.Hit(ak)~=0 then return ak end
    end
until Key.Hit(KEY_ESCAPE)~=0
return nil
end
    
    
function configcolors()
local items = {"Header","Regular text","Background"}
local vars = {"bthead","btfont","btback"}
local RGB = {"R","G","B"}
local y
local ak,i,al,il,iv
local PI = 1
local PRGB = 1
Key.Flush()
repeat
Image.Cls()
Image.Color(255,255,255)
Image.Tile("MenuBack",0,0)
y = 0
for ak,i in ipairs(items) do 
    iv = vars[ak]
	for al,il in ipairs(RGB) do
        if ak==PI and al==PRGB then
           Image.SetAlpha(.5)
           Image.Color(255,0,0)
           Image.Rect(0,y,800,15)
           Image.SetAlpha(1)
           Image.Color(255,255,0)
           else
           Image.Color(255,255,255)
           end		
        if al==1 then
           Image.DText(i,0,y)
           end
        Image.DText(il,250,y)
        Image.DText(config[iv][il],600,y)
        y = y + 15
        end
    y = y + 5
    end
if KeyHit(KEY_DOWN) or joydirhit('S') then
   PRGB = PRGB + 1
   if PRGB>=4 then PRGB=1; PI = PI + 1 end
   if PI>=4 then PI=1 end
   end            	  
if KeyHit(KEY_UP  ) or joydirhit('N') then
   PRGB = PRGB - 1
   if PRGB<=0 then PRGB=3; PI = PI - 1 end
   if PI<=0 then PI=3 end
   end            	  
if (KeyDown(KEY_LEFT ) or joyx()==-1) and config[vars[PI]][RGB[PRGB]]>0   then config[vars[PI]][RGB[PRGB]] = config[vars[PI]][RGB[PRGB]] - 1 end   
if (KeyDown(KEY_RIGHT) or joyx()== 1) and config[vars[PI]][RGB[PRGB]]<255 then config[vars[PI]][RGB[PRGB]] = config[vars[PI]][RGB[PRGB]] + 1 end   
ShowBox({["Head"] = "Test Box", ["lines"] = {"Here you can see what your box will look like","UP/DOWN to select what to change","LEFT/RIGHT to change","When you are done, press ESCAPE to exit"}, ["linecount"]=4})
Image.NoFont()
Image.Flip()
until CancelKeyHit() --KeyHit(KEY_ESCAPE)
Key.Flush()
end 
