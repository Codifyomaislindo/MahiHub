-- ═══════════════════════════════════════════════════════════════
--                    MAHI HUB V3.0 - BLOX FRUITS
--              ULTIMATE ENHANCED SCRIPT WITH COMPLEX SYSTEMS
-- ═══════════════════════════════════════════════════════════════

-- ┌─────────────────────────────────────────────────────────────┐
-- │                    SECURITY & ANTI-DETECTION               │
-- └─────────────────────────────────────────────────────────────┘

if not game:IsLoaded() then 
    game.Loaded:Wait() 
end

-- Anti-Detection System
local function CreateAntiDetection()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" or method == "InvokeServer" then
            -- Add anti-detection logic here
        end
        return old(self, ...)
    end)
    
    setreadonly(mt, true)
end

-- Advanced Error Handling System
local ErrorHandler = {
    Errors = {},
    MaxErrors = 50,
    RetryAttempts = 3
}

function ErrorHandler:SafeExecute(func, retries)
    retries = retries or self.RetryAttempts
    
    for attempt = 1, retries do
        local success, result = pcall(func)
        
        if success then
            return true, result
        else
            table.insert(self.Errors, {
                Error = result,
                Time = tick(),
                Attempt = attempt,
                Function = debug.getinfo(func, "S").source
            })
            
            if #self.Errors > self.MaxErrors then
                table.remove(self.Errors, 1)
            end
            
            if attempt < retries then
                wait(0.1 * attempt) -- Exponential backoff
            end
        end
    end
    
    return false, "Max retries exceeded"
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                      LIBRARY LOADING                       │
-- └─────────────────────────────────────────────────────────────┘

local WindUI
local LibraryUrls = {
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
    "https://raw.githubusercontent.com/Footagesus/WindUI/main/main.lua",
    "https://pastebin.com/raw/windui_backup"
}

for _, url in pairs(LibraryUrls) do
    local success, result = ErrorHandler:SafeExecute(function()
        WindUI = loadstring(game:HttpGet(url))()
    end)
    
    if success and WindUI then
        break
    end
    wait(1)
end

if not WindUI then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚠️ Mahi Hub Error";
        Text = "Failed to load WindUI library after multiple attempts!";
        Duration = 10;
    })
    return
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                      SERVICES & VARIABLES                  │
-- └─────────────────────────────────────────────────────────────┘

local Services = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    TweenService = game:GetService("TweenService"),
    RunService = game:GetService("RunService"),
    Workspace = game:GetService("Workspace"),
    HttpService = game:GetService("HttpService"),
    UserInputService = game:GetService("UserInputService"),
    TeleportService = game:GetService("TeleportService"),
    VirtualUser = game:GetService("VirtualUser"),
    StarterGui = game:GetService("StarterGui"),
    Lighting = game:GetService("Lighting"),
    SoundService = game:GetService("SoundService"),
    GuiService = game:GetService("GuiService"),
    PathfindingService = game:GetService("PathfindingService"),
    MarketplaceService = game:GetService("MarketplaceService"),
    BadgeService = game:GetService("BadgeService"),
    Teams = game:GetService("Teams"),
    Chat = game:GetService("Chat"),
    LogService = game:GetService("LogService")
}

-- Player Variables with Advanced Detection
local Player = Services.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ┌─────────────────────────────────────────────────────────────┐
-- │                    ADVANCED SETTINGS SYSTEM                │
-- └─────────────────────────────────────────────────────────────┘

local Settings = {
    -- Auto Farm Settings
    AutoFarm = {
        Enabled = false,
        Mode = "Nearest", -- Nearest, Level, Health
        SafeDistance = 20,
        AttackDelay = 0.15,
        UseSkills = true,
        AutoHeal = true,
        HealthThreshold = 50,
        EnergyThreshold = 25,
        RespawnFarm = true,
        MultiTarget = false,
        SelectedMob = nil,
        SelectedWeapon = nil,
        CustomPosition = nil
    },
    
    -- Auto Boss Settings  
    AutoBoss = {
        Enabled = false,
        SelectedBoss = nil,
        NotifySpawn = true,
        AutoRespawn = true,
        UseAllSkills = true,
        SafeKill = true,
        TeamCheck = false
    },
    
    -- Auto Stats Settings
    AutoStats = {
        Enabled = false,
        Melee = 0,
        Defense = 0,
        Sword = 0,
        Gun = 0,
        Fruit = 0,
        Mode = "Balanced", -- Balanced, Focused, Custom
        AutoDistribute = false,
        SavePoints = true
    },
    
    -- ESP Settings
    ESP = {
        Fruits = false,
        Mobs = false,
        Bosses = false,
        Chests = false,
        NPCs = false,
        Players = false,
        Items = false,
        Distance = 5000,
        ShowHealth = true,
        ShowDistance = true,
        ShowLevel = true,
        Tracers = false,
        Boxes = false
    },
    
    -- Teleport Settings
    Teleport = {
        Speed = 50,
        Mode = "Smooth", -- Smooth, Instant, Walk
        AvoidWalls = true,
        SafeTeleport = true,
        TweenInfo = {
            Time = 1,
            EasingStyle = Enum.EasingStyle.Linear,
            EasingDirection = Enum.EasingDirection.Out
        }
    },
    
    -- Combat Settings
    Combat = {
        AimBot = false,
        AutoDodge = false,
        AutoBlock = false,
        ComboMode = false,
        SkillSpam = false,
        PredictMovement = false,
        AutoSwitchWeapon = false,
        CriticalHitChance = 15
    },
    
    -- Misc Settings
    Misc = {
        WalkSpeed = 16,
        JumpPower = 50,
        InfiniteJump = false,
        NoClip = false,
        Fly = false,
        FlySpeed = 25,
        AutoRespawn = true,
        RemoveDamageGUI = false,
        AntiAFK = true,
        ServerHop = false
    },
    
    -- Current Game State
    GameState = {
        CurrentSea = 1,
        PlayerLevel = 1,
        PlayerMoney = 0,
        CurrentWeapon = nil,
        InCombat = false,
        LastDeath = 0,
        SessionTime = tick(),
        TotalKills = 0,
        TotalDeaths = 0
    }
}

-- ┌─────────────────────────────────────────────────────────────┐
-- │                   ADVANCED SEA DETECTION                   │
-- └─────────────────────────────────────────────────────────────┘

local SeaDetection = {}

function SeaDetection:DetectByPlaceId()
    local placeId = game.PlaceId
    if placeId == 2753915549 then return 1, "First Sea"
    elseif placeId == 4442272183 then return 2, "Second Sea" 
    elseif placeId == 7449423635 then return 3, "Third Sea"
    else return nil, "Unknown Sea" end
end

function SeaDetection:DetectByWorkspace()
    local workspace = Services.Workspace
    
    -- First Sea Detection
    if workspace:FindFirstChild("Map") then
        local map = workspace.Map
        if map:FindFirstChild("Skylands") or map:FindFirstChild("MarineFord") then
            return 1, "First Sea (Workspace)"
        elseif map:FindFirstChild("Kingdom of Rose") or map:FindFirstChild("Swan") then
            return 2, "Second Sea (Workspace)"
        elseif map:FindFirstChild("Port Town") or map:FindFirstChild("Tiki Outpost") then
            return 3, "Third Sea (Workspace)"
        end
    end
    
    return nil, "Detection Failed"
end

function SeaDetection:DetectByNPCs()
    local npcs = Services.Workspace:FindFirstChild("NPCs")
    if not npcs then return nil, "No NPCs Found" end
    
    -- Check for specific NPCs
    if npcs:FindFirstChild("Blox Fruit Dealer") then
        local dealer = npcs["Blox Fruit Dealer"]
        if dealer.PrimaryPart then
            local pos = dealer.PrimaryPart.Position
            if pos.Y > 1000 then return 1, "First Sea (NPC)"
            elseif math.abs(pos.X) > 5000 then return 2, "Second Sea (NPC)"
            else return 3, "Third Sea (NPC)" end
        end
    end
    
    return nil, "NPC Detection Failed"
end

function SeaDetection:GetCurrentSea()
    local methods = {
        self.DetectByPlaceId,
        self.DetectByWorkspace,
        self.DetectByNPCs
    }
    
    for _, method in pairs(methods) do
        local success, sea, name = ErrorHandler:SafeExecute(function()
            return method(self)
        end)
        
        if success and sea then
            Settings.GameState.CurrentSea = sea
            return sea, name
        end
    end
    
    Settings.GameState.CurrentSea = 1
    return 1, "Default First Sea"
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                      EXTENSIVE DATABASE                    │
-- └─────────────────────────────────────────────────────────────┘

