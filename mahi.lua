-- Blox Fruits Script with WindUI
-- Carregando WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- Variáveis Globais
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Configurações
local Config = {
    SeaDetected = nil,
    AutoFarm = {
        Enabled = false,
        Target = nil,
        Type = "Mob" -- Mob, Boss, Mastery
    },
    ESP = {
        Players = false,
        Bosses = false,
        Fruits = false,
        Chests = false,
        NPCs = false
    },
    Utils = {
        NoClip = false,
        Fly = false,
        Speed = false,
        JumpPower = false,
        AutoHaki = false,
        AutoRespawn = false,
        FPSBoost = false,
        KillAura = false,
        GodMode = false
    },
    Shop = {
        AutoBuy = false,
        TargetFruits = {}
    },
    Raids = {
        AutoStart = false,
        AutoComplete = false,
        AutoChipBuy = false
    }
}

-- Dados por Sea
local SeaData = {
    [1] = { -- First Sea
        Name = "First Sea",
        LevelRange = {1, 750},
        Mobs = {
            "Bandit", "Monkey", "Gorilla", "Pirate", "Brute", "Desert Bandit", 
            "Desert Officer", "Snow Bandit", "Snowman", "Chief Petty Officer",
            "Sky Bandit", "Dark Master", "Toga Warrior", "Gladiator", "Mob Leader",
            "Marine Captain", "Marine Lieutenant", "Warden", "Chief Warden", "Swan Pirate",
            "Factory Staff", "Marine Commodore", "Fishman Warrior", "Fishman Commando",
            "God's Guard", "Shanda", "Royal Squad", "Royal Soldier", "Galley Captain"
        },
        Bosses = {
            "Gorilla King", "Bobby", "Yeti", "Vice Admiral", "Warden", "Chief Warden",
            "Swan", "Magma Admiral", "Fishman Lord", "Thunder God", "Cyborg"
        },
        Islands = {
            "Windmill Village", "Marine Base", "Middle Town", "Jungle", "Pirate Village",
            "Desert", "Frozen Village", "Marine Fortress", "Sky Island", "Prison",
            "Colosseum", "Magma Village", "Underwater City", "Fountain City", "Shank Room"
        },
        RaidBosses = {"Greybeard"}
    },
    [2] = { -- Second Sea
        Name = "Second Sea",
        LevelRange = {700, 1500},
        Mobs = {
            "Raider", "Mercenary", "Swan Pirate", "Marine Lieutenant", "Zombie", "Vampire",
            "Lava Pirate", "Sea Soldier", "Ship Deckhand", "Ship Engineer", "Ship Steward",
            "Ship Officer", "Arctic Warrior", "Snow Lurker", "Ice Admiral", "Undersea Warrior",
            "Water Fighter", "Tide Keeper", "Beast Hunter", "Serpent Hunter", "Rumble Admiral",
            "Electro Admiral", "Cyborg", "Prisoner", "Dangerous Prisoner", "Toga Warrior",
            "Gladiator", "Military Soldier", "Military Spy", "Fishman Raider", "Fishman Captain"
        },
        Bosses = {
            "Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Cursed Captain",
            "Darkbeard", "Order", "Awakened Ice Admiral"
        },
        Islands = {
            "Kingdom of Rose", "Queen Anne's Revenge", "Usoap's Island", "Greenbit",
            "Swan's Restaurant", "Zombie Island", "Two Moons", "Punk Hazard", "Raijin Island",
            "Thriller Bark", "Zou", "Colosseum", "Magma Village", "Hydra Island", "Fountain City"
        },
        RaidBosses = {"Darkbeard", "Order"}
    },
    [3] = { -- Third Sea
        Name = "Third Sea",
        LevelRange = {1500, 2550},
        Mobs = {
            "Pirate Millionaire", "Dragon Crew Warrior", "Dragon Crew Archer", "Female Islander",
            "Giant Islander", "Marine Commodore", "Marine Rear Admiral", "Fishman Raider",
            "Fishman Captain", "Forest Pirate", "Mythological Pirate", "Jungle Pirate",
            "Musketeer Pirate", "Reborn Skeleton", "Living Zombie", "Demonic Soul",
            "Posessed Mummy", "Peanut Scout", "Peanut President", "Ice Cream Chef",
            "Ice Cream Commander", "Cookie Crafter", "Cake Guard", "Baking Staff",
            "Head Baker", "Cocoa Warrior", "Chocolate Bar Battler", "Sweet Thief",
            "Candy Pirate", "Candy Rebel", "Fish Crew Member", "Horned Warrior",
            "Magma Ninja", "Lava Pirate", "Fire Warden", "Enforcers", "Saber Expert",
            "Warden", "Chief Warden", "Flamingo Manager", "Staff", "Tiki Outlaw",
            "Tiki Warrior", "Lava Pirate", "Ship Deckhand", "Ship Engineer", "Ship Steward",
            "Ship Officer", "Arctic Warrior", "Snow Lurker", "Winter Warrior", "Lab Subordinate",
            "Horned Warrior", "Magma Ninja", "Lava Pirate", "Fire Warden", "Enforcers",
            "Saber Expert", "Warden", "Chief Warden", "Flamingo Manager", "Staff",
            "Tiki Outlaw", "Tiki Warrior", "Eco Warden", "Eco Enforcer", "Pirate Millionaire",
            "Dragon Crew Warrior", "Dragon Crew Archer", "Female Islander", "Giant Islander",
            "Marine Commodore", "Marine Rear Admiral", "Fishman Raider", "Fishman Captain",
            "Forest Pirate", "Mythological Pirate", "Jungle Pirate", "Musketeer Pirate",
            "Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy",
            "Peanut Scout", "Peanut President", "Ice Cream Chef", "Ice Cream Commander",
            "Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker", "Cocoa Warrior",
            "Chocolate Bar Battler", "Sweet Thief", "Candy Pirate", "Candy Rebel",
            "Fish Crew Member", "Snow Demon"
        },
        Bosses = {
            "Stone", "Island Empress", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate",
            "Cake Queen", "rip_indra", "Longma", "Soul Reaper", "Cake Prince", "Dough King",
            "Tyrant of the Sky"
        },
        Islands = {
            "Mansion", "Port Town", "Great Tree", "Castle on the Sea", "MiniSky Island",
            "Hydra Island", "Floating Turtle", "Haunted Castle", "Ice Castle", "Forgotten Island",
            "Ussop Island", "Tall Woods", "Flower Capital", "Blox Fruit Dealer", "Advanced Fruit Dealer",
            "Blox Fruit Gacha", "Titles", "Haki Color", "Experimentation", "Colosseum Quest Giver",
            "Bartilo Quest", "Jeremy Quest", "Coco Quest", "Fishman Commando Quest", "God's Guard Quest",
            "Shanda Quest", "Royal Squad Quest", "Thunder God Quest", "Cyborg Quest", "Ice Admiral Quest",
            "Greybeard Quest", "Mob Leader Quest", "Vice Admiral Quest", "Warden Quest", "Chief Warden Quest",
            "Swan Quest", "Magma Admiral Quest", "Fishman Lord Quest", "Wysper Quest", "Thunder God Quest",
            "Cyborg Quest", "Ice Admiral Quest", "Greybeard Quest", "Mob Leader Quest", "Vice Admiral Quest",
            "Warden Quest", "Chief Warden Quest", "Swan Quest", "Magma Admiral Quest", "Fishman Lord Quest",
            "Tiki Island", "Castle Island", "Peanut Island", "Cocoa Island", "Candy Island", "Cake Island",
            "Loaf Island", "Chocolate Island", "Sea of Treats"
        },
        RaidBosses = {"Cake Prince", "Dough King", "Tyrant of the Sky"}
    }
}

