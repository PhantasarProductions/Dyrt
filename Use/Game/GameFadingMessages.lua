--[[
/* 
  

  Copyright (C) 2014 Jeroen Broks

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



Version: 14.02.07

]]
GFMList = {}

function GameFieldMessages() 
if not GFMList[1] then return end
-- @SELECT GFMList[1].Count
-- @CASE "UP"
   GFMList[1].Alpha = GFMList[1].Alpha + 0.005
   if GFMList[1].Alpha>=1 then GFMList[1].Count = "KEEP" end
-- @CASE "KEEP"
   GFMList[1].FTime = GFMList[1].FTime - 1
   if GFMList[1].FTime<=0 then GFMList[1].Count = "DOWN" end
-- @CASE "DOWN"
   GFMList[1].Alpha = GFMList[1].Alpha - 0.005
   if GFMList[1].Alpha<=0 then
      if GFMList[1].Img and GFMList[1].ImgDel then 
         Image.Free(GFMList[1].Img)
         end 
      table.remove(GFMList,1); 
      return 
      end
-- @ENDSELECT
-- @IF !$PPC
Image.SetAlpha(GFMList[1].Alpha)
-- @FI
Image.Color(255*GFMList[1].Alpha,255*GFMList[1].Alpha,255)
if GFMList[1].Img then Image.Draw(GFMList[1].Img,400,300) end
if GFMList[1].Msg then 
   Image.Font("Fonts/Abigail.ttf",50);
   Image.Color(0,0,0) 
   DText(GFMList[1].Msg,401,301,2,2) 
   Image.Color(255*GFMList[1].Alpha,255*GFMList[1].Alpha,255)
   DText(GFMList[1].Msg,400,300,2,2) 
   end
-- @IF !$PPC
Image.SetAlpha(1)
-- @FI   
end


function GameFieldMessage(Msg)
table.insert(GFMList,{["Msg"]=Msg,["Alpha"]=0,["FTime"]=250,["Count"]="UP"})
end

function GameFieldImgMsg(ImageFile)
local img = Image.Load(ImageFile)
Image.HotCenter(img)
table.insert(GFMList,{["Img"]=img,["Alpha"]=0,["FTime"]=500,["Count"]="UP",["ImgDel"]=true})
end

function GameFieldImgTag(Tag)
-- GameFieldImgMsg(Img,true)
table.insert(GFMList,{["Img"]=Tag,["Alpha"]=0,["FTime"]=500,["Count"]="UP",["ImgDel"]=false})
end

function Chapter(ChapterNumber)
GameFieldImgMsg("GFX/Chapter/"..ChapterNumber..".png")
end
