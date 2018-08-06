--[[
/* 
  Darkness falls over Frundarmon's mansion

  Copyright (C) 2014 JP Broks

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



Version: 14.11.02

]]
-- @IF IGNOREME
AfterDrawMap = {}
-- @FI


function AfterDrawMap.CH4_FRUNDARMON()
if not circleloaded then
   Image.AssignLoad("CIRCLEDARKNESS","GFX/AFTERDRAWMAP/CIRCULARDARKNESS.PNG")
   CWrite("Circular darkness loaded",0,0,255)
   circleloaded = true
   end
Image.Draw("CIRCLEDARKNESS",0,0)  
--  CWrite("Dark?") -- Debug line. Must be on 'rem' in final version. 
end

AfterDrawMap.CH4_FRUNDARMONBASEMENT = AfterDrawMap.CH4_FRUNDARMON
AfterDrawMap.CH5_DYRT_DEATHCAVE     = AfterDrawMap.CH4_FRUNDARMON
AfterDrawMap.CH5_DYRT_FOREST        = AfterDrawMap.CH4_FRUNDARMON
AfterDrawMap.CH5_DYRT_BEACH         = AfterDrawMap.CH4_FRUNDARMON
AfterDrawMap.CH5_VILLAGE            = AfterDrawMap.CH4_FRUNDARMON
AfterDrawMap.CH5_DZGJYMZA_KEEP      = AfterDrawMap.CH4_FRUNDARMON
AfterDrawMap.CH5_DZGJYMZA_UPSTAIRS  = AfterDrawMap.CH4_FRUNDARMON