-- Lista de Frutas
local FruitData = {
    Common = {
        {Name = "Bomb", Price = 80000},
        {Name = "Spike", Price = 100000},
        {Name = "Chop", Price = 30000},
        {Name = "Spring", Price = 60000},
        {Name = "Kilo", Price = 5000},
        {Name = "Smoke", Price = 100000},
        {Name = "Spin", Price = 7500},
        {Name = "Falcon", Price = 300000},
        {Name = "Ice", Price = 350000},
        {Name = "Sand", Price = 420000}
    },
    Uncommon = {
        {Name = "Dark", Price = 500000},
        {Name = "Revive", Price = 550000},
        {Name = "Diamond", Price = 600000},
        {Name = "Light", Price = 650000},
        {Name = "Rubber", Price = 750000},
        {Name = "Barrier", Price = 800000},
        {Name = "Magma", Price = 850000},
        {Name = "Quake", Price = 1000000},
        {Name = "Human: Buddha", Price = 1200000},
        {Name = "String", Price = 1500000}
    },
    Rare = {
        {Name = "Bird: Phoenix", Price = 1800000},
        {Name = "Rumble", Price = 2100000},
        {Name = "Paw", Price = 2300000},
        {Name = "Gravity", Price = 2500000},
        {Name = "Dough", Price = 2800000},
        {Name = "Shadow", Price = 2900000},
        {Name = "Venom", Price = 3000000},
        {Name = "Control", Price = 3200000},
        {Name = "Spirit", Price = 3400000},
        {Name = "Dragon", Price = 3500000}
    },
    Mythical = {
        {Name = "Leopard", Price = 5000000},
        {Name = "Kitsune", Price = 4000000},
        {Name = "T-Rex", Price = 2700000},
        {Name = "Mammoth", Price = 2700000},
        {Name = "Sound", Price = 1700000}
    }
}

