--[[
/* 
  Dyrt - Shop

  Copyright (C) 2014 JP Broks
  
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



Version: 14.08.05

]]
function TrueShop(Store)
local Rebecca = tablecontains(party,"Rebecca")
if Rebecca and (not CVV('&TUTORIAL.HAGGLE')) then
   SerialBoxText("Tutorial/Shopping","SHOP")
   Var.D("&TUTORIAL.HAGGLE","TRUE")
   end
if tablecontains(party,"Rebecca") and (not Haggle) then
   Haggle = { ["Rep"] = 2-skill, ["Shop"]={} }
   if Rebecca then SerialBoxText("Tutorial/Shopping","SHOP1") end
   end
if Rebecca then
   Haggle.Shop[Store] = Haggle.Shop[Store] or {['Rate']=1}
   end
local shop = FetchDataRecord('DATA/SHOP',Str.Upper(Store))
local trade = false
local ak
for ak=1 , 10 do
    if shop["Item"..ak] and (shop["Item"..ak] ~= "") then
       trade = trade or itemdata[shop["Item"..ak]]=='Weapon'
       trade = trade or itemdata[shop["Item"..ak]]=='Armor'
       trade = trade or itemdata[shop["Item"..ak]]=='Accesoiry'
       end 
    end
local choice 
choice = ShopMainMenu(Store,shop,trade,Rebecca)
while choice do
      choice = ShopMainMenu(Store,shop,trade,Rebecca)
      end
end

function ShopWin()
if config.bttrans then Image.SetAlpha(.5) end
ARColor(config.btback)
Image.Rect(0,0,800,600)
Image.SetAlpha(1)
ARColor(config.btfont)
Image.Line(  1,  1,798,  1) -- U
Image.Line(798,  1,798,598) -- R
Image.Line(  1,598,798,598) -- D
Image.Line(  1,  1,  1,598) -- L
Image.Line(  1,570,798,570) -- Div
Image.ViewPort(10,10,750,560)
Image.Origin(10,10)
end

function ShopBuy(store,shop,Rebecca)
local bye = false
local P = 1
local ak
local stock = {}
local y
local mox,moy
local buy = false
local ok
local ItMax = 5
local totalprice
local plus,minus,M1,M2
local HaggleRate = 1
if Haggle and Rebecca then
   if Haggle.Shop[store] then HaggleRate = Haggle.Shop[store].Rate end
   end
if skill==1 then ItMax=50 elseif skill==2 then ItMax=25 end
Key.Flush()
repeat
ShopWin()
totalprice=0
plus = false
minus = false
M1 = Mouse.Hit(1)==1
for ak=1,10 do
    if shop["Item"..ak] and shop["Item"..ak]~="" then
      stock[ak] = stock[ak] or 
       { 
           ['code'] = shop["Item"..ak], 
           ['name']=itemdata[shop['Item'..ak]].Name, 
           ['Price']=math.ceil(itemdata[shop['Item'..ak]].ShopPrice * HaggleRate), 
           ['amount']=0
       }
     end
    y = (ak-1)*50
    if P==ak then Image.Font("Fonts/Coolvetica.ttf",25) else Image.Font("Fonts/Coolvetica.ttf",20) end
    if stock[ak] then
     Image.Color(255,255,255)
     itemicon(stock[ak].code,16,y+16)
     ARColor(config.btfont)
     DText(stock[ak].name,50,y)
     DText(stock[ak].Price.." Sh",300,y,1,0)
     DText("x"..stock[ak].amount,320,y)
     stock[ak].total = stock[ak].Price * stock[ak].amount
     DText(stock[ak].total.." Sh",500,y,1,0)
     DText("+",525,y)
     DText("-",550,y)
     if mox~=Mouse.X() and moy~=Mouse.Y() and Mouse.Y()+10>y and Mouse.Y()+10<y+50 then 
       mox=Mouse.X()
       moy=Mouse.Y()
       P=ak
       end
     if Mouse.Y()+10>y and Mouse.Y()+10<y+50 then 
       if Mouse.X()>525 and Mouse.X()<550 and M1 then plus =true end
       if Mouse.X()>550 and Mouse.X()<575 and M1 then minus=true end              
       end
     totalprice = totalprice + stock[ak].total
     end  
    end    
Image.ViewPort(0,0,800,600)
Image.Origin(0,0)
Image.Font('Fonts/Coolvetica.ttf',20)
DText(itemdata[stock[P].code]["Item Type"]..": "..Var.S(itemdata[stock[P].code].Desc),10,583,0,2)
DText("Total price: "..totalprice,10,575,0,1)
DText("Cash: "..cash,790,575,1,1)
if (KeyHit(KEY_DOWN) or joydirhit('D')) and P<10 and stock[P+1] and stock[P+1].code~="" then P=P+1 end
if (KeyHit(KEY_UP)   or joydirhit('U')) and P> 1                                        then P=P-1 end
if ActionKeyHit() then bye=true; buy=true  end
if CancelKeyHit() then bye=true; buy=false end
if KeyHit(KEY_RIGHT) or KeyHit(KEY_NUMADD) or joydirhit('R') or plus then
   ok=true
   ok=ok and stock[P]
   ok=ok and stock[P].amount + (inventory[stock[P].code] or 0)< ItMax
   ok=ok and cash >= totalprice + stock[P].Price
   if ok then stock[P].amount = stock[P].amount + 1 end
   end
if (KeyHit(KEY_LEFT) or KeyHit(KEY_NUMSUBSTRACT) or joydirhit('L') or minus) and stock[P] and stock[P].amount>0 then stock[P].amount = stock[P].amount - 1 end   
Flip()    
until bye
if buy then
   -- Selection has been made, so let's buy it all.
   ak = P
   for P=1 , 10 do 
       if stock[P] and stock[P].amount>0 then
          CSay("Buying "..stock[P].amount.."x "..stock[P].code)
          inventory[stock[P].code] = inventory[stock[P].code] or 0
          inventory[stock[P].code] = inventory[stock[P].code] + stock[P].amount         
          end
       end 
   cash = cash - totalprice    
   SFX("SFX/General/Buy.ogg")
   end
end 

function SellPrice(item)
local ret = itemdata[item].ShopPrice
-- @SELECT skill
-- @CASE 2
ret = math.ceil(ret*0.75)
-- @CASE 3
ret = math.ceil(ret*0.50)
-- @ENDSELECT
return ret
end

function ShopSell()
local amount = {}
local i = {}
local bye
local cnt = 0
local P = 1
local PM = 0
local allow = {}
local y = 0
CSay("I wanna make money, so I sell!")
for iID,iNum in spairs(inventory,invsort) do
    if iNum and iNum>0 then
       cnt = cnt + 1
       i[cnt] = iID
       end
    end
repeat
ShopWin()
-- if ActionKeyHit() and allow[P] then return i[P] end
-- Base draw
for ak,it in ipairs(i) do
    -- Determine position on screen
    y = ((ak-1)*35)-PM
    if ak==P and y>500 then PM=PM+1 end
    if ak==P and y<0 then PM=PM-1 end
    -- Item code
    itm = itemdata[it]
    if ak == P then
       Image.Font("Fonts/Coolvetica.ttf",32)
       else
       Image.Font("Fonts/Coolvetica.ttf",25)
       end
    Image.Color(255,255,255)
    itemicon(it,20,y+16)
    -- if tablecontains(a_allow,itm["Item Type"]) then
    if SellPrice(it)>0 then
       allow[ak] = true
       ARColor(config.btfont)
       else
       allow[ak] = false
       HARColor(config.btfont)
       end
    amount[it] = amount[it] or 0   
    DText(itm.Name,40,y+10,0,2)
    DText(inventory[it],300,y+10,1,2)
    DText(amount[it].."X",320,y+10,0,2)
    DText(SellPrice(it).." sh >>",500,y+10,1,2)
    DText(math.ceil(SellPrice(it)*amount[it]).." sh",700,y+10,1,2)    
    end
Image.ViewPort(0,0,800,600)
Image.Origin(0,0)
Image.Font('Fonts/Coolvetica.ttf',20)
Image.Font('Fonts/Coolvetica.ttf',20)
DText(itemdata[i[P]]["Item Type"]..": "..Var.S(itemdata[i[P]].Desc),10,583,0,2)
Flip()
if CancelKeyHit() then return nil end
if (KeyHit(KEY_UP)   or joydirhit('U')) and P>1    then P=P-1 end
if (KeyHit(KEY_DOWN) or joydirhit('D')) and i[P+1] then P=P+1 end
if (KeyHit(KEY_RIGHT) or KeyHit(KEY_NUMADD)       or joydirhit('R')) and allow[P] and amount[i[P]] and amount[i[P]] < inventory[i[P]] then amount[i[P]] = amount[i[P]] + 1 end
if (KeyHit(KEY_LEFT)  or KeyHit(KEY_NUMSUBSTRACT) or joydirhit('L')) and amount[i[P]] and amount[i[P]] > 0                            then amount[i[P]] = amount[i[P]] - 1 end
if ActionKeyHit() then bye=true end
until bye
-- Selections are made, let's sell all this shit!
for ak,it in ipairs(i) do
    if amount[it] and amount[it]>0 then
       RemoveItem(it,amount[it])
       cash = cash + (SellPrice(it)*amount[it])
       end 
    end
SFX("SFX/General/Buy.ogg")    
end

function ShopTrade()
end

function ShopHaggle(store,shop)
local die = rand(1,char.Rebecca.Level) + Haggle.Rep
local txt = ReadLanguageFile("General/Haggle")
local txttag = ""
local procent = 100
local procentshow = 0
local rep = 0
-- Did we haggle before here?
if Haggle.Shop[store].Haggled then
   SerialBoxText(txt,"AGAIN")
   return
   end
-- Are we succesful or not?
if die>=shop.HaggleLevel then
   txttag = "GOOD"
   procent = rand(50+(skill*5),50+(skill*10))
   procentshow = 100 - procent
   rep = shop.GoodRep
elseif die<=shop.TerribleHaggle then
   txttag = "TERRIBLE"
   procent = rand(100,100+(skill*25))
   procentshow = procent
   rep = shop.TerribleRep
elseif die<=shop.BadHaggle then
   txttag = "BAD"
   procentshow = procent
   rep = shop.BadRep
else
   txttag = "FAIL"
   procentshow = procent
   rep = shop.FailRep
   end 
-- Calculate rep
-- @SELECT skill
-- @CASE 1
   if rep>0 then rep = rep * 2 else rep = rep / 2 end
-- @CASE 3
   if rep>0 then rep = rep / 2 else rep = rep * 2 end
-- @ENDSELECT
Haggle.Rep = Haggle.Rep + rep
CSay("You have now "..Haggle.Rep.." haggle reputation points")
-- Let's set the new price rate
Haggle.Shop[store] = { ["Rate"] = procent/100, ["Procent"]=procent, ["Haggled"]=true }   
-- When we play the hardmode SAVE now!
if skill==3 then SaveGame(true) end
-- Let's now report the result to the player.
Var.D("$HAGGLEPERCENT",procentshow.."%")
SerialBoxText(txt,txttag)
end

function __consolecommand.HAGGLEDATA()
local r = serialize("Haggle",Haggle)
local rs = split(r,"\n")
local ak,line
local r = rand(1,255)
local g = rand(1,255)
local b = rand(1,255)
for ak,line in ipairs(rs) do
    Console.Write(line,r,g,b)   
    end 
end

ShopMenuItems = {
   { ["Name"] = "Buy",    ["FN"] = ShopBuy,    ["X"] = 0, ["Y"] = 200, ['enable']=true},
   { ["Name"] = "Sell",   ["FN"] = ShopSell,   ["X"] = 0, ["Y"] = 255, ['enable']=true},
   --{ ["Name"] = "Trade",  ["FN"] = ShopTrade,  ["X"] = 0, ["Y"] = 310, ['enable']=true},
   { ["Name"] = "Haggle", ["FN"] = ShopHaggle, ["X"] = 0, ["Y"] = 310, ['enable']=true}  -- Y was originall 365   
}


function ShopMainMenu(store,shop,trade,Rebecca)
local ak,I
local c
local choice = 1
local omx,omy
Key.Flush()
for ak=1,#ShopMenuItems do ShopMenuItems[ak].X = 600 + (ak*50) end
ShopMenuItems[3].enable=trade
ShopMenuItems[3].enable=Rebecca and (not Haggle.Shop[store].Haggled)
repeat
DrawScreen()
Image.Color(255,255,255)
Image.Font("Fonts/Coolvetica.ttf",40)
DText(shop.Name,400,150,2,1)
for ak,I in ipairs(ShopMenuItems) do
    if ShopMenuItems[ak].X>300 then ShopMenuItems[ak].X=ShopMenuItems[ak].X-4 end
    if config.bttrans then Image.SetAlpha(.5) end
    if ShopMenuItems[ak].enable then c = ARColor else c = HARColor end
    c(config.btback)
    Image.Rect(I.X,I.Y,200,50)
    Image.SetAlpha(1)
    c(config.btfont)
    Image.Font("Fonts/Coolvetica.ttf",40)
    if choice==ak then Image.Font("Fonts/Coolvetica.ttf",45) end
    Image.Line(I.X+  1,I.Y+ 1,I.X+199,I.Y+ 1) -- U
    Image.Line(I.X+  1,I.Y+49,I.X+199,I.Y+49) -- D
    Image.Line(I.X+  1,I.Y+ 1,I.X+  1,I.Y+49) -- L
    Image.Line(I.X+199,I.Y+ 1,I.X+199,I.Y+49) -- R
    Image.DText(I.Name,I.X+100,I.Y+25,2,2)
    if Mouse.X()>I.X and Mouse.X()<I.X+200 and Mouse.Y()>I.Y and Mouse.Y()<I.Y+50 and Mouse.X()~=omx and Mouse.Y()~=omy then
       choice = ak
       omx = Mouse.X()
       omy = Mouse.Y()
       end
    end
if ActionKeyHit()   and ShopMenuItems[choice].enable then ShopMenuItems[choice].FN(store,shop,Rebecca) end
if Mouse.Hit(1)==1  and ShopMenuItems[choice].enable then ShopMenuItems[choice].FN(store,shop,Rebecca) end
if (KeyHit(KEY_UP)   or joydirhit('U')) and choice>1              then choice=choice-1 end
if (KeyHit(KEY_DOWN) or joydirhit('D')) and choice<#ShopMenuItems then choice=choice+1 end
Flip()    
until CancelKeyHit()
Key.Flush()
return nil
end

