--[[
/* 
  Credits - Dyrt

  Copyright (C) 2014 Jeroen P. Broks

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



Version: 14.03.27

]]
-- @UNDEF CREDITSDEBUG

-- Init
function InitCredits()
local ak
CreditsInitData()
Credits = {}
table.insert(Credits,{Img="Logo"})
for ak=0,50 do table.insert(Credits,{Txt=""}) end
table.insert(Credits,{Txt="Jeroen P. Broks",Big=true,Color={R=255,G=255,B=0}})
table.insert(Credits,{Txt="Project Leader"})
table.insert(Credits,{Txt="Code & Script"})
table.insert(Credits,{Txt="Story & Design"})
table.insert(Credits,{Txt="Maps design"})
table.insert(Credits,{Txt="World & Characters"})
table.insert(Credits,{Txt="User Interface"})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt="Man of Steel",Big=true,Color={R=255,G=255,B=0}})
table.insert(Credits,{Txt="Main Graphics"})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt="Widzy",Big=true,Color={R=255,G=255,B=0}})
table.insert(Credits,{Txt="Music"})
table.insert(Credits,{Txt="Sound Effects"})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt="Additional Credits to:",Big=true,Color={R=255,G=0,B=255}})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt="Blitz Research Ltd.",Big=true,Color={R=255,G=255,B=0}})
table.insert(Credits,{Txt="BlitzMax Programming Language"})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt="PUC-RIO",Big=true,Color={R=255,G=255,B=0}})
table.insert(Credits,{Txt="Lua Scripting Language"})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt="Bruce A. Henderson",Big=true,Color={R=255,G=255,B=0}})
table.insert(Credits,{Txt="A few core modules"})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt="Jean-Loup Gailly",Big=true,Color={R=255,G=255,B=0}})
table.insert(Credits,{Txt="& Mark Adler",Big=true,Color={R=255,G=255,B=0}})
table.insert(Credits,{Txt="zLib compression algorithm"})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt="Next I would like to credit the next people"})
table.insert(Credits,{Txt="for their free stuff. Without them this game"})
table.insert(Credits,{Txt="would not be possible"})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})

local author,authordata,act
for author,authordata in spairs(Contributors) do 
    table.insert(Credits,{Txt=author,Big=true,Color={R=255,G=255,B=0}})
    for _,act in ipairs(authordata.Actions) do 
        table.insert(Credits,{Txt=act})
        end
    table.insert(Credits,{Txt=''})
    end
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt="The story is entirely based on fiction!",NF=true})
table.insert(Credits,{Txt="Any resamblence to real people either",NF=true})
table.insert(Credits,{Txt="dead or alive is purely coincidental",NF=true})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt=""})
table.insert(Credits,{Txt="The Secrets of Dyrt"})
table.insert(Credits,{Txt="(c) Jeroen P. Broks 2013, 2014",NF=true})
    
local cl
local cy = 300
for ak,cl in ipairs(Credits) do
    Credits[ak].y = cy
    if Credits[ak].Img then cy=cy+Image.Height(Credits[ak].Img)
    elseif Credits[ak].Big then cy = cy + 30
    else cy = cy + 15 end
    end    
    
end

-- Let's show the credits
function ShowCredits() 
InitCredits()
local ok = true
local ak,cl,al
while ok do
      Image.Cls()
      --[[
      for al=50,0,-.5 do 
        Image.Color(al,al,al)
        Image.Line(0,al*2,800,al*2)
        end
        ]]
      ok = false
      for ak,cl in ipairs(Credits) do
          -- ok = ok and cl.y<(-500)
          ok = ok or cl.y>(-500)
          if cl.Img then
             Image.Color(255,255,255)
             Image.Draw(cl.Img,400-(Image.Width(cl.Img)/2),cl.y)
             -- Image.Draw(cl.Img,400,cl.y)
          else
             if cl.Big then Image.Font("Fonts/Abigail.ttf",25) elseif cl.NF then Image.NoFont() else Image.Font("Fonts/Coolvetica.ttf",15) end
             ARColor(cl.Color or {R=0,G=255,B=255})
             DText(cl.Txt,400,cl.y,2,0)
             end
          -- @IF CREDITSDEBUG
          Image.Color(255,255,255)
          Image.NoFont()
          DText(ak.."> (y="..cl.y..")",0,cl.y)
          -- @FI   
          Credits[ak].y = Credits[ak].y - 1
          end
      Flip()    
      end
end


__consolecommand.CREDITS = ShowCredits
