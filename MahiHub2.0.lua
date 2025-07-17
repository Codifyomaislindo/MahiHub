-- ============================================
-- MAHI HUB - BLOX FRUITS SCRIPT
-- ============================================

-- Carregamento da biblioteca WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Serviços do Roblox
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

-- Variáveis globais
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Atualização de Character quando respawna
Player.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
end)

-- ====================
-- DETECÇÃO AUTOMÁTICA DE SEA
-- ====================

local SeaDetector = {}
SeaDetector.__index = SeaDetector

function SeaDetector:new()
    local self = setmetatable({}, SeaDetector)
    self.currentSea = 1
    self.seaNames = {
        [1] = "First Sea",
        [2] = "Second Sea", 
        [3] = "Third Sea"
    }
    return self
end

function SeaDetector:DetectCurrentSea()
    local placeId = game.PlaceId
    local mapName = game.Workspace.Map.Name or ""
    
    -- Detecção por PlaceId (mais confiável)
    if placeId == 2753915549 then
        self.currentSea = 1
        return 1
    elseif placeId == 4442272183 then
        self.currentSea = 2
        return 2
    elseif placeId == 7449423635 then
        self.currentSea = 3
        return 3
    end
    
    -- Detecção por nome do mapa como fallback
    if mapName:find("Starter") or mapName:find("Marine") or mapName:find("Jungle") then
        self.currentSea = 1
        return 1
    elseif mapName:find("Kingdom") or mapName:find("Cafe") or mapName:find("Hydra") then
        self.currentSea = 2
        return 2
    elseif mapName:find("Mansion") or mapName:find("Great Tree") or mapName:find("Castle") then
        self.currentSea = 3
        return 3
    end
    
    -- Detecção por NPCs existentes
    local enemies = Workspace:FindFirstChild("Enemies")
    if enemies then
        for _, enemy in pairs(enemies:GetChildren()) do
            local enemyName = enemy.Name
            -- First Sea enemies
            if enemyName:find("Bandit") or enemyName:find("Monkey") or enemyName:find("Gorilla") then
                self.currentSea = 1
                return 1
            -- Second Sea enemies  
            elseif enemyName:find("Swan Pirate") or enemyName:find("Factory Staff") or enemyName:find("Marine Captain") then
                self.currentSea = 2
                return 2
            -- Third Sea enemies
            elseif enemyName:find("Pirate Millionaire") or enemyName:find("Dragon Crew") or enemyName:find("Reborn Skeleton") then
                self.currentSea = 3
                return 3
            end
        end
    end
    
    -- Default para First Sea se não conseguir detectar
    self.currentSea = 1
    return 1
end

function SeaDetector:GetCurrentSeaName()
    return self.seaNames[self.currentSea] or "Unknown Sea"
end

-- Instância do detector
local seaDetector = SeaDetector:new()
local currentSea = seaDetector:DetectCurrentSea()

-- ====================
-- CONFIGURAÇÕES POR SEA
-- ====================