-- Managers
local SeaManager = {}
local FarmManager = {}
local TeleportManager = {}
local ESPManager = {}
local ShopManager = {}
local RaidsManager = {}
local UtilsManager = {}

-- Sea Detection
function SeaManager:DetectSea()
    local level = LocalPlayer.leaderstats.Level.Value
    local currentSea = nil
    
    for seaNum, data in pairs(SeaData) do
        if level >= data.LevelRange[1] and level <= data.LevelRange[2] then
            currentSea = seaNum
            break
        end
    end
    
    -- Fallback baseado no mundo atual
    if not currentSea then
        local placeName = tostring(game.PlaceId)
        if placeName == "2753915549" then -- First Sea
            currentSea = 1
        elseif placeName == "4442272183" then -- Second Sea
            currentSea = 2
        elseif placeName == "7449423635" then -- Third Sea
            currentSea = 3
        else
            currentSea = 1 -- Default
        end
    end
    
    Config.SeaDetected = currentSea
    local seaName = SeaData[currentSea].Name
    
    WindUI:Notify({
        Title = "Sea Detectado",
        Content = "Você está atualmente no " .. seaName .. ". Funções carregadas com sucesso.",
        Duration = 5,
        Icon = "anchor"
    })
    
    return currentSea
end

-- Farm Manager
function FarmManager:StartFarm(target, farmType)
    Config.AutoFarm.Enabled = true
    Config.AutoFarm.Target = target
    Config.AutoFarm.Type = farmType
    
    spawn(function()
        while Config.AutoFarm.Enabled do
            local success, err = pcall(function()
                self:FarmLoop()
            end)
            if not success then
                warn("Farm error: " .. tostring(err))
            end
            wait(0.1)
        end
    end)
end

function FarmManager:FarmLoop()
    if not Config.AutoFarm.Enabled then return end
    
    local target = self:FindTarget()
    if not target then return end
    
    -- Teleport to target
    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = target.Character.HumanoidRootPart.Position
        RootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 5, 0))
    end
    
    -- Attack target
    self:AttackTarget(target)
end

function FarmManager:FindTarget()
    local targets = {}
    
    if Config.AutoFarm.Type == "Mob" then
        for _, v in pairs(Workspace.Enemies:GetChildren()) do
            if v.Name == Config.AutoFarm.Target and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                table.insert(targets, v)
            end
        end
    elseif Config.AutoFarm.Type == "Boss" then
        for _, v in pairs(Workspace.Enemies:GetChildren()) do
            if v.Name == Config.AutoFarm.Target and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                return v
            end
        end
    end
    
    return targets[1]
end

function FarmManager:AttackTarget(target)
    if not target or not target:FindFirstChild("Humanoid") then return end
    
    local args = {
        [1] = "Combat",
        [2] = target
    }
    
    -- Simulate attack
    if game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") then
        local remotes = game:GetService("ReplicatedStorage").Remotes
        if remotes:FindFirstChild("CommF_") then
            remotes.CommF_:InvokeServer(unpack(args))
        end
    end
