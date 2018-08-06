--[[
/* 
  Main routines combat

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



Version: 14.07.03

]]

-- @DEFINE E_A_RESPOND_DEBUG

-- @IF IGNOREME
__consolecommand = {}
-- @FI

-- Initiative
-- 1 = Initiative
-- 2 = Ambushed
-- Nil or any other value is a normal fight
function Combat_Init(CombatData)
local ak,al,f,ch,base,sk
-- Reset Combat messae, so that messages from a previous battle will not be shown
Combat_Message_Stuff = {}
-- Make sure other functions know that it's combat we're dealing with now!
CombatRunning = true
-- Set value for making the interface scroll in
StuffY = 300
-- Default Gauge Settings according to initiative settings
CombatTime = { ["Heroes"] = {0,0,0,0}, ["Foes"] = {0,0,0,0,0,0,0,0,0,0}}
if CombatData.Initiative==1 then Combat_Message('Initiative') CombatTime.Heroes={9000,9000,9000,9000} end -- Initiative. All heroes have 9000 points advantage
if CombatData.Initiative==2 then Combat_Message('Ambushed')   CombatTime.Foes  ={9000,9000,9000,9000,9000,9000,9000,9000,9000} end -- Ambused. All foes have 9000 points advantage
local k,ct,chi,t
CSay("Adjusting combat time!")
for k,ct in pairs(CombatTime) do
    for chi,t in pairs(ct) do
        CombatTime[k][chi] = t + (rand(1,3000)-1500)    
        if CombatTime[k][chi]>9900 then CombatTime[k][chi]=9900 end    
        CSay("CombatTime."..k..'['..chi..'] = '..CombatTime[k][chi])
        end
    end
-- Who are our foes?
Combat_LoadFoes(CombatData)
-- Background (or "Arena") picture load
Combat_Arena = CombatData.Arena -- The After Effect needs this var
Image.AssignLoad("Arena","GFX/Arena/"..CombatData.Arena)
-- Load Music if it should be loaded
CombatMusic = (CombatData["Music"]~="*NOCHANGE*")
if CombatMusic then
   PushMusic()
   Music(CombatData["Music"])
   CombatVictoryTune = CombatData["VictoryTune"]
   else
   CombatData["VictoryTune"] = nil
   CombatVictoryTune = nil
   PushedMusic = {}
   end
-- Oversoul count Init
CountOversoul = CountOversoul or {}
-- Init FoeScale
FoeScale = {}
-- Init Time Gauge Speed
HiSpeed=1
for ak=0,1 do
    for al=1,9 do
        CSay("- Speed Check on ("..ak..","..al.."):  "..Combat_Stat(ak,al,"Agility"))
        if Combat_Stat(ak,al,"Agility")>HiSpeed then HiSpeed=Combat_Stat(ak,al,"Agility") end
	end
    end
CSay("Highest speed = "..HiSpeed)
-- Init Experience Awarding stuff
earnexperience = 0
multiplier = {}
participated = {}
for ak,al in pairs(party) do 
    multiplier[al] = 1
    participated[al] = false
    end
-- Init the AP values
for ak,ch in pairs(party) do
    base = 0
    for al,sk in pairs(char[ch].SkillLevels) do
        base = base + (sk * char[ch].SkillFP[al])
        end
    char[ch].AP = char[ch].AP or {0,char[ch].Level*10}        
    if skill~=3 or (char[ch].AP[1]>base) then         
       char[ch].AP = { base , char[ch].Level*10 }
       end
    end
-- Cash
earncash = 0
-- Items
earnitems = {}
-- Magic Stones
earnstones = 0
-- Last Action
LastAction = party[1]  -- If you (in theory) win a battle without taking actions, the character first in the party will be the one to talk
-- Reset 'Hurt' values
HurtP = {['Foe']={},['Player']={}}
HurtT = {['Foe']={},['Player']={}}
HurtC = {['Foe']={},['Player']={}}
-- Reset enemy status changes as the enemies NEVER start with status changes unless set otherwise, but at first, we set them this way.
StatusSet[StN["Foe"]] = {}
-- A few settings
flawlessvictory = true
MiniMessage.Combat = {}
-- Reset Enemy Position Modifiers
enemspotmod = {}
for ak=0,9 do
    enemspotmod[ak] = { x=0,y=0 }
    end
Combat_Reset_Enemy_List()
-- Onyx steal tutorial if applicable
for ak=1,9 do
    if FoeData[ak] and FoeData[ak].OnyxInvincibility and (not Done('&DONE.TUTOR.ONYXKEY')) then
       SerialBattleBoxText('Tutorial/OnyxKey','ONYXKEY')
       end
    end
end
    
-- Reset enemy list
function Combat_Reset_Enemy_List()
FoeShowList = {}
local akfoe,vlfoe 
for ak,akfoe in pairs(Foe) do
    if not FoeShowList[akfoe] then
       FoeShowList[akfoe] = {}
       FoeShowList[akfoe].Name = FoeData[ak].Name
       FoeShowList[akfoe].Count = Combat_CountFoe(akfoe)
       end
    end
local vkf_x=900
local vkf_y=50    
for akfoe,vlfoe in spairs(FoeShowList) do
    FoeShowList[akfoe].X = vkf_x; vkf_x=vkf_x+100
    FoeShowList[akfoe].Y = vkf_y; vkf_y=vkf_y+25
    end       
end

function Combat_CountFoe(foeid)
local ret = 0
local f
for _,f in pairs(Foe) do
    if f==foeid then ret = ret + 1 end
    end
return ret    
end


function Combat_InitFromVars()
local ak,vr
local vcombat = {}
for ak,vr in PBV(false) do
    vcombat[vr] = Var.C('$COMBAT.'..vr)
    end
Var.D("&VICTORY",Str.Upper(sval(Combat(vcombat))))    
end

function Combat_SyncFoe(Num,Oversoul)
local i,d,p,ch
FoeData = FoeData or {}
FoeData[Num] = {}
for i,d in pairs(FoeMainData[Num]) do
    Ok=false
    if Str.Left(i,4)=='Gen_'   then Ok=true p=4 end
    if Str.Left(i,5)=='Item_'  then Ok=true p=0 end
    if Str.Left(i,5)=='Drop_'  then Ok=true p=0 end
    if Str.Left(i,6)=='Steal_' then Ok=true p=0 end
    if Str.Left(i,3)=='Abl'    then Ok=true p=0 end
    if Str.Left(i,4)=="RES_"   then Ok=true p=0 end
    if Str.Left(i,5)=='Over_'  and (    Oversoul) then Ok=true p=5 end 
    if Str.Left(i,5)=='Base_'  and (not Oversoul) then Ok=true p=5 end
    if i=='Oversoul'           then Ok=true p=0 end 
    if Ok then
       --[[
       if type(d)=='numbar' and d<0 and Str.Left(i,4)~="RES_" then 
          ch = party[d*-1]
          d = char[ch][Str.Right(i,Str.Length(i)-p)] or 1
          CWrite("Enemy #"..Num.." (Oversoul:"..sval(Oversoul)..") copies value "..d.." on stat "..Str.Right(i,Str.Length(i)-p).." from character: "..ch)
          end
       ]]   
       FoeData[Num][Str.Right(i,Str.Length(i)-p)] = d 
       end
    end
end

function Combat_LoadFoes(CombatData,noreset)
local FIM,FNM
if noreset then
   Foe = Foe or {}
   else
   Foe = {}
   end
for ak=1,9 do
    if CombatData['Enemy'..ak] and CombatData['Enemy'..ak]~='' then
       -- Let's load the picture first!
       FNM = CombatData['Enemy'..ak]
       Foe[ak] = upper(FNM)
       if FoeData then FoeData[ak] = {} end
       FIM = Image.Load('GFX/Combat/Foes/'..FNM..'.png')
       if FIM=='ERROR' then 
          Sys.Error('No picture found for foe "'..FNM..'"')
	        end
       if JCR5.Exist('GFX/Combat/Foes/'..FNM..'.hot')==0 then Image.Hot(FIM,Image.Width(FIM)/2,Image.Height(FIM)); end  
       Image.Assign(FIM,'FOE'..ak)       
       CSay("Foe '"..FNM.."' picture loaded at "..FIM.." now assigned to 'FOE"..ak.."'")
       -- Let's now download the data we need
       FoeMainData = FoeMainData or {}
       FoeMainData[ak] = FetchDataRecord('Data/Foes',FNM)
       Combat_SyncFoe(ak,false)
       if FoeScale then FoeScale[ak] = 100 end
       end
    end
end

S_Hero = 0
S_Foe  = 1


function Combat_Stat(FOF,ak,Stat) -- FOF = Friend or Foe?
local ret = 0
local ch
local TFOF = FOF
if FOF == 'Heroes' or FOF == 'Hero' or FOF=='Player' or FOF=='Players' then TFOF=S_Hero end
if FOF == 'Foes'   or FOF == 'Foe'  or FOF=='Enemies' or FOF=='Enemy'  then TFOF=S_Foe  end
-- Let's first determine the main value + weapon bonus 
-- @SELECT TFOF
-- @CASE S_Hero
   ch = party[ak]
   if not ch then return 0 end
   -- Main value
   ret = char[ch][Stat]
   if not ret then CWrite("WARNING!",255,180,0); CWrite("Stat became nil!  ch="..sval(ch).." Stat="..sval(Stat)) end 
   -- Equipment
   ret = ret + Stat_Mod(ch,Stat)
   
   
-- @CASE S_Foe
   if not FoeData then return 0 end
   if not FoeData[ak] then return 0 end
   ret = FoeData[ak][Stat]
-- @DEFAULT
   Sys.Error("Combat.Stat("..FOF..",'"..Stat.."'): Unknown group!")
-- @ENDSELECT
-- Buffs & Debuffs
local buffch
for status , data in pairs(StatusData) do
    if not StN[FOF] then Sys.Error("Buff/Debuff manager could not find key number for: "..FOF) end
    if StN[FOF]==1 then buffch = party[ak] else buffch=ak end
    StatusSet[StN[FOF]] = StatusSet[StN[FOF]] or {}
    StatusSet[StN[FOF]][buffch] = StatusSet[StN[FOF]][buffch] or {}
    if data.StatUp==Stat then
       if StatusSet[StN[FOF]][buffch][status] then ret = math.floor(ret*1.25) end
       end 
    if data.StatDown==Stat then
       if StatusSet[StN[FOF]][buffch][status] then ret = math.floor(ret*0.75) end
       end 
    end
-- We got everything let's return our shit
if (ret or 0)<1 then ret = 1 end
return ret
end

function Combat_RealAct(ActArray)
local ret = 'UNKNOWN ACTION' -- Standard value if no action could be retrieved. Basically this should never be returned
if ActArray.Action == 'ATK' then ret = 'Attack' end
if ActArray.Action == 'ABL' then ret = Abilities[ActArray.Ability].Name end
if ActArray.Action == 'ITM' then ret = 'Use Item' end
if ActArray.Action == 'GRD' then ret = 'Guarding' end
if ActArray.Action == 'LRN' then ret = 'Learn a new skill' end
if ActArray.Action == 'JUG' then ret = 'Juggernaut Attack' end
if ActArray.Action == 'OVERSOUL' then ret = 'Oversoul' end
return ret
end

function Combat_ShowAct(TGROUP,TRGT)
ret = 'UNKNOWN' -- Standard value if no action could be retrieved. Basically this should never be returned
local player = TGROUP=='Player' or TGROUP=='Hero' or TGROUP=='Players' or TGROUP=='Heroes'
local enemy  = TGROUP=='Enemy'  or TGROUP=='Foe'  or TGROUP=='Enemies' or TGROUP=='Foes'
local TG = TGROUP
if player then
   if CombatTime.Heroes[TRGT]< 10000 then ret = "IDLE" end
   if CombatTime.Heroes[TRGT]==10000 then ret = "Enter Command" end
   if CombatTime.Heroes[TRGT]> 10000 then ret = Combat_RealAct(PlayAct[TRGT]) end
   end
if enemy then
   if CombatTime.Foes[TRGT]  < 10000 then ret = "IDLE" end
   if CombatTime.Foes[TRGT]  ==10000 then ret = "Thinking" end
   if CombatTime.Foes[TRGT]  > 10000 then ret = Combat_RealAct(FoeAct[TRGT]) end
   end    
return ret
end



function Combat_InputEnemyMoves()
local ak,al
local IM
local OversoulMax = {1234567890,20,10}
local gooversoul
for ak=1,9 do
    if CombatTime.Foes[ak]==10000 then
       if skill~=1 and FoeData[ak].Oversoul and CountOversoul and (CountOversoul[Str.Upper(Foe[ak])] or 0)>=OversoulMax[skill] and (not FoeData[ak].OversoulState) then
          gooversoul = true
          CSay('- Hmm... Minimal requirement for oversoul has been reached. Can we go oversoul here?')
          for al=1,9 do
              if Str.Upper(Foe[ak])==Str.Upper(Foe[al]) and ak~=al then
                 if FoeData[al] and FoeData[al].HP>0 and FoeData[al].OversoulState then gooversoul = false CSay('  = Rejected. Another character has already gone oversoul.')end
                 if FoeAct and FoeAct[al] and FoeAct[al].Action == 'OVERSOUL' then gooversoul = false CSay('  = Rejected. Somebody is already going for oversoul.') end
                 end
              end
              -- No objections? Then let's go oversoul!              
          if gooversoul then
             FoeAct     = FoeAct     or {}
             FoeAct[ak] = FoeAct[ak] or {}
             FoeAct[ak].Action      = 'OVERSOUL'
             FoeAct[ak].ActSpeed    = 1000
             FoeAct[ak].TargetGroup = 'Foes'
             FoeAct[ak].Target      = ak
             CombatTime.Foes[ak] = 10001
             return
             end 
          end
       FoeData[ak]["FightingStyle"] = FoeData[ak]["FightingStyle"] or "Default"
       if FoeData[ak]["FightingStyle"] == "" then FoeData[ak]["FightingStyle"] = "Default" end
       IM = FoeData[ak]["FightingStyle"] 
       if not E_IMove[IM] then Sys.Error("Non-existent E_IMove") end
       E_IMove[IM](ak)
       CombatTime.Foes[ak] = 10001
       end
    end
end



PlayAct = {{},{},{},{}}
function Combat_InputPlayer(chnr)
local ch = party[chnr]
local ok = false
local abl,itm
repeat
-- @IF DEVELOPMENT
if KeyHit(KEY_NUMMULTIPLY) then 
  Sys.Bye() -- Emergency crashout routine in the DEVELOPMENT version of the game
  -- LAURA.Console()
  end
-- @FI
-- Confusion or other stuff that makes you lose control over your character?
for sti,sts in pairs(StatusSet[StN["Player"]][ch]) do
    std = StatusData[sti]
    if std.AltInput then 
       PlayAct[chnr] = std.AltInput("Player",chnr)
       CombatTime.Heroes[chnr] = 10001
       return
       end 
    end
-- If you are in control, let's go!
Audio.Play("C_Signal")
Image.Cls()
Image.Color(255,255,255)
Combat_DrawScreen()
PlayAct[chnr]["Action"] = Combat_MainMenu(chnr)
ch = party[chnr]
StatusSet[StN["Player"]][ch] = StatusSet[StN["Player"]][ch] or {}
local sti,std,sts 
if PlayAct[chnr]["Action"] == "ATK" then
   PlayAct[chnr]["TargetGroup"] = "Foes"
   PlayAct[chnr]["Target"] = Combat_PlayerSelectEnemyTarget()
   PlayAct[chnr]["ActSpeed"] = 250
   ok = PlayAct[chnr]["Target"]
   if not StatusSpellBlock("Player",chnr) then Combat_CheckTeachList(chnr) end
   end
if PlayAct[chnr]["Action"] == "ABL" then
   CSay("Player chose to pick a special ability. Let's select one")
   PlayAct[chnr]["Ability"] = Abil_List(ch,true)
   if PlayAct[chnr].Ability then CSay("Ability Selected: "..PlayAct[chnr].Ability..", let's now pick our target") else CSay("Selection cancelled! Let's get outta here!") end
   if PlayAct[chnr]["Ability"] then
      abl = Abilities[PlayAct[chnr]["Ability"]]
      if     abl.Target == "OS" then PlayAct[chnr]["TargetGroup"] = "Players";   PlayAct[chnr].Target = chnr 
      elseif abl.Target == "1F" then PlayAct[chnr]["TargetGroup"] = "Foes";      PlayAct[chnr].Target = Combat_PlayerSelectEnemyTarget()
      elseif abl.Target == "1A" then PlayAct[chnr]["TargetGroup"] = "Players";   PlayAct[chnr].Target = Combat_PlayerSelectPlayerTarget()
      elseif abl.Target == "EV" then PlayAct[chnr]["TargetGroup"] = "Everybody"; PlayAct[chnr].Target = true
      elseif abl.Target == "AA" then PlayAct[chnr]["TargetGroup"] = "Players"    PlayAct[chnr].Target = true
      elseif abl.Target == "AF" then PlayAct[chnr]["TargetGroup"] = "Foes"       PlayAct[chnr].Target = true
      else   Sys.Error("Unknown ability target setting","Target Setting,"..abl.Target ) end
      PlayAct[chnr]["ActSpeed"] = abl.Speed
      if abl.SKLCut and abl.SKLCut>0 and char[ch].SkillLevels[2] then PlayAct[chnr]["ActSpeed"] = PlayAct[chnr]["ActSpeed"] + (char[ch].SkillLevels[2]/abl.SKLCut) end
      ok = PlayAct[chnr].Target
      if abl.GameSpellFunction and Combat_ExtraInput[abl.GameSpellFunction] then ok = ok and Combat_ExtraInput[abl.GameSpellFunction](chnr) end
      else
      ok = false
      end
   CSay("All done, let's get back to the game cycle!")   
   end  
if PlayAct[chnr]["Action"] == "ITM" then
   PlayAct[chnr]["Item"]  = PickItem({"Healing","Spell"})
   if PlayAct[chnr].Item then
      itm = itemdata[PlayAct[chnr].Item]
      CSay("Item chosen: "..PlayAct[chnr].Item)
      CSay("Item Type:   "..itm["Item Type"])
      if itm["Item Type"] == "Healing" then
         PlayAct[chnr]["TargetGroup"] = "Players";   PlayAct[chnr].Target = Combat_PlayerSelectPlayerTarget()
         ok = PlayAct[chnr].Target
         PlayAct[chnr].ActSpeed = rand(200,400)
         end
      else
      Console.Write("Use cancelled the selection of an item",255,0,0)   
      end 
   end
if PlayAct[chnr]["Action"] == 'GRD' then 
   PlayAct[chnr].TargetGroup = Player
   PlayAct[chnr].Target = chnr
   PlayAct[chnr].ActSpeed =  ((Combat_Stat('Player',chnr,"Agility")/HiSpeed)*25)
   CombatTime['Heroes'][chnr] = 10001
   ok=true
   end   
Flip()
until ok
CombatTime.Heroes[chnr] = 10001
end

function Combat_CheckTeachList(chnr)
local ch = party[chnr]
if not teachlist[ch] then Console.Write(ch..': No teachlist found',255,0,0); return nil end
if not teachlist[ch][1] then Console.Write(ch..': Teachlist is currently empty',255,0,0) return nil end
Console.Write(ch..": a new spell found! Standby!")
PlayAct[chnr].Action = "LRN"
PlayAct[chnr].LearnAbility = teachlist[ch][1]
PlayAct[chnr].Ability = Str.Upper("CH_"..ch.."_"..teachlist[ch][1])
abl = Abilities[PlayAct[chnr].Ability]
if not abl then Sys.Error("Ability "..PlayAct[chnr].Ability.." gave nil for data") end
-- @SELECT abl.Target
-- @CASE "OS"
   PlayAct[chnr]["TargetGroup"] = "Players";   PlayAct[chnr].Target = chnr 
-- @CASE "1A"   
   PlayAct[chnr]["TargetGroup"] = "Players";   PlayAct[chnr].Target = chnr 
-- @CASE "AA"
   PlayAct[chnr]["TargetGroup"] = "Players";   PlayAct[chnr].Target = chnr 
-- @ENDSELECT
PlayAct[chnr].ActSpeed = 900
return true
end


function Combat_PlayerSelectEnemyTarget()
local mx = Mouse.X()
local my = Mouse.Y()
local ak,sx,sy
local ch = nil
local timeout = 0
Key.Flush()
for ak=1,9 do
    if Foe[ak] and (not ch) then ch=ak end
    end
if not ch then Sys.Error("Trying to select an enemy from an empty enemy field") end    
repeat
timeout=0
-- Keyboard input
if CancelKeyHit() then return nil end -- KeyHit(KEY_ESCAPE) then return nil end -- Cancel the action
if KeyHit(KEY_UP) or joydirhit('U') then 
   repeat
   ch = ch - 1
   if ch<1 then ch=9 end
   timeout=timeout+1; if timeout>1000 then return nil end -- cancel if no target can be found
   until Foe[ch]
   end
if KeyHit(KEY_DOWN) or joydirhit('D') then 
   repeat
   ch = ch + 1
   if ch>9 then ch=1 end
   timeout=timeout+1; if timeout>1000 then return nil end -- cancel if no target can be found
   until Foe[ch]
   end
if KeyHit(KEY_LEFT) or joydirhit('L') then 
   repeat
   ch = ch - 3
   if ch<1 then ch=ch+9 end
   timeout=timeout+1; if timeout>1000 then return nil end -- cancel if no target can be found
   until Foe[ch]
   end
if KeyHit(KEY_RIGHT) or joydirhit('R') then 
   repeat
   ch = ch + 3
   if ch>9 then ch=ch-9 end
   timeout=timeout+1; if timeout>1000 then return nil end -- cancel if no target can be found
   until Foe[ch]
   end
if ActionKeyHit() then --KeyHit(KEY_ENTER) or KeyHit(KEY_SPACE) then 
   return ch 
   end
-- Mouse input
if mx~=Mouse.X() or my~=Mouse.Y() then
   for ak=1,9 do
       if Foe[ak] then
          sx,sy=Combat_EnemySpot(ak)
	  if mx>sx-16 and mx<sx+16 and my<sy and my>sy-64 then ch=ak end
	  end -- if Foe[ak]
       end -- For    
   mx = Mouse.X()
   my = Mouse.Y()    
   end -- Mouse Check  
if Mouse.Hit(1)~=0 then
   return ch
   end
Image.Cls()   
Combat_DrawScreen('Foe',ch)
Combat_TargetInfo('Foe',ch)
Flip()  
until false -- In other words, loop forever!!!
end


function Combat_PlayerSelectPlayerTarget()
local mx = Mouse.X()
local my = Mouse.Y()
local ak,sx,sy
local ch = nil
local timeout = 0
Key.Flush()
for ak=1,4 do
    if party[ak] and (not ch) then ch=ak end
    end
if not ch then Sys.Error("Trying to select a hero from an empty hero field","WARNING!,This error can only occur;,when there is a REALLY SERIOUS BUG;,in the system!;,',Please go to http://dyrt.sourceforge.net;,to report this bug immediately!") end
CSay("On which hero are we going to cast this spell?")
repeat
timeout=0
-- Keyboard input
if CancelKeyHit() then CSay("Request Cancelled") return nil end -- Cancel the action
if KeyHit(KEY_UP) or joydirhit('U') then 
   repeat
   ch = ch - 1
   if ch<1 then ch=4 end
   timeout=timeout+1; if timeout>1000 then return nil end -- cancel if no target can be found
   until party[ch]
   end
if KeyHit(KEY_DOWN) or joydirhit('D') then 
   repeat
   ch = ch + 1
   if ch>4 then ch=1 end
   timeout=timeout+1; if timeout>1000 then return nil end -- cancel if no target can be found
   until party[ch]
   end
if ActionKeyHit() then -- KeyHit(KEY_ENTER) or KeyHit(KEY_SPACE) then 
   CSay('Hero #'..ch..' selected by keyboard or joypad')
   return ch 
   end
-- Mouse input
if mx~=Mouse.X() or my~=Mouse.Y() then
   for ak=1,4 do
       if party[ak] then
          sx,sy=Combat_PlayerSpot(ak)
	  if mx>sx-16 and mx<sx+16 and my<sy and my>sy-64 and party[ak] then ch=ak end
	  end -- if Foe[ak]
       end -- For    
   mx = Mouse.X()
   my = Mouse.Y()    
   end -- Mouse Check  
if Mouse.Hit(1)~=0 then
   CSay('Hero #'..ch..' selected by mouse') 
   return ch
   end
Image.Cls()   
Combat_DrawScreen('Player',ch)
Combat_TargetInfo('Player',ch)
Flip()  
until false -- In other words, loop forever!!!
end


function Combat_InputPlayerMoves()
local ak
for ak=1,4 do
    if CombatTime.Heroes[ak]==10000 then Combat_InputPlayer(ak) end
    end
end

function Combat_InputMoves()
Combat_InputPlayerMoves()
Combat_InputEnemyMoves()
end

HurtP = HurtP or {['Foe']={},['Player']={}}
HurtT = HurtT or {['Foe']={},['Player']={}}
HurtC = HurtC or {['Foe']={},['Player']={}}

function Combat_RemoveFoe(TARGET)
CSay("Removing foe: "..TARGET)
if FoeData[TARGET].Boss then CSay("= Rejected! Foe appears to be a boss enemy!") return false end
if upper(left(Foe[TARGET],5))=="KIDS_" then CSay("= Rejected! Foe is one of the children of Frundarmon") return false end
FoeData[TARGET] = nil
Foe[TARGET] = nil
CSay("= Target successfully removed!")
return true
end

function Combat_KillFoe(TARGET)
local drop
local ak
if Str.Upper(Foe[TARGET])=="HIRELING" then AwardTrophy("KILLHIRELING") end
if Str.Upper(Foe[TARGET])=="BUG" then AwardTrophy("KILLBUG") end
if FoeData[TARGET].Boss then
   AwardTrophy('BOSS'..Str.Upper(Foe[TARGET]))
   end
-- If the 'E_Die' value is set for this enemy, execute that.
if FoeData[TARGET].FightingStyle~='' and E_Die[FoeData[TARGET].FightingStyle] then E_Die[FoeData[TARGET].FightingStyle]() end
-- Set to 0 to prevent any bugs
FoeData[TARGET].HP = 0
-- Update the bestiary
Bestiary                         = Bestiary              or {}
Bestiary[Str.Upper(Foe[TARGET])] = Bestiary[Str.Upper(Foe[TARGET])] or 0
Bestiary[Str.Upper(Foe[TARGET])] = Bestiary[Str.Upper(Foe[TARGET])] +  1
-- Count for OverSoul
if skill~=1 and FoeData[TARGET].Oversoul then
   if FoeData[TARGET].OversoulState then CountOversoul[Str.Upper(Foe[TARGET])] = 0 
   else CountOversoul[Str.Upper(Foe[TARGET])] = (CountOversoul[Str.Upper(Foe[TARGET])] or 0) + 1 end
   end
if FoeData[TARGET].OversoulState then 
   TotalOverKills = (TotalOverKills or 0) + 1
   CSay(TotalOverKills.." kills done in Oversoul State")
   end
-- Update kill count
TotalKills = TotalKills or 0
TotalKills = TotalKills  + 1
-- Update trophies based on kills
for ak,k in pairs(trophykills) do -- regular kills
    if TotalKills>=k and (not achieved["KILL"..k]) then AwardTrophy("KILL"..k) end
    end
for ak,k in pairs(trophyoverkills) do -- oversoul kills
    CSay("Let's see can we award the trophy for "..k.." oversoul kills?")
    if TotalOverKills and TotalOverKills>=k and (not achieved["OVERS"..k]) then AwardTrophy("OVERS"..k) end
    end
-- Recover stolen money
local fx,fy = Combat_EnemySpot(TARGET)
if FoeData[TARGET].StolenMoney then
   cash = cash + FoeData[TARGET].StolenMoney
   AddMiniMessage('Combat',FoeData[TARGET].StolenMoney..' stolen shilders recovered',fx,fy)
   end    
-- Update the number of experience points earned
if FoeData[TARGET].Experience then earnexperience = earnexperience + FoeData[TARGET].Experience end
-- Update the cash earned
if FoeData[TARGET].Cash       then earncash       = earncash       + FoeData[TARGET].Cash end
-- Do we earn a magic stone?
local mul 
-- @SELECT skill
-- @CASE 1
   mul = 1
-- @CASE 2
   mul = 2.5
-- @CASE 3
   mul = 30
-- @ENDSELECT
if rand(1,mul*Bestiary[Str.Upper(Foe[TARGET])])==1 then
   Console.Write("This kill earns the player a magic stone",28,104,170)
   earnstones = earnstones + 1
   end
-- Did we get any items?
for ak=1,9 do
    drop = rand(1,100)
    CSay("Rolled "..drop.." for the item drop! - "..ak)
    if drop<=FoeData[TARGET]['Drop_'..ak] then
       earnitems[FoeData[TARGET]['Item_'..ak]] = (earnitems[FoeData[TARGET]['Item_'..ak]] or 0) + 1
       earnitems['*'] = true
       end
    end   
if FoeData[TARGET].Boss then
   SFX("SFX/Combat/BossDeath.ogg")   
   else
   SFX("SFX/Combat/FoeDeath.ogg")
   end
end
    
function Combat_Hurt(TGROUP,TARGET,Damage,r,g,b,ignoreguard)
local G,ak,k,ch
if TGROUP == 'Player' or TGROUP == 'Players' or TGROUP == 'Hero' or TGROUP == 'Heroes' then
   G = 'Player'
   ch = party[TARGET]   
   if not GodMode then
      if PlayAct and PlayAct[Target] and PlayAct[Target].Action=='GRD' and (not ignoreguard) then
         char[ch].HP[1] = char[ch].HP[1] - math.ceil(Damage/2)
         else
         char[ch].HP[1] = char[ch].HP[1] - Damage
         end
      if char[ch].HP[1] < 0 then char[ch].HP[1] = 0 end
      end
   if char[ch].HP[1]==0 then
      char[ch].AP[1]=0
      if CharKilled[ch] then CharKilled[ch]() end
      else
      char[ch].AP[1]=char[ch].AP[1] + round((Damage/char[ch].HP[2])*10)
      end
   if Damage>0 then flawlessvictory=false end  
   if char[ch].HP[1] > 0 then 
      TotalHeroHurt = TotalHeroHurt or 0
      TotalHeroHurt = TotalHeroHurt + Damage 
      CSay("You've endured "..TotalHeroHurt.." non-lethal damage now")
      if TotalHeroHurt>9000 then AwardTrophy('HURT9000') end
      end
   end
if TGROUP == 'Enemy'  or TGROUP == 'Enemies' or TGROUP == 'Foe'  or TGROUP ==   'Foes' then
   G = 'Foe'
   if not FoeData[TARGET] then CWrite("WARNING! Trying to hurt target #"..TARGET.." which doesn't exist! (DMG"..damage..")",255,180,0) end
   if FoeData[TARGET] and (not FoeData[TARGET].OnyxInvincibility) then
      FoeData[TARGET].HP = FoeData[TARGET].HP - Damage
      if KillerMode then FoeData[TARGET].HP=0 end -- Killer Mode. Every hit to enemy is instant DEATH
      if FoeData[TARGET].HP<=0 then 
         Combat_KillFoe(TARGET)
         end
      end
   end   
HurtP[G][TARGET] = Damage
HurtT[G][TARGET] = 250
HurtC[G][TARGET] = {r or 255, g or 255, b or 0}
CSay(G.." #"..TARGET.." hurt! Dmg = "..Damage)
-- Any status changes that get away by being hurt (like 'sleep' and 'confusion')
local sti,sts,std,chi
if G=="Player" then chi = ch else chi=TARGET end
StatusSet[StN[G]][chi] = StatusSet[StN[G]][chi] or {}
for sti,sts in pairs(StatusSet[StN[G]][chi]) do
    std = StatusData[sti]
    if std.GoneHit then
       StatusSet[StN[G]][chi][sti] = nil
       end 
    end
if G=='Player' then
   for ak=1,4 do
       if AllyHurt[party[ak]] then AllyHurt[party[ak]](TARGET) end 
       end 
   end
end

function __consolecommand.BESTIARY()
if not Bestiary then Console.Write("? No bestiary set up yet",255,0,0)  return  end
local k,v
local c=0
for k,v in pairs(Bestiary) do
    c = c + 1
    Console.Write(k.."  ... "..v.." kills",255,255,200)
    end
if c==1 then
   Console.Write("  Oh, my... Only one enemy in this list so far",255,200,255)
   else
   Console.Write("   "..c.." enemies counted in the bestiary.",200,255,255)
   Console.Write("   "..TotalKills.." kills were done in total",200,255,255)
   end
end

function Combat_ShowAction(TGROUP,TACTOR)
CSay("Show Action - empty for now")
end

function Combat_GetHP(TGROUP,TARGET,max)
local ch
if TGROUP == 'Player' or TGROUP == 'Players' or TGROUP == 'Hero' or TGROUP == 'Heroes' then
   ch = party[TARGET]
   if not ch then 
      Console.Write('! WARNING! Null character asked for: returning 0!',255,180,0)
      Console.Write('TGROUP='..TGROUP.."; TACTOR="..sval(TACTOR))
      end
   if max then return char[ch].HP[2] end
   return char[ch].HP[1]
   end
if TGROUP == 'Enemy'  or TGROUP == 'Enemies' or TGROUP == 'Foe'  or TGROUP ==   'Foes' then
   G = 'Foe'
   if not FoeData[TARGET] then return 0 end
   if max then return FoeData[TARGET].HPMax end
   return FoeData[TARGET].HP
   end
end

function Combat_InvalidMove(TGROUP,TACTOR)
if TGROUP == 'Player' or TGROUP == 'Players' or TGROUP == 'Hero' or TGROUP == 'Heroes' then
  G = 'Heroes'
  end
if TGROUP == 'Enemy'  or TGROUP == 'Enemies' or TGROUP == 'Foe'  or TGROUP ==   'Foes' then
   G = 'Foes'
   end
Console.Write('Move of ['..G..','..TACTOR..'] has been deemed invalid. Reset on time bar',184,168,8)   
CombatTime[G][TACTOR] = rand(5000,9500)
Console.Write('Move of ['..G..','..TACTOR..'] has been deemed invalid. Reset on time bar to position: '..CombatTime[G][TACTOR],184,168,8)   
end

function Combat_Attack(TGROUP,TACTOR,TACT)
-- Did it hit or did it miss
local hitroll = rand(0,Combat_Stat(TGROUP             ,TACTOR        ,"Accuracy"))
local evaroll = rand(0,Combat_Stat(TACT["TargetGroup"],TACT["Target"],"Evasion"))
local G,G2
if TACT["TargetGroup"] == 'Player' or TACT["TargetGroup"] == 'Players' or TACT["TargetGroup"] == 'Hero' or TACT["TargetGroup"] == 'Heroes' then
   G = 'Player'
   end
if TACT["TargetGroup"] == 'Enemy'  or TACT["TargetGroup"] == 'Enemies' or TACT["TargetGroup"] == 'Foe'  or TACT["TargetGroup"] ==   'Foes' then
   G = 'Foe'
   end  
if Combat_GetHP(G,TACT['Target'])<=0 then 
   Combat_InvalidMove(TGROUP,TACTOR) 
   return 
   end   
if hitroll<evaroll then 
   HurtP[G][TACT["Target"]] = "Miss"
   HurtT[G][TACT["Target"]] = 250
   HurtC[G][TACT["Target"]] = {150,150,150}
   return
   end   
-- If it hit, then let's calculate how much damage it did do
local base = Combat_Stat(TGROUP,TACTOR,"Strength")
local adie = rand(1,base/2)
local defb = Combat_Stat(TACT["TargetGroup"],TACT["Target"],"Defense")
local ddie = rand(1,defb/5)
local totaldmg = base + adie
local totaldef = defb + ddie
local dmg = round(totaldmg-totaldef)
CSay("Combat rolls - Attack: "..adie.." - Defense: "..ddie)
if dmg<1 then dmg = 1 end
Combat_ShowAction(TGROUP,TACTOR)
Combat_Hurt(TACT["TargetGroup"],TACT["Target"],dmg)
-- Now let's award the player for his or her strike (this this attack was in fact done by the player)
if (TGROUP == 'Player' or TGROUP == 'Players' or TGROUP == 'Hero' or TGROUP == 'Heroes') then
   G2 = "Player"
   ch = party[TACTOR]   
   -- Let's first discuss the skill experience. The harder the monster, the more EXP one can earn here.
   if char[ch].SkillExperience[1] and G=="Foe" then
      local skl = char[ch].SkillLevels[1]
      local enl = FoeData[TACT["Target"]].Level or 1
      if enl==0 then enl=1 end -- No division by zero errors, please!
      local ske = (enl/skl)*(5/skill)
      char[ch].SkillExperience[1] = char[ch].SkillExperience[1] + ske
      end
   -- And now the AP
   char[ch].AP[1] = round(char[ch].AP[1] + ((defb/base) * 10))   
   -- And now the experience modifier
   multiplier[ch] = multiplier[ch] + 0.005
   if G=="Foe" then  if FoeData[TACT["Target"]].HP==0 then multiplier[ch] = multiplier[ch] + 0.01 end end
   end
end

function Combat_SkillLevelUp()
local ch,ak
local skak,sklv,lmsg
local msx,msy
for ak,ch in pairs(party) do for skak=1 , 5 do
   -- Skill Level up
   sklv = char[ch].SkillLevels[skak]
   if char[ch].SkillExperience[skak] and char[ch].SkillExperience[skak]>skillexptable[sklv] then
      char[ch].SkillExperience[skak] = 0 -- char[ch].SkillExperience[skak] - skillexptable[sklv]
      char[ch].SkillLevels[skak] = char[ch].SkillLevels[skak] + 1
      -- No level 13, the unlucky number. A bit of an easter egg, I wonder how many people will see this :P
      if char[ch].SkillLevels[skak]==13 then char[ch].SkillLevels[skak]=14 end
      -- Combat_Message(Var.S(char[ch].Name.."'s "..'"'..char[ch].SkillNames[skak]..'" reached lv'..char[ch].SkilLevels[skak])) -- where is the nil?
      lmsg = char[ch].Name.."'s "
      lmsg = lmsg..char[ch].SkillNames[skak]
      lmsg = lmsg.." reached lv"..char[ch].SkillLevels[skak]
      msx,msy = Combat_PlayerSpot(ak)
      -- Combat_Message(Var.S(lmsg)) -- old and ugly
      AddMiniMessage("Combat",Var.S(lmsg),msx-100,msy)
      sklv = char[ch].SkillLevels[skak]
      if sklv>=250 or (skill==2 and sklv>=100) or (skill>=3 and sklv>=50) then 
         char[ch].SkillExperience[skak] = nil
         AwardTrophy(Str.Upper("MAX"..char[ch].TrophySkill[skak]..ch)) 
         end -- When the max level is reached no more experience for you!
      multiplier[ch] = multiplier[ch] + (sklv/100)
      if skilllevelup[ch] then skilllevelup[ch](skak) end
      end -- if
   end end -- 2x for
end -- function   

function Combat_SpriteInAction(TGROUP,TACTOR,BA)
local act
local ak
if TGROUP == 'Player' or TGROUP == 'Players' or TGROUP == 'Hero' or TGROUP == 'Heroes' then act='P' end
if TGROUP == 'Enemy'  or TGROUP == 'Enemies' or TGROUP == 'Foe'  or TGROUP ==   'Foes' then act='F' end
if act=='P' and BA==3 then -- Player moves forward before the action (cast spell or use item)
   for ak=0,-10,-.5 do
       hmodx[TACTOR] = ak
       Combat_DrawScreen()
       Flip()
       end
   Combat_CastPose(TACTOR)    
   end
if act=='P' and BA==1 then -- Player moves forward before the action (Swing weapon)
   for ak=0,-10,-.5 do
       hmodx[TACTOR] = ak
       Combat_DrawScreen()
       Flip()
       end
   Combat_SwingWeapon(TACTOR)    
   end
if act=='P' and BA==2 then -- Player moves backward after the action
   for ak=-10,0,.5 do
       hmodx[TACTOR] = ak
       Combat_DrawScreen()
       Flip()
       end
   end   
if act=='F' and (BA==1 or BA==3) then -- Enemy flashes before the action
   foe_black = foe_black or {}
   for ak=1,20 do
       foe_black[TACTOR] = not foe_black[TACTOR]
       Combat_DrawScreen()
       Flip()
       end
   foe_black[TACTOR] = false
   if FoeData[TACTOR].AttackSound and FoeData[TACTOR].AttackSound~="" then
      local snd = 'SFX/Combat/FoeAttack/'..FoeData[TACTOR].AttackSound
      if right(Str.Lower(snd),4)~=".ogg" then snd = snd .. ".ogg" end
      SFX(snd)
      end
   end
end

function Combat_HP(TGROUP,TARGET,max)
local player = TGROUP=='Player' or TGROUP=='Hero' or TGROUP=='Players' or TGROUP=='Heroes'
local enemy  = TGROUP=='Enemy'  or TGROUP=='Foe'  or TGROUP=='Enemies' or TGROUP=='Foes'
if player and (not char[party[TARGET]]) then Console.Write("Character #"..TARGET.." does not exist",255,0,0) return nil end
if enemy  and (not FoeData[TARGET])     then Console.Write("Foe #"..TARGET.." does not exist",255,0,0) return nil end
if max then
 if player then return char[party[TARGET]].HP[2] end
 if enemy  then return FoeData[TARGET].HPMax end
 else
 if player then return char[party[TARGET]].HP[1] end
 if enemy  then return FoeData[TARGET].HP end
 end
Sys.Error('Combat_HP("'..TGROUP..'",'..sval(TARGET)..","..sval(max)..'): No HP data could be retrieved!') 
end

function Combat_Heal(TGROUP,TARGET,heal,forcezombie,forcedisease)
-- Zombies get hurt
-- If disease crash out
-- If nothing is wrong then heal him/her up
if TGROUP == 'Player' or TGROUP == 'Players' or TGROUP == 'Hero' or TGROUP == 'Heroes' then
   G = 'Player'
   ch = party[TARGET]   
   char[ch].HP[1] = char[ch].HP[1] + heal
      if char[ch].HP[1] > char[ch].HP[2] then char[ch].HP[1] = char[ch].HP[2] end
      end
if TGROUP == 'Enemy'  or TGROUP == 'Enemies' or TGROUP == 'Foe'  or TGROUP ==   'Foes' then
   G = 'Foe'
   FoeData[TARGET].HP = FoeData[TARGET].HP + heal
   if FoeData[TARGET].HP > FoeData[TARGET].HPMax then 
      FoeData[TARGET].HP = FoeData[TARGET].HPMax
      end
   end   
HurtP[G][TARGET] = heal
HurtT[G][TARGET] = 250
HurtC[G][TARGET] = {0,255,0}
CSay(G.." #"..TARGET.." heals "..heal.." HP")
end

function Combat_Ability_Attack(actor,TACTOR,act,pabl,target)
local abl = pabl or Abilities[act.Ability]
local TACT = act
local TGROUP
if actor~="P" and actor~="F" then Sys.Error("Combat_Ability_Attack only accepts 'P' or 'F' for a parameter and not '"..actor.."'") end
if actor=="P" then TGROUP = 'Player' else TGROUP='Foe' end
local base = Combat_Stat(TGROUP,TACTOR,abl.AttackStat); CSay("AttackStat = "..abl.AttackStat); CSay("base = "..base)
if abl.UseModifier then base = round(base * (abl.Modifier/100)) end
local adie = rand(1,base/2)
local defb = Combat_Stat(TACT["TargetGroup"],target,abl.DefenseStat)
local ddie = rand(1,defb/5)
local totaldmg = base + adie
local totaldef = defb + ddie
local dmg = round(totaldmg-totaldef); if dmg<1 then dmg=1 end
local victim
local r = 255
local g = 255
local b = 0
local res = 0
local elem = Str.Upper(abl.Element)
local ch
if TACT["TargetGroup"]=='Player' or TACT["TargetGroup"]=='Players' or TACT["TargetGroup"]=="Hero" or TACT["TargetGroup"]=="Heroes" then
   victim = 'P'
   ch = party[target] 
   else
   victim = 'F'
   end
-- Can people break this move?
if victim == 'P' and AbilityBreak[ch] then
   if AbilityAttackBreak[ch] then if AbilityAttackBreak[ch](act) then return end end
   end
local ultdmg = dmg
-- Let's see what the elemental resistances (or weaknesses) do to this damage
if elem ~= "NONE" then
   if victim == 'F' then
      if not FoeData[target]["RES_"..elem] then 
         Console.Write("WARNING.... 'RES_"..elem.."' is not properly set!!! Expect an error!",255,0,0)
         end
      res = (FoeData[target]["RES_"..elem] or 0)/ 100
      else
      if not ch then Sys.Error("Resistance for empty character","VictimGroup,"..sval(victim).."; Target,"..sval(target)..";".."TargetGroup,"..sval(act.TargetGroup)..";ch,"..sval(ch)) end
      resistance[ch] = resistance[ch] or {}
      resistance[ch][elem] = resistance[ch][elem] or 0
      res = resistance[ch][elem]
      end
   CSay('Damage is pure: '..ultdmg)
   if ultdmg<1 then ultdmg=1 end
   CSay('Damage is fixed:'..ultdmg)
   CSay('Resistance is:  '..res)   
   ultdmg = round(ultdmg - (ultdmg * res))
   CSay('Damage is then: '..ultdmg)
   if res< 0 then r=255; g=0;   b=0   end -- weakness 
   if res> 0 then r=180; g=180; b=180 end -- resistant or higher resistance
   if res> 1 then r=0;   g=255; b=0   end -- absorbing
   if res==0 then r=255; g=255; b=0   end -- no special effects
   end
if ultdmg<0 then 
   Combat_Heal(act.TargetGroup,target,ultdmg*-1,true,false) 
   -- Zombies can still heal when hit by an element they can absorb. Diseased enemies however cannot heal this way!
   else
   Combat_Hurt(act.TargetGroup,target,ultdmg,r,g,b)
   end
end


function Combat_ProtectStatus(target,status)
CWrite("Is "..target.G.."["..target.T.."] protected against "..status.."?",255,0,255)
if target.G == "Enemies" or target.G=="Foes"   or target.G=="Enemy"  or target.G=="Foe"  then CWrite('Enemies are not protected!',255,0,0) return false end
local ch=party[target.T]
local eq,it
local ret
CWrite("Is "..target.G.."["..target.T.."] protected against "..status.."?",255,0,255)
if not equip[ch] then
   CWrite("WARNING! Character "..sval(ch).." appears to have "..sval(equip[ch]).." for equipment",255,180,0)
   return
   end
for eq,it in pairs(equip[ch]) do
    if it and itemdata and itemdata[it] then
       ret = ret or itemdata[it]["Protect"..status]
       end
    end
return ret    
end

function Combat_CauseStatus(statuschange,target,force)
           local dostatus=true  -- herritage from older (bad) code
           local chi
           local hit
           CWrite("Gonna cause "..statuschange.." to Target."..target.G.."["..target.T.."]",255,180,0)           
           -- CSay("Do Status ["..idx.."] = "..sval(dostatus))
           if true then --dostatus then
              if not statuschange then CWrite("!WARNING! "..sval(statuschange).." given for statuschange.....",255,180,0) end
              if not StatusData[statuschange] then CWrite("!WARNING! Status change "..statuschange.." contains no data at all!",255,180,0) end
              rstatuschange = StatusData[statuschange].Resistance or statuschange
              if target.G == "Players" or target.G=="Heroes" or target.G=="Player" or target.G=="Hero" then target.G="Player"; StatusResistance = (resistance[party[target.T]]["ST"..upper(rstatuschange)] or 0)*100; chi=party[target.T] end
              if target.G == "Enemies" or target.G=="Foes"   or target.G=="Enemy"  or target.G=="Foe"  then target.G="Foe";    StatusResistance = FoeData[target.T]["RES_ST"..upper(rstatuschange)]; chi=target.T end
              StatusResistance = StatusResistance or 0
              local die = rand(1,100)
              CSay("Roll of the die "..sval(die).." to resistance "..sval(StatusResistance))
              if (die>StatusResistance or force) and (not Combat_ProtectStatus(target,statuschange)) then
                 StatusSet[StN[target.G]][chi] = StatusSet[StN[target.G]][chi] or {}
                 StatusSet[StN[target.G]][chi][statuschange] = true
                 if StatusData[statuschange].Cancel then StatusSet[StN[target.G]][chi][StatusData[statuschange].Cancel] = nil end
                 local audio = 'SFX/StatusChange/'..statuschange..".ogg"
                 if JCR5.Exist(audio)==1 then SFX(audio) end
                 if StatusData[statuschange].Receive then StatusData[statuschange].Receive(target.G,target.T) end
                 hit = true
                 CSay("Status change has been caused") 
                 else
                 if StN[target.G]==1 then AwardTrophy("MISSSTATUS"..upper(statuschange)) end
                 end 
              end
           return hit   
           end


function Combat_Ability(TGROUP,TACTOR,act,dontuseap)
local actor
if TGROUP == 'Player' or TGROUP == 'Players' or TGROUP == 'Hero' or TGROUP == 'Heroes' then actor='P' end
if TGROUP == 'Enemy'  or TGROUP == 'Enemies' or TGROUP == 'Foe'  or TGROUP ==   'Foes' then actor='F' end
local abl = Abilities[act.Ability]
local targets,target
local ak
local hit
local ch
local dostatus, idx, statuschange,StatusResistance,chi,rstatuschange
-- No ability?
if not abl then Sys.Error("Ability "..act.Ability.." does not appear to exist!") end
-- Determine targets
if     abl.Target == "OS"                        then targets = { {['G']=TGROUP, ['T']=TACTOR} }
elseif abl.Target == "1F" or abl.Target == '1A'  then targets = { {['G']=act.TargetGroup, ['T']=act.Target } }
elseif (abl.Target == "AA" and actor == 'P') or (abl.Target == 'AF' and actor=='F') then   
       targets = {}
       for ak=1,4 do
           if party[ak] then table.insert(targets,{ ['G']='Player', ['T']=ak }) end
           end
elseif (abl.Target == "AA" and actor == 'F') or (abl.Target == 'AF' and actor=='P') then
       targets = {}
       for ak=1,9 do
           if Foe[ak] and FoeData[ak] then table.insert(targets,{ ['G']='Foe', ['T']=ak }) end
           end
elseif abl.Target == "EV" then
       targets = {}
       for ak=1,4 do
           if party[ak] then table.insert(targets,{ ['G']='Player', ['T']=ak }) end
           end
       for ak=1,9 do
           if Foe[ak] and FoeData[ak] then table.insert(targets,{ ['G']='Foe', ['T']=ak }) end
           end
else   Sys.Error("Ability '"..act.Ability.."' has an an unknown target type","Ability,"..act.Ability..";Target Type,"..abl.Target) end
-- Is a single target spell on a dead guy or girl. Then let's disable this move.
if (abl.Target=='1F' or abl.Target=='1A') and (not abl.CureDeath) and Combat_GetHP(act.TargetGroup,act.Target)<=0 then
   Combat_InvalidMove(TGROUP,TACTOR)
   return
   end
-- Does the player have enough AP to cast this spell?
if (not dontuseap) and actor=='P' and char[party[TACTOR]].AP[1]<abl.APCost then
   Combat_InvalidMove(TGROUP,TACTOR)
   return 
elseif actor=='P' and (not dontuseap) then
   char[party[TACTOR]].AP[1] = char[party[TACTOR]].AP[1] - abl.APCost
   end
-- Block spell if silenced
if abl.AffectSilence and StatusSpellBlock(TGROUP,TACTOR) then 
   Combat_InvalidMove(TGROUP,TACTOR) 
   end   
-- Name of the spell / ability on the screen
Combat_Message(abl.Name,act.Ability)
CSay("Ability: "..abl.Name)
local beastArray,beastID,beastPic,beastAbl
for ak = 0,75 do Combat_DrawScreen(); Flip() end
if actor=='F' then Combat_SpriteInAction(TGROUP,TACTOR,1) end
if actor=='P' then 
    if     abl.HeroSpriteAction == 'Attack' then Combat_SpriteInAction(TGROUP,TACTOR,1) 
    elseif abl.HeroSpriteAction == 'Cast'   then Combat_SpriteInAction(TGROUP,TACTOR,3) 
    else 
     Console.Write("! Warning: Unknown action for ability "..sval(abl.Name),255,100,0)
     Console.Write("  = "..sval(abl.HeroSpriteAction))
     end
    -- If a spell from charming an enemy, spirit it in 
    beastArray = char[party[TACTOR]].CharmPic    
    beastAbl = Str.Replace(act.Ability,"CH_"..upper(party[TACTOR]).."_","")
    if beastArray then beastID = beastArray[beastAbl]; CSay("A charm list has been found!"); CSay("Ability "..sval(act.Ability).." is tied to enemy: "..sval(beastID)) end
    if beastID then
       beastPic = Image.Load('GFX/Combat/Foes/'..beastID..'.png')
       CSay("BeastPic = "..sval(beastPic))
       Image.HotCenter(beastPic)
       for ak = 1,0,-0.01 do
           Combat_DrawScreen();
           Image.SetAlpha(ak)
           Image.Scale(-1,1)
           Image.Draw(beastPic,400,300)
           Image.SetAlpha(1)
           Image.Scale(1,1) 
           Flip()
           end 
       Image.Free(beastPic)    
       end
    end
-- Perform the animation
if SpellAni[abl.GameAnimationFunction] then
   Image.Color(255,255,255)
   SpellAni[abl.GameAnimationFunction](TGROUP,TACTOR,act)
   elseif abl.GameAnimationFunction and abl.GameAnimationFunction~="" then
   Console.Write("!WARNING! SpellAni '"..sval(abl.GameAnimationFunction).."' requested but not found!",255,180,100) 
   end
-- Perform the spell effect
for ak,target in ipairs(targets) do
    hit = false
    -- Cure status changes / Remove buffs or debuffs (THIS ALWAYS COMES FIRST!!!)
     for idx,dostatus in pairs(abl) do
        if left(idx,4)=="Cure" then
           statuschange = right(idx,len(idx)-4)
           if target.G == "Players" or target.G=="Heroes" or target.G=="Player" or target.G=="Hero" then target.G="Player"; StatusResistance = (resistance[party[target.T]]["ST"..upper(statuschange)] or 0)*100; chi=party[target.T] end
           if target.G == "Enemies" or target.G=="Foes"   or target.G=="Enemy"  or target.G=="Foe"  then target.G="Foe";    StatusResistance = FoeData[target.T]["RES_ST"..upper(statuschange)]; chi=target.T end
           -- CSay("Cure Status ["..idx.."] = "..sval(dostatus).."; chi = "..sval(chi))           
           if dostatus then
              -- CSay("Curing status '"..statuschange.."' on "..sval(target.G)..": "..chi)
              StatusSet[StN[target.G]][chi] = StatusSet[StN[target.G]][chi] or {}
              StatusSet[StN[target.G]][chi][statuschange] = nil
              hit=true
              end
           end
        end   
    -- Cure death
    if abl.CureDeath and Combat_GetHP(target.G,target.T)==0 then
       -- @SELECT StN[target.G]
       -- @CASE 1
          char[party[target.T]].HP[1]=1
          hit = true
       -- @CASE 2
          Sys.Error('Tried to revive foe #'..target.T..". Only allies can be revived!")
       -- @DEFAULT
          Sys.Error('For TG '..sval(target.G)..' I got value '..sval(Stn[target.G])..'. Meaning I can\'t revive')
       -- @ENDSELECT   
       end
    -- Healing
    if abl.Heal>0 then
       local heal = round(abl.Heal * (Combat_Stat(TGROUP,TACTOR,abl.HealModStat)/100))
       if heal<1 then heal = 1 end
       if Combat_GetHP(target.G,target.T)<=0 then heal=0 end 
       Combat_Heal(target.G,target.T,heal)
       hit = true
       end
    -- AP recovery
    if StN[target.G]==1 and abl.RecoverAP>0 then
       chi = party[target.T]
       char[chi].AP[1] = char[chi].AP[1] + abl.RecoverAP
       if char[chi].AP[1]>char[chi].AP[2] then char[chi].AP[1]=char[chi].AP[2] end 
       hit = true
       HurtP[target.G][target.T] = abl.RecoverAP
       HurtT[target.G][target.T] = 250
       HurtC[target.G][target.T] = {0, 35, 180}       
       end   
    -- Attack
    if abl.Attack then Combat_Ability_Attack(actor,TACTOR,act,abl,target.T); hit=true end
    -- Scripting effect
    if abl.GameSpellFunction and abl.GameSpellFunction~="" then
       Combat_AbilityOptions = {}
       if abl.Options and abl.Options~="" then Combat_AbilityOptions = split(Var.S(abl.Options),",") end
       if Combat_AbilityEffect[abl.GameSpellFunction] then 
          hit = Combat_AbilityEffect[abl.GameSpellFunction](target.G,target.T) or hit
          elseif Combat_XAbilityEffect[abl.GameSpellFunction] then 
          hit = Combat_XAbilityEffect[abl.GameSpellFunction](TGROUP,TACTOR,target.G,target.T) or hit
          end
    elseif abl.GameSpellFunction~="" then
       Sys.Error("Combat Ability Effect function '"..abl.GameSpellFunction.."' does not exist!")
       end
    -- Cause status changes / Cause buffs or debuffs (THIS ALWAYS COMES LAST BEFORE REMOVE!!!)
    for idx,dostatus in pairs(abl) do
        if left(idx,5)=="Cause" then
           -- CSay(idx.." = "..sval(dostatus))
           statuschange = right(idx,len(idx)-5)
           if dostatus then hit = Combat_CauseStatus(statuschange,target) or hit end 
           end
        end
    -- Remove a foe (this ALWAYS COMES LAST OR THE GAME WILL CRASH)
    if abl.RemoveEnemy then
       if target.G=="Player" or target.G=="Players" or target.G=="Hero" or target.G=="Heroes" then Sys.Error("Cannot remove a player. Only an enemy!") end
       hit = hit or Combat_RemoveFoe(target.T)  
       end
    -- Nothing happened, so we count this move a 'miss'
    if not hit then 
       CSay(target.G..": "..target.T.." has been missed!")
       if target.G == "Players" or target.G=="Heroes" or target.G=='Hero' or target.G=='P' then target.G="Player" end
       if target.G == "Foes"    then target.G="Foe"   end
       HurtP[target.G][target.T] = "Miss"
       HurtT[target.G][target.T] = 250
       HurtC[target.G][target.T] = {150,150,150}
       end
    end
-- Put player back?
if actor=='P' then Combat_SpriteInAction(TGROUP,TACTOR,2) end
-- Reward Player
if actor=='P' then
   local mul = 1
   local usk = abl.SkillNumber
   if skill==1 then mul = 2.5 elseif skill==3 then mul = 0.75 end
   ch = party[TACTOR]
   -- if not char[ch].SkillLevels[2] then Sys.Error("Character "..ch.." does not have skill #"..2) end
   if char[ch].SkillLevels[usk] and char[ch].SkillExperience[usk] then char[ch].SkillExperience[usk] = char[ch].SkillExperience[usk] + (abl.SkillExp*mul) end   
   ------------------------------------------------------------------------------------------------
   --  If a skill level is below the average skill level, then we're gonna reward extra points.  --
   --  How much depends on how much lower the level is and on the skill level.                   --
   --  The general level will also be counted. In normal mode even twice and in easy mode it     --
   --  will count three times.                                                                   --
   ------------------------------------------------------------------------------------------------
   local genml = 4 - skill
   local numsk = genml
   local totsk = genml * char[ch].Level
   local sk
   for _,sk in pairs(char[ch].SkillLevels) do 
       totsk = totsk + sk
       numsk = numsk + 1
       end
   local avgsk = totsk / numsk
   local mulsk = {25,10,5}
   if  char[ch].SkillLevels[usk] and char[ch].SkillLevels[usk]<avgsk then
      local bonus = mulsk[skill]-((char[ch].SkillLevels[usk]/avgsk)*mulsk[skill])
      char[ch].SkillExperience[usk] = char[ch].SkillExperience[usk] + bonus
      CWrite(ch.."  get "..sval(bonus).." extra skill experience for skill "..usk)
      CWrite(char[ch].SkillLevels[usk].." < "..avgsk)
      end    
   end
-- Reset gauge
if actor=='P' then CombatTime['Heroes'][TACTOR]=rand(0,100) end
if actor=='F' then CombatTime[  'Foes'][TACTOR]=rand(0,100) end
-- Does any of the current enemies have a response to this ability?
if actor=='P' then
   for ak=1,9 do
       -- @IF E_A_RESPOND_DEBUG
       CSay("ABLRESPOND:   Foe["..ak.."]              = "..sval(Foe[ak]))
       CSay("ABLRESPOND:   FoeData Exists           = "..sval(FoeData[ak]~=nil))
       -- @FI
       if Foe[ak] and FoeData[ak] and FoeData[ak].HP>0 then
          if FoeData[ak].FightingStyle and FoeData[ak].FightingStyle~="" and E_AbilityRespond[FoeData[ak].FightingStyle] then
             E_AbilityRespond[FoeData[ak].FightingStyle](ak,act,TACTOR)
             end 
          end 
       end
   end
-- All done, byebye!
end

function Combat_UseItem(TACTOR,act,mystic)
local itm = itemdata[act.Item]
local tgts,ak,ch,target
if not inventory[act.Item] then Combat_InvalidMove("Player",TACTOR) end
if (not mystic) and (not itm.Fallen) and (char[party[act.Target]].HP[1]<=0) then
   Combat_InvalidMove('Player',TACTOR)
   return
   end   
if mystic then Combat_Message("Mystic - "..itm.Name) else Combat_Message(itm.Name) end
Combat_SpriteInAction("Player",TACTOR,3)    
if itm["Item Type"]=="Healing" then
   local audio = "SFX/ItemUsage/"..act.Item..".ogg"
   if JCR5.Exist(audio)==1 then 
      SFX(audio) 
      else
      Console.Write("! WARNING: Item sound '"..audio.."' does not exist. Request ignored",255,180,0)
      end   
   if mystic then -- When dealing with a healing item, using Mystic will cause it to go over the entire party and not one person, that is the 4 that are in battle.       
      tgts = {}
      for ak,ch in pairs(party) do
          if ak<=4 then table.insert(tgts,ak) end
          end
      else
      tgts = {act.Target}
      end
   for ak,target in pairs(tgts) do
       ch = party[target]
       local stn,std
       for stn,std in pairs(StatusData) do
           if itm[stn] then
              StatusSet[StN["Player"]][ch] = StatusSet[StN["Player"]][ch] or {}
              StatusSet[StN["Player"]][ch][stn] = nil 
              CSay("On player: "..ch.." heal status: "..stn)
              end
           end
       if char[ch].HP[1]==0 and itm.Fallen then 
          char[ch].HP[1]=1
          if upper(act.Item)=='PHOENIX' then AwardTrophy("Phoenix") end 
          end    
       if itm.Heal and itm.Heal>0 and char[ch].HP[1]>0 then          
          -- char[ch].HP[1] = char[ch].HP[1] + itm.Heal
          -- if char[ch].HP[1] > char[ch].HP[2] then char[ch].HP[1] = char[ch].HP[2] end
          Combat_Heal("Heroes",target,itm.Heal)
          end
       if itm.RecoverAP and itm.RecoverAP>0 then
          ch = party[target]
          char[ch].AP[1] = char[ch].AP[1] + itm.RecoverAP
          if char[ch].AP[1]>char[ch].AP[2] then char[ch].AP[1]=char[ch].AP[2] end
          HurtP.Player[target] = itm.RecoverAP
          HurtT.Player[target] = 250
          HurtC.Player[target] = {0, 35, 180}       
          end   
       end
   end
Combat_SpriteInAction("Player",TACTOR,2)   
inventory[act.Item] = inventory[act.Item] - 1
if inventory[act.Item] == 0 then inventory[act.Item]=nil end
local itemexppoints = {10,5,1}   
if party[TACTOR]=="Merya" then
   if char.Merya.SkillLevels[2] and char.Merya.SkillExperience[2] then char.Merya.SkillExperience[2] = char.Merya.SkillExperience[2] + (itemexppoints[skill]) end
   end
end 

function Combat_Action(TGROUP,TACTOR)
local act,player
local msx,msy
CSay("Combat_Action('"..TGROUP.."',"..TACTOR..")")
if TGROUP == 'Player' or TGROUP == 'Players' or TGROUP == 'Hero' or TGROUP == 'Heroes' then act=PlayAct[TACTOR]; participated[party[TACTOR]]=true; LastAction=party[TACTOR]; player=true end
if TGROUP == 'Enemy'  or TGROUP == 'Enemies' or TGROUP == 'Foe'  or TGROUP ==   'Foes' then act= FoeAct[TACTOR] end
local TACT = act
-- @SELECT act["Action"]
-- @CASE "ATK"
   if StatusAttackBlock(TGROUP,TACTOR) then
    Combat_InvalidMove(TGROUP,TACTOR)
   elseif Combat_GetHP(act['TargetGroup'],act['Target'])<=0 then 
    Combat_InvalidMove(TGROUP,TACTOR) 
   else   
    Combat_SpriteInAction(TGROUP,TACTOR,1)
    -- Combat_ShootIfIMust(TGROUP,TACTOR)
    Combat_Attack(TGROUP,TACTOR,act)
    Combat_SpriteInAction(TGROUP,TACTOR,2)
    if player and AfterAttack[party[TACTOR]] then 
       CSay("After attack by "..party[TACTOR]) 
       AfterAttack[party[TACTOR]](TACT)
     elseif player then
       CSay("After attack by "..party[TACTOR].." not found, so ignoring!") 
       end       
   end
-- @CASE "ABL"
   Combat_Ability(TGROUP,TACTOR,act)
-- @CASE "LRN"
   if upper(act.LearnAbility)=='MYSTIC' or tablecontains(char[party[TACTOR]].Abilities,act.LearnAbility) then
      CWrite("INVALID TEACH!",255,180,0)
      CombatTime['Heroes'][TACTOR] = 9999
      table.remove(teachlist[party[TACTOR]],1)
      return
      end
   learntext = learntext or ReadLanguageFile('GENERAL/NEWSPELL')
   SerialBattleBoxText(learntext,Str.Upper(party[TACTOR]))
   table.insert(char[party[TACTOR]].Abilities,act.LearnAbility)
   Combat_Ability(TGROUP,TACTOR,act,true)   
   msx,msy=Combat_PlayerSpot(TACTOR)
   AddMiniMessage('Combat',Abilities[act.Ability].Name.." was learned!",msx-100,msy)
   table.remove(teachlist[party[TACTOR]],1)   
-- @CASE "ITM"
   Combat_UseItem(TACTOR,act)   
-- @CASE "GRD"
   CombatTime['Heroes'][TACTOR] = 9999   
-- @CASE "OVERSOUL"
   Combat_Message('Oversoul')
   Combat_Oversoul(TACTOR)   
-- @CASE "JUG"
   Juggernaut_Attack()   
-- @DEFAULT
    Sys.Error("Unknown Action Requested","Function,Combat_Action;By Group,"..TGROUP..";By Actor,"..TACTOR..";Action,"..act.Action)
-- @ENDSELECT    
end

function Combat_PerformMoves()
local ak,al,ik,il
for ak,ik in pairs(CombatTime) do
    for al,il in pairs(ik) do
        if il==20000 then 
	   Combat_Action(ak,al)
	   if CombatTime[ak][al]>=20000 then CombatTime[ak][al]=0 end
	   end
	end
    end
end

function Combat_MoveGauge()
local ak,al,ik,il,ch
for ak,ik in pairs(CombatTime) do
    for al,il in pairs(ik) do
        if il then
           if ak=="Heroes" and party[al] then
              ch = party[al]
              if char[ch].HP[1] == 0 then CombatTime[ak][al]=0 end
              end
           if ak=="Foes" and FoeData[al] then              
              if FoeData[al].HP == 0 then CombatTime[ak][al]=0 end
              end
           if il<10000 then
	      CombatTime[ak][al] = CombatTime[ak][al] + ((Combat_Stat(ak,al,"Agility")/HiSpeed)*25)
	      if CombatTime[ak][al]>10000 then CombatTime[ak][al]=10000 end
	      end
	   if il>10000 then
	      if ak=="Heroes"              then CombatTime[ak][al] = CombatTime[ak][al] + PlayAct[al]["ActSpeed"] end
	      if ak=="Foes" and FoeAct[al] then CombatTime[ak][al] = CombatTime[ak][al] +  FoeAct[al]["ActSpeed"] end
	      if CombatTime[ak][al]>20000  then CombatTime[ak][al]=20000 end
	      end
	   end
	end   
    end
end

function Combat_Oversoul(TARGET)
Combat_SyncFoe(TARGET,true)
FoeData[TARGET].Name = FoeData[TARGET].Name.." (Oversoul)"
if skill==3 then FoeData[TARGET].Experience = 0 end
FoeData[TARGET].OversoulState = true
end

function Combat_Message(msg,filename)
  Combat_Message_Stuff.Loaded   = false
  Combat_Message_Stuff.Filename = filename
  Combat_Message_Stuff.Message  = msg
  Combat_Message_Stuff.Timer    = 250
end

function Combat_Victory(CombatData)
ch = CheckVictory [CombatData.CheckVictory]  or CheckVictory.Default
ac = VictoryAction[CombatData.VictoryAction] or VictoryAction.Default
ret = ch(CombatData)
ret = ret and ac(CombatData)
return ret
end

function Combat_Defeated(CombatData)
ch = CheckDefeat [CombatData.CheckDefeat]  or  CheckDefeat.Default
ac = DefeatAction[CombatData.DefeatAction] or DefeatAction.Default
ret = ch(CombatData)
if ret then ac(CombatData) end
return ret
end

function Combat_Char2Num(ch)
local ret = 0
local ak,name
if type(ch)=='number' then return ch end
for ak,name in pairs(party) do
    if name==ch then ret = ak end
    end
return ret    
end

function Combat_IntervalStatusChanges()
local status,data
local PF = {"Player","Foe"}
local ak,setarray
local al,set
local chn
local debug = false
for status , data in pairs(StatusData) do
    if data.Interval then
       data.Interval = data.Interval - 1
       if data.Interval==0 then
          if debug then CSay('Checking interval based status: '..status) end
          for ak,setarray in pairs(StatusSet) do
              for al,set in pairs(setarray) do
                  if set[status] then
                     chn = Combat_Char2Num(al)
                     if (ak==2 or chn<5) and chn>0 then
                        data.IntervalFunc(PF[ak],chn)
                        end
                     end
                  data.Interval = data.IntervalReset
                  end
              end
          end
       end
    end
end


function Combat_IntervalAPRegen()
local ak,ch
for ak=1,4 do
    ch = party[ak]
    if ch and APRegen[ch]then
       APRegen[ch].Time = (APRegen[ch].Time or 1) - 1
       if APRegen[ch].Time<=0 then
          char[ch].AP[1] = char[ch].AP[1] + APRegen[ch].AP()
          APRegen[ch].Time = APRegen[ch].Interval
          end
       end
    end
end

function Combat_NoStatusOnDeath()
local ch,ak
for _,ch in ipairs(party) do
    if char[ch].HP[1]==0 then
       StatusSet[StN['Player']][ch] = {}
       end
    end
for ak=1,9 do
    if (not Foe[ak]) or (not FoeData[ak]) then 
       StatusSet[StN['Foe']][ak] = {} 
        end
    end
end

function Combat(CombatData)
local CData = CombatData or {}
Combat_Init(CData)
repeat
-- @IF DEVELOPMENT
if KeyHit(KEY_F1) then
  LAURA.Console()
  end
-- @FI
Combat_MoveGauge()
Image.Cls()
Combat_DrawScreen()
Combat_InputMoves()
Combat_PerformMoves()
Combat_SkillLevelUp()
Combat_IntervalStatusChanges()
Combat_IntervalAPRegen()
Combat_NoStatusOnDeath()
-- End combat. Always check defeated first and victory later. If they both happen at the same time (which is possible) then it counts as defeated!
if Combat_Defeated(CombatData) then combatrunning=false; CombatRunning=false; StatusLingerCheck(); FoeData=nil; Foe=nil; return false end
if Combat_Victory(CombatData) then combatrunning=false; CombatRunning=false; StatusLingerCheck(); FoeData=nil; Foe=nil; return true end 
Flip()
until false
end