local SeaConfig = {
    [1] = { -- First Sea
        Islands = {
            ["Starter Island"] = CFrame.new(1, 16, 1474),
            ["Marine Base"] = CFrame.new(-2573, 6, 2046),
            ["Jungle"] = CFrame.new(-1612, 36, 149),
            ["Pirate Village"] = CFrame.new(-378, 7, 298),
            ["Desert"] = CFrame.new(944, 20, 4373),
            ["Frozen Village"] = CFrame.new(1347, 104, -1319),
            ["Marineford"] = CFrame.new(-4914, 50, 4281),
            ["Skypiea"] = CFrame.new(-4607, 872, -1667),
            ["Colosseum"] = CFrame.new(-1427, 7, -2792),
            ["Magma Village"] = CFrame.new(-5247, 12, 8504),
            ["Underwater City"] = CFrame.new(61163, 11, 1819),
            ["Fountain City"] = CFrame.new(5127, 59, 4105),
            ["Shank Room"] = CFrame.new(-1442, 29, 4)
        },
        Enemies = {"Bandit", "Monkey", "Gorilla", "Pirate", "Brute", "Desert Bandit", "Desert Officer", "Snow Bandit", "Snowman", "Chief Petty Officer", "Sky Bandit", "Dark Master", "Prisoner", "Dangerous Prisoner", "Gladiator", "Mob Leader", "Magma Admiral", "Fishman Warrior", "Fishman Commando", "God's Guard", "Shanda", "Royal Squad", "Royal Soldier", "Galley Pirate"}
    },
    [2] = { -- Second Sea
        Islands = {
            ["Kingdom of Rose"] = CFrame.new(-288, 15, 1652),
            ["Cafe"] = CFrame.new(-385, 73, 299),
            ["Mansion"] = CFrame.new(-12463, 374, -7523),
            ["Flamingo Room"] = CFrame.new(2284, 15, 905),
            ["Hydra Island"] = CFrame.new(-5421, 778, -2427),
            ["Graveyard Island"] = CFrame.new(-9516, 172, 6145),
            ["Snow Mountain"] = CFrame.new(753, 408, -5274),
            ["Hot and Cold"] = CFrame.new(-6127, 15, -4530),
            ["Cursed Ship"] = CFrame.new(923, 125, 32852),
            ["Ice Castle"] = CFrame.new(6148, 294, -6741),
            ["Forgotten Island"] = CFrame.new(-3032, 317, -10075),
            ["Ussop Island"] = CFrame.new(4816, 8, 2863),
            ["Mini Sky Island"] = CFrame.new(-2673, 3387, -2682)
        },
        Enemies = {"Raider", "Mercenary", "Swan Pirate", "Factory Staff", "Marine Lieutenant", "Marine Captain", "Zombie", "Vampire", "Snow Trooper", "Winter Warrior", "Lab Subordinate", "Horned Warrior", "Magma Ninja", "Lava Pirate", "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer", "Arctic Warrior", "Snow Lurker", "Sea Soldier", "Water Fighter"}
    },
    [3] = { -- Third Sea
        Islands = {
            ["Port Town"] = CFrame.new(-290, 43, 5580),
            ["Hydra Island"] = CFrame.new(-5421, 778, -2427),
            ["Great Tree"] = CFrame.new(2681, 1682, -7190),
            ["Castle on the Sea"] = CFrame.new(-5085, 316, -3156),
            ["Haunted Castle"] = CFrame.new(-9515, 142, 5618),
            ["Peanut Island"] = CFrame.new(-2062, 50, -10232),
            ["Ice Cream Island"] = CFrame.new(-902, 79, -10988),
            ["Cake Island"] = CFrame.new(-1884, 19, -11666),
            ["Cocoa Island"] = CFrame.new(87, 73, -12297),
            ["Candy Island"] = CFrame.new(-1049, 13, -14200),
            ["Tiki Outpost"] = CFrame.new(-16220, 9, 439),
            ["Mansion"] = CFrame.new(-12463, 374, -7523)
        },
        Enemies = {"Pirate Millionaire", "Dragon Crew Warrior", "Dragon Crew Archer", "Female Islander", "Giant Islander", "Marine Commodore", "Marine Rear Admiral", "Fishman Raider", "Fishman Captain", "Forest Pirate", "Mythological Pirate", "Jungle Pirate", "Musketeer Pirate", "Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy", "Peanut Scout", "Peanut President", "Ice Cream Chef", "Ice Cream Commander", "Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker", "Cocoa Warrior", "Chocolate Bar Battler", "Sweet Thief", "Candy Rebel", "Candy Pirate", "Tiki Warrior"}
    }
}