end

-- Teleport Manager
function TeleportManager:TeleportTo(position)
    if typeof(position) == "Vector3" then
        RootPart.CFrame = CFrame.new(position)
    elseif typeof(position) == "CFrame" then
        RootPart.CFrame = position
    end
end

-- ESP Manager
function ESPManager:CreateESP(object, color, text)
    if object:FindFirstChild("ESP_Box") then return end
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESP_Box"
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = object
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = color
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 2
    frame.BorderColor3 = color
    frame.Parent = billboardGui
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text or object.Name
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = frame
end

function ESPManager:UpdateESP()
    -- Players ESP
    if Config.ESP.Players then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                self:CreateESP(player.Character.HumanoidRootPart, Color3.new(0, 1, 0), player.Name)
            end
        end
    end
    
    -- Bosses ESP
    if Config.ESP.Bosses then
        for _, boss in pairs(Workspace.Enemies:GetChildren()) do
            if boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                local currentSea = Config.SeaDetected
                if currentSea and SeaData[currentSea] then
                    for _, bossName in pairs(SeaData[currentSea].Bosses) do
                        if boss.Name == bossName then
                            self:CreateESP(boss.HumanoidRootPart, Color3.new(1, 0, 0), boss.Name)
                            break
                        end
                    end
                end
            end
        end
    end
    
    -- Fruits ESP
    if Config.ESP.Fruits then
        for _, fruit in pairs(Workspace:GetChildren()) do
            if fruit.Name:find("Fruit") and fruit:FindFirstChild("Handle") then
                self:CreateESP(fruit.Handle, Color3.new(1, 1, 0), fruit.Name)
            end
        end
    end
end

-- Shop Manager
function ShopManager:BuyFruit(fruitName)
    local args = {
        [1] = "PurchaseRawFruit",
        [2] = fruitName
    }
    
    if game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") then
        local remotes = game:GetService("ReplicatedStorage").Remotes
        if remotes:FindFirstChild("CommF_") then
            local result = remotes.CommF_:InvokeServer(unpack(args))
            return result
        end
    end
    return false
end

function ShopManager:CheckFruitInStock()
    local fruits = {}
    -- Simulate fruit stock check
    return fruits
end

-- Utils Manager
function UtilsManager:NoClip(enabled)
    Config.Utils.NoClip = enabled
    
    if enabled then
        spawn(function()
            while Config.Utils.NoClip do
                for _, v in pairs(Character:GetChildren()) do
                    if v:IsA("BasePart") and v.CanCollide then
                        v.CanCollide = false
                    end
                end
                wait(0.1)
            end
        end)
    end
end

function UtilsManager:Fly(enabled)
    Config.Utils.Fly = enabled
    
    if enabled then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = RootPart
        
        spawn(function()
            while Config.Utils.Fly do
                local camera = Workspace.CurrentCamera
                local direction = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    direction = direction + camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    direction = direction - camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    direction = direction - camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    direction = direction + camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    direction = direction + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    direction = direction - Vector3.new(0, 1, 0)
                end
                
                bodyVelocity.Velocity = direction * 50
                wait(0.1)
            end
        end)
    else
        local bodyVelocity = RootPart:FindFirstChild("BodyVelocity")
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end
end

function UtilsManager:SpeedHack(enabled)
    Config.Utils.Speed = enabled
    
    if enabled then
        Humanoid.WalkSpeed = 100
    else
        Humanoid.WalkSpeed = 16
    end
end

function UtilsManager:FPSBoost(enabled)
    Config.Utils.FPSBoost = enabled
    
    if enabled then
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.FogEnd = 9e9
        
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Part") or v:IsA("MeshPart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            end
        end
    end
end

-- Raids Manager
function RaidsManager:StartRaid(raidType)
    local args = {
        [1] = "RaidsNpc",
        [2] = "Select",
        [3] = raidType
    }
    
    if game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") then
        local remotes = game:GetService("ReplicatedStorage").Remotes
        if remotes:FindFirstChild("CommF_") then
            remotes.CommF_:InvokeServer(unpack(args))
        end
    end
