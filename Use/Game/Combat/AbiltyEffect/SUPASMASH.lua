--[[
/**********************************************
  
  (c) Jeroen Broks, 2014, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is stricyly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.

  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************/
 



Version: 14.08.05

]]
-- IMPORTANT!
-- THIS MOVE MAY ONLY BE PERFOMED BY BRENDOR OR THE SYSTEM WON'T LIKE YOU AND CRASH TO PUNISH YOU!!!!
function Combat_AbilityEffect.SUPASMASH(TGROUP,TARGET)
-- Did it hit or did it miss
local hitroll = rand(0,char.Brendor.Accuracy)
local evaroll = rand(0,Combat_Stat(TGROUP,TARGET,"Evasion"))
local G,G2
local chi,ak
for ak=1,4 do
    if party[ak]=='Brendor' then chi = ak end
    end
if not chi then Sys.Error("How can SUPASMASH happen without Brendor?") end    
G = 'Foe'
if Combat_GetHP(G,TARGET)<=0 then 
   Combat_InvalidMove("Player",chi) 
   return 
   end   
if hitroll<evaroll then 
   HurtP[G][TARGET] = "Miss"
   HurtT[G][TARGET] = 250
   HurtC[G][TARGET] = {150,150,150}
   char.Brendor.AP[1]=0   
   return
   end   
-- If it hit, then let's calculate how much damage it did do
local base = char.Brendor.AP[1]*(3/skill)  -- Combat_Stat(TGROUP,TARGET,"Strength")
local adie = rand(1,base/2)
local defb = Combat_Stat(TGROUP,TARGET,"Defense")
local ddie = rand(1,defb/5)
local totaldmg = base + adie
local totaldef = defb + ddie
local dmg = round(totaldmg-totaldef)
CSay("Combat rolls - Attack: "..adie.." - Defense: "..ddie)
if dmg<1 then dmg = 1 end
for ak=1,4 do
    if party[ak]=='Brendor' then chi = ak end
    end
if not chi then Sys.Error("How can SUPASMASH happen without Brendor?") end    
-- Combat_ShowAction("Player",chi)
Combat_Hurt("Foe",TARGET,dmg)
char.Brendor.AP[1]=0
return true
end
