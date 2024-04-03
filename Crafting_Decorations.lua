--[[





  __  __                              ____ _          _     _                             
 |  \/  | ___ _ __ _ __ _   _        / ___| |__  _ __(_)___| |_ _ __ ___   __ _ ___       
 | |\/| |/ _ \ '__| '__| | | |      | |   | '_ \| '__| / __| __| '_ ` _ \ / _` / __|      
 | |  | |  __/ |  | |  | |_| |      | |___| | | | |  | \__ \ |_| | | | | | (_| \__ \      
 |_|  |_|\___|_|  |_|   \__, |       \____|_| |_|_|  |_|___/\__|_| |_| |_|\__,_|___/      
 __   __           _____|___/_   _                     _          _                 _     
 \ \ / /_ _       |  ___(_) | |_| |__  _   _          / \   _ __ (_)_ __ ___   __ _| |___ 
  \ V / _` |      | |_  | | | __| '_ \| | | |        / _ \ | '_ \| | '_ ` _ \ / _` | / __|
   | | (_| |      |  _| | | | |_| | | | |_| |       / ___ \| | | | | | | | | | (_| | \__ \
   |_|\__,_|      |_|   |_|_|\__|_| |_|\__, |      /_/   \_\_| |_|_|_| |_| |_|\__,_|_|___/
                                       |___/                                              




                                                                                        -- 404 M  k
                                                                                            XX 
                                                                                            XX 
                                                                                            XX 
                                                                                            XX 
                                                                                            XX 
                                                                                            .. 
                                                                                            
                                                                                        -- 404 Meek
                                                                                               

]]








local API = require("api")
local MAX_IDLE_TIME_MINUTES = 10 -- CHANGE TO (5) IF NOT ON JAGEX ACC
local startTime, afk = os.time(), os.time()


local skill = "CONSTRUCTION"
local startXp = API.GetSkillXP(skill)
local startTime, afk = os.time(), os.time()
local startChristmasSpirits


local function readChristmasSpirits()
    local base = { { 1272,6,-1,-1,0 }, { 1272,2,-1,6,0 }, { 1272,8,-1,2,0 } }
    local spirits = API.ScanForInterfaceTest2Get(false, base)[1].textids
    local str = spirits:gsub("[^%d]+", "")
    return tonumber(str:match("(%d[%d,]*)"))
end

local function round(val, decimal)
    if decimal then
        return math.floor((val * 10 ^ decimal) + 0.5) / (10 ^ decimal)
    else
        return math.floor(val + 0.5)
    end
end

function formatNumber(num)
    if num >= 1e6 then
        return string.format("%.1fM", num / 1e6)
    elseif num >= 1e3 then
        return string.format("%.1fK", num / 1e3)
    else
        return tostring(num)
    end
end

-- Format script elapsed time to [hh:mm:ss]
local function formatElapsedTime(startTime)
    local currentTime = os.time()
    local elapsedTime = currentTime - startTime
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = elapsedTime % 60
    return string.format("[%02d:%02d:%02d]", hours, minutes, seconds)
end

local function calcProgressPercentage(skill, currentExp)
    local currentLevel = API.XPLevelTable(API.GetSkillXP(skill))
    if currentLevel == 120 then return 100 end
    local nextLevelExp = XPForLevel(currentLevel + 1)
    local currentLevelExp = XPForLevel(currentLevel)
    local progressPercentage = (currentExp - currentLevelExp) / (nextLevelExp - currentLevelExp) * 100
    return math.floor(progressPercentage)
end

local function printProgressReport(final)
    local currentXp = API.GetSkillXP(skill)
    local elapsedMinutes = (os.time() - startTime) / 60
    local diffXp = math.abs(currentXp - startXp);
    local xpPH = round((diffXp * 60) / elapsedMinutes);
    local christmasSpirits = readChristmasSpirits() - startChristmasSpirits
    local christmasSpiritsPH = round((christmasSpirits * 60) / elapsedMinutes)
    local time = formatElapsedTime(startTime)
    local currentLevel = API.XPLevelTable(API.GetSkillXP(skill))
    IGP.radius = calcProgressPercentage(skill, API.GetSkillXP(skill)) / 100
    IGP.string_value = time ..
        " | " ..
        string.lower(skill):gsub("^%l", string.upper) ..
        ": " .. currentLevel .. " | XP/H: " .. formatNumber(xpPH) .. " | XP: " .. formatNumber(diffXp) .. " | Christmas Spirits: " .. formatNumber(christmasSpirits) .. " | Christmas Spirits/H: " .. formatNumber(christmasSpiritsPH)
end

local function setupGUI()
    IGP = API.CreateIG_answer()
    IGP.box_start = FFPOINT.new(5, 5, 0)
    IGP.box_name = "PROGRESSBAR"
    IGP.colour = ImColor.new(205, 133, 63);
    IGP.string_value = "CRAFTING DECORATIONS"
end

local function drawGUI()
    DrawProgressBar(IGP)
end






local function idleCheck()
    local timeDiff = os.difftime(os.time(), afk)
    local randomTime = math.random((MAX_IDLE_TIME_MINUTES * 60) * 0.6, (MAX_IDLE_TIME_MINUTES * 60) * 0.9)

    if timeDiff > randomTime then
        local rnd1 = math.random(25, 28)
        local rnd2 = math.random(25, 28)

        API.KeyboardPress31(0x28, math.random(20, 60), math.random(50, 200))
        API.KeyboardPress31(0x27, math.random(20, 60), math.random(50, 200))

        afk = os.time()
    end
end


local function getUNFDecorations()
    API.DoAction_Object1(0x2D, 0, {128787}, 50)
    
end


local function hasUNFDecorations()
    local UnfinishedDecorations = 56168
    local item_count = API.InvItemcount_2(UnfinishedDecorations)
    return item_count > 0
end


local function craftDecorations()
        API.DoAction_Object1(0x29, 0, {128793}, 50)
        
        
  
end


local function hasFinishedDecorations()
    local UnfinishedDecorationsID = 56168
    local FinishedDecorationsID = 56170

    local unfinished_count = API.InvItemcount_2(UnfinishedDecorationsID)
    local finished_count = API.InvItemcount_2(FinishedDecorationsID)

    return unfinished_count == 0 and finished_count > 0
end



local function depositDecoration()
    API.DoAction_Object1(0x29, 0, {128788}, 50)
    API.RandomSleep2(800, 300, 300)
    print("Deposit completed.")
    gatherCount = 0
    API.RandomSleep2(800, 300, 300)
end





setupGUI()

startChristmasSpirits = readChristmasSpirits()

local gatherCount = 0 





while (API.Read_LoopyLoop()) do
    idleCheck()
    drawGUI()
    readChristmasSpirits()
    API.DoRandomEvents()

    if API.ReadPlayerMovin2() or (API.ReadPlayerAnim() > 0) then
        goto continue
    end

    if gatherCount <22 then -- CHANGE HOW MANY YOU WANT IN INV.
        if getUNFDecorations() then
            
            goto continue
        end

        gatherCount = gatherCount + 1
    end

    if hasUNFDecorations() then
        while not API.CheckAnim(127) do
            print("CHECKING ANIM")
            craftDecorations()
            goto continue
        end
    elseif hasFinishedDecorations() then
        depositDecoration()

        gatherCount = 0
    end

    ::continue::
    printProgressReport()
    API.RandomSleep2(100, 200, 200)
end