-- Configurações do script
local Config = {
    AutoFarm = {
        Enabled = false,
        Target = "Closest",
        FastAttack = false,
        AutoHaki = false,
        FarmDistance = 25,
        SelectedEnemy = ""
    },
    ESP = {
        Players = false,
        Bosses = false,
        Fruits = false,
        Chests = false,
        NPCs = false
    },
    Teleport = {
        TweenSpeed = 300
    },
    Utils = {
        NoClip = false,
        Fly = false,
        Speed = 16,
        JumpPower = 50,
        AutoRespawn = false,
        FPSBoost = false
    },
    Shop = {
        AutoBuy = false,
        TargetFruits = {"Leopard", "Dough", "Dragon", "Kitsune", "Spirit", "T-Rex", "Sound", "Mammoth"}
    },
    Raids = {
        AutoStart = false,
        AutoComplete = false,
        AutoChip = false
    }
}

-- ====================
-- MANAGERS CORRIGIDOS
-- ====================

-- FarmManager corrigido
local FarmManager = {}
FarmManager.__index = FarmManager

function FarmManager:new()
    local self = setmetatable({}, FarmManager)
    self.isRunning = false
    self.currentTarget = nil
    self.connection = nil
    self.attackConnection = nil
    return self
end

function FarmManager:Start()
    if self.isRunning then return end
    self.isRunning = true
    
    self.connection = RunService.Heartbeat:Connect(function()
        if not Config.AutoFarm.Enabled then return end
        
        pcall(function()
            local target = self:FindTarget()
            if target and target.Parent then
                self:AttackTarget(target)
            end
        end)
    end)
    
    -- Ataque rápido separado
    if Config.AutoFarm.FastAttack then
        self.attackConnection = RunService.Heartbeat:Connect(function()
            self:FastAttack()
        end)
    end
end

function FarmManager:Stop()
    if self.connection then
        self.connection:Disconnect()
        self.connection = nil
    end
    if self.attackConnection then
        self.attackConnection:Disconnect()
        self.attackConnection = nil
    end
    self.isRunning = false
end