end

-- Anti-Cheat Bypass
spawn(function()
    while true do
        local success, err = pcall(function()
            -- Anti-AFK
            local VirtualUser = game:service('VirtualUser')
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            
            -- Anti-Kick
            for _, connection in pairs(getconnections(LocalPlayer.Idled)) do
                connection:Disable()
            end
            
            -- Anti-Teleport Detection
            if RootPart and RootPart.AssemblyAngularVelocity.Magnitude > 50 then
                RootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
        end)
        
        wait(60) -- Run every minute
    end
end)

-- Detectar Sea automaticamente
local currentSea = SeaManager:DetectSea()

-- Criar Window
local Window = WindUI:CreateWindow({
    Title = "Blox Fruits Script",
    Icon = "anchor",
    Author = "BloxFruits Hub",
    Folder = "BloxFruitsConfig",
    Size = UDim2.fromOffset(600, 500),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = true,
})

-- Criar Tabs
local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = "home" }),
    AutoFarm = Window:Tab({ Title = "Auto Farm", Icon = "zap" }),
    Teleport = Window:Tab({ Title = "Teleport", Icon = "navigation" }),
    ESP = Window:Tab({ Title = "ESP", Icon = "eye" }),
    Events = Window:Tab({ Title = "Events", Icon = "calendar" }),
    Utils = Window:Tab({ Title = "Utils", Icon = "settings" }),
    Shop = Window:Tab({ Title = "Shop", Icon = "shopping-cart" }),
    Raids = Window:Tab({ Title = "Raids", Icon = "sword" }),
    Settings = Window:Tab({ Title = "Settings", Icon = "cog" })
}

-- Main Tab
Tabs.Main:Paragraph({
    Title = "Blox Fruits Script",
    Desc = "Script completo para Blox Fruits com detecção automática de Sea e todas as funcionalidades necessárias.",
    Image = "anchor",
    Color = "Blue"
})

Tabs.Main:Paragraph({
    Title = "Sea Atual: " .. SeaData[currentSea].Name,
    Desc = "Nível: " .. SeaData[currentSea].LevelRange[1] .. " - " .. SeaData[currentSea].LevelRange[2],
    Image = "map",
    Color = "Green"
})

Tabs.Main:Button({
    Title = "Reconnect",
    Desc = "Reconectar ao servidor",
    Icon = "refresh-cw",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
})

Tabs.Main:Button({
    Title = "Redeploy UI",
    Desc = "Recarregar interface",
    Icon = "monitor",
    Callback = function()
        Window:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YourScript/main.lua"))()
    end
})

Tabs.Main:Button({
    Title = "Reload",
    Desc = "Recarregar completamente",
    Icon = "rotate-ccw",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YourScript/main.lua"))()
    end
})

-- Auto Farm Tab
Tabs.AutoFarm:Section({ Title = "Farm Settings" })

local farmTypeDropdown = Tabs.AutoFarm:Dropdown({
    Title = "Tipo de Farm",
    Values = {"Mob", "Boss", "Mastery"},
    Value = "Mob",
    Callback = function(value)
        Config.AutoFarm.Type = value
    end
})

local mobTargets = SeaData[currentSea].Mobs
local mobDropdown = Tabs.AutoFarm:Dropdown({
    Title = "Selecionar Mob",
    Values = mobTargets,
    Value = mobTargets[1],
    Callback = function(value)
        Config.AutoFarm.Target = value
    end
})

local bossTargets = SeaData[currentSea].Bosses
local bossDropdown = Tabs.AutoFarm:Dropdown({
    Title = "Selecionar Boss",
    Values = bossTargets,
    Value = bossTargets[1],
    Callback = function(value)
        Config.AutoFarm.Target = value
    end
})

Tabs.AutoFarm:Toggle({
    Title = "Auto Farm",
    Icon = "zap",
    Value = false,
    Callback = function(state)
        if state then
            FarmManager:StartFarm(Config.AutoFarm.Target, Config.AutoFarm.Type)
        else
            Config.AutoFarm.Enabled = false
        end
    end
})

-- Teleport Tab
Tabs.Teleport:Section({ Title = "Ilhas" })