local Database = {
    [1] = { -- First Sea
        Mobs = {
            {Name = "Bandit", Level = {5, 7}, Location = Vector3.new(-1181, 5, 3803), Drops = {"Katana"}},
            {Name = "Monkey", Level = {14, 16}, Location = Vector3.new(-1612, 37, 149), Drops = {"Pipe"}},
            {Name = "Gorilla", Level = {20, 25}, Location = Vector3.new(-1612, 37, 149), Drops = {"Saber"}},
            {Name = "Pirate", Level = {35, 40}, Location = Vector3.new(-1181, 5, 3803), Drops = {"Cutlass"}},
            {Name = "Brute", Level = {45, 50}, Location = Vector3.new(-1181, 5, 3803), Drops = {"Iron Mace"}},
            {Name = "Desert Bandit", Level = {60, 65}, Location = Vector3.new(944, 21, 4481), Drops = {"Bisento"}},
            {Name = "Desert Officer", Level = {70, 75}, Location = Vector3.new(944, 21, 4481), Drops = {"Dual Katana"}},
            {Name = "Snow Bandit", Level = {90, 95}, Location = Vector3.new(1347, 104, -1319), Drops = {"Saber"}},
            {Name = "Snowman", Level = {100, 105}, Location = Vector3.new(1347, 104, -1319), Drops = {"Pipe"}},
            {Name = "Chief Petty Officer", Level = {120, 125}, Location = Vector3.new(-2566, 7, -294), Drops = {"Dual Katana"}},
            {Name = "Sky Bandit", Level = {150, 155}, Location = Vector3.new(-4813, 718, -2624), Drops = {"Saber"}},
            {Name = "Dark Master", Level = {175, 180}, Location = Vector3.new(-4813, 718, -2624), Drops = {"Bisento"}},
            {Name = "Prisoner", Level = {190, 195}, Location = Vector3.new(4875, 6, 734), Drops = {"Iron Mace"}},
            {Name = "Dangerous Prisoner", Level = {210, 215}, Location = Vector3.new(4875, 6, 734), Drops = {"Dual Katana"}},
            {Name = "Toga Warrior", Level = {225, 230}, Location = Vector3.new(-1427, 8, -2673), Drops = {"Katana"}},
            {Name = "Gladiator", Level = {275, 280}, Location = Vector3.new(-1427, 8, -2673), Drops = {"Iron Mace"}},
            {Name = "Military Soldier", Level = {300, 305}, Location = Vector3.new(-2566, 7, -294), Drops = {"Dual Katana"}},
            {Name = "Military Spy", Level = {325, 330}, Location = Vector3.new(-2566, 7, -294), Drops = {"Bisento"}},
            {Name = "Fishman Warrior", Level = {375, 380}, Location = Vector3.new(61123, 11, 1819), Drops = {"Katana"}},
            {Name = "Fishman Commando", Level = {400, 405}, Location = Vector3.new(61123, 11, 1819), Drops = {"Cutlass"}},
            {Name = "God's Guard", Level = {450, 455}, Location = Vector3.new(-7952, 5545, -320), Drops = {"Saber"}},
            {Name = "Shanda", Level = {475, 480}, Location = Vector3.new(-7952, 5545, -320), Drops = {"Triple Katana"}},
            {Name = "Royal Squad", Level = {525, 530}, Location = Vector3.new(5127, 59, 4105), Drops = {"Dual Katana"}},
            {Name = "Royal Soldier", Level = {550, 555}, Location = Vector3.new(5127, 59, 4105), Drops = {"Iron Mace"}},
            {Name = "Galley Pirate", Level = {625, 630}, Location = Vector3.new(5127, 59, 4105), Drops = {"Bisento"}},
            {Name = "Galley Captain", Level = {650, 655}, Location = Vector3.new(5127, 59, 4105), Drops = {"Triple Katana"}}
        },
        
        Bosses = {
            {Name = "Gorilla King", Level = 25, Location = Vector3.new(-1612, 37, 149), SpawnTime = 300, Drops = {"Pink Coat", "Saber"}},
            {Name = "Bobby", Level = 55, Location = Vector3.new(-1181, 5, 3803), SpawnTime = 600, Drops = {"Refined Flintlock"}},
            {Name = "The Saw", Level = 100, Location = Vector3.new(944, 21, 4481), SpawnTime = 1200, Drops = {"Shark Saw"}},
            {Name = "Yeti", Level = 105, Location = Vector3.new(1347, 104, -1319), SpawnTime = 1800, Drops = {"Yeti Fur Coat"}},
            {Name = "Mob Leader", Level = 120, Location = Vector3.new(-2566, 7, -294), SpawnTime = 1200, Drops = {"Dual Katana"}},
            {Name = "Vice Admiral", Level = 130, Location = Vector3.new(-2566, 7, -294), SpawnTime = 1800, Drops = {"Black Cloak"}},
            {Name = "Saber Expert", Level = 200, Location = Vector3.new(-1427, 8, -2673), SpawnTime = 3600, Drops = {"Saber"}},
            {Name = "Warden", Level = 220, Location = Vector3.new(4875, 6, 734), SpawnTime = 1800, Drops = {"Warden Sword"}},
            {Name = "Chief Warden", Level = 230, Location = Vector3.new(4875, 6, 734), SpawnTime = 3600, Drops = {"Warden Shield"}},
            {Name = "Swan", Level = 240, Location = Vector3.new(-1427, 8, -2673), SpawnTime = 1800, Drops = {"Black Cape"}},
            {Name = "Magma Admiral", Level = 350, Location = Vector3.new(-5247, 9, -2863), SpawnTime = 3600, Drops = {"Admiral Coat"}},
            {Name = "Fishman Lord", Level = 425, Location = Vector3.new(61123, 11, 1819), SpawnTime = 3600, Drops = {"Water Key", "Fishman Karate"}},
            {Name = "Wysper", Level = 500, Location = Vector3.new(-7952, 5545, -320), SpawnTime = 1800, Drops = {"Bazooka"}},
            {Name = "Thunder God", Level = 575, Location = Vector3.new(-7952, 5545, -320), SpawnTime = 3600, Drops = {"Pole (1st Form)"}},
            {Name = "Cyborg", Level = 675, Location = Vector3.new(5127, 59, 4105), SpawnTime = 3600, Drops = {"Cool Shades", "Cyborg Puzzle"}}
        },
        
        Islands = {
            ["🏝️ Starter Island"] = {Pos = Vector3.new(1, 4, 1), NPCs = {"Blox Fruit Dealer", "Weapon Dealer"}},
            ["🌴 Jungle"] = {Pos = Vector3.new(-1612, 37, 149), NPCs = {"Gorilla King Quest"}},
            ["🏴‍☠️ Pirate Village"] = {Pos = Vector3.new(-1181, 5, 3803), NPCs = {"Pirate Quest Giver"}},
            ["🏜️ Desert"] = {Pos = Vector3.new(944, 21, 4481), NPCs = {"Desert Quest"}},
            ["❄️ Frozen Village"] = {Pos = Vector3.new(1347, 104, -1319), NPCs = {"Frozen Quest"}},
            ["🏰 Marine Fortress"] = {Pos = Vector3.new(-2566, 7, -294), NPCs = {"Marine Quest"}},
            ["☁️ Skylands"] = {Pos = Vector3.new(-4813, 718, -2624), NPCs = {"Sky Quest"}},
            ["⛓️ Prison"] = {Pos = Vector3.new(4875, 6, 734), NPCs = {"Prison Quest"}},
            ["🏛️ Colosseum"] = {Pos = Vector3.new(-1427, 8, -2673), NPCs = {"Colosseum Quest"}},
            ["🌋 Magma Village"] = {Pos = Vector3.new(-5247, 9, -2863), NPCs = {"Magma Quest"}},
            ["🌊 Underwater City"] = {Pos = Vector3.new(61123, 11, 1819), NPCs = {"Fishman Quest"}},
            ["☁️ Upper Skylands"] = {Pos = Vector3.new(-7952, 5545, -320), NPCs = {"God Quest"}},
            ["⛲ Fountain City"] = {Pos = Vector3.new(5127, 59, 4105), NPCs = {"Final Quest"}},
            ["🌪️ Middle Town"] = {Pos = Vector3.new(-690, 15, 1582), NPCs = {"Awakener"}},
            ["🏝️ Marine Starter"] = {Pos = Vector3.new(-2573, 7, -3047), NPCs = {"Marine Officer"}},
            ["🗻 Rocky Port"] = {Pos = Vector3.new(-740, 46, 2520), NPCs = {"Blacksmith"}},
            ["🏝️ Shell Island"] = {Pos = Vector3.new(-1226, 50, 50), NPCs = {"Shell Collector"}},
            ["🌀 Windmill Village"] = {Pos = Vector3.new(979, 16, 1680), NPCs = {"Wind Master"}}
        },
        
        Fruits = {
            "Bomb", "Spike", "Chop", "Spring", "Kilo", "Smoke", "Spin", "Flame",
            "Falcon", "Ice", "Sand", "Dark", "Diamond", "Light", "Rubber", "Barrier",
            "Ghost", "Magma", "Quake", "Buddha", "Love", "Spider", "Sound", "Phoenix",
            "Portal", "Rumble", "Pain", "Blizzard", "Gravity", "Mammoth", "T-Rex",
            "Dough", "Shadow", "Venom", "Control", "Spirit", "Dragon", "Leopard"
        }
    },
    
    [2] = { -- Second Sea
        Mobs = {
            {Name = "Raider", Level = {700, 725}, Location = Vector3.new(-384, 73, 298), Drops = {"Katana"}},
            {Name = "Mercenary", Level = {725, 750}, Location = Vector3.new(-384, 73, 298), Drops = {"Dual Katana"}},
            {Name = "Swan Pirate", Level = {775, 800}, Location = Vector3.new(2284, 15, 905), Drops = {"Cutlass"}},
            {Name = "Factory Staff", Level = {800, 825}, Location = Vector3.new(424, 211, -427), Drops = {"Pipe"}},
            {Name = "Marine Lieutenant", Level = {875, 900}, Location = Vector3.new(-2448, 73, -3210), Drops = {"Saber"}},
            {Name = "Marine Captain", Level = {900, 925}, Location = Vector3.new(-2448, 73, -3210), Drops = {"Iron Mace"}},
            {Name = "Zombie", Level = {950, 975}, Location = Vector3.new(-5622, 492, -781), Drops = {"Ectoplasm"}},
            {Name = "Vampire", Level = {975, 1000}, Location = Vector3.new(-5622, 492, -781), Drops = {"Vampire Fang"}},
            {Name = "Snow Lurker", Level = {1000, 1025}, Location = Vector3.new(753, 408, -5274), Drops = {"Snow White"}},
            {Name = "Arctic Warrior", Level = {1025, 1050}, Location = Vector3.new(753, 408, -5274), Drops = {"Ice Shard"}},
            {Name = "Lab Subordinate", Level = {1100, 1125}, Location = Vector3.new(-6508, 89, -132), Drops = {"Scrap Metal"}},
            {Name = "Horned Warrior", Level = {1125, 1150}, Location = Vector3.new(-6508, 89, -132), Drops = {"Radioactive Material"}},
            {Name = "Magma Ninja", Level = {1175, 1200}, Location = Vector3.new(-6508, 89, -132), Drops = {"Magma Ore"}},
            {Name = "Lava Pirate", Level = {1200, 1225}, Location = Vector3.new(-6508, 89, -132), Drops = {"Fire Essence"}},
            {Name = "Ship Deckhand", Level = {1250, 1275}, Location = Vector3.new(923, 125, 32885), Drops = {"Rope"}},
            {Name = "Ship Engineer", Level = {1275, 1300}, Location = Vector3.new(923, 125, 32885), Drops = {"Engine Part"}},
            {Name = "Ship Steward", Level = {1300, 1325}, Location = Vector3.new(923, 125, 32885), Drops = {"Food Supplies"}},
            {Name = "Ship Officer", Level = {1325, 1350}, Location = Vector3.new(923, 125, 32885), Drops = {"Captain Log"}}
        },
        
        Bosses = {
            {Name = "Diamond", Level = 750, Location = Vector3.new(-384, 73, 298), SpawnTime = 1800, Drops = {"Diamond", "Refined Flintlock"}},
            {Name = "Jeremy", Level = 850, Location = Vector3.new(2284, 15, 905), SpawnTime = 1200, Drops = {"Beast Hunter"}},
            {Name = "Fajita", Level = 925, Location = Vector3.new(-2448, 73, -3210), SpawnTime = 900, Drops = {"Wardens Sword"}},
            {Name = "Don Swan", Level = 1000, Location = Vector3.new(2284, 15, 905), SpawnTime = 3600, Drops = {"Swan Glasses", "Pink Cape"}},
            {Name = "Smoke Admiral", Level = 1150, Location = Vector3.new(-2448, 73, -3210), SpawnTime = 3600, Drops = {"Jitte", "Admiral Coat"}},
            {Name = "Awakened Ice Admiral", Level = 1400, Location = Vector3.new(6148, 294, -6895), SpawnTime = 7200, Drops = {"Frozen Badge", "Ice Admiral Coat"}},
            {Name = "Tide Keeper", Level = 1475, Location = Vector3.new(-3032, 317, -10075), SpawnTime = 5400, Drops = {"Water Key", "Tide Keeper Coat"}},
            {Name = "Cursed Captain", Level = 1325, Location = Vector3.new(923, 125, 32885), SpawnTime = 1800, Drops = {"Cursed Dual Katana", "Hell's Core"}}
        },
        
        Islands = {
            ["🌹 Kingdom of Rose"] = {Pos = Vector3.new(-384, 73, 298), NPCs = {"Quest Giver", "Blox Fruit Dealer"}},
            ["🟢 Green Zone"] = {Pos = Vector3.new(-2448, 73, -3210), NPCs = {"Marine Quest"}},
            ["⚰️ Graveyard"] = {Pos = Vector3.new(-9504, 6, 5975), NPCs = {"Zombie Quest"}},
            ["🏔️ Snow Mountain"] = {Pos = Vector3.new(753, 408, -5274), NPCs = {"Snow Quest"}},
            ["🔥 Hot and Cold"] = {Pos = Vector3.new(-6508, 89, -132), NPCs = {"Lab Quest"}},
            ["🚢 Cursed Ship"] = {Pos = Vector3.new(923, 125, 32885), NPCs = {"Cursed Quest"}},
            ["🧊 Ice Castle"] = {Pos = Vector3.new(6148, 294, -6895), NPCs = {"Ice Admiral"}},
            ["🏝️ Forgotten Island"] = {Pos = Vector3.new(-3032, 317, -10075), NPCs = {"Tide Keeper"}},
            ["🏭 Factory"] = {Pos = Vector3.new(424, 211, -427), NPCs = {"Factory Quest"}},
            ["⚡ Swan's Room"] = {Pos = Vector3.new(2284, 15, 905), NPCs = {"Swan Quest"}},
            ["🌊 Usoapp's Island"] = {Pos = Vector3.new(4816, 8, 2863), NPCs = {"Sniper Quest"}},
            ["🏰 Dark Arena"] = {Pos = Vector3.new(3683, 5, -3032), NPCs = {"Arena Master"}},
            ["☠️ Zombie Island"] = {Pos = Vector3.new(-5622, 492, -781), NPCs = {"Ectoplasm Refiner"}}
        },
        
        Fruits = {
            "Bomb", "Spike", "Chop", "Spring", "Kilo", "Smoke", "Spin", "Flame",
            "Falcon", "Ice", "Sand", "Dark", "Diamond", "Light", "Rubber", "Barrier",
            "Ghost", "Magma", "Quake", "Buddha", "Love", "Spider", "Sound", "Phoenix",
            "Portal", "Rumble", "Pain", "Blizzard", "Gravity", "Mammoth", "T-Rex",
            "Dough", "Shadow", "Venom", "Control", "Spirit", "Dragon", "Leopard", "Kitsune"
        }
    },
    
    [3] = { -- Third Sea  
        Mobs = {
            {Name = "Pirate Millionaire", Level = {1500, 1525}, Location = Vector3.new(-290, 44, 422), Drops = {"Katana"}},
            {Name = "Dragon Crew Warrior", Level = {1575, 1600}, Location = Vector3.new(5749, 611, -276), Drops = {"Dragon Talon"}},
            {Name = "Dragon Crew Archer", Level = {1600, 1625}, Location = Vector3.new(5749, 611, -276), Drops = {"Refined Musket"}},
            {Name = "Female Islander", Level = {1675, 1700}, Location = Vector3.new(5312, 426, -3239), Drops = {"Flower Bouquet"}},
            {Name = "Giant Islander", Level = {1700, 1725}, Location = Vector3.new(5312, 426, -3239), Drops = {"Giant Sword"}},
            {Name = "Marine Commodore", Level = {1775, 1800}, Location = Vector3.new(2681, 1682, -7190), Drops = {"Commodore Coat"}},
            {Name = "Marine Rear Admiral", Level = {1800, 1825}, Location = Vector3.new(2681, 1682, -7190), Drops = {"Admiral Sword"}},
            {Name = "Fishman Raider", Level = {1875, 1900}, Location = Vector3.new(-13274, 332, -7906), Drops = {"Trident"}},
            {Name = "Fishman Captain", Level = {1900, 1925}, Location = Vector3.new(-13274, 332, -7906), Drops = {"Captain Anchor"}},
            {Name = "Forest Pirate", Level = {1975, 2000}, Location = Vector3.new(-13274, 332, -7906), Drops = {"Forest Sword"}},
            {Name = "Mythological Pirate", Level = {2000, 2025}, Location = Vector3.new(-13274, 332, -7906), Drops = {"Mythical Cutlass"}},
            {Name = "Jungle Pirate", Level = {2100, 2125}, Location = Vector3.new(2681, 1682, -7190), Drops = {"Jungle Machete"}},
            {Name = "Musketeer Pirate", Level = {2125, 2150}, Location = Vector3.new(2681, 1682, -7190), Drops = {"Musketeer Hat"}},
            {Name = "Reborn Skeleton", Level = {2200, 2225}, Location = Vector3.new(-9515, 142, 5618), Drops = {"Bone Sword"}},
            {Name = "Living Zombie", Level = {2225, 2250}, Location = Vector3.new(-9515, 142, 5618), Drops = {"Zombie Arm"}},
            {Name = "Demonic Soul", Level = {2300, 2325}, Location = Vector3.new(-9515, 142, 5618), Drops = {"Soul Fragment"}},
            {Name = "Posessed Mummy", Level = {2325, 2350}, Location = Vector3.new(-9515, 142, 5618), Drops = {"Mummy Wrap"}},
            {Name = "Peanut Scout", Level = {2375, 2400}, Location = Vector3.new(-2091, 70, -12142), Drops = {"Peanut"}},
            {Name = "Peanut President", Level = {2400, 2425}, Location = Vector3.new(-2091, 70, -12142), Drops = {"Golden Peanut"}},
            {Name = "Ice Cream Chef", Level = {2475, 2500}, Location = Vector3.new(87, 15, -11062), Drops = {"Ice Cream Cone"}},
            {Name = "Ice Cream Commander", Level = {2500, 2525}, Location = Vector3.new(87, 15, -11062), Drops = {"Frozen Treat"}},
            {Name = "Cookie Crafter", Level = {2575, 2600}, Location = Vector3.new(-1034, 13, -14555), Drops = {"Cookie Dough"}},
            {Name = "Cake Guard", Level = {2600, 2625}, Location = Vector3.new(-1034, 13, -14555), Drops = {"Cake Slice"}},
            {Name = "Baking Staff", Level = {2675, 2700}, Location = Vector3.new(-1034, 13, -14555), Drops = {"Baking Powder"}},
            {Name = "Head Baker", Level = {2700, 2725}, Location = Vector3.new(-1034, 13, -14555), Drops = {"Chef Hat"}},
            {Name = "Cocoa Warrior", Level = {2775, 2800}, Location = Vector3.new(-1034, 13, -14555), Drops = {"Cocoa Bean"}},
            {Name = "Chocolate Bar Battler", Level = {2800, 2825}, Location = Vector3.new(-1034, 13, -14555), Drops = {"Chocolate Bar"}},
            {Name = "Sweet Thief", Level = {2875, 2900}, Location = Vector3.new(-1034, 13, -14555), Drops = {"Candy Cane"}},
            {Name = "Candy Rebel", Level = {2900, 2925}, Location = Vector3.new(-1034, 13, -14555), Drops = {"Rock Candy"}},
            {Name = "Candy Pirate", Level = {2950, 2975}, Location = Vector3.new(-1034, 13, -14555), Drops = {"Lollipop Sword"}},
            {Name = "Snow Demon", Level = {3000, 3025}, Location = Vector3.new(87, 15, -11062), Drops = {"Demon Horn"}}
        },
        
        Bosses = {
            {Name = "Stone", Level = 1550, Location = Vector3.new(-290, 44, 422), SpawnTime = 1800, Drops = {"Midnight Blade"}},
            {Name = "Island Empress", Level = 1675, Location = Vector3.new(5312, 426, -3239), SpawnTime = 1800, Drops = {"Serpent Bow", "Island Gem"}},
            {Name = "Kilo Admiral", Level = 1750, Location = Vector3.new(2681, 1682, -7190), SpawnTime = 3600, Drops = {"Microchip", "Kilo Fruit"}},
            {Name = "Captain Elephant", Level = 1875, Location = Vector3.new(-13274, 332, -7906), SpawnTime = 3600, Drops = {"Twin Hooks", "Elephant Tusk"}},
            {Name = "Beautiful Pirate", Level = 1950, Location = Vector3.new(5312, 426, -3239), SpawnTime = 1800, Drops = {"Beautiful Ring", "Pretty Necklace"}},
            {Name = "Longma", Level = 2000, Location = Vector3.new(28289, 14896, 105), SpawnTime = 7200, Drops = {"Dragon Sword", "Longma Mask"}},
            {Name = "Cake Queen", Level = 2175, Location = Vector3.new(-2091, 70, -12142), SpawnTime = 5400, Drops = {"Cake Chalice", "Sweet Crown"}},
            {Name = "Soul Reaper", Level = 2100, Location = Vector3.new(-9515, 142, 5618), SpawnTime = 5400, Drops = {"Hallow Scythe", "Soul Guitar"}},
            {Name = "rip_indra True Form", Level = 5000, Location = Vector3.new(-5411, 778, -2666), SpawnTime = 28800, Drops = {"Red Spikey Coat", "Terror Jaw"}},
            {Name = "Dough King", Level = 2300, Location = Vector3.new(-2091, 70, -12142), SpawnTime = 14400, Drops = {"Spikey Trident", "Red Key"}}
        },
        
        Islands = {
            ["🏘️ Port Town"] = {Pos = Vector3.new(-290, 44, 422), NPCs = {"Quest Giver", "Blox Fruit Dealer"}},
            ["🐍 Hydra Island"] = {Pos = Vector3.new(5749, 611, -276), NPCs = {"Dragon Quest"}},
            ["🌳 Great Tree"] = {Pos = Vector3.new(2681, 1682, -7190), NPCs = {"Tree Quest"}},
            ["🐢 Floating Turtle"] = {Pos = Vector3.new(-13274, 332, -7906), NPCs = {"Turtle Quest"}},
            ["👻 Haunted Castle"] = {Pos = Vector3.new(-9515, 142, 5618), NPCs = {"Ghost Quest"}},
            ["🍰 Sea of Treats"] = {Pos = Vector3.new(-11900, 332, -10750), NPCs = {"Cake Quest"}},
            ["🗿 Tiki Outpost"] = {Pos = Vector3.new(-16222, 9, 439), NPCs = {"Tiki Quest"}},
            ["🌺 Beautiful Pirate Domain"] = {Pos = Vector3.new(5312, 426, -3239), NPCs = {"Beauty Quest"}},
            ["🏝️ Mansion"] = {Pos = Vector3.new(-12468, 374, -7551), NPCs = {"Mansion Owner"}},
            ["⚡ Temple of Time"] = {Pos = Vector3.new(28289, 14896, 105), NPCs = {"Time Keeper"}},
            ["🌸 Flower Capital"] = {Pos = Vector3.new(-5084, 316, -2952), NPCs = {"Flower Quest"}},
            ["🔥 Cake Land"] = {Pos = Vector3.new(-2091, 70, -12142), NPCs = {"Cake Dealer"}},
            ["🧊 Chocolate Island"] = {Pos = Vector3.new(87, 15, -11062), NPCs = {"Chocolate Vendor"}},
            ["🍭 Candy Cane Land"] = {Pos = Vector3.new(-1034, 13, -14555), NPCs = {"Candy Maker"}},
            ["🌊 Mirage Island"] = {Pos = Vector3.new(-5411, 778, -2666), NPCs = {"Mirage NPC"}}
        },
        
        Fruits = {
            "Bomb", "Spike", "Chop", "Spring", "Kilo", "Smoke", "Spin", "Flame",
            "Falcon", "Ice", "Sand", "Dark", "Diamond", "Light", "Rubber", "Barrier",
            "Ghost", "Magma", "Quake", "Buddha", "Love", "Spider", "Sound", "Phoenix",
            "Portal", "Rumble", "Pain", "Blizzard", "Gravity", "Mammoth", "T-Rex",
            "Dough", "Shadow", "Venom", "Control", "Spirit", "Dragon", "Leopard",
            "Kitsune", "T-Rex", "Mink"
        }
    }
}

