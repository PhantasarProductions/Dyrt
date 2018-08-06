--[[
/*
	
	
	
	
	
	(c) , , All rights reserved
	
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
		
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
		
	Exceptions to the standard GNU license are available with Jeroen's written permission given prior 
	to the project the exceptions are needed for.
*/


Version: 14.11.13

]]
-- @USEDIR Scripts/Use/AnyWay
-- @USEDIR Scripts/Use/Maps



function DD(ch,dir)
local x,y = PlayerCoords()
local dg = { n = {x,y-1}, s = {x,y+1}, w = {x-1,y}, e = {x+1,y}}
MapText("DD_"..upper(ch))
Actors.Pick("Player")
Actors.WalkTo(dg[dir][1],dg[dir][2])
end

function DD_Irra()    DD('IRRA','w') end
function DD_Brendor() DD('BRENDOR','n') end
function DD_Scyndi()  DD('SCYNDI','n') end
function DD_Rebecca() DD('REBECCA','n') end
function DD_Dernor()  DD('DERNOR','n') end
function DD_Merya()   DD('MERYA','e') end
function DD_Aziella() DD('AZIELLA','e') end
function DD_Zooi()    DD("ZOOI","n") end

function ByeOraclePath()
if not CVV("&DONE.ORACLE") then return DD("LEAVEORACLETOOSOON","n") end
Teleport("BackCorridor")
end

function ToOraclePath()
if CVV("&DONE.ORACLE") then 
   DD("NOMOREORACLE","s")
   return 
   end
MapText("CRACK")
Teleport("OraPathS")
Look(0x3)
MapText("NACRACK")
end

function WelcomeOracle() if not CVV("&DONE.ORACLE") then MapText("WELCOMEORACLE") end end

function ACTOR_ORACLE()
if Done("&DONE.ORACLE") then 
   MapText("AFTERORACLE") 
   else 
   MapText("ORACLE");
   Maps.LayerDefValue(50,0,'WallsDeco',0,1) 
   end
end

function Einde()
if not CVV("&DONE.ORACLE") then return end
MapText("NAARBED")
Maps.LoadMap("CH4_Rayal_Palace")
SpawnPlayer("VoorKoning")
Look(0x4)
MapText("MORNING")
local ch = BoxQuestion(MapTextArray,"MORNINGCHOOSE1")
local start = {"CH4_Split/StartTeamEric.lua","CH4_Split/StartTeamRebecca.lua"}
LAURA.Shell(start[ch])
end


function GALE_OnLoad()
Music("Frozen Star")
ZA_Enter(0x4,WelcomeOracle)
ZA_Enter(0x1,Einde)
end
