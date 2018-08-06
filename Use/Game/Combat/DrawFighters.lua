--[[
/* 
  Draw the fighters in the field

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



Version: 14.09.10

]]



function Combat_EnemySpot(ak)
local spotx,spoty
    if ak<4 then
       spotx=60
       spoty=190 + (ak*90)
    elseif ak<7 then
       spotx=180
       spoty=190 + ((ak-3)*90)
    else
       spotx=300
       spoty=190 + ((ak-6)*90)
       end       
if FoeData[ak] and FoeData[ak].AltCoords then
   spotx = FoeData[ak].AltX
   spoty = FoeData[ak].AltY      
   end    
return spotx+enemspotmod[ak].x,spoty+enemspotmod[ak].y       
end

function Combat_PlayerSpot(ak)
spotx = 600
spoty = 190 + (ak*80)
return spotx,spoty
end

function Combat_TargetSpot(TG,TT)
local TS = {Combat_PlayerSpot,Combat_EnemySpot}
return TS[StN[TG]](TT)
end


hmodx=hmodx or {}
fmodx=fmodx or {}
fmody=fmody or {}
function Combat_DrawFighters(TGroup,Target)
local ak
local ch
local spotx,spoty
-- friend
for ak=1,4 do
    spotx,spoty=Combat_PlayerSpot(ak)
    hmodx[ak] = hmodx[ak] or 0
    -- @IF FIGHTLINES
    Image.Color(255,255,0)
    Image.Line(spotx,spoty,spotx-10,spoty)
    Image.Color(255,0,255)
    Image.Line(spotx,spoty,spotx+10,spoty)
    Image.Color(0,255,255)
    Image.Line(spotx,spoty,spotx,spoty-10)    
    -- @FI
    if party[ak] then
       ch = party[ak]
       Image.Color(255,255,255)
       if CharCastPose and CharCastPose[ak] then
          castpic = castpic or {}
          if not castpic[ch] then    -- If the pic's not loaded yet, let's do it now ;)
             castpic[ch] = Image.Load('GFX/Combat/CastHeroes/'..ch..'.png')
             if castpic[ch]=='ERROR' then Sys.Error('Cast Picture not loaded for "'..ch..'"'); end -- end ERROR
             if JCR5.Exist('GFX/Combat/CastHeroes/'..ch..'.hot')==0 then Image.Hot(castpic[ch],Image.Width(fightpic[ch])/2,Image.Height(fightpic[ch])); end
             end -- no castpic
          Image.Draw(castpic[ch],spotx+hmodx[ak],spoty)
          -- end of casting pose
       elseif char[ch].HP[1]>0 then
          fightpic = fightpic or {}
          if not fightpic[ch] then    -- If the pic's not loaded yet, let's do it now ;)
             fightpic[ch] = Image.Load('GFX/Combat/Heroes/'..ch..'.png')
             if fightpic[ch]=='ERROR' then Sys.Error('Picture not loaded for "'..ch..'"'); end -- end ERROR
             if JCR5.Exist('GFX/Combat/Heroes/'..ch..'.hot')==0 then Image.Hot(fightpic[ch],Image.Width(fightpic[ch])/2,Image.Height(fightpic[ch])); end
             end -- no fightpic
          Image.Draw(fightpic[ch],spotx+hmodx[ak],spoty)
          end -- HP>0   
       if char[ch].HP[1]==0 then
          deadpic = deadpic or {}
          if not deadpic[ch] then    -- If the pic's not loaded yet, let's do it now ;)
             deadpic[ch] = Image.Load('GFX/Combat/DeadHeroes/'..ch..'.png')
             if deadpic[ch]=='ERROR' then Sys.Error('DEAD Picture not loaded for "'..ch..'"'); else CSay("A picture for a dead "..ch.." is loaded now!")end -- end ERROR
             if JCR5.Exist('GFX/Combat/DeadHeroes/'..ch..'.hot')==0 then Image.Hot(deadpic[ch],Image.Width(deadpic[ch])/2,Image.Height(deadpic[ch])); end
             end -- no deadpic
          Image.Draw(deadpic[ch],spotx+hmodx[ak],spoty)
          end -- HP>0   
       end
    if HurtT.Player[ak] and HurtT.Player[ak]>0 then 
       Image.NoFont()
       Image.Color(0,0,0)
       DText(HurtP.Player[ak],spotx+2,spoty+2,1,1)
       Image.Color(HurtC.Player[ak][1],HurtC.Player[ak][2],HurtC.Player[ak][3])
       DText(HurtP.Player[ak],spotx,spoty,1,1)
       HurtT.Player[ak] = HurtT.Player[ak] - 1
       end
    if (TGroup=="Heroes" or TGroup=="Hero" or TGroup=="Players" or TGroup=="Player") and Target==ak then
       Image.Draw("C_PPoint",spotx,spoty-64)
       end
end
-- foe
for ak=1, 9 do
    spotx,spoty = Combat_EnemySpot(ak)
    -- @IF FIGHTLINES
    Image.Color(255,255,0)
    Image.Line(spotx,spoty,spotx-10,spoty)
    Image.Color(255,0,255)
    Image.Line(spotx,spoty,spotx+10,spoty)
    Image.Color(0,255,255)
    Image.Line(spotx,spoty,spotx,spoty-10)   
    Image.NoFont()
    Image.Color(255,255,255)
    if Foe[ak] then Image.DText(ak..". "..Foe[ak],spotx,spoty+3,2,0) end
    -- @FI        
    if Foe[ak] then
       fmodx[ak] = fmodx[ak] or 0
       fmody[ak] = fmody[ak] or 0
       FoeScale[ak] = FoeScale[ak] or 100
       if FoeData[ak]["HP"] <= 0 and FoeScale[ak]>0 and (not FoeData[ak].DontDisappear) then
          FoeScale[ak] = FoeScale[ak] - 5
	        if FoeScale[ak]<=0 then Foe[ak] = nil end
	        end       	  
       Image.Color(255,255,255)
       if FoeData[ak].OversoulState then Image.Color(200,60,255) end
       Image.ScalePC(100,FoeScale[ak])
       if foe_black and foe_black[ak] then Image.Color(0,0,0) end
       Image.Draw('FOE'..ak,spotx+fmodx[ak],spoty+fmody[ak])
       Image.ScalePC(100,100)
       if (TGroup=="Foes" or TGroup=="Foe" or TGroup=="Enemies" or TGroup=="Enemy") and Target==ak then
          Image.Draw("C_FPoint",spotx,spoty-Image.Height("FOE"..ak))
	        end
       end
    if HurtT.Foe[ak] and HurtT.Foe[ak]>0 then 
       Image.NoFont()
       Image.Color(0,0,0)
       DText(HurtP.Foe[ak],spotx+2,spoty+2,1,1)
       Image.Color(HurtC.Foe[ak][1],HurtC.Foe[ak][2],HurtC.Foe[ak][3])
       DText(HurtP.Foe[ak],spotx,spoty,1,1)
       HurtT.Foe[ak] = HurtT.Foe[ak] - 1
       end
    end
-- @IF DEVELOPMENT
   Image.Color(255,255,255)
   if TGroup then Image.DText("Group: "..TGroup,799,599,1,1) end
   if Target then Image.DText("Target: "..Target,799,579,1,1) end
-- @FI
end



function Combat_SwingWeapon(Actor)
local spotx,spoty
if not Actor then Sys.Error("No valid value given to Combat_SwingWeapon()") end
spotx,spoty = Combat_PlayerSpot(Actor)
local ch = party[Actor]
-- Initiaze the stuff if this hasn't yet been done before.
atpl = atpl or {} -- attack pic loaded
swpr = swpr or {} -- swing pic refereces
shpr = shpr or {} -- shooting weapon pic references
prpr = prpr or {} -- projectile pic references
-- The code below is only a safety precaution, it should basically NEVER happen this feature has to be actually used.
if not itemdata then
   Console.Write("!! WARNING !!",255,180,0)
   Console.Write("Item database wasn't loaded. Just reloading it!",255,180,0)
   FetchItemBase()
   if not itemdata then Sys.Error("Load Item Database Failed!") end
   end
-- Equipment MUST be set
if not equip then Sys.Error("Combat_SwingWeapon("..actor.."): Equipment not set at all") end
-- If the character has no equipment than don't crash out, but put a warning on the console!
if not equip[ch] then 
   Console.Write("!! WARNING !!",255,180,0)
   Console.Write("Character "..ch.." has no equipment! Is he/she correctly loaded?",255,180,0)
   return
   end
-- If the character has no equipment than don't crash out, but put a warning on the console!
if not equip[ch].WEAPON then 
   Console.Write("!! WARNING !!",255,180,0)
   Console.Write("Character "..ch.." has no weapon equipped! Is he/she correctly loaded?",255,180,0)
   return
   end   
-- Get item data
local wp = Str.Upper(equip[ch].WEAPON)
if not itemdata[wp] then Sys.Error("Can't load requested weapon for the strike animation","Actor,"..ch..";Weapon,"..wp) end
-- Shoot
if itemdata[wp].ShootPic and itemdata[wp].ShootPic~="" then
   CurrentShootPic = itemdata[wp].ShootPic
   SpellAni.AziellaShoot('Player',Actor,PlayAct[Actor])
   return
   end
-- Prepare swing picture
if (not atpl[wp]) then -- and itemdata[wp].SwingPic and itemdata[wp].SwingPic~="" then
    -- Swing picture
    Console.Write("We need a picture here for a weapon strike!",255,0,255)
    if JCR5.Exist("GFX/Combat/Strike/"..itemdata[wp].SwingPic)==1 then
       Console.Write("Setting up SwingPic: "..itemdata[wp].SwingPic.." for weapon: "..wp,255,255,0)
       swpr[wp] = Image.Load("GFX/Combat/Strike/"..itemdata[wp].SwingPic)
       Console.Write("  == Loaded at "..swpr[wp],0,255,255)
       if swpr[wp] == "ERROR" then Sys.Error("Swing weapon picture was not correctly loaded!","Actor,"..ch..";Weapon,"..wp..";Picture,"..itemdata[wp].SwingPic) end
       Image.Hot(swpr[wp],Image.Width(swpr[wp])/2,Image.Height(swpr[wp]))
     else
       Console.Write('WARNING',255,0,0)
       Console.Write('JCR5 could not find the requested SWING PIC image',255,0,0)
       Console.Write("GFX/Combat/Strike/"..itemdata[wp].SwingPic,255,0,0)
       end
   -- Shoot picture   
   -- Projectile picture
   -- Yes, something HAS been loaded
   atpl[wp] = true
   end
-- Is everything OK? Then let's get ready to rumble!!


-- Swing
local x = spotx + hmodx[Actor]
local y = spoty
local rad
local ak
local sound = 'SFX/Combat/CharAttack/'..sval(itemdata[wp].AttackSound)
if sound and sound~="" and right(Str.Lower(sound),4)~=".ogg" then sound = sound ..".ogg" end
if swpr[wp] then
   for ak=10,-10,-1 do
       Combat_DrawScreen()
       Image.Color(255,255,255)
       rad = (4.5*ak)
       Image.Rotate(rad)
       Image.Draw(swpr[wp],x+ak,y-60)
       Image.Rotate(0)
       Flip()
       end
   if sound and sound~="" and JCR5.Exist(sound)~=0 then SFX(sound) end     
   end    
end

function Combat_CastPose(Actor)
CharCastPose = CharCastPose or {}
CharCastPose[Actor]=true
for ak=10,-10,-1 do
    Combat_DrawScreen()
    Image.Color(255,255,255)
    Flip()
    end
CharCastPose[Actor]=false       
end