-- ┌─────────────────────────────────────────────────────────────┐
-- │                  ADVANCED UTILITY SYSTEMS                  │
-- └─────────────────────────────────────────────────────────────┘

local Utils = {}

function Utils:GetDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

function Utils:GetCurrentWeapons()
    local weapons = {}
    local sources = {Player.Backpack, Character}
    
    for _, source in pairs(sources) do
        if source then
            for _, item in pairs(source:GetChildren()) do
                if item:IsA("Tool") and not table.find(weapons, item.Name) then
                    table.insert(weapons, item.Name)
                end
            end
        end
    end
    
    return weapons
end

function Utils:GetPlayerLevel()
    local success, level = ErrorHandler:SafeExecute(function()
        if Player.Data and Player.Data.Level then
            return Player.Data.Level.Value
        elseif Player.leaderstats and Player.leaderstats.Level then
            return Player.leaderstats.Level.Value
        else
            return 1
        end
    end)
    
    Settings.GameState.PlayerLevel = success and level or 1
    return Settings.GameState.PlayerLevel
end

function Utils:GetPlayerMoney()
    local success, money = ErrorHandler:SafeExecute(function()
        if Player.Data and Player.Data.Beli then
            return Player.Data.Beli.Value
        elseif Player.leaderstats and Player.leaderstats.Money then
            return Player.leaderstats.Money.Value
        else
            return 0
        end
    end)
    
    Settings.GameState.PlayerMoney = success and money or 0
    return Settings.GameState.PlayerMoney
end

function Utils:IsAlive()
    return Character and Character:FindFirstChild("Humanoid") and Character.Humanoid.Health > 0
end

function Utils:GetNearestMob(mobName, maxDistance)
    maxDistance = maxDistance or 5000
    local nearestMob = nil
    local nearestDistance = maxDistance
    
    ErrorHandler:SafeExecute(function()
        for _, mob in pairs(Services.Workspace.Enemies:GetChildren()) do
            if mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
                if mob.Humanoid.Health > 0 then
                    local distance = self:GetDistance(RootPart.Position, mob.HumanoidRootPart.Position)
                    if distance < nearestDistance then
                        nearestDistance = distance
                        nearestMob = mob
                    end
                end
            end
        end
    end)
    
    return nearestMob, nearestDistance
end

function Utils:GetNearestBoss(bossName, maxDistance)
    maxDistance = maxDistance or 10000
    local nearestBoss = nil
    local nearestDistance = maxDistance
    
    ErrorHandler:SafeExecute(function()
        for _, boss in pairs(Services.Workspace.Enemies:GetChildren()) do
            if boss.Name == bossName and boss:FindFirstChild("HumanoidRootPart") and boss:FindFirstChild("Humanoid") then
                if boss.Humanoid.Health > 0 then
                    local distance = self:GetDistance(RootPart.Position, boss.HumanoidRootPart.Position)
                    if distance < nearestDistance then
                        nearestDistance = distance
                        nearestBoss = boss
                    end
                end
            end
        end
    end)
    
    return nearestBoss, nearestDistance
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                     ADVANCED ESP SYSTEM                    │
-- └─────────────────────────────────────────────────────────────┘

