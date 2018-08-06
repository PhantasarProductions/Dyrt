--[[
/* 
  KeyboardInput

  Copyright (C) 2013 J.P. Broks

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



Version: 13.12.26

]]
function GphInput(question,default,picture)
local ch,ascii 
local ret = default or ""
local cursor = {"/","--","\\","|"}
local curpos = 1
Key.Flush()
repeat
ascii=Key.GetChar()
ch = Str.Char(ascii)
if ascii>=32 then ret = ret .. ch end
if ascii==8 and ret~="" then ret = Str.Left(ret,Str.Length(ret)-1) end
Image.Cls()
Image.Color(255,255,255)
Image.Tile("MenuBack",0,0)
--Image.NoFont()
SetLangFont()
if picture then Image.Draw(picture,790-Image.Width(picture),10) end
Image.DText(question,10,10)
Image.DText(">"..ret..cursor[math.floor(curpos)],10,100)
curpos = curpos + .1
if curpos>=5 then curpos=1 end
Image.Flip()
until ascii==13 and ret~=""
Key.Flush()
return ret
end 


function ButtonPressed()
local ak
for ak=0,255 do
    if Key.Hit(ak)==1 or Mouse.Hit(ak)==1 or Joy.Hit(ak)==1 then print("ButtonPressed() is true") return true end
    end
return false
end
