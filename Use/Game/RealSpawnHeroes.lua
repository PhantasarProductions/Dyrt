--[[
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 2.0
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is (c) Jeroen P. Broks.
 *
 * The Initial Developer of the Original Code is
 * Jeroen P. Broks.
 * Portions created by the Initial Developer are Copyright (C) 2013
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 * -
 *
 * ***** END LICENSE BLOCK ***** */



Version: 14.04.20

]]


function TrueSpawnPlayer(spot)
local x,y,w
if not teleporters[spot] then Sys.Error('TrueSpawn spot '..spot..' has not been found') end
x = teleporters[spot].X
y = teleporters[spot].Y
w = teleporters[spot].Wind
if teleporters[spot].CamX~=0 and teleporters[spot].CamY~=0 then
   Maps.CamX = teleporters[spot].CamX
   Maps.CamY = teleporters[spot].CamY
   end
CSay("Going to spawn a player")
Spawn.ID = "Player"; CSay("ID set to 'Player")
Spawn.SinglePic = "" CSay("SinglePic has been set to an empty string")
Spawn.PicBundle = "PLAYER"; CSay("Pic bundle set to 'Player'")
Spawn.ChosenPic = Str.Upper(activecharacter).."."..Str.Upper(w); CSay("Chosen pic is set to "..Str.Upper(activecharacter).."."..Str.Upper(w))
Spawn.ChosenFrame = 0; CSay("Chosen picture is set to 0")
Spawn.MvX = 0
Spawn.MvY = 0
Spawn.R = 255
Spawn.G = 255
Spawn.B = 255
Spawn.IgnoreBlockMap = 1
Actors.Spawn(x,y); CSay("Player should have spawned")
end

function TrueSetActive(char)
activecharacter = char
Actors.Pick("Player")
Actors.ChoosePic(activecharacter.."."..Actors.PA_Wind())
end

function TrueSpawn(spot,data,permanent,OnlyNew)
local k,v
local r = 128
local g = 126
local b = 64
if not teleporters[spot] then Sys.Error('TrueSpawn spot '..spot..' has not been found') end
local x = teleporters[spot].X
local y = teleporters[spot].Y
local w = teleporters[spot].Wind
Spawn.ID             = data.ID or 'UNKNOWN:'..rand(1,1000000)
Spawn.SinglePic      = data.SinglePic
Spawn.PicBundle      = data.PicBundle
Spawn.ChosenFrame    = data.ChosenFrame or 0
Spawn.ChosenPic      = data.ChosenPic
Spawn.IgnoreBlockmap = data.IgnoreBlockmap or 0
Spawn.MvX            = data.MvX or 0
Spawn.MvY            = data.MvY or 0
Spawn.R              = data.R or 255
Spawn.G              = data.G or 255
Spawn.B              = data.B or 255
Console.Write('Spawning actor "'..data.ID..'" at ('..x..','..y..')',r,g,b)
Actors.Spawn(x,y,0,permanent,OnlyNew)
end

function TransferSpawn()
local data = {}
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
    data[k] = Var.C(v..'SPAWN.'..k)
    if v=='%' then data[k] = Sys.Val(data[k]) end
    end
local spot = Var.C('$SPAWN.SPOT')
local permanent = Var.C('&SPOT.PERMANENT')=='TRUE'
Var.D('&SPOT.PERMANENT','FALSE')
TrueSpawn(spot,data,permanent)    
end
