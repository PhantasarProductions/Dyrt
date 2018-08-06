--[[
/* 
  Spawn Heroes for LAURA projects, for linking to the main project

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

function SetActive(char)
if TrueSetActive then 
   TrueSetActive(char)
   else
   LAURA.ExecuteGame('TrueSetActive',char)
   end
end   

function SpawnPlayer(spotID)
if GameScript then
	TrueSpawnPlayer(spotID)
	else
	LAURA.ExecuteGame("TrueSpawnPlayer",spotID)
	end
end

function SpawnActor(spot,data,permanent)
if TrueSpawn then
   TrueSpawn(spot,data,permanent)
   return
   end
local keys = {
   ['ID']        = '$',
   ['SinglePic'] = '$',
   ['PicBundle'] = '$',
   ['ChosenPic'] = '$',
   ['MvX']       = '%',
   ['MvY']       = '%',
   ['R']         = '%',
   ['G']         = '%',
   ['B']         = '%'
   }  
local k,v
for k,v in pairs(keys) do
    Var.D(v..'SPAWN.'..k,data[k])
    end
Var.D('$SPAWN.SPOT',spot)
if permanent then Var.D('&SPAWN.PERMANENT','TRUE') else Var.D('&SPAWN.PERMANENT','FALSE') end
LAURA.ExecuteGame('TransferSpawn','')
end


function GrabTeleporter(spot)
if GameScript then
   Var.D("%GRAB.TELEPORTER.X"   ,teleporters[spot].X)
   Var.D("%GRAB.TELEPORTER.Y"   ,teleporters[spot].Y)
   Var.D("$GRAB.TELEPORTER.WIND",teleporters[spot].Wind)
   return teleporters[spot]
   else
   LAURA.ExecuteGame('GrabTeleporter',spot)
   return {X = CVV("%GRAB.TELEPORTER.X"), Y = CVV('%GRAB.TELEPORTER.Y'), Wind = CVV("$GRAB.TELEPORTER.WIND")}
   end   
end
