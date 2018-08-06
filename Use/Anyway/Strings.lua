--[[
/* 
  Strings

  Copyright (C) 2014 Jeroen P. Broks

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



Version: 14.04.20

]]
function Mid(FStr,P,L)
return Str.Mid(FStr,P,L)
end

mid = Mid

function string:split(pat)
  pat = pat or '%s+'
  local st, g = 1, self:gmatch("()("..pat..")")
  local function getter(segs, seps, sep, cap1, ...)
    st = sep and seps + #sep
    return self:sub(segs, (seps or 0) - 1), cap1 or sep, ...
  end
  return function() if st then return getter(st, g()) end end
end

function split(str,pat)
ret = {}
local k
for k in str:split(pat) do table.insert(ret,k) end
return ret
end

function isplit(str,pat)
ret = {}
local k
for k in str:split(pat) do table.insert(ret,Sys.Val(k)) end
return ret
end