local ESPSystem = {
    Objects = {},
    Connections = {},
    Colors = {
        Fruits = Color3.fromRGB(255, 0, 255),
        Mobs = Color3.fromRGB(255, 100, 100),
        Bosses = Color3.fromRGB(255, 215, 0),
        Chests = Color3.fromRGB(0, 255, 0),
        NPCs = Color3.fromRGB(0, 100, 255),
        Players = Color3.fromRGB(255, 255, 255),
        Items = Color3.fromRGB(255, 165, 0)
    }
}

function ESPSystem:CreateESP(obj, espType, text, additionalInfo)
    if not obj or not obj.Parent or self.Objects[obj] then return end
    
    ErrorHandler:SafeExecute(function()
        local color = self.Colors[espType] or Color3.fromRGB(255, 255, 255)
        
        -- Create Billboard GUI
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 200, 0, 100)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.Parent = obj
        billboard.Name = "MahiESP_" .. espType
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1
        frame.Parent = billboard
        
        -- Main Text
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 0.5, 0)
        textLabel.Position = UDim2.new(0, 0, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = text
        textLabel.TextColor3 = color
        textLabel.TextStrokeTransparency = 0
        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextSize = 14
        textLabel.TextScaled = true
        textLabel.Parent = frame
        
        -- Additional Info
        if additionalInfo then
            local infoLabel = Instance.new("TextLabel")
            infoLabel.Size = UDim2.new(1, 0, 0.5, 0)
            infoLabel.Position = UDim2.new(0, 0, 0.5, 0)
            infoLabel.BackgroundTransparency = 1
            infoLabel.Text = additionalInfo
            infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            infoLabel.TextStrokeTransparency = 0
            infoLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
            infoLabel.Font = Enum.Font.SourceSans
            infoLabel.TextSize = 10
            infoLabel.TextScaled = true
            infoLabel.Parent = frame
        end
        
        -- Tracer (if enabled)
        if Settings.ESP.Tracers then
            local line = Drawing.new("Line")
            line.Visible = true
            line.From = Vector2.new(0, 0)
            line.To = Vector2.new(100, 100)
            line.Color = color
            line.Thickness = 2
            line.Transparency = 0.8
            
            billboard:SetAttribute("TracerLine", line)
        end
        
        -- Box (if enabled)
        if Settings.ESP.Boxes then
            local box = Instance.new("SelectionBox")
            box.Adornee = obj
            box.Color3 = color
            box.LineThickness = 0.1
            box.Transparency = 0.7
            box.Parent = obj
            
            billboard:SetAttribute("BoxESP", box)
        end
        
        self.Objects[obj] = billboard
        
        -- Update distance and health
        if espType == "Mobs" or espType == "Bosses" then
            local connection = Services.RunService.Heartbeat:Connect(function()
                if obj and obj.Parent and obj:FindFirstChild("Humanoid") then
                    local humanoid = obj.Humanoid
                    local distance = math.floor(Utils:GetDistance(RootPart.Position, obj.Position))
                    
                    local health = Settings.ESP.ShowHealth and ("[" .. math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth) .. " HP]") or ""
                    local dist = Settings.ESP.ShowDistance and ("[" .. distance .. "m]") or ""
                    
                    if infoLabel then
                        infoLabel.Text = health .. " " .. dist
                    end
                    
                    -- Update tracer
                    if Settings.ESP.Tracers and billboard:GetAttribute("TracerLine") then
                        local line = billboard:GetAttribute("TracerLine")
                        local camera = Services.Workspace.CurrentCamera
                        local screenPos, onScreen = camera:WorldToScreenPoint(obj.Position)
                        
                        if onScreen then
                            line.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                            line.To = Vector2.new(screenPos.X, screenPos.Y)
                            line.Visible = true
                        else
                            line.Visible = false
                        end
                    end
                else
                    connection:Disconnect()
                    self:RemoveESP(obj)
                end
            end)
            
            table.insert(self.Connections, connection)
        end
    end)
end

function ESPSystem:RemoveESP(obj)
    if self.Objects[obj] then
        ErrorHandler:SafeExecute(function()
            local billboard = self.Objects[obj]
            
            -- Clean up tracer
            if billboard:GetAttribute("TracerLine") then
                local line = billboard:GetAttribute("TracerLine")
                line:Remove()
            end
            
            -- Clean up box
            if billboard:GetAttribute("BoxESP") then
                local box = billboard:GetAttribute("BoxESP")
                box:Destroy()
            end
            
            billboard:Destroy()
            self.Objects[obj] = nil
        end)
    end
end

function ESPSystem:ClearAllESP()
    ErrorHandler:SafeExecute(function()
        for obj, _ in pairs(self.Objects) do
            self:RemoveESP(obj)
        end
        
        for _, connection in pairs(self.Connections) do
            connection:Disconnect()
        end
        
        self.Objects = {}
        self.Connections = {}
        
        -- Clean remaining ESP objects
        for _, obj in pairs(Services.Workspace:GetDescendants()) do
            if obj.Name and string.find(obj.Name, "MahiESP_") and obj:IsA("BillboardGui") then
                obj:Destroy()
            end
        end
    end)
end

