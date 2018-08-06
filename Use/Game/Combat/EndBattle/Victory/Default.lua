--[[
/* 
  

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



Version: 14.10.14

]]
function CheckVictory.Default()
local ret = true
local k,v
for k,v in pairs(FoeData) do
    if v.HP>0 and Foe[k] then ret = false end
    end
return ret
end


function VictoryAction.Default(CBData)
local experiencegained
local foundloot
local item,amount
local lootbox,expbox
local k,ch
local lee -- (local experience earned)
if CBData.CombatMusic~="*NOCHANGE*" then   
   if CBData.VictoryTune then StopMusic() TrueMusic(CBData.VictoryTune,true) end
   end
-- Check if anybody gains experience at all
if earnexperience>0 then
   -- local k,ch
   if flawlessvictory then
      AwardTrophy('COMBFLAWLESS')
      if skill==1 then earnexperience=earnexperience * 3 end      
      end
   for k,ch in pairs(party) do
       if char[ch].Experience then
          if skill==3 then
             if char[ch].HP[1]==0 then multiplier[ch]=0   
             elseif participated[ch] then multiplier[ch]=1; experiencegained=true else multiplier[ch]=0 end
          elseif skill==2 then
             if not participated[ch] then 
                 multiplier[ch]=0.75
             elseif flawlessvictory then
                 multiplier[ch]=multiplier[ch]+1 
                end
             if char[ch].HP[1]==0 then multiplier[ch]=.5 end   
             experiencegained=true
          elseif skill==1 then
             experiencegained=true
             if flawlessvictory then  multiplier[ch]= multiplier[ch]+3 end
          else
             Sys.Error("Unknown skill ("..skill..")")
             end -- skill check
          end -- character may gain exp?   
       end -- party loop
   end -- Did we gain exp at all?
-- If experience is gained, show the player how much
if experiencegained then
   expbox = {}
   expbox.lines = {}
   expbox.Head = '"'..(char[LastAction].Victory or "We won!")..'"' -- This will prevent an error if savegame data is corrupted.
   if flawlessvicotry then expbox.Head = '"'..(char[LastAction].Perfect or expbox.Head)..'"' end
   for k,ch in pairs(party) do
       lee = round(earnexperience*multiplier[ch])
       if char[ch].Experience and multiplier[ch]>0 then
          char[ch].Experience = char[ch].Experience - lee
          if char[ch].Experience<=0 then -- Level up!
             while char[ch].Experience and char[ch].Experience<=0  do
               char[ch].Level = char[ch].Level + 1
               if     skill==3 and char[ch].Level>= 50 then char[ch].Experience = nil; AwardTrophy("MAX"..Str.Upper(ch))
               elseif skill==2 and char[ch].Level>=100 then char[ch].Experience = nil; AwardTrophy("MAX"..Str.Upper(ch))
               elseif              char[ch].Level>=250 then char[ch].Experience = nil; AwardTrophy("MAX"..Str.Upper(ch))
               else   char[ch].Experience = char[ch].Experience + experiencetable[char[ch].Level] end
               end             
             if char[ch].Level==13 then char[ch].Level=14 end  
             table.insert(expbox.lines,"- "..Var.S(char[ch].Name).." gained "..lee.." EXP points and reached level "..char[ch].Level)
             Combat_AddLvUpMessage(Var.S(char[ch].Name).." gained a level",ch)
             GrabLevelStats(ch,char[ch].Level)
             if skill==1 then
                char[ch].HP[1] = char[ch].HP[2]
                end
             if levelup[ch] then levelup[ch]() end
             else
             table.insert(expbox.lines,"- "..Var.S(char[ch].Name).." gained "..lee.." EXP and needs "..char[ch].Experience.." to reach level "..round(char[ch].Level+1)) -- Round gave me the possibility to force mathematics in this line
             end -- Level up or not?
          end -- char gain exp 
       end -- for k,ch
   BattleBoxText(expbox)          
   end -- If exp gained
-- Are we all at the max level?
local chchars, numskills 
if char.Yasathar then
   chchars = { Yasathar = 5, Irravonia = 5, Brendor = 1, Scyndi = 5, Rebecca = 1, Dernor = 2, Merya = 2, Aziella = 2}
   else    
   chchars = { Eric = 5, Irravonia = 5, Brendor = 1, Scyndi = 5, Rebecca = 1, Dernor = 2, Merya = 2, Aziella = 2}
   end
local maxallchar = true
local maxallskill = true   
local maxlevels = {250,100,50}
for ch,numskills in spairs(chchars) do
    maxallchar = maxallchar and char[ch]
    maxallskill = maxallskill and char[ch]
    maxallchar = maxallchar and char[ch].Level == maxlevels[skill]
    for ak=1,numskills do 
        maxallskill = maxallskill and char[ch].SkillLevels[ak] == maxlevels[skill]
        end
    end
if maxallchar then AwardTrophy("MAXALLCHAR") end
if maxallskill then AwardTrophy("MAXALLSKILL") end
if maxallchar and maxallskill then AwardTrophy("MAXALL") end       
-- Check if any item or money was found
if (earncash and earncash>0) or (earnstones and earnstones>0) then foundloot=true end
if (earnitems['*']) then foundloot=true; earnitems['*']=nil end
-- If any items are scored, show the player what they scored and how much
if foundloot then
   lootbox = {}
   lootbox.lines = {}
   lootbox.Head = "You found treasure"
   if earncash and earncash>0 then 
      table.insert(lootbox.lines,"= "..earncash.." "..gamecurrency)
      cash = cash + earncash
      end
   if earnstones and earnstones>0 and allowstones then 
      if earnstones==1 then table.insert(lootbox.lines,"= One Magic Stone") else table.insert(lootbox.lines,"= "..earnstones.." magic stones") end
      stones = stones or 0
      stones = stones  + earnstones
      end
   for item,amount in pairs(earnitems) do
       inventory[item] = inventory[item] or 0
       inventory[item] = inventory[item] +  amount
       if inventory[item]>imax() then inventory[item]=imax() end
       table.insert(lootbox.lines,"= "..amount.."X   "..itemdata[item].Name)
       end
   BattleBoxText(lootbox)
   end
if CBData.CombatMusic~="*NOCHANGE*" then PullMusic() end   
VictoryCount = (VictoryCount or 0) + 1
CSay(VictoryCount.." battles won so far!")
if not trophyVictories then
   trophyVictories = {}
   for ak,k in spairs(achievements) do
       local stk = "COMBVICTORY"
       local lnk = Str.Length(stk)
       if Str.Left(ak,lnk) == stk then table.insert(trophyVictories,Sys.Val(Str.Right(ak,Str.Length(ak)-lnk))) end
       end
   end
for ak,k in ipairs(trophyVictories) do
    if VictoryCount>=k and (not achieved["COMBVICTORY"..k]) then AwardTrophy("COMBVICTORY"..k) end
    end
-- Revive the dead (yes even in the hard mode. Call me lazy, but it's too much trouble doing this otherwise).
for ak,ch in pairs(party) do
    if char[ch].HP[1]==0 then
       -- @SELECT skill
       -- @CASE 1
          char[ch].HP[1]=round(char[ch].HP[2]*.25) 
       -- @CASE 2
          char[ch].HP[1]=round(char[ch].HP[2]*.1) 
       -- @CASE 3
          char[ch].HP[1]=1 
       -- @ENDSELECT   
       end 
    end    
return true
end

function __consolecommand.SETVICCOUNT(a)
VictoryCount = Sys.Val(a[1])
end

