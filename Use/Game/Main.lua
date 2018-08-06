--[[
/* 
  Game - Main functionality

  Copyright (C) 2013 Jeroen P. Broks

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



Version: 14.04.22

]]
function __Main()
cash = cash or 0
stones = stones or 0
Key.Flush()
repeat
areay = areay or 620
toey = toey or 620
if areay>575 then areay = areay - 1 end
if toey>575 and AllowTOE then toey = toey - 1 end
if toey<620 and (not AllowTOE) then toey = toey + 1 end
M1 = Mouse.Hit(1)==1
M2 = Mouse.Hit(2)==1
PressAction = ActionKeyHit() -- KeyHit(KEY_SPACE)
-- @IF DEVELOPMENT
if KeyHit(KEY_F1) then
	LAURA.Console()
	end
-- @FI
SpecialKeys()
Walk()
Maps.Run("ZA_doCycle",sval(OldZone))
AutoScroll()
CheckMenu()
DrawScreen()
if CVV("$ROOM.RUN") and CVV('$ROOM.RUN')~='' then
   Maps.Run(CVV('$ROOM.RUN'))
   Var.Clear('$ROOM.RUN')
   end
-- Image.DText("Player ("..Actors.PA_X()..","..Actors.PA_Y()..");     Fine ("..Actors.PA_MX()..","..Actors.PA_MY()..")    Mv"..Actors.Chosen.Mv,780,0,1,0) -- debug line.
-- @IF FIELDDEBUG
Image.NoFont()
Image.Color(255*Math.AlwaysPos(Math.Sin(Time.MSecs()/1000)),Math.AlwaysPos(Math.Cos(Time.MSecs()/1005))*255,(155*Math.AlwaysPos(Math.Sin(Time.MSecs()/1008)))+100)
Image.DText("Mouse ("..Mouse.X()..","..Mouse.Y()..")",780,0,1,0) if M1 then Image.DText("M1",780,15,1,0) end if M2 then Image.DText("M1",780,30,1,0) end -- debug line
if gamesteps then Image.DText("Steps: "..gamesteps,780,30,1,0) end
if GFMList and GFMList[1] then Image.DText("GFM Time: "..GFMList[1].FTime,780,45,1,0); Image.DText("GFM Alpha: "..GFMList[1].Alpha,780,60,1,0) end
-- @FI
Flip()
until GameBreak
StopMusic()
Sys.Bye()
end