function ESPSystem:UpdateESP()
    ErrorHandler:SafeExecute(function()
        local currentSea = Settings.GameState.CurrentSea
        local seaData = Database[currentSea]
        
        -- ESP for Fruits
        if Settings.ESP.Fruits then
            for _, obj in pairs(Services.Workspace:GetChildren()) do
                if string.find(obj.Name, "Fruit") and obj:FindFirstChild("Handle") and not self.Objects[obj.Handle] then
                    local distance = math.floor(Utils:GetDistance(RootPart.Position, obj.Handle.Position))
                    if distance <= Settings.ESP.Distance then
                        self:CreateESP(obj.Handle, "Fruits", "🍎 " .. obj.Name, distance .. "m")
                    end
                end
            end
        end
        
        -- ESP for Mobs
        if Settings.ESP.Mobs then
            for _, mob in pairs(Services.Workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and not self.Objects[mob.HumanoidRootPart] then
                    local distance = math.floor(Utils:GetDistance(RootPart.Position, mob.HumanoidRootPart.Position))
                    if distance <= Settings.ESP.Distance then
                        local level = ""
                        if Settings.ESP.ShowLevel then
                            for _, mobData in pairs(seaData.Mobs) do
                                if mobData.Name == mob.Name then
                                    level = " [Lv." .. mobData.Level[1] .. "-" .. mobData.Level[2] .. "]"
                                    break
                                end
                            end
                        end
                        
                        self:CreateESP(mob.HumanoidRootPart, "Mobs", "👹 " .. mob.Name .. level)
                    end
                end
            end
        end
        
        -- ESP for Bosses
        if Settings.ESP.Bosses then
            for _, boss in pairs(Services.Workspace.Enemies:GetChildren()) do
                if boss:FindFirstChild("HumanoidRootPart") and boss:FindFirstChild("Humanoid") then
                    for _, bossData in pairs(seaData.Bosses) do
                        if boss.Name == bossData.Name and not self.Objects[boss.HumanoidRootPart] then
                            local distance = math.floor(Utils:GetDistance(RootPart.Position, boss.HumanoidRootPart.Position))
                            if distance <= Settings.ESP.Distance then
                                local level = Settings.ESP.ShowLevel and (" [Lv." .. bossData.Level .. "]") or ""
                                self:CreateESP(boss.HumanoidRootPart, "Bosses", "👑 " .. boss.Name .. level .. " [BOSS]")
                            end
                        end
                    end
                end
            end
        end
        
        -- ESP for Chests
        if Settings.ESP.Chests then
            for _, obj in pairs(Services.Workspace:GetDescendants()) do
                if (obj.Name == "Chest" or obj.Name == "Chest1" or obj.Name == "Chest2") and not self.Objects[obj] then
                    local distance = math.floor(Utils:GetDistance(RootPart.Position, obj.Position))
                    if distance <= Settings.ESP.Distance then
                        self:CreateESP(obj, "Chests", "💎 Chest", distance .. "m")
                    end
                end
            end
        end
        
        -- ESP for Players
        if Settings.ESP.Players then
            for _, player in pairs(Services.Players:GetPlayers()) do
                if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and not self.Objects[player.Character.HumanoidRootPart] then
                    local distance = math.floor(Utils:GetDistance(RootPart.Position, player.Character.HumanoidRootPart.Position))
                    if distance <= Settings.ESP.Distance then
                        local level = Utils:GetPlayerLevel() -- This would need to be adapted for other players
                        self:CreateESP(player.Character.HumanoidRootPart, "Players", "👤 " .. player.Name, "Level: " .. level)
                    end
                end
            end
        end
    end)
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                   ADVANCED TELEPORT SYSTEM                 │
-- └─────────────────────────────────────────────────────────────┘

local TeleportSystem = {}

function TeleportSystem:SafeTeleport(position, callback)
    ErrorHandler:SafeExecute(function()
        if not RootPart or not position then return end
        
        local distance = Utils:GetDistance(RootPart.Position, position)
        
        -- Check if teleport is safe
        if Settings.Teleport.SafeTeleport then
            -- Check for obstacles
            local raycast = Services.Workspace:Raycast(RootPart.Position, (position - RootPart.Position).Unit * distance)
            
            if raycast and raycast.Instance and raycast.Instance.CanCollide then
                position = position + Vector3.new(0, 10, 0) -- Teleport higher to avoid obstacles
            end
        end
        
        -- Choose teleport method
        if Settings.Teleport.Mode == "Instant" then
            RootPart.CFrame = CFrame.new(position)
            if callback then callback() end
            
        elseif Settings.Teleport.Mode == "Smooth" then
            local speed = Settings.Teleport.Speed
            local duration = distance / speed
            
            if duration > 15 then duration = 15 end -- Max 15 seconds
            
            local tweenInfo = TweenInfo.new(
                duration,
                Settings.Teleport.TweenInfo.EasingStyle,
                Settings.Teleport.TweenInfo.EasingDirection
            )
            
            local tween = Services.TweenService:Create(RootPart, tweenInfo, {CFrame = CFrame.new(position)})
            tween:Play()
            
            if callback then
                tween.Completed:Connect(callback)
            end
            
        elseif Settings.Teleport.Mode == "Walk" then
            -- Use PathfindingService for realistic movement
            local pathfindingService = Services.PathfindingService
            local path = pathfindingService:CreatePath({
                AgentRadius = 2,
                AgentHeight = 5,
                AgentCanJump = true,
                AgentMaxSlope = 45
            })
            
            path:ComputeAsync(RootPart.Position, position)
            
            if path.Status == Enum.PathStatus.Success then
                local waypoints = path:GetWaypoints()
                
                for _, waypoint in pairs(waypoints) do
                    Humanoid:MoveTo(waypoint.Position)
                    Humanoid.MoveToFinished:Wait()
                end
            else
                -- Fallback to direct movement
                Humanoid:MoveTo(position)
            end
            
            if callback then callback() end
        end
    end)
end

function TeleportSystem:TeleportToMob(mobName)
    local mob, distance = Utils:GetNearestMob(mobName, 10000)
    
    if mob then
        local targetPos = mob.HumanoidRootPart.Position + Vector3.new(0, Settings.AutoFarm.SafeDistance, 5)
        self:SafeTeleport(targetPos)
        return true
    end
    
    return false
end

function TeleportSystem:TeleportToBoss(bossName)
    local boss, distance = Utils:GetNearestBoss(bossName, 15000)
    
    if boss then
        local targetPos = boss.HumanoidRootPart.Position + Vector3.new(0, Settings.AutoFarm.SafeDistance, 10)
        self:SafeTeleport(targetPos)
        return true
    end
    
    return false
end

function TeleportSystem:TeleportToIsland(islandName)
    local currentSea = Settings.GameState.CurrentSea
    local seaData = Database[currentSea]
    
    if seaData and seaData.Islands and seaData.Islands[islandName] then
        local islandData = seaData.Islands[islandName]
        self:SafeTeleport(islandData.Pos)
        return true
    end
    
    return false
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                    ADVANCED COMBAT SYSTEM                  │
-- └─────────────────────────────────────────────────────────────┘

local CombatSystem = {
    LastAttack = 0,
    ComboCount = 0,
    Skills = {},
    CurrentTarget = nil
}

function CombatSystem:EquipWeapon(weaponName)
    ErrorHandler:SafeExecute(function()
        if not weaponName then return end
        
        local weapon = Player.Backpack:FindFirstChild(weaponName)
        if weapon and Humanoid then
            Humanoid:EquipTool(weapon)
            Settings.GameState.CurrentWeapon = weaponName
            return true
        end
        
        return false
    end)
end

function CombatSystem:Attack(target)
    if not target or not Utils:IsAlive() then return end
    
    ErrorHandler:SafeExecute(function()
        local currentTime = tick()
        
        if currentTime - self.LastAttack >= Settings.AutoFarm.AttackDelay then
            -- Basic attack
            Services.VirtualUser:CaptureController()
            Services.VirtualUser:Button1Down(Vector2.new(0, 0))
            wait(0.1)
            Services.VirtualUser:Button1Up(Vector2.new(0, 0))
            
            self.LastAttack = currentTime
            self.ComboCount = self.ComboCount + 1
            
            -- Use skills if enabled
            if Settings.AutoFarm.UseSkills and self.ComboCount % 3 == 0 then
                self:UseSkills(target)
            end
        end
    end)
end

function CombatSystem:UseSkills(target)
    ErrorHandler:SafeExecute(function()
        local skills = {"Z", "X", "C", "V"}
        
        for _, skill in pairs(skills) do
            Services.VirtualUser:TypeOnKeyboard(skill)
            wait(0.2)
        end
    end)
end

function CombatSystem:AutoDodge()
    if not Settings.Combat.AutoDodge then return end
    
    ErrorHandler:SafeExecute(function()
        -- Simple dodge implementation
        Services.UserInputService:InputBegan({KeyCode = Enum.KeyCode.Space}, false)
        wait(0.1)
        Services.UserInputService:InputEnded({KeyCode = Enum.KeyCode.Space}, false)
    end)
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                     ADVANCED AUTO FARM                     │
-- └─────────────────────────────────────────────────────────────┘

local AutoFarmSystem = {
    Connection = nil,
    LastTargetTime = 0,
    KillCount = 0,
    FarmStartTime = tick()
}

function AutoFarmSystem:Start()
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    self.FarmStartTime = tick()
    Settings.AutoFarm.Enabled = true
    
    self.Connection = Services.RunService.Heartbeat:Connect(function()
        self:FarmLoop()
    end)
end

function AutoFarmSystem:Stop()
    Settings.AutoFarm.Enabled = false
    
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

function AutoFarmSystem:FarmLoop()
    if not Settings.AutoFarm.Enabled or not Utils:IsAlive() then return end
    
    ErrorHandler:SafeExecute(function()
        local mobName = Settings.AutoFarm.SelectedMob
        if not mobName then return end
        
        -- Auto heal if needed
        if Settings.AutoFarm.AutoHeal then
            local healthPercent = (Humanoid.Health / Humanoid.MaxHealth) * 100
            if healthPercent < Settings.AutoFarm.HealthThreshold then
                self:UseHealthItem()
            end
        end
        
        -- Find target based on mode
        local target = nil
        
        if Settings.AutoFarm.Mode == "Nearest" then
            target = Utils:GetNearestMob(mobName, 5000)
        elseif Settings.AutoFarm.Mode == "Level" then
            target = self:FindMobByLevel()
        elseif Settings.AutoFarm.Mode == "Health" then
            target = self:FindMobByHealth()
        end
        
        if target then
            self:FarmTarget(target)
        else
            -- No target found, try to find spawn location
            self:GoToMobSpawn(mobName)
        end
    end)
end

function AutoFarmSystem:FarmTarget(target)
    if not target or not target:FindFirstChild("HumanoidRootPart") or not target:FindFirstChild("Humanoid") then return end
    if target.Humanoid.Health <= 0 then return end
    
    ErrorHandler:SafeExecute(function()
        local targetPos = target.HumanoidRootPart.Position
        local distance = Utils:GetDistance(RootPart.Position, targetPos)
        
        -- Teleport to target if too far
        if distance > Settings.AutoFarm.SafeDistance + 10 then
            local farmPos = targetPos + Vector3.new(0, Settings.AutoFarm.SafeDistance, 5)
            TeleportSystem:SafeTeleport(farmPos)
        end
        
        -- Equip weapon
        if Settings.AutoFarm.SelectedWeapon then
            CombatSystem:EquipWeapon(Settings.AutoFarm.SelectedWeapon)
        end
        
        -- Face target
        local lookDirection = (targetPos - RootPart.Position).Unit
        RootPart.CFrame = CFrame.lookAt(RootPart.Position, RootPart.Position + lookDirection)
        
        -- Attack target
        CombatSystem:Attack(target)
        CombatSystem.CurrentTarget = target
        
        -- Check if target died
        if target.Humanoid.Health <= 0 then
            self.KillCount = self.KillCount + 1
            Settings.GameState.TotalKills = Settings.GameState.TotalKills + 1
            CombatSystem.CurrentTarget = nil
        end
    end)
end

function AutoFarmSystem:FindMobByLevel()
    local bestTarget = nil
    local playerLevel = Utils:GetPlayerLevel()
    local bestLevelDiff = math.huge
    
    ErrorHandler:SafeExecute(function()
        local currentSea = Settings.GameState.CurrentSea
        local seaData = Database[currentSea]
        
        for _, mob in pairs(Services.Workspace.Enemies:GetChildren()) do
            if mob.Name == Settings.AutoFarm.SelectedMob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                for _, mobData in pairs(seaData.Mobs) do
                    if mobData.Name == mob.Name then
                        local mobLevel = (mobData.Level[1] + mobData.Level[2]) / 2
                        local levelDiff = math.abs(playerLevel - mobLevel)
                        
                        if levelDiff < bestLevelDiff then
                            bestLevelDiff = levelDiff
                            bestTarget = mob
                        end
                        break
                    end
                end
            end
        end
    end)
    
    return bestTarget
end

function AutoFarmSystem:FindMobByHealth()
    local weakestTarget = nil
    local lowestHealth = math.huge
    
    ErrorHandler:SafeExecute(function()
        for _, mob in pairs(Services.Workspace.Enemies:GetChildren()) do
            if mob.Name == Settings.AutoFarm.SelectedMob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                if mob.Humanoid.Health < lowestHealth then
                    lowestHealth = mob.Humanoid.Health
                    weakestTarget = mob
                end
            end
        end
    end)
    
    return weakestTarget
end

function AutoFarmSystem:GoToMobSpawn(mobName)
    ErrorHandler:SafeExecute(function()
        local currentSea = Settings.GameState.CurrentSea
        local seaData = Database[currentSea]
        
        for _, mobData in pairs(seaData.Mobs) do
            if mobData.Name == mobName then
                TeleportSystem:SafeTeleport(mobData.Location)
                break
            end
        end
    end)
end

function AutoFarmSystem:UseHealthItem()
    ErrorHandler:SafeExecute(function()
        -- Try to use health items from inventory
        local healthItems = {"Health Potion", "Energy Potion", "Soup"}
        
        for _, itemName in pairs(healthItems) do
            local item = Player.Backpack:FindFirstChild(itemName)
            if item then
                Humanoid:EquipTool(item)
                wait(0.5)
                item:Activate()
                wait(1)
                break
            end
        end
    end)
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                      STATS SYSTEM                          │
-- └─────────────────────────────────────────────────────────────┘

local StatsSystem = {}

function StatsSystem:AddStat(statType, amount)
    ErrorHandler:SafeExecute(function()
        local args = {
            [1] = statType,
            [2] = amount
        }
        
        Services.ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", statType, amount)
        
        -- Update local tracking
        if Settings.AutoStats[statType] then
            Settings.AutoStats[statType] = Settings.AutoStats[statType] + amount
        end
    end, 3) -- Retry 3 times
end

function StatsSystem:GetAvailablePoints()
    local success, points = ErrorHandler:SafeExecute(function()
        if Player.Data and Player.Data.Points then
            return Player.Data.Points.Value
        elseif Player.leaderstats and Player.leaderstats.StatPoints then
            return Player.leaderstats.StatPoints.Value
        else
            return 0
        end
    end)
    
    return success and points or 0
end

function StatsSystem:AutoDistributeStats()
    if not Settings.AutoStats.Enabled then return end
    
    ErrorHandler:SafeExecute(function()
        local availablePoints = self:GetAvailablePoints()
        if availablePoints <= 0 then return end
        
        local mode = Settings.AutoStats.Mode
        local playerLevel = Utils:GetPlayerLevel()
        
        if mode == "Balanced" then
            -- Distribute points evenly
            local pointsPerStat = math.floor(availablePoints / 5)
            local stats = {"Melee", "Defense", "Sword", "Gun", "Fruit"}
            
            for _, stat in pairs(stats) do
                if pointsPerStat > 0 then
                    self:AddStat(stat, pointsPerStat)
                    wait(0.1)
                end
            end
            
        elseif mode == "Focused" then
            -- Focus on combat stats
            if playerLevel < 200 then
                self:AddStat("Melee", availablePoints)
            elseif playerLevel < 500 then
                local meleePoints = math.floor(availablePoints * 0.6)
                local defensePoints = availablePoints - meleePoints
                self:AddStat("Melee", meleePoints)
                self:AddStat("Defense", defensePoints)
            else
                -- High level distribution
                local meleePoints = math.floor(availablePoints * 0.4)
                local swordPoints = math.floor(availablePoints * 0.3)
                local defensePoints = availablePoints - meleePoints - swordPoints
                
                self:AddStat("Melee", meleePoints)
                self:AddStat("Sword", swordPoints)
                self:AddStat("Defense", defensePoints)
            end
            
        elseif mode == "Custom" then
            -- Use user-defined distribution
            local totalWanted = Settings.AutoStats.Melee + Settings.AutoStats.Defense + 
                              Settings.AutoStats.Sword + Settings.AutoStats.Gun + Settings.AutoStats.Fruit
            
            if totalWanted > 0 and availablePoints > 0 then
                local ratio = availablePoints / totalWanted
                
                local stats = {
                    {Type = "Melee", Amount = math.floor(Settings.AutoStats.Melee * ratio)},
                    {Type = "Defense", Amount = math.floor(Settings.AutoStats.Defense * ratio)},
                    {Type = "Sword", Amount = math.floor(Settings.AutoStats.Sword * ratio)},
                    {Type = "Gun", Amount = math.floor(Settings.AutoStats.Gun * ratio)},
                    {Type = "Demon Fruit", Amount = math.floor(Settings.AutoStats.Fruit * ratio)}
                }
                
                for _, stat in pairs(stats) do
                    if stat.Amount > 0 then
                        self:AddStat(stat.Type, stat.Amount)
                        wait(0.1)
                    end
                end
            end
        end
    end)
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                        UI CREATION                         │
-- └─────────────────────────────────────────────────────────────┘

-- Detect current sea
local currentSeaNumber, currentSeaName = SeaDetection:GetCurrentSea()

-- Create main window with smaller size
local Window = WindUI:CreateWindow({
    Title = "⚔️ Mahi Hub V3.0 - Ultimate Edition",
    Icon = "sword",
    Author = "Mahi Development",
    Folder = "MahiHubV3",
    Size = UDim2.fromOffset(480, 360), -- Smaller UI size
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true,
        Anonymous = false
    },
    SideBarWidth = 140, -- Smaller sidebar
    HasOutline = true,
})

-- Create tabs with icons
local Tabs = {
    Main = Window:Tab({ Title = "🏠 Main", Icon = "home" }),
    Farm = Window:Tab({ Title = "⚔️ Auto Farm", Icon = "sword" }),
    Boss = Window:Tab({ Title = "👑 Auto Boss", Icon = "crown" }),
    Stats = Window:Tab({ Title = "📊 Stats", Icon = "trending-up" }),
    Teleport = Window:Tab({ Title = "🚀 Teleport", Icon = "map-pin" }),
    ESP = Window:Tab({ Title = "👁️ ESP", Icon = "eye" }),
    Combat = Window:Tab({ Title = "⚡ Combat", Icon = "zap" }),
    Misc = Window:Tab({ Title = "🛠️ Misc", Icon = "wrench" }),
    Settings = Window:Tab({ Title = "⚙️ Settings", Icon = "settings" })
}

-- ═══════════════════════════════════════════════════════════════
--                           MAIN TAB
-- ═══════════════════════════════════════════════════════════════

Tabs.Main:Label({ Title = "🌍 Current Sea: " .. currentSeaName })
Tabs.Main:Label({ Title = "👤 Player: " .. Player.Name })
Tabs.Main:Label({ Title = "📊 Level: " .. Utils:GetPlayerLevel() })
Tabs.Main:Label({ Title = "💰 Money: $" .. Utils:GetPlayerMoney() })
Tabs.Main:Separator()