function FarmManager:FindTarget()
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return nil end
    
    local closestTarget = nil
    local closestDistance = math.huge
    
    for _, mob in pairs(enemies:GetChildren()) do
        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
            local humanoid = mob.Humanoid
            if humanoid.Health > 0 then
                local distance = (RootPart.Position - mob.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance < Config.AutoFarm.FarmDistance then
                    -- Filtrar por inimigo selecionado se especificado
                    if Config.AutoFarm.SelectedEnemy == "" or mob.Name == Config.AutoFarm.SelectedEnemy then
                        closestDistance = distance
                        closestTarget = mob
                    end
                end
            end
        end
    end
    
    return closestTarget
end

function FarmManager:AttackTarget(target)
    if not target or not target:FindFirstChild("HumanoidRootPart") or not Character then return end
    
    pcall(function()
        -- Teleporte para o alvo
        local targetPos = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        RootPart.CFrame = targetPos
        
        -- Ativação do Haki
        if Config.AutoFarm.AutoHaki then
            self:ActivateHaki()
        end
        
        -- Ataque com a ferramenta equipada
        local tool = Character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
            if tool:FindFirstChild("Handle") then
                tool.Handle:FindFirstChild("Attachment"):Destroy()
            end
        end
    end)
end

function FarmManager:FastAttack()
    pcall(function()
        local tool = Character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
    end)
end

function FarmManager:ActivateHaki()
    pcall(function()
        local args = {"Buso"}
        ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    end)
end

-- TeleportManager corrigido
local TeleportManager = {}
TeleportManager.__index = TeleportManager

function TeleportManager:new()
    local self = setmetatable({}, TeleportManager)
    self.currentTween = nil
    return self
end

function TeleportManager:TeleportTo(cframe)
    if self.currentTween then
        self.currentTween:Cancel()
    end
    
    local distance = (RootPart.Position - cframe.Position).Magnitude
    local speed = Config.Teleport.TweenSpeed
    local time = distance / speed
    
    self.currentTween = TweenService:Create(RootPart, 
        TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
        {CFrame = cframe}
    )
    
    self.currentTween:Play()
end

function TeleportManager:TeleportToIsland(islandName)
    local seaIslands = SeaConfig[currentSea].Islands
    local cframe = seaIslands[islandName]
    if cframe then
        self:TeleportTo(cframe)
    end
end

function TeleportManager:GetCurrentSeaIslands()
    return SeaConfig[currentSea].Islands
end

-- ESPManager corrigido
local ESPManager = {}
ESPManager.__index = ESPManager

function ESPManager:new()
    local self = setmetatable({}, ESPManager)
    self.espObjects = {}
    self.connections = {}
    return self
end

function ESPManager:CreateESP(object, color, text, distance)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_" .. object.Name
    billboard.Parent = CoreGui
    billboard.Adornee = object
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    
    local frame = Instance.new("Frame")
    frame.Parent = billboard
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text .. (distance and " [" .. math.floor(distance) .. "m]" or "")
    label.TextColor3 = color
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    
    return billboard
end

function ESPManager:TogglePlayersESP(enabled)
    if enabled then
        self.connections.Players = RunService.Heartbeat:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local existingESP = CoreGui:FindFirstChild("ESP_" .. player.Name)
                    if not existingESP then
                        local distance = (RootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        local esp = self:CreateESP(player.Character.HumanoidRootPart, Color3.new(1, 0, 0), player.Name, distance)
                        self.espObjects[player.Name] = esp
                    end
                end
            end
        end)
    else
        if self.connections.Players then
            self.connections.Players:Disconnect()
            self.connections.Players = nil
        end
        for name, esp in pairs(self.espObjects) do
            if esp and esp.Parent then
                esp:Destroy()
            end
            self.espObjects[name] = nil
        end
    end
end

function ESPManager:ToggleFruitsESP(enabled)
    if enabled then
        self.connections.Fruits = RunService.Heartbeat:Connect(function()
            pcall(function()
                -- Procurar por frutas no workspace
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("Tool") and obj.Name:find("Fruit") and obj:FindFirstChild("Handle") then
                        local existingESP = CoreGui:FindFirstChild("ESP_" .. obj.Name .. "_" .. tostring(obj))
                        if not existingESP then
                            local distance = (RootPart.Position - obj.Handle.Position).Magnitude
                            local esp = self:CreateESP(obj.Handle, Color3.new(1, 1, 0), obj.Name, distance)
                            esp.Name = "ESP_" .. obj.Name .. "_" .. tostring(obj)
                            self.espObjects[obj.Name .. "_" .. tostring(obj)] = esp
                        end
                    end
                end
            end)
        end)
    else
        if self.connections.Fruits then
            self.connections.Fruits:Disconnect()
            self.connections.Fruits = nil
        end
        for name, esp in pairs(self.espObjects) do
            if name:find("Fruit") and esp and esp.Parent then
                esp:Destroy()
                self.espObjects[name] = nil
            end
        end
    end
end

function ESPManager:ToggleBossesESP(enabled)
    if enabled then
        self.connections.Bosses = RunService.Heartbeat:Connect(function()
            pcall(function()
                local bosses = Workspace:FindFirstChild("Enemies")
                if bosses then
                    for _, boss in pairs(bosses:GetChildren()) do
                        if boss:FindFirstChild("HumanoidRootPart") and boss:FindFirstChild("Humanoid") then
                            -- Verificar se é um boss (geralmente tem mais vida)
                            if boss.Humanoid.MaxHealth > 1000 then
                                local existingESP = CoreGui:FindFirstChild("ESP_Boss_" .. boss.Name)
                                if not existingESP then
                                    local distance = (RootPart.Position - boss.HumanoidRootPart.Position).Magnitude
                                    local esp = self:CreateESP(boss.HumanoidRootPart, Color3.new(1, 0, 1), boss.Name .. " [BOSS]", distance)
                                    esp.Name = "ESP_Boss_" .. boss.Name
                                    self.espObjects["Boss_" .. boss.Name] = esp
                                end
                            end
                        end
                    end
                end
            end)
        end)
    else
        if self.connections.Bosses then
            self.connections.Bosses:Disconnect()
            self.connections.Bosses = nil
        end
        for name, esp in pairs(self.espObjects) do
            if name:find("Boss") and esp and esp.Parent then
                esp:Destroy()
                self.espObjects[name] = nil
            end
        end
    end
end

-- ShopManager corrigido
local ShopManager = {}
ShopManager.__index = ShopManager

function ShopManager:new()
    local self = setmetatable({}, ShopManager)
    self.FruitPrices = {
        ["Leopard"] = 5000000,
        ["Dough"] = 2800000,
        ["Dragon"] = 3500000,
        ["Kitsune"] = 4000000,
        ["Spirit"] = 3400000,
        ["T-Rex"] = 2700000,
        ["Sound"] = 1700000,
        ["Mammoth"] = 2700000,
        ["Venom"] = 3000000,
        ["Control"] = 3200000,
        ["Shadow"] = 2900000,
        ["Phoenix"] = 1800000,
        ["Rumble"] = 2100000,
        ["Paw"] = 2300000,
        ["Gravity"] = 2500000,
        ["Buddha"] = 1200000,
        ["String"] = 750000,
        ["Quake"] = 1000000,
        ["Dark"] = 500000,
        ["Ice"] = 350000,
        ["Flame"] = 250000,
        ["Rubber"] = 750000,
        ["Barrier"] = 800000,
        ["Magma"] = 850000,
        ["Door"] = 950000,
        ["Revive"] = 550000,
        ["Diamond"] = 600000,
        ["Light"] = 650000,
        ["Love"] = 500000,
        ["Spider"] = 1500000,
        ["Falcon"] = 300000,
        ["Bomb"] = 100000,
        ["Spike"] = 700000,
        ["Chop"] = 30000,
        ["Spring"] = 60000,
        ["Kilo"] = 5000,
        ["Spin"] = 7500,
        ["Smoke"] = 100000,
        ["Paw"] = 2300000,
        ["Gravity"] = 2500000,
        ["Portal"] = 1900000,
        ["Pain"] = 2400000
    }
    return self
end

function ShopManager:BuyFruit(fruitName)
    pcall(function()
        local args = {
            [1] = "PurchaseRawFruit",
            [2] = fruitName,
            [3] = false
        }
        ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    end)
end

function ShopManager:CheckFruitInStock(fruitName)
    pcall(function()
        local args = {
            [1] = "GetFruits"
        }
        local result = ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
        if result then
            for _, fruit in pairs(result) do
                if fruit.Name == fruitName then
                    return true
                end
            end
        end
    end)
    return false
end

function ShopManager:AutoBuyFruits()
    if Config.Shop.AutoBuy then
        spawn(function()
            while Config.Shop.AutoBuy do
                wait(5)
                for _, fruit in pairs(Config.Shop.TargetFruits) do
                    if self:CheckFruitInStock(fruit) then
                        self:BuyFruit(fruit)
                        wait(1)
                    end
                end
            end
        end)
    end
end

-- UtilsManager corrigido
local UtilsManager = {}
UtilsManager.__index = UtilsManager

function UtilsManager:new()
    local self = setmetatable({}, UtilsManager)
    self.connections = {}
    self.bodyVelocity = nil
    return self
end

function UtilsManager:ToggleNoClip(enabled)
    if enabled then
        self.connections.NoClip = RunService.Stepped:Connect(function()
            if Character then
                for _, part in pairs(Character:GetChildren()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if self.connections.NoClip then
            self.connections.NoClip:Disconnect()
            self.connections.NoClip = nil
        end
        if Character then
            for _, part in pairs(Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

function UtilsManager:ToggleFly(enabled)
    if enabled then
        self.bodyVelocity = Instance.new("BodyVelocity")
        self.bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        self.bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        self.bodyVelocity.Parent = RootPart
        
        local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
        bodyAngularVelocity.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
        bodyAngularVelocity.Parent = RootPart
        
        self.connections.Fly = RunService.Heartbeat:Connect(function()
            if Character and RootPart then
                local camera = Workspace.CurrentCamera
                local moveVector = Humanoid.MoveDirection
                
                if moveVector.Magnitude > 0 then
                    local velocity = (camera.CFrame.LookVector * moveVector.Z + camera.CFrame.RightVector * moveVector.X) * 50
                    self.bodyVelocity.Velocity = velocity
                else
                    self.bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
                
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    self.bodyVelocity.Velocity = self.bodyVelocity.Velocity + Vector3.new(0, 50, 0)
                end
                
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    self.bodyVelocity.Velocity = self.bodyVelocity.Velocity + Vector3.new(0, -50, 0)
                end
            end
        end)
    else
        if self.connections.Fly then
            self.connections.Fly:Disconnect()
            self.connections.Fly = nil
        end
        if self.bodyVelocity then
            self.bodyVelocity:Destroy()
            self.bodyVelocity = nil
        end
        if RootPart:FindFirstChild("BodyAngularVelocity") then
            RootPart.BodyAngularVelocity:Destroy()
        end
    end
end

function UtilsManager:SetSpeed(speed)
    if Character and Humanoid then
        Humanoid.WalkSpeed = speed
    end
end

function UtilsManager:SetJumpPower(jumpPower)
    if Character and Humanoid then
        Humanoid.JumpPower = jumpPower
    end
end

function UtilsManager:ServerHop()
    pcall(function()
        local servers = {}
        local req = game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
        local body = HttpService:JSONDecode(req)
        
        for _, server in pairs(body.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                table.insert(servers, server.id)
            end
        end
        
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], Player)
        end
    end)
end

function UtilsManager:FPSBoost()
    pcall(function()
        -- Remover efeitos visuais
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") then
                effect.Enabled = false
            end
        end
        
        -- Reduzir qualidade
        settings().Rendering.QualityLevel = 1
        
        -- Remover partículas
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Explosion") then
                obj.Enabled = false
            end
        end
    end)
end

-- ====================
-- INICIALIZAÇÃO DOS MANAGERS
-- ====================

local farmManager = FarmManager:new()
local teleportManager = TeleportManager:new()
local espManager = ESPManager:new()
local shopManager = ShopManager:new()
local utilsManager = UtilsManager:new()

-- ====================
-- CRIAÇÃO DA UI
-- ====================

-- Popup de boas-vindas (corrigido)
WindUI:Popup({
    Title = "Mahi Hub",
    Icon = "anchor",
    Content = "Bem-vindo ao Mahi Hub!\n" .. seaDetector:GetCurrentSeaName() .. " detectado.",
    Buttons = {
        {
            Title = "Iniciar",
            Icon = "play",
            Callback = function() end,
            Variant = "Primary"
        }
    }
})

-- Criação da janela principal
local Window = WindUI:CreateWindow({
    Title = "Mahi Hub",
    Icon = "anchor",
    Author = "Mahi Team",
    Folder = "MahiHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = true
})

-- Criação das abas
local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = "home", Desc = "Informações principais" }),
    AutoFarm = Window:Tab({ Title = "Auto Farm", Icon = "zap", Desc = "Farm automático" }),
    Teleport = Window:Tab({ Title = "Teleport", Icon = "map-pin", Desc = "Sistema de teleporte" }),
    ESP = Window:Tab({ Title = "ESP", Icon = "eye", Desc = "Visualizações ESP" }),
    Events = Window:Tab({ Title = "Events", Icon = "calendar", Desc = "Eventos automáticos" }),
    Utils = Window:Tab({ Title = "Utils", Icon = "settings", Desc = "Utilitários" }),
    Shop = Window:Tab({ Title = "Shop", Icon = "shopping-cart", Desc = "Loja de frutas" }),
    Raids = Window:Tab({ Title = "Raids", Icon = "sword", Desc = "Sistema de raids" }),
    Settings = Window:Tab({ Title = "Settings", Icon = "cog", Desc = "Configurações" })
}

