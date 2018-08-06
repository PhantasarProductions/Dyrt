--[[
/* 
  

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



Version: 14.09.10

]]
function Shop(store)
if TrueShop then 
   TrueShop(store)
   else
   LAURA.ExecuteGame("TrueShop",store)
   end
end   

function Teleport(exit)
if ManualTeleport then 
   ManualTeleport(exit)
   else
   LAURA.ExecuteGame("ManualTeleport",exit)
   end
end   

if not GameScript then
   CSay("Creating link to the real worldmap routine")
   WorldMap = function (aw)
     local w = aw or 'Delisto'
     LAURA.ExecuteGame("WorldMap",w)
     end
   WorldMap_Reveal = function (mp,mt)
     CSay("- Let's reveal a new world map entry")
     CSay("  = "..sval(mp))
     CSay("  = "..sval(mt))     
     LAURA.ExecuteGame('WorldMap_Reveal',mp..";"..mt)
     end  
     
   StoneMaster = function(Master)
     LAURA.ExecuteGame("StoneMaster",Master)
     end     
     
   function Bank()
    LAURA.ExecuteGame("Bank")   
    end  
    
   function Flip()
    LAURA.ExecuteGame("Flip")
    end 
    
   function Walk(NoChange)
    LAURA.ExecuteGame("Walk",sval(NoChange))
    end 
    
   function SetRENC(v)
    LAURA.ExecuteGame("SetRENC",v)
    end 
    
   function NewDSX(Tag,X,Y,Img)
    LAURA.ExecuteGame("NewDSX",Tag..";"..X..";"..Y..";"..Img)
    end
    
   function RemoveDSX(Tag)
    LAURA.ExecuteGame('RemoveDSX',Tag)
    end  
   
   function MoveDSX(Tag,X,Y,StX,StY)
    LAURA.ExecuteGame("MoveDSX",Tag..";"..X..";"..Y..";"..(StX or 1)..";"..(StY or 1))
    end 
    
   function WalkToExit(exit,actor)
    if actor then
       LAURA.ExecuteGame("WalkToExit",exit..";"..actor)
       else
       LAURA.ExecuteGame("WalkToExit",exit)
       end
    end 
    
   end