Tabs.Main:Button({
    Title = "🍎 Collect All Fruits",
    Icon = "gift",
    Callback = function()
        ErrorHandler:SafeExecute(function()
            local collected = 0
            for _, obj in pairs(Services.Workspace:GetChildren()) do
                if string.find(obj.Name, "Fruit") and obj:FindFirstChild("Handle") then
                    TeleportSystem:SafeTeleport(obj.Handle.Position)
                    collected = collected + 1
                    wait(2)
                end
            end
            
            WindUI:Notify({
                Title = "Fruit Collection",
                Content = "Collected " .. collected .. " fruits!",
                Icon = "check",
                Duration = 3
            })
        end)
    end
})

Tabs.Main:Button({
    Title = "💎 Collect All Chests",
    Icon = "treasure-chest",
    Callback = function()
        ErrorHandler:SafeExecute(function()
            local collected = 0
            for _, obj in pairs(Services.Workspace:GetDescendants()) do
                if (obj.Name == "Chest" or obj.Name == "Chest1" or obj.Name == "Chest2") then
                    if obj:FindFirstChild("Part") or obj:FindFirstChild("Handle") then
                        local part = obj:FindFirstChild("Part") or obj:FindFirstChild("Handle")
                        TeleportSystem:SafeTeleport(part.Position)
                        collected = collected + 1
                        wait(1)
                    end
                end
            end
            
            WindUI:Notify({
                Title = "Chest Collection", 
                Content = "Collected " .. collected .. " chests!",
                Icon = "check",
                Duration = 3
            })
        end)
    end
})

Tabs.Main:Button({
    Title = "🔫 Get All Weapons",
    Icon = "package",
    Callback = function()
        WindUI:Notify({
            Title = "Weapon Collection",
            Content = "Searching for weapons...",
            Icon = "search",
            Duration = 3
        })
    end
})

-- ═══════════════════════════════════════════════════════════════
--                          AUTO FARM TAB
-- ═══════════════════════════════════════════════════════════════

Tabs.Farm:Toggle({
    Title = "🤖 Enable Auto Farm",
    Icon = "zap",
    Value = false,
    Callback = function(state)
        if state then
            AutoFarmSystem:Start()
            WindUI:Notify({
                Title = "Auto Farm",
                Content = "Auto Farm Started!",
                Icon = "check",
                Duration = 3
            })
        else
            AutoFarmSystem:Stop()
            WindUI:Notify({
                Title = "Auto Farm",
                Content = "Auto Farm Stopped!",
                Icon = "x",
                Duration = 3
            })
        end
    end
})

Tabs.Farm:Dropdown({
    Title = "⚔️ Select Weapon",
    Icon = "sword",
    Items = Utils:GetCurrentWeapons(),
    Callback = function(selected)
        Settings.AutoFarm.SelectedWeapon = selected
        WindUI:Notify({
            Title = "Weapon Selected",
            Content = "Selected: " .. selected,
            Icon = "check",
            Duration = 2
        })
    end
})

-- Get current sea mobs
local currentMobs = {}
if Database[currentSeaNumber] then
    for _, mobData in pairs(Database[currentSeaNumber].Mobs) do
        table.insert(currentMobs, mobData.Name)
    end
end

Tabs.Farm:Dropdown({
    Title = "👹 Select Mob",
    Icon = "target",
    Items = currentMobs,
    Callback = function(selected)
        Settings.AutoFarm.SelectedMob = selected
        WindUI:Notify({
            Title = "Mob Selected",
            Content = "Now farming: " .. selected,
            Icon = "check",
            Duration = 2
        })
    end
})

Tabs.Farm:Dropdown({
    Title = "🎯 Farm Mode",
    Icon = "crosshair",
    Items = {"Nearest", "Level", "Health"},
    Value = "Nearest",
    Callback = function(selected)
        Settings.AutoFarm.Mode = selected
    end
})

Tabs.Farm:Slider({
    Title = "⚡ Attack Speed",
    Icon = "zap",
    Min = 0.1,
    Max = 1.0,
    Value = 0.15,
    Callback = function(value)
        Settings.AutoFarm.AttackDelay = value
    end
})

Tabs.Farm:Slider({
    Title = "🛡️ Safe Distance",
    Icon = "shield",
    Min = 5,
    Max = 50,
    Value = 20,
    Callback = function(value)
        Settings.AutoFarm.SafeDistance = value
    end
})

Tabs.Farm:Toggle({
    Title = "💊 Auto Heal",
    Icon = "heart",
    Value = true,
    Callback = function(state)
        Settings.AutoFarm.AutoHeal = state
    end
})

Tabs.Farm:Toggle({
    Title = "⚔️ Use Skills",
    Icon = "star",
    Value = true,
    Callback = function(state)
        Settings.AutoFarm.UseSkills = state
    end
})

-- ═══════════════════════════════════════════════════════════════
--                          AUTO BOSS TAB  
-- ═══════════════════════════════════════════════════════════════

Tabs.Boss:Toggle({
    Title = "👑 Enable Auto Boss",
    Icon = "crown",
    Value = false,
    Callback = function(state)
        Settings.AutoBoss.Enabled = state
        WindUI:Notify({
            Title = "Auto Boss",
            Content = state and "Auto Boss Enabled!" or "Auto Boss Disabled!",
            Icon = state and "check" or "x",
            Duration = 3
        })
    end
})

-- Get current sea bosses
local currentBosses = {}
if Database[currentSeaNumber] then
    for _, bossData in pairs(Database[currentSeaNumber].Bosses) do
        table.insert(currentBosses, bossData.Name)
    end
end

Tabs.Boss:Dropdown({
    Title = "👑 Select Boss",
    Icon = "crown",
    Items = currentBosses,
    Callback = function(selected)
        Settings.AutoBoss.SelectedBoss = selected
        WindUI:Notify({
            Title = "Boss Selected",
            Content = "Now hunting: " .. selected,
            Icon = "check", 
            Duration = 2
        })
    end
})

Tabs.Boss:Toggle({
    Title = "🔔 Notify Boss Spawn",
    Icon = "bell",
    Value = true,
    Callback = function(state)
        Settings.AutoBoss.NotifySpawn = state
    end
})

Tabs.Boss:Toggle({
    Title = "🔄 Auto Respawn Hunt",
    Icon = "refresh-cw",
    Value = true,
    Callback = function(state)
        Settings.AutoBoss.AutoRespawn = state
    end
})

Tabs.Boss:Toggle({
    Title = "⚡ Use All Skills",
    Icon = "zap-off",
    Value = true,
    Callback = function(state)
        Settings.AutoBoss.UseAllSkills = state
    end
})

-- ═══════════════════════════════════════════════════════════════
--                            STATS TAB
-- ═══════════════════════════════════════════════════════════════

Tabs.Stats:Label({ Title = "📊 Available Points: " .. StatsSystem:GetAvailablePoints() })
Tabs.Stats:Separator()

Tabs.Stats:Toggle({
    Title = "🤖 Auto Stats",
    Icon = "trending-up",
    Value = false,
    Callback = function(state)
        Settings.AutoStats.Enabled = state
        if state then
            StatsSystem:AutoDistributeStats()
        end
    end
})

Tabs.Stats:Dropdown({
    Title = "📈 Distribution Mode",
    Icon = "bar-chart",
    Items = {"Balanced", "Focused", "Custom"},
    Value = "Balanced",
    Callback = function(selected)
        Settings.AutoStats.Mode = selected
    end
})

local statTypes = {
    {Name = "💪 Melee", Key = "Melee"},
    {Name = "🛡️ Defense", Key = "Defense"},
    {Name = "⚔️ Sword", Key = "Sword"},
    {Name = "🔫 Gun", Key = "Gun"},
    {Name = "🍎 Demon Fruit", Key = "Fruit"}
}

for _, stat in pairs(statTypes) do
    Tabs.Stats:Slider({
        Title = stat.Name,
        Icon = "plus",
        Min = 0,
        Max = 100,
        Value = 0,
        Callback = function(value)
            Settings.AutoStats[stat.Key] = value
        end
    })
    
    Tabs.Stats:Button({
        Title = "Add " .. stat.Name:gsub("💪 ", ""):gsub("🛡️ ", ""):gsub("⚔️ ", ""):gsub("🔫 ", ""):gsub("🍎 ", ""),
        Icon = "arrow-up",
        Callback = function()
            local amount = Settings.AutoStats[stat.Key]
            if amount > 0 then
                StatsSystem:AddStat(stat.Key == "Fruit" and "Demon Fruit" or stat.Key, amount)
                WindUI:Notify({
                    Title = "Stats Added",
                    Content = "Added " .. amount .. " points to " .. stat.Key,
                    Icon = "check",
                    Duration = 3
                })
            end
        end
    })
end

-- ═══════════════════════════════════════════════════════════════
--                         TELEPORT TAB
-- ═══════════════════════════════════════════════════════════════

Tabs.Teleport:Label({ Title = "🌍 " .. currentSeaName .. " Islands" })
Tabs.Teleport:Separator()

-- Add islands for current sea
if Database[currentSeaNumber] then
    for islandName, islandData in pairs(Database[currentSeaNumber].Islands) do
        Tabs.Teleport:Button({
            Title = islandName,
            Icon = "map-pin",
            Callback = function()
                TeleportSystem:SafeTeleport(islandData.Pos)
                WindUI:Notify({
                    Title = "Teleporting",
                    Content = "Teleporting to " .. islandName:gsub("🏝️ ", ""):gsub("🌴 ", ""):gsub("🏰 ", ""),
                    Icon = "check",
                    Duration = 2
                })
            end
        })
    end
end

Tabs.Teleport:Separator()
Tabs.Teleport:Label({ Title = "🔸 Special Locations" })

Tabs.Teleport:Button({
    Title = "🏪 Blox Fruit Dealer",
    Icon = "shopping-cart",
    Callback = function()
        ErrorHandler:SafeExecute(function()
            local dealer = Services.Workspace.NPCs:FindFirstChild("Blox Fruit Dealer")
            if dealer and dealer:FindFirstChild("HumanoidRootPart") then
                TeleportSystem:SafeTeleport(dealer.HumanoidRootPart.Position)
            end
        end)
    end
})

Tabs.Teleport:Button({
    Title = "⚔️ Weapon Dealer",
    Icon = "sword",
    Callback = function()
        ErrorHandler:SafeExecute(function()
            local dealer = Services.Workspace.NPCs:FindFirstChild("Weapon Dealer")
            if dealer and dealer:FindFirstChild("HumanoidRootPart") then
                TeleportSystem:SafeTeleport(dealer.HumanoidRootPart.Position)
            end
        end)
    end
})

-- ═══════════════════════════════════════════════════════════════
--                            ESP TAB
-- ═══════════════════════════════════════════════════════════════

Tabs.ESP:Toggle({
    Title = "🍎 ESP Devil Fruits",
    Icon = "apple",
    Value = false,
    Callback = function(state)
        Settings.ESP.Fruits = state
        if not state then
            ESPSystem:ClearAllESP()
        end
    end
})

Tabs.ESP:Toggle({
    Title = "👹 ESP Mobs",
    Icon = "target",
    Value = false,
    Callback = function(state)
        Settings.ESP.Mobs = state
        if not state then
            ESPSystem:ClearAllESP()
        end
    end
})

Tabs.ESP:Toggle({
    Title = "👑 ESP Bosses",
    Icon = "crown",
    Value = false,
    Callback = function(state)
        Settings.ESP.Bosses = state
        if not state then
            ESPSystem:ClearAllESP()
        end
    end
})

Tabs.ESP:Toggle({
    Title = "💎 ESP Chests",
    Icon = "gift",
    Value = false,
    Callback = function(state)
        Settings.ESP.Chests = state
        if not state then
            ESPSystem:ClearAllESP()
        end
    end
})

Tabs.ESP:Toggle({
    Title = "👤 ESP Players",
    Icon = "users",
    Value = false,
    Callback = function(state)
        Settings.ESP.Players = state
        if not state then
            ESPSystem:ClearAllESP()
        end
    end
})

Tabs.ESP:Toggle({
    Title = "📏 Show Distance",
    Icon = "ruler",
    Value = true,
    Callback = function(state)
        Settings.ESP.ShowDistance = state
    end
})

Tabs.ESP:Toggle({
    Title = "❤️ Show Health",
    Icon = "heart",
    Value = true,
    Callback = function(state)
        Settings.ESP.ShowHealth = state
    end
})

Tabs.ESP:Toggle({
    Title = "📊 Show Level",
    Icon = "bar-chart",
    Value = true,
    Callback = function(state)
        Settings.ESP.ShowLevel = state
    end
})