-- ====================
-- IMPLEMENTAÇÃO DAS ABAS
-- ====================

-- ABA MAIN
Tabs.Main:Paragraph({
    Title = "Mahi Hub - Blox Fruits",
    Desc = "Sea Atual: " .. seaDetector:GetCurrentSeaName(),
    Image = "anchor",
    Color = "Blue"
})

Tabs.Main:Section({ Title = "Controles Rápidos" })

Tabs.Main:Button({
    Title = "Reconnect",
    Icon = "refresh-cw",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, Player)
    end
})

Tabs.Main:Button({
    Title = "Redeploy UI",
    Icon = "monitor",
    Callback = function()
        Window:Destroy()
        wait(1)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MahiHub/script.lua"))()
    end
})

Tabs.Main:Button({
    Title = "Reload Character",
    Icon = "user",
    Callback = function()
        Player.Character:BreakJoints()
    end
})

Tabs.Main:Button({
    Title = "Server Hop",
    Icon = "shuffle",
    Callback = function()
        utilsManager:ServerHop()
    end
})

-- ABA AUTO FARM
Tabs.AutoFarm:Section({ Title = "Configurações de Farm" })

Tabs.AutoFarm:Toggle({
    Title = "Ativar Auto Farm",
    Icon = "zap",
    Value = false,
    Callback = function(state)
        Config.AutoFarm.Enabled = state
        if state then
            farmManager:Start()
        else
            farmManager:Stop()
        end
    end
})