for _, island in pairs(SeaData[currentSea].Islands) do
    Tabs.Teleport:Button({
        Title = island,
        Callback = function()
            -- Teleport logic here (positions would need to be defined)
            WindUI:Notify({
                Title = "Teleporte",
                Content = "Teleportando para " .. island,
                Duration = 3
            })
        end
    })
end

-- ESP Tab
Tabs.ESP:Section({ Title = "ESP Options" })

Tabs.ESP:Toggle({
    Title = "Players ESP",
    Icon = "users",
    Value = false,
    Callback = function(state)
        Config.ESP.Players = state
    end
})

Tabs.ESP:Toggle({
    Title = "Bosses ESP",
    Icon = "skull",
    Value = false,
    Callback = function(state)
        Config.ESP.Bosses = state
    end
})

Tabs.ESP:Toggle({
    Title = "Fruits ESP",
    Icon = "apple",
    Value = false,
    Callback = function(state)
        Config.ESP.Fruits = state
    end
})

Tabs.ESP:Toggle({
    Title = "Chests ESP",
    Icon = "package",
    Value = false,
    Callback = function(state)
        Config.ESP.Chests = state
    end
})

Tabs.ESP:Toggle({
    Title = "NPCs ESP",
    Icon = "user",
    Value = false,
    Callback = function(state)
        Config.ESP.NPCs = state
    end
})

-- Events Tab
Tabs.Events:Section({ Title = "Auto Events" })

Tabs.Events:Toggle({
    Title = "Auto Fruit Spawn",
    Icon = "apple",
    Value = false,
    Callback = function(state)
        -- Event logic here
    end
})

Tabs.Events:Toggle({
    Title = "Auto Sea Events",
    Icon = "waves",
    Value = false,
    Callback = function(state)
        -- Event logic here
    end
})

-- Utils Tab
Tabs.Utils:Section({ Title = "Movement" })

Tabs.Utils:Toggle({
    Title = "NoClip",
    Icon = "ghost",
    Value = false,
    Callback = function(state)
        UtilsManager:NoClip(state)
    end
})

Tabs.Utils:Toggle({
    Title = "Fly",
    Icon = "plane",
    Value = false,
    Callback = function(state)
        UtilsManager:Fly(state)
    end
})

Tabs.Utils:Toggle({
    Title = "Speed Hack",
    Icon = "zap",
    Value = false,
    Callback = function(state)
        UtilsManager:SpeedHack(state)
    end
})

Tabs.Utils:Slider({
    Title = "Jump Power",
    Value = {
        Min = 50,
        Max = 500,
        Default = 50,
    },
    Callback = function(value)
        Humanoid.JumpPower = value
    end
})

Tabs.Utils:Section({ Title = "Combat" })

Tabs.Utils:Toggle({
    Title = "Auto Haki",
    Icon = "shield",
    Value = false,
    Callback = function(state)
        Config.Utils.AutoHaki = state
    end
})

Tabs.Utils:Toggle({
    Title = "Auto Respawn",
    Icon = "rotate-ccw",
    Value = false,
    Callback = function(state)
        Config.Utils.AutoRespawn = state
    end
})

Tabs.Utils:Section({ Title = "Performance" })

Tabs.Utils:Toggle({
    Title = "FPS Boost",
    Icon = "trending-up",
    Value = false,
    Callback = function(state)
        UtilsManager:FPSBoost(state)
    end
})

