--[[
/* 
  Game Script - Secrets of Dyrt

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



Version: 14.11.02

]]

GameScript = true -- This value MUST be set to true, or we may get VERY undesirable behavior.

--[[
  This file only contains definitions and references 
  the GALE Pre-Processor picks up. The reason why they are prefixed as "-- @" is 
  to make them appear like a comment otherwise my IDE (based on Eclipse) thinks 
  the GALE preprocessor's lines are faulty and will spook everything up and the @ is 
  to make sure the pre-processsor sees the difference between a regular comment and a 
  directive.
  
  Those new to Lua. These lines are not supported by Lua itself. The GALE engine
  LAURA uses creates a new Lua script based on these lines and that script will
  be compiled by Lua itself.
  
  The GameScript variable is here set to true. This is to make the scripts 
  included by -- @USEDIR Scripts/Use/AnyWay see the difference between the game
  script and other scripts. This is very important!
  
]]

-- DEVELOPMENT means this is the development version. General debug features are enabled
-- FIGHTLINES will mark the spots for heroes and foes on the battlefield.

-- @DEFINE DEVELOPMENT
-- @UNDEF FIGHTLINES
-- @UNDEF STACKCHECK
-- @UNDEF FIELDDEBUG

-- @DEFINE CHAPTER2
-- @DEFINE CHAPTER3
-- @DEFINE CHAPTER4
-- @DEFINE CHAPTER5

-- @USEDIR Scripts/Use/Anyway/
-- @USEDIR Scripts/Use/Game/
-- @USEDIR Scripts/Use/Characters/
-- @USEDIR Scripts/Use/GameData/