Tabs.AutoFarm:Toggle({
    Title = "Fast Attack",
    Icon = "zap",
    Value = false,
    Callback = function(state)
        Config.AutoFarm.FastAttack = state
        if state then
            farmManager:Stop()
            farmManager:Start()
        end
    end
})

Tabs.AutoFarm:Toggle({
    Title = "Auto Haki",
    Icon = "shield",
    Value = false,
    Callback = function(state)
        Config.AutoFarm.AutoHaki = state
    end
})

Tabs.AutoFarm:Slider({
    Title = "Distância de Farm",
    Value = {
        Min = 10,
        Max = 50,
        Default = 25
    },
    Callback = function(value)
        Config.AutoFarm.FarmDistance = value
    end
})

-- Dropdown para seleção de inimigos
local currentEnemies = SeaConfig[currentSea].Enemies
local enemyOptions = {"Todos"}
for _, enemy in pairs(currentEnemies) do
    table.insert(enemyOptions, enemy)
end

Tabs.AutoFarm:Dropdown({
    Title = "Inimigo Alvo",
    Values = enemyOptions,
    Value = "Todos",
    Callback = function(enemy)
        Config.AutoFarm.SelectedEnemy = enemy == "Todos" and "" or enemy
    end
})

-- ABA TELEPORT
Tabs.Teleport:Section({ Title = "Ilhas - " .. seaDetector:GetCurrentSeaName() })