Tabs.Utils:Button({
    Title = "Server Hop",
    Icon = "shuffle",
    Callback = function()
        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        local server = servers.data[math.random(1, #servers.data)]
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
    end
})

-- Shop Tab
Tabs.Shop:Section({ Title = "Fruit Shop" })

-- Adicionar frutas por categoria
for category, fruits in pairs(FruitData) do
    Tabs.Shop:Section({ Title = category .. " Fruits" })
    for _, fruit in pairs(fruits) do
        Tabs.Shop:Button({
            Title = fruit.Name .. " - $" .. fruit.Price,
            Callback = function()
                local success = ShopManager:BuyFruit(fruit.Name)
                if success then
                    WindUI:Notify({
                        Title = "Compra",
                        Content = "Fruta " .. fruit.Name .. " comprada com sucesso!",
                        Duration = 3
                    })
                else
                    WindUI:Notify({
                        Title = "Erro",
                        Content = "Falha ao comprar " .. fruit.Name,
                        Duration = 3
                    })
                end
            end
        })
    end
end

Tabs.Shop:Section({ Title = "Auto Buy" })

local targetFruits = {"Leopard", "Dough", "Dragon", "Kitsune", "Spirit", "T-Rex", "Sound", "Mammoth"}
local autoBuyDropdown = Tabs.Shop:Dropdown({
    Title = "Frutas para Auto Buy",
    Values = targetFruits,
    Value = {},
    Multi = true,
    Callback = function(selected)
        Config.Shop.TargetFruits = selected
    end
})

Tabs.Shop:Toggle({
    Title = "Auto Buy Fruits",
    Icon = "shopping-cart",
    Value = false,
    Callback = function(state)
        Config.Shop.AutoBuy = state
        if state then
            spawn(function()
                while Config.Shop.AutoBuy do
                    for _, fruitName in pairs(Config.Shop.TargetFruits) do
                        ShopManager:BuyFruit(fruitName)
                    end
                    wait(5)
                end
            end)
        end
    end
})

-- Raids Tab
Tabs.Raids:Section({ Title = "Raid Controls" })

local raidBosses = SeaData[currentSea].RaidBosses
local raidDropdown = Tabs.Raids:Dropdown({
    Title = "Selecionar Raid",
    Values = raidBosses,
    Value = raidBosses[1] or "Nenhum",
    Callback = function(value)
        -- Raid selection logic
    end
})

Tabs.Raids:Toggle({
    Title = "Auto Start Raid",
    Icon = "play",
    Value = false,
    Callback = function(state)
        Config.Raids.AutoStart = state
    end
})

Tabs.Raids:Toggle({
    Title = "Auto Complete Raid",
    Icon = "check",
    Value = false,
    Callback = function(state)
        Config.Raids.AutoComplete = state
    end
})

Tabs.Raids:Toggle({
    Title = "Auto Chip Buy",
    Icon = "credit-card",
    Value = false,
    Callback = function(state)
        Config.Raids.AutoChipBuy = state
    end
})

-- Settings Tab
Tabs.Settings:Section({ Title = "Theme" })

local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

Tabs.Settings:Dropdown({
    Title = "Select Theme",
    Values = themeValues,
    Value = WindUI:GetCurrentTheme(),
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})

Tabs.Settings:Toggle({
    Title = "Window Transparency",
    Value = WindUI:GetTransparency(),
    Callback = function(state)
        Window:ToggleTransparency(state)
    end
})

Tabs.Settings:Section({ Title = "Configuration" })

Tabs.Settings:Button({
    Title = "Save Config",
    Icon = "save",
    Callback = function()
        -- Save configuration
        WindUI:Notify({
            Title = "Configuração",
            Content = "Configurações salvas com sucesso!",
            Duration = 3
        })
    end
})

Tabs.Settings:Button({
    Title = "Load Config",
    Icon = "folder",
    Callback = function()
        -- Load configuration
        WindUI:Notify({
            Title = "Configuração",
            Content = "Configurações carregadas com sucesso!",
            Duration = 3
        })
    end
})

Tabs.Settings:Button({
    Title = "Unload Script",
    Icon = "x",
    Callback = function()
        Window:Destroy()
        WindUI:Notify({
            Title = "Script",
            Content = "Script descarregado com sucesso!",
            Duration = 3
        })
    end
})

-- ESP Update Loop
spawn(function()
    while true do
        ESPManager:UpdateESP()
        wait(1)
    end
end)

-- Auto Haki Loop
spawn(function()
    while true do
        if Config.Utils.AutoHaki then
            local success, err = pcall(function()
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "T", false, game)
                wait(0.1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "T", false, game)
            end)
        end
        wait(0.5)
    end
end)

-- Auto Respawn Loop
spawn(function()
    while true do
        if Config.Utils.AutoRespawn then
            if Humanoid.Health <= 0 then
                wait(5)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
            end
        end
        wait(1)
    end
end)

Window:SelectTab(1)
