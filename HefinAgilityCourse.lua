local API = require("api")

API.SetDrawTrackedSkills(true) -- Set to False if you don't want to track XP
local MAX_IDLE_TIME_MINUTES = 15
local afk = os.time()



local function idleCheck()
    local timeDiff = os.difftime(os.time(), afk)
    local randomTime = math.random((MAX_IDLE_TIME_MINUTES * 60) * 0.6, (MAX_IDLE_TIME_MINUTES * 60) * 0.9)

    if timeDiff > randomTime then
        API.PIdle2()
        afk = os.time()
    end
end

local function windowIsOpen()
    return #API.GetAllObjArrayInteract({ 94053 }, 4, { 0 }) > 0
end

local function nearWalkway()
    return API.PInArea(2176, 3, 3400, 3)
end

local function nearCliff()
    return API.PInArea(2180, 3, 3419, 3)
end

local function nearCitadel()
    return API.PInArea(2171, 3, 3437, 3)
end

local function nearRoof()
    return API.PInArea(2177, 3, 3448, 3)
end

local function nearZipline()
    return API.PInArea(2187, 3, 3443, 3)
end

local function nearLightCreature()
    return API.PInArea(2187, 1, 3415, 1)
end

while API.Read_LoopyLoop() do
    idleCheck()

    if nearWalkway() then
        API.DoAction_Object1(0xb5,API.OFF_ACT_GeneralObject_route0,{ 94050 },50) -- Leap across Walkway
        API.RandomSleep2(9000,800,600)
        API.WaitUntilMovingandAnimEnds()
    elseif nearCliff() then
        API.DoAction_Object1(0xb5,API.OFF_ACT_GeneralObject_route0,{ 94051 },50) -- Traverse Cliff
        API.RandomSleep2(9000,800,600)
        API.WaitUntilMovingandAnimEnds()
    elseif nearCitadel() then
        if windowIsOpen() then
            API.DoAction_Object1(0xb5,API.OFF_ACT_GeneralObject_route0,{ 94053 },4) -- Leap through Window
            API.RandomSleep2(5000,800,600)
            API.WaitUntilMovingandAnimEnds()
        else
            API.DoAction_Object1(0xb5,API.OFF_ACT_GeneralObject_route0,{ 94055 },50) -- Scale Citadel
            API.RandomSleep2(9000,800,600)
            API.WaitUntilMovingandAnimEnds()
        end
    elseif nearRoof() then
        API.DoAction_Object1(0xb5,API.OFF_ACT_GeneralObject_route0,{ 94056 },50) -- Vault Roof
        API.RandomSleep2(9000,800,600)
        API.WaitUntilMovingandAnimEnds()
    elseif nearZipline() then
        API.DoAction_Object1(0xb5,API.OFF_ACT_GeneralObject_route0,{ 94057 },50) -- Slide down Zipline
        API.RandomSleep2(9000,800,600)
        API.WaitUntilMovingandAnimEnds()
    elseif nearLightCreature() then
        API.DoAction_NPC(0xb5,API.OFF_ACT_InteractNPC_route,{ 20274 },5) -- Merge with Light Creature
        API.RandomSleep2(9000,800,600)
        API.WaitUntilMovingandAnimEnds()
    end
end