local currentIslands = teleportManager:GetCurrentSeaIslands()
for islandName, _ in pairs(currentIslands) do
    Tabs.Teleport:Button({
        Title = islandName,
        Icon = "map-pin",
        Callback = function()
            teleportManager:TeleportToIsland(islandName)
        end
    })
end

Tabs.Teleport:Section({ Title = "Configurações" })

Tabs.Teleport:Slider({
    Title = "Velocidade de Teleporte",
    Value = {
        Min = 100,
        Max = 500,
        Default = 300
    },
    Callback = function(value)
        Config.Teleport.TweenSpeed = value
    end
})

-- ABA ESP
Tabs.ESP:Section({ Title = "Visualizações ESP" })

Tabs.ESP:Toggle({
    Title = "ESP Jogadores",
    Icon = "users",
    Value = false,
    Callback = function(state)
        Config.ESP.Players = state
        espManager:TogglePlayersESP(state)
    end
})

Tabs.ESP:Toggle({
    Title = "ESP Frutas",
    Icon = "apple",
    Value = false,
    Callback = function(state)
        Config.ESP.Fruits = state
        espManager:ToggleFruitsESP(state)
    end
})

Tabs.ESP:Toggle({
    Title = "ESP Bosses",
    Icon = "skull",
    Value = false,
    Callback = function(state)
        Config.ESP.Bosses = state
        espManager:ToggleBossesESP(state)
    end
})