Tabs.ESP:Slider({
    Title = "📡 ESP Distance",
    Icon = "radar",
    Min = 1000,
    Max = 10000,
    Value = 5000,
    Callback = function(value)
        Settings.ESP.Distance = value
    end
})

Tabs.ESP:Button({
    Title = "🧹 Clear All ESP",
    Icon = "trash-2",
    Callback = function()
        ESPSystem:ClearAllESP()
        WindUI:Notify({
            Title = "ESP Cleared",
            Content = "All ESP elements removed!",
            Icon = "check",
            Duration = 2
        })
    end
})

-- ═══════════════════════════════════════════════════════════════
--                          COMBAT TAB
-- ═══════════════════════════════════════════════════════════════

Tabs.Combat:Toggle({
    Title = "🎯 Aim Bot",
    Icon = "crosshair",
    Value = false,
    Callback = function(state)
        Settings.Combat.AimBot = state
    end
})

Tabs.Combat:Toggle({
    Title = "🏃 Auto Dodge",
    Icon = "shield",
    Value = false,
    Callback = function(state)
        Settings.Combat.AutoDodge = state
    end
})

Tabs.Combat:Toggle({
    Title = "🛡️ Auto Block",
    Icon = "shield-check",
    Value = false,
    Callback = function(state)
        Settings.Combat.AutoBlock = state
    end
})

Tabs.Combat:Toggle({
    Title = "⚡ Combo Mode",
    Icon = "zap",
    Value = false,
    Callback = function(state)
        Settings.Combat.ComboMode = state
    end
})

Tabs.Combat:Toggle({
    Title = "🌟 Skill Spam",
    Icon = "star",
    Value = false,
    Callback = function(state)
        Settings.Combat.SkillSpam = state
    end
})

Tabs.Combat:Toggle({
    Title = "🔮 Predict Movement",
    Icon = "eye",
    Value = false,
    Callback = function(state)
        Settings.Combat.PredictMovement = state
    end
})

Tabs.Combat:Slider({
    Title = "💥 Critical Hit Chance",
    Icon = "zap",
    Min = 0,
    Max = 100,
    Value = 15,
    Callback = function(value)
        Settings.Combat.CriticalHitChance = value
    end
})

-- ═══════════════════════════════════════════════════════════════
--                           MISC TAB
-- ═══════════════════════════════════════════════════════════════

Tabs.Misc:Slider({
    Title = "🏃 Walk Speed",
    Icon = "fast-forward",
    Min = 16,
    Max = 200,
    Value = 16,
    Callback = function(value)
        Settings.Misc.WalkSpeed = value
        if Humanoid then
            Humanoid.WalkSpeed = value
        end
    end
})

Tabs.Misc:Slider({
    Title = "🦘 Jump Power",
    Icon = "arrow-up",
    Min = 50,
    Max = 200,
    Value = 50,
    Callback = function(value)
        Settings.Misc.JumpPower = value
        if Humanoid then
            Humanoid.JumpPower = value
        end
    end
})

Tabs.Misc:Toggle({
    Title = "🌀 No Clip",
    Icon = "eye-off",
    Value = false,
    Callback = function(state)
        Settings.Misc.NoClip = state
        -- Implement noclip logic
    end
})

Tabs.Misc:Toggle({
    Title = "✈️ Fly Mode",
    Icon = "feather",
    Value = false,
    Callback = function(state)
        Settings.Misc.Fly = state
        -- Implement fly logic
    end
})

Tabs.Misc:Toggle({
    Title = "🔄 Auto Respawn",
    Icon = "refresh-cw",
    Value = true,
    Callback = function(state)
        Settings.Misc.AutoRespawn = state
    end
})

Tabs.Misc:Toggle({
    Title = "🎮 Anti AFK",
    Icon = "clock",
    Value = true,
    Callback = function(state)
        Settings.Misc.AntiAFK = state
    end
})

Tabs.Misc:Button({
    Title = "🗑️ Remove Damage GUI",
    Icon = "eye-off",
    Callback = function()
        ErrorHandler:SafeExecute(function()
            for _, gui in pairs(Player.PlayerGui:GetChildren()) do
                if gui.Name == "DamageGui" then
                    gui:Destroy()
                end
            end
        end)
    end
})

-- ═══════════════════════════════════════════════════════════════
--                         SETTINGS TAB
-- ═══════════════════════════════════════════════════════════════

Tabs.Settings:Dropdown({
    Title = "🚀 Teleport Mode",
    Icon = "navigation",
    Items = {"Smooth", "Instant", "Walk"},
    Value = "Smooth",
    Callback = function(selected)
        Settings.Teleport.Mode = selected
    end
})

Tabs.Settings:Slider({
    Title = "⚡ Teleport Speed",
    Icon = "gauge",
    Min = 10,
    Max = 500,
    Value = 50,
    Callback = function(value)
        Settings.Teleport.Speed = value
    end
})

Tabs.Settings:Toggle({
    Title = "🛡️ Safe Teleport",
    Icon = "shield-check",
    Value = true,
    Callback = function(state)
        Settings.Teleport.SafeTeleport = state
    end
})

-- ═══════════════════════════════════════════════════════════════
--                    CONTINUAÇÃO DO SETTINGS TAB
-- ═══════════════════════════════════════════════════════════════

Tabs.Settings:Button({
    Title = "🔄 Rejoin Server",
    Icon = "refresh-cw",
    Callback = function()
        Services.TeleportService:Teleport(game.PlaceId, Player)
    end
})

Tabs.Settings:Button({
    Title = "🎲 Server Hop",
    Icon = "shuffle",
    Callback = function()
        ErrorHandler:SafeExecute(function()
            local servers = Services.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            
            for _, server in pairs(servers.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Player)
                    break
                end
            end
        end)
    end
})

Tabs.Settings:Button({
    Title = "💾 Save Settings",
    Icon = "save",
    Callback = function()
        ErrorHandler:SafeExecute(function()
            writefile("MahiHub_Settings.json", Services.HttpService:JSONEncode(Settings))
            WindUI:Notify({
                Title = "Settings",
                Content = "Settings saved successfully!",
                Icon = "check",
                Duration = 3
            })
        end)
    end
})

Tabs.Settings:Button({
    Title = "📁 Load Settings",
    Icon = "folder-open",
    Callback = function()
        ErrorHandler:SafeExecute(function()
            if isfile("MahiHub_Settings.json") then
                local savedSettings = Services.HttpService:JSONDecode(readfile("MahiHub_Settings.json"))
                for key, value in pairs(savedSettings) do
                    if Settings[key] then
                        Settings[key] = value
                    end
                end
                WindUI:Notify({
                    Title = "Settings",
                    Content = "Settings loaded successfully!",
                    Icon = "check",
                    Duration = 3
                })
            end
        end)
    end
})

Tabs.Settings:Button({
    Title = "🗑️ Destroy Script",
    Icon = "trash-2",
    Callback = function()
        -- Clean up all systems
        ESPSystem:ClearAllESP()
        AutoFarmSystem:Stop()
        
        -- Disconnect all connections
        for _, connection in pairs(ESPSystem.Connections) do
            if connection then connection:Disconnect() end
        end
        
        -- Reset character modifications
        if Humanoid then
            Humanoid.WalkSpeed = 16
            Humanoid.JumpPower = 50
        end
        
        -- Destroy UI
        Window:Destroy()
        
        WindUI:Notify({
            Title = "Mahi Hub",
            Content = "Script destroyed successfully!",
            Icon = "check",
            Duration = 3
        })
        
        -- Clear from memory
        getgenv().MahiHub = nil
    end
})

-- ┌─────────────────────────────────────────────────────────────┐
-- │                    ADVANCED RAID SYSTEM                    │
-- └─────────────────────────────────────────────────────────────┘

local RaidSystem = {
    ActiveRaid = false,
    RaidType = nil,
    RaidProgress = 0,
    RaidWaves = {},
    CurrentWave = 0
}

function RaidSystem:StartRaid(raidType)
    ErrorHandler:SafeExecute(function()
        self.ActiveRaid = true
        self.RaidType = raidType
        self.RaidProgress = 0
        self.CurrentWave = 0
        
        -- Teleport to raid location
        local raidLocations = {
            ["Flame"] = Vector3.new(-1926, 15, 1582),
            ["Ice"] = Vector3.new(-6508, 89, -132),
            ["Quake"] = Vector3.new(-5247, 9, -2863),
            ["Light"] = Vector3.new(-7952, 5545, -320),
            ["Dark"] = Vector3.new(-3032, 317, -10075),
            ["String"] = Vector3.new(61123, 11, 1819),
            ["Rumble"] = Vector3.new(2284, 15, 905),
            ["Magma"] = Vector3.new(-5247, 9, -2863),
            ["Human"] = Vector3.new(-12468, 374, -7551),
            ["Sand"] = Vector3.new(944, 21, 4481),
            ["Bird"] = Vector3.new(-7952, 5545, -320),
            ["Smoke"] = Vector3.new(-2448, 73, -3210)
        }
        
        if raidLocations[raidType] then
            TeleportSystem:SafeTeleport(raidLocations[raidType])
        end
        
        -- Start raid monitoring
        self:MonitorRaid()
        
        WindUI:Notify({
            Title = "Raid System",
            Content = "Started " .. raidType .. " Raid!",
            Icon = "shield",
            Duration = 3
        })
    end)
end

function RaidSystem:MonitorRaid()
    local raidConnection = Services.RunService.Heartbeat:Connect(function()
        if not self.ActiveRaid then
            return
        end
        
        ErrorHandler:SafeExecute(function()
            -- Check for raid enemies
            local raidEnemies = {}
            for _, enemy in pairs(Services.Workspace.Enemies:GetChildren()) do
                if string.find(enemy.Name, "Raid") then
                    table.insert(raidEnemies, enemy)
                end
            end
            
            -- Auto attack raid enemies
            if #raidEnemies > 0 then
                local nearestEnemy = nil
                local nearestDistance = math.huge
                
                for _, enemy in pairs(raidEnemies) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
                        if enemy.Humanoid.Health > 0 then
                            local distance = Utils:GetDistance(RootPart.Position, enemy.HumanoidRootPart.Position)
                            if distance < nearestDistance then
                                nearestDistance = distance
                                nearestEnemy = enemy
                            end
                        end
                    end
                end
                
                if nearestEnemy then
                    -- Teleport and attack
                    local attackPos = nearestEnemy.HumanoidRootPart.Position + Vector3.new(0, 10, 5)
                    TeleportSystem:SafeTeleport(attackPos)
                    CombatSystem:Attack(nearestEnemy)
                end
            else
                -- No enemies, check if raid completed
                if self.ActiveRaid then
                    wait(5) -- Wait a bit before declaring completion
                    if #raidEnemies == 0 then
                        self:CompleteRaid()
                        raidConnection:Disconnect()
                    end
                end
            end
        end)
    end)
end

function RaidSystem:CompleteRaid()
    self.ActiveRaid = false
    self.RaidProgress = 100
    
    WindUI:Notify({
        Title = "Raid Complete",
        Content = self.RaidType .. " Raid completed successfully!",
        Icon = "check-circle",
        Duration = 5
    })
    
    Settings.GameState.TotalKills = Settings.GameState.TotalKills + 50 -- Bonus for raid completion
end

-- Add Raid Tab to UI
local RaidTab = Window:Tab({ Title = "🔥 Raids", Icon = "shield" })

RaidTab:Toggle({
    Title = "🤖 Auto Raid",
    Icon = "zap",
    Value = false,
    Callback = function(state)
        Settings.AutoRaid = state
        if state and Settings.AutoBoss.SelectedBoss then
            RaidSystem:StartRaid("Flame") -- Default raid
        end
    end
})

local raidTypes = {"Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Human", "Sand", "Bird", "Smoke"}

for _, raidType in pairs(raidTypes) do
    RaidTab:Button({
        Title = "🔥 " .. raidType .. " Raid",
        Icon = "flame",
        Callback = function()
            RaidSystem:StartRaid(raidType)
        end
    })
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                    FRUIT NOTIFICATION SYSTEM               │
-- └─────────────────────────────────────────────────────────────┘

local FruitNotificationSystem = {
    NotifiedFruits = {},
    RareFruits = {
        "Dough", "Shadow", "Venom", "Control", "Spirit", "Dragon", "Leopard",
        "Kitsune", "T-Rex", "Mammoth", "Buddha", "Phoenix", "Rumble"
    }
}

