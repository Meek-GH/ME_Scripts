local API = require("api")
local afk, lastCheck = os.time(), os.time()
local lastXp = API.GetSkillXP("AGILITY")
local MAX_IDLE_TIME_MINUTES = 15
API.SetDrawTrackedSkills(true)

local lastPose = nil

local function idleCheck()
    local timeDiff = os.difftime(os.time(), afk)
    local randomTime = math.random((MAX_IDLE_TIME_MINUTES * 60) * 0.6, (MAX_IDLE_TIME_MINUTES * 60) * 0.9)

    if timeDiff > randomTime then
        API.PIdle2()
        afk = os.time()
    end
end

local function readPose()
    local base = { { 1551,3,-1,-1,0 }, { 1551,2,-1,3,0 } }
    local pose = API.ScanForInterfaceTest2Get(false, base)[1].textids
    return pose
end

local function isAtSerenity()
    return API.PInArea(2190, 4, 3397, 4)
end

local function balancePost()
    API.DoAction_Object1(0xb5,API.OFF_ACT_GeneralObject_route0,{ 93115 },50)
    API.RandomSleep2(1000, 200, 300)
    API.WaitUntilMovingandAnimEnds()
end

while API.Read_LoopyLoop() do
    idleCheck()

    if isAtSerenity() then
        balancePost()
    end

        local pose = readPose()
if pose ~= lastPose then
    lastPose = pose
    if pose == "Crane" then
        API.RandomSleep2(800, 600, 400)
        API.KeyboardPress2(0x31, 0, 0)
    elseif pose == "Bow" then
        API.RandomSleep2(800, 600, 400)
        API.KeyboardPress2(0x32, 0, 0)
    elseif pose == "Lotus" then
        API.RandomSleep2(800, 600, 400)
        API.KeyboardPress2(0x33, 0, 0)
    elseif pose == "Ward" then
        API.RandomSleep2(800, 600, 400)
        API.KeyboardPress2(0x34, 0, 0)
    end
end

    local currentXp, currentTime = API.GetSkillXP("AGILITY"), os.time()
    if currentXp > lastXp then
        lastXp, lastCheck = currentXp, currentTime
    elseif currentTime - lastCheck > 15 then
        API.Write_LoopyLoop(false)
        break
    end

    API.RandomSleep2(300, 400, 600)
end