-- ABA UTILS
Tabs.Utils:Section({ Title = "Movimento" })

Tabs.Utils:Toggle({
    Title = "NoClip",
    Icon = "ghost",
    Value = false,
    Callback = function(state)
        Config.Utils.NoClip = state
        utilsManager:ToggleNoClip(state)
    end
})

Tabs.Utils:Toggle({
    Title = "Fly",
    Icon = "plane",
    Value = false,
    Callback = function(state)
        Config.Utils.Fly = state
        utilsManager:ToggleFly(state)
    end
})

Tabs.Utils:Slider({
    Title = "Velocidade",
    Value = {
        Min = 16,
        Max = 100,
        Default = 16
    },
    Callback = function(value)
        Config.Utils.Speed = value
        utilsManager:SetSpeed(value)
    end
})

Tabs.Utils:Slider({
    Title = "Força do Pulo",
    Value = {
        Min = 50,
        Max = 200,
        Default = 50
    },
    Callback = function(value)
        Config.Utils.JumpPower = value
        utilsManager:SetJumpPower(value)
    end
})

Tabs.Utils:Section({ Title = "Utilitários" })

Tabs.Utils:Button({
    Title = "FPS Boost",
    Icon = "zap",
    Callback = function()
        utilsManager:FPSBoost()
    end
})

Tabs.Utils:Toggle({
    Title = "Auto Respawn",
    Icon = "refresh-cw",
    Value = false,
    Callback = function(state)
        Config.Utils.AutoRespawn = state
        if state then
            Player.CharacterAdded:Connect(function()
                wait(1)
                if Config.Utils.AutoRespawn then
                    -- Reativar configurações após respawn
                    utilsManager:SetSpeed(Config.Utils.Speed)
                    utilsManager:SetJumpPower(Config.Utils.JumpPower)
                end
            end)
        end
    end
})

-- ABA SHOP
Tabs.Shop:Section({ Title = "Compra de Frutas" })

Tabs.Shop:Toggle({
    Title = "Auto Buy Frutas",
    Icon = "shopping-cart",
    Value = false,
    Callback = function(state)
        Config.Shop.AutoBuy = state
        shopManager:AutoBuyFruits()
    end
})

Tabs.Shop:Section({ Title = "Frutas Premium" })

for fruitName, price in pairs(shopManager.FruitPrices) do
    if price >= 1000000 then
        Tabs.Shop:Button({
            Title = fruitName .. " - $" .. price,
            Icon = "apple",
            Callback = function()
                shopManager:BuyFruit(fruitName)
            end
        })
    end
end

-- ABA SETTINGS
Tabs.Settings:Section({ Title = "Configurações" })

Tabs.Settings:Button({
    Title = "Descarregar Script",
    Icon = "x",
    Callback = function()
        farmManager:Stop()
        for _, connection in pairs(utilsManager.connections) do
            if connection then
                connection:Disconnect()
            end
        end
        Window:Destroy()
    end
})

-- ====================
-- PROTEÇÃO ANTI-CHEAT
-- ====================

-- Proteção contra AFK
spawn(function()
    while wait(60) do
        pcall(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
    end
end)

-- Proteção contra kick
pcall(function()
    local mt = getrawmetatable(game)
    local oldindex = mt.__index
    setreadonly(mt, false)
    mt.__index = function(t, k)
        if k == "Kick" then
            return function() end
        end
        return oldindex(t, k)
    end
    setreadonly(mt, true)
end)

-- Seleção da primeira aba
Window:SelectTab(1)

-- Notificação de carregamento
WindUI:Notify({
    Title = "Mahi Hub",
    Content = "Carregado com sucesso!",
    Duration = 3,
    Icon = "check"
})