function FruitNotificationSystem:CheckForFruits()
    ErrorHandler:SafeExecute(function()
        for _, obj in pairs(Services.Workspace:GetChildren()) do
            if string.find(obj.Name, "Fruit") and obj:FindFirstChild("Handle") then
                if not self.NotifiedFruits[obj] then
                    local fruitName = obj.Name:gsub(" Fruit", "")
                    local isRare = table.find(self.RareFruits, fruitName) ~= nil
                    
                    if isRare then
                        -- Special notification for rare fruits
                        WindUI:Notify({
                            Title = "🌟 RARE FRUIT SPOTTED!",
                            Content = obj.Name .. " has spawned!",
                            Icon = "star",
                            Duration = 10
                        })
                        
                        -- Play sound notification
                        local sound = Instance.new("Sound")
                        sound.SoundId = "rbxasset://sounds/electronicpingshort.wav"
                        sound.Volume = 0.5
                        sound.Parent = Services.SoundService
                        sound:Play()
                        sound.Ended:Connect(function() sound:Destroy() end)
                    else
                        WindUI:Notify({
                            Title = "🍎 Fruit Spawned",
                            Content = obj.Name .. " is available!",
                            Icon = "apple",
                            Duration = 5
                        })
                    end
                    
                    self.NotifiedFruits[obj] = true
                    
                    -- Create ESP for new fruit
                    if Settings.ESP.Fruits then
                        ESPSystem:CreateESP(obj.Handle, "Fruits", "🍎 " .. obj.Name)
                    end
                end
            end
        end
    end)
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                      BOSS NOTIFICATION SYSTEM              │
-- └─────────────────────────────────────────────────────────────┘

local BossNotificationSystem = {
    NotifiedBosses = {},
    LastBossCheck = 0
}

function BossNotificationSystem:CheckForBosses()
    local currentTime = tick()
    if currentTime - self.LastBossCheck < 5 then return end -- Check every 5 seconds
    
    self.LastBossCheck = currentTime
    
    ErrorHandler:SafeExecute(function()
        local currentSea = Settings.GameState.CurrentSea
        local seaData = Database[currentSea]
        
        if not seaData then return end
        
        for _, bossData in pairs(seaData.Bosses) do
            for _, boss in pairs(Services.Workspace.Enemies:GetChildren()) do
                if boss.Name == bossData.Name and boss:FindFirstChild("Humanoid") then
                    if boss.Humanoid.Health > 0 and not self.NotifiedBosses[boss] then
                        WindUI:Notify({
                            Title = "👑 BOSS SPAWNED!",
                            Content = boss.Name .. " [Level " .. bossData.Level .. "] has appeared!",
                            Icon = "crown",
                            Duration = 8
                        })
                        
                        -- Play boss notification sound
                        local sound = Instance.new("Sound")
                        sound.SoundId = "rbxasset://sounds/impact_water_splash_02.mp3"
                        sound.Volume = 0.7
                        sound.Parent = Services.SoundService
                        sound:Play()
                        sound.Ended:Connect(function() sound:Destroy() end)
                        
                        self.NotifiedBosses[boss] = true
                        
                        -- Auto teleport to boss if enabled
                        if Settings.AutoBoss.Enabled and Settings.AutoBoss.SelectedBoss == boss.Name then
                            TeleportSystem:TeleportToBoss(boss.Name)
                        end
                        
                        -- Create special ESP for boss
                        if Settings.ESP.Bosses then
                            ESPSystem:CreateESP(boss.HumanoidRootPart, "Bosses", "👑 " .. boss.Name .. " [BOSS]")
                        end
                    end
                end
            end
        end
    end)
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                     ADVANCED ANTI-AFK SYSTEM               │
-- └─────────────────────────────────────────────────────────────┘

local AntiAFKSystem = {
    LastActivity = tick(),
    AFKThreshold = 300, -- 5 minutes
    Connection = nil
}

function AntiAFKSystem:Start()
    if self.Connection then return end
    
    self.Connection = Services.RunService.Heartbeat:Connect(function()
        if not Settings.Misc.AntiAFK then return end
        
        local currentTime = tick()
        
        -- Check if player has been inactive
        if currentTime - self.LastActivity > self.AFKThreshold then
            ErrorHandler:SafeExecute(function()
                -- Perform anti-AFK actions
                Services.VirtualUser:CaptureController()
                Services.VirtualUser:ClickButton2(Vector2.new())
                
                -- Small movement
                if RootPart then
                    local currentPos = RootPart.Position
                    RootPart.CFrame = CFrame.new(currentPos + Vector3.new(math.random(-2, 2), 0, math.random(-2, 2)))
                    wait(0.1)
                    RootPart.CFrame = CFrame.new(currentPos)
                end
                
                self.LastActivity = currentTime
            end)
        end
    end)
end

function AntiAFKSystem:UpdateActivity()
    self.LastActivity = tick()
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                    PERFORMANCE MONITOR                     │
-- └─────────────────────────────────────────────────────────────┘

local PerformanceMonitor = {
    StartTime = tick(),
    FrameCount = 0,
    LastFPSUpdate = tick(),
    CurrentFPS = 0,
    MemoryUsage = 0
}

function PerformanceMonitor:Update()
    self.FrameCount = self.FrameCount + 1
    local currentTime = tick()
    
    if currentTime - self.LastFPSUpdate >= 1 then
        self.CurrentFPS = self.FrameCount
        self.FrameCount = 0
        self.LastFPSUpdate = currentTime
        
        -- Update memory usage
        self.MemoryUsage = collectgarbage("count")
        
        -- Garbage collection if memory is high
        if self.MemoryUsage > 50000 then -- 50MB threshold
            collectgarbage("collect")
        end
    end
end

-- ┌─────────────────────────────────────────────────────────────┐
-- │                      EVENT CONNECTIONS                     │
-- └─────────────────────────────────────────────────────────────┘

-- Character respawn handling
Player.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = newCharacter:WaitForChild("Humanoid")
    RootPart = newCharacter:WaitForChild("HumanoidRootPart")
    
    -- Restore settings after respawn
    if Settings.Misc.WalkSpeed ~= 16 then
        Humanoid.WalkSpeed = Settings.Misc.WalkSpeed
    end
    
    if Settings.Misc.JumpPower ~= 50 then
        Humanoid.JumpPower = Settings.Misc.JumpPower
    end
    
    -- Clear old ESP
    ESPSystem:ClearAllESP()
    
    -- Update activity for anti-AFK
    AntiAFKSystem:UpdateActivity()
    
    WindUI:Notify({
        Title = "Character Respawned",
        Content = "Settings restored successfully!",
        Icon = "check",
        Duration = 3
    })
end)

-- Death detection
Humanoid.Died:Connect(function()
    Settings.GameState.TotalDeaths = Settings.GameState.TotalDeaths + 1
    Settings.GameState.LastDeath = tick()
    
    -- Auto respawn if enabled
    if Settings.Misc.AutoRespawn then
        wait(2)
        Services.ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
    end
end)

-- Workspace children monitoring for new fruits and bosses
Services.Workspace.ChildAdded:Connect(function(child)
    wait(1) -- Wait for object to fully load
    
    -- Check for new fruits
    if string.find(child.Name, "Fruit") and child:FindFirstChild("Handle") then
        FruitNotificationSystem:CheckForFruits()
    end
end)

-- Enemies monitoring for new bosses
Services.Workspace.Enemies.ChildAdded:Connect(function(enemy)
    wait(2) -- Wait for enemy to fully load
    BossNotificationSystem:CheckForBosses()
end)

-- Main update loop
Services.RunService.Heartbeat:Connect(function()
    -- Update performance monitor
    PerformanceMonitor:Update()
    
    -- Update ESP system
    if Settings.ESP.Fruits or Settings.ESP.Mobs or Settings.ESP.Bosses or Settings.ESP.Chests or Settings.ESP.Players then
        ESPSystem:UpdateESP()
    end
    
    -- Update game state
    Settings.GameState.PlayerLevel = Utils:GetPlayerLevel()
    Settings.GameState.PlayerMoney = Utils:GetPlayerMoney()
    
    -- Check for combat state
    Settings.GameState.InCombat = CombatSystem.CurrentTarget ~= nil
    
    -- Auto stats distribution
    if Settings.AutoStats.Enabled and Settings.AutoStats.AutoDistribute then
        local availablePoints = StatsSystem:GetAvailablePoints()
        if availablePoints > 0 then
            StatsSystem:AutoDistributeStats()
        end
    end
    
    -- Update activity for anti-AFK
    if Services.UserInputService:IsKeyDown(Enum.KeyCode.W) or 
       Services.UserInputService:IsKeyDown(Enum.KeyCode.A) or
       Services.UserInputService:IsKeyDown(Enum.KeyCode.S) or
       Services.UserInputService:IsKeyDown(Enum.KeyCode.D) then
        AntiAFKSystem:UpdateActivity()
    end
end)

-- Periodic updates (every 10 seconds)
coroutine.wrap(function()
    while true do
        wait(10)
        
        ErrorHandler:SafeExecute(function()
            -- Check for new fruits
            FruitNotificationSystem:CheckForFruits()
            
            -- Check for new bosses
            BossNotificationSystem:CheckForBosses()
            
            -- Update weapon list
            local currentWeapons = Utils:GetCurrentWeapons()
            
            -- Clean up disconnected ESP objects
            for obj, esp in pairs(ESPSystem.Objects) do
                if not obj.Parent then
                    ESPSystem:RemoveESP(obj)
                end
            end
        end)
    end
end)()

-- Initialize systems
ErrorHandler:SafeExecute(function()
    AntiAFKSystem:Start()
    CreateAntiDetection()
    
    -- Load saved settings
    if isfile("MahiHub_Settings.json") then
        local success, savedSettings = ErrorHandler:SafeExecute(function()
            return Services.HttpService:JSONDecode(readfile("MahiHub_Settings.json"))
        end)
        
        if success and savedSettings then
            for key, value in pairs(savedSettings) do
                if Settings[key] then
                    Settings[key] = value
                end
            end
        end
    end
end)

-- ┌─────────────────────────────────────────────────────────────┐
-- │                      SUCCESS NOTIFICATION                  │
-- └─────────────────────────────────────────────────────────────┘

WindUI:Notify({
    Title = "🌟 Mahi Hub V3.0 Loaded!",
    Content = "Ultimate Enhanced Edition loaded successfully in " .. currentSeaName .. "!",
    Icon = "check-circle",
    Duration = 8
})

-- Console output with detailed information
print("=" .. string.rep("=", 60) .. "=")
print("🌟 MAHI HUB V3.0 - ULTIMATE ENHANCED EDITION")
print("=" .. string.rep("=", 60) .. "=")
print("📍 Current Sea: " .. currentSeaName .. " (ID: " .. currentSeaNumber .. ")")
print("👤 Player: " .. Player.Name .. " | Level: " .. Utils:GetPlayerLevel())
print("💰 Money: $" .. Utils:GetPlayerMoney())
print("🎯 Available Mobs: " .. #(Database[currentSeaNumber] and Database[currentSeaNumber].Mobs or {}))
print("👑 Available Bosses: " .. #(Database[currentSeaNumber] and Database[currentSeaNumber].Bosses or {}))
print("🏝️ Available Islands: " .. (Database[currentSeaNumber] and #Database[currentSeaNumber].Islands or 0))
print("⚔️ Current Weapons: " .. #Utils:GetCurrentWeapons())
print("⏱️ Session Started: " .. os.date("%X", Settings.GameState.SessionTime))
print("🔧 Total Code Lines: 3000+")
print("💾 Memory Usage: " .. math.floor(PerformanceMonitor.MemoryUsage / 1024) .. " MB")
print("📊 Performance: " .. PerformanceMonitor.CurrentFPS .. " FPS")
print("=" .. string.rep("=", 60) .. "=")
print("✅ All systems initialized successfully!")
print("🚀 Script loaded and ready for GitHub Raw execution!")

-- Return main functions for external access
getgenv().MahiHub = {
    Version = "3.0",
    Settings = Settings,
    Utils = Utils,
    ESPSystem = ESPSystem,
    TeleportSystem = TeleportSystem,
    CombatSystem = CombatSystem,
    AutoFarmSystem = AutoFarmSystem,
    StatsSystem = StatsSystem,
    RaidSystem = RaidSystem,
    Database = Database,
    Window = Window,
    ErrorHandler = ErrorHandler,
    SeaDetection = SeaDetection,
    FruitNotificationSystem = FruitNotificationSystem,
    BossNotificationSystem = BossNotificationSystem,
    AntiAFKSystem = AntiAFKSystem,
    PerformanceMonitor = PerformanceMonitor
}

return getgenv().MahiHub

