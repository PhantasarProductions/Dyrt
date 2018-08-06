function DefeatAction.ScharumLose(CBData)
StopMusic()
-- Always look on the bright side of life
AwardTrophy("BrightSide")
Combat_DrawScreen()
Time.Sleep(500)
local ch=party[1]
char[ch].HP[1]=1
PullMusic()
end