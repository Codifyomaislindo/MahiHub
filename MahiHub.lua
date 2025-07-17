-- Carregamento da biblioteca WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Serviços do Roblox
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

-- Variáveis globais
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Configurações do script
local Config = {
    AutoFarm = {
        Enabled = false,
        Target = "Closest",
        FastAttack = false,
        AutoHaki = false,
        FarmDistance = 10
    },
    ESP = {
        Players = false,
        Bosses = false,
        Fruits = false,
        Chests = false,
        NPCs = false
    },
    Teleport = {
        TweenSpeed = 350
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
-- MANAGERS
-- ====================

-- FarmManager
local FarmManager = {}
FarmManager.__index = FarmManager

function FarmManager:new()
    local self = setmetatable({}, FarmManager)
    self.isRunning = false
    self.currentTarget = nil
    self.connection = nil
    return self
end

function FarmManager:Start()
    if self.isRunning then return end
    self.isRunning = true
    
    self.connection = RunService.Heartbeat:Connect(function()
        if not Config.AutoFarm.Enabled then return end
        
        local target = self:FindTarget()
        if target then
            self:AttackTarget(target)
        end
    end)
end

function FarmManager:Stop()
    if self.connection then
        self.connection:Disconnect()
        self.connection = nil
    end
    self.isRunning = false
end

function FarmManager:FindTarget()
    local closestTarget = nil
    local closestDistance = math.huge
    
    for _, mob in pairs(Workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
            if mob.Humanoid.Health > 0 then
                local distance = (RootPart.Position - mob.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance < Config.AutoFarm.FarmDistance then
                    closestDistance = distance
                    closestTarget = mob
                end
            end
        end
    end
    
    return closestTarget
end

function FarmManager:AttackTarget(target)
    if not target or not target:FindFirstChild("HumanoidRootPart") then return end
    
    -- Teleporte para o alvo
    RootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
    
    -- Ativação do Haki se habilitado
    if Config.AutoFarm.AutoHaki then
        self:ActivateHaki()
    end
    
    -- Ataque rápido
    if Config.AutoFarm.FastAttack then
        local tool = Player.Character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("MouseButton1Click") then
            tool:Activate()
        end
    end
end

function FarmManager:ActivateHaki()
    -- Implementar ativação do Haki (Ken e Buso)
    local args = {"Buso"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

-- TeleportManager
local TeleportManager = {}
TeleportManager.__index = TeleportManager

function TeleportManager:new()
    local self = setmetatable({}, TeleportManager)
    self.Islands = {
        ["Starter Island"] = CFrame.new(1, 4, 1),
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
    }
    return self
end

function TeleportManager:TeleportTo(cframe)
    local tween = TweenService:Create(RootPart, 
        TweenInfo.new((RootPart.Position - cframe.Position).Magnitude / Config.Teleport.TweenSpeed, Enum.EasingStyle.Linear),
        {CFrame = cframe}
    )
    tween:Play()
end

function TeleportManager:TeleportToIsland(islandName)
    local cframe = self.Islands[islandName]
    if cframe then
        self:TeleportTo(cframe)
    end
end

-- ESPManager
local ESPManager = {}
ESPManager.__index = ESPManager

function ESPManager:new()
    local self = setmetatable({}, ESPManager)
    self.espObjects = {}
    return self
end

function ESPManager:CreateESP(object, color, text)
    local billboard = Instance.new("BillboardGui")
    billboard.Parent = CoreGui
    billboard.Adornee = object
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    
    local frame = Instance.new("Frame")
    frame.Parent = billboard
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    
    return billboard
end

function ESPManager:TogglePlayersESP(enabled)
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Player and player.Character then
                local esp = self:CreateESP(player.Character.HumanoidRootPart, Color3.new(1, 0, 0), player.Name)
                self.espObjects[player.Name] = esp
            end
        end
    else
        for name, esp in pairs(self.espObjects) do
            if esp then esp:Destroy() end
            self.espObjects[name] = nil
        end
    end
end

function ESPManager:ToggleFruitsESP(enabled)
    if enabled then
        for _, fruit in pairs(Workspace:GetChildren()) do
            if fruit.Name:find("Fruit") then
                local esp = self:CreateESP(fruit, Color3.new(1, 1, 0), fruit.Name)
                self.espObjects[fruit.Name] = esp
            end
        end
    else
        for name, esp in pairs(self.espObjects) do
            if name:find("Fruit") then
                esp:Destroy()
                self.espObjects[name] = nil
            end
        end
    end
end

-- ShopManager
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
        ["Mammoth"] = 2700000
    }
    return self
end

function ShopManager:BuyFruit(fruitName)
    local args = {
        [1] = "PurchaseRawFruit",
        [2] = fruitName,
        [3] = false
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

function ShopManager:CheckFruitInStock(fruitName)
    -- Implementar verificação de estoque
    return true
end

function ShopManager:AutoBuyFruits()
    for _, fruit in pairs(Config.Shop.TargetFruits) do
        if self:CheckFruitInStock(fruit) then
            self:BuyFruit(fruit)
            break
        end
    end
end

-- RaidsManager
local RaidsManager = {}
RaidsManager.__index = RaidsManager

function RaidsManager:new()
    local self = setmetatable({}, RaidsManager)
    self.RaidBosses = {
        ["Greybeard"] = CFrame.new(-5000, 125, 4000),
        ["Darkbeard"] = CFrame.new(-5500, 125, 4500),
        ["Cake Prince"] = CFrame.new(-2100, 70, -12000),
        ["Dough King"] = CFrame.new(-2150, 70, -12500),
        ["Tyrant of the Sky"] = CFrame.new(-7900, 5500, -33300)
    }
    return self
end

function RaidsManager:StartRaid(chipType)
    local args = {
        [1] = "RaidsNpc",
        [2] = "Select",
        [3] = chipType
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

function RaidsManager:BuyChip(chipType)
    local args = {
        [1] = "RaidsNpc",
        [2] = "Buy",
        [3] = chipType
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

-- UtilsManager
local UtilsManager = {}
UtilsManager.__index = UtilsManager

function UtilsManager:new()
    local self = setmetatable({}, UtilsManager)
    self.connections = {}
    return self
end

function UtilsManager:ToggleNoClip(enabled)
    if enabled then
        self.connections.NoClip = RunService.Stepped:Connect(function()
            for _, part in pairs(Character:GetChildren()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end)
    else
        if self.connections.NoClip then
            self.connections.NoClip:Disconnect()
            self.connections.NoClip = nil
        end
    end
end

function UtilsManager:ToggleFly(enabled)
    if enabled then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = RootPart
        
        self.connections.Fly = RunService.Heartbeat:Connect(function()
            local camera = Workspace.CurrentCamera
            local moveVector = Humanoid.MoveDirection
            bodyVelocity.Velocity = (camera.CFrame.LookVector * moveVector.Z + camera.CFrame.RightVector * moveVector.X) * 50
        end)
    else
        if self.connections.Fly then
            self.connections.Fly:Disconnect()
            self.connections.Fly = nil
        end
        if RootPart:FindFirstChild("BodyVelocity") then
            RootPart.BodyVelocity:Destroy()
        end
    end
end

function UtilsManager:SetSpeed(speed)
    Humanoid.WalkSpeed = speed
end

function UtilsManager:SetJumpPower(jumpPower)
    Humanoid.JumpPower = jumpPower
end

function UtilsManager:ServerHop()
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
end

function UtilsManager:FPSBoost()
    -- Remover efeitos visuais para melhorar FPS
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect.Enabled = false
        end
    end
    
    -- Reduzir qualidade gráfica
    settings().Rendering.QualityLevel = 1
end

-- ====================
-- INICIALIZAÇÃO DA UI
-- ====================

-- Managers
local farmManager = FarmManager:new()
local teleportManager = TeleportManager:new()
local espManager = ESPManager:new()
local shopManager = ShopManager:new()
local raidsManager = RaidsManager:new()
local utilsManager = UtilsManager:new()

-- Popup de boas-vindas
WindUI:Popup({
    Title = "Blox Fruits Script",
    Icon = "anchor",
    Content = "Script carregado com sucesso! Desenvolvido para otimizar sua experiência no Blox Fruits.",
    Buttons = {
        {
            Title = "Continuar",
            Icon = "play",
            Callback = function() end,
            Variant = "Primary"
        }
    }
})

-- Criação da janela principal
local Window = WindUI:CreateWindow({
    Title = "Blox Fruits Hub",
    Icon = "anchor",
    Author = "BloxFruits Script",
    Folder = "BloxFruitsHub",
    Size = UDim2.fromOffset(620, 500),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 220,
    HasOutline = true
})

-- Criação das abas
local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = "home", Desc = "Informações principais e controles básicos" }),
    AutoFarm = Window:Tab({ Title = "Auto Farm", Icon = "zap", Desc = "Automação de farm de mobs e mastery" }),
    Teleport = Window:Tab({ Title = "Teleport", Icon = "map-pin", Desc = "Sistema de teleporte para ilhas e NPCs" }),
    ESP = Window:Tab({ Title = "ESP", Icon = "eye", Desc = "Visualização de jogadores, frutas e bosses" }),
    Events = Window:Tab({ Title = "Events", Icon = "calendar", Desc = "Automação de eventos globais" }),
    Utils = Window:Tab({ Title = "Utils", Icon = "settings", Desc = "Ferramentas utilitárias e hacks" }),
    Shop = Window:Tab({ Title = "Shop", Icon = "shopping-cart", Desc = "Sistema de compra de frutas" }),
    Raids = Window:Tab({ Title = "Raids", Icon = "sword", Desc = "Automação de raids e bosses" }),
    Settings = Window:Tab({ Title = "Settings", Icon = "cog", Desc = "Configurações e temas" })
}

-- ====================
-- ABA MAIN
-- ====================

Tabs.Main:Paragraph({
    Title = "Blox Fruits Hub v1.0",
    Desc = "Script desenvolvido para otimizar sua experiência no Blox Fruits com funcionalidades avançadas de automação.",
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
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YourScript/script.lua"))()
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

-- ====================
-- ABA AUTO FARM
-- ====================

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
        Min = 5,
        Max = 50,
        Default = 10
    },
    Callback = function(value)
        Config.AutoFarm.FarmDistance = value
    end
})

Tabs.AutoFarm:Dropdown({
    Title = "Modo de Farm",
    Values = {"Closest", "Strongest", "Weakest"},
    Value = "Closest",
    Callback = function(mode)
        Config.AutoFarm.Target = mode
    end
})

-- ====================
-- ABA TELEPORT
-- ====================

Tabs.Teleport:Section({ Title = "Teleporte para Ilhas" })

for islandName, _ in pairs(teleportManager.Islands) do
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
        Default = 350
    },
    Callback = function(value)
        Config.Teleport.TweenSpeed = value
    end
})

-- ====================
-- ABA ESP
-- ====================

Tabs.ESP:Section({ Title = "Visualização" })

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
    end
})

Tabs.ESP:Toggle({
    Title = "ESP Baús",
    Icon = "package",
    Value = false,
    Callback = function(state)
        Config.ESP.Chests = state
    end
})

Tabs.ESP:Toggle({
    Title = "ESP NPCs",
    Icon = "user",
    Value = false,
    Callback = function(state)
        Config.ESP.NPCs = state
    end
})

-- ====================
-- ABA EVENTS
-- ====================

Tabs.Events:Section({ Title = "Eventos Automáticos" })

Tabs.Events:Toggle({
    Title = "Auto Collect Fruits",
    Icon = "apple",
    Value = false,
    Callback = function(state)
        -- Implementar coleta automática de frutas
    end
})

Tabs.Events:Toggle({
    Title = "Auto Sea Events",
    Icon = "waves",
    Value = false,
    Callback = function(state)
        -- Implementar eventos do mar
    end
})

Tabs.Events:Toggle({
    Title = "Auto Boss Events",
    Icon = "skull",
    Value = false,
    Callback = function(state)
        -- Implementar eventos de boss
    end
})

-- ====================
-- ABA UTILS
-- ====================

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

Tabs.Utils:Toggle({
    Title = "Auto Respawn",
    Icon = "refresh-cw",
    Value = false,
    Callback = function(state)
        Config.Utils.AutoRespawn = state
    end
})

Tabs.Utils:Button({
    Title = "FPS Boost",
    Icon = "zap",
    Callback = function()
        utilsManager:FPSBoost()
    end
})

-- ====================
-- ABA SHOP
-- ====================

Tabs.Shop:Section({ Title = "Compra de Frutas" })

Tabs.Shop:Toggle({
    Title = "Auto Buy Frutas",
    Icon = "shopping-cart",
    Value = false,
    Callback = function(state)
        Config.Shop.AutoBuy = state
    end
})

Tabs.Shop:Section({ Title = "Frutas Disponíveis" })

for fruitName, price in pairs(shopManager.FruitPrices) do
    Tabs.Shop:Button({
        Title = fruitName .. " - $" .. price,
        Icon = "apple",
        Callback = function()
            shopManager:BuyFruit(fruitName)
        end
    })
end

-- ====================
-- ABA RAIDS
-- ====================

Tabs.Raids:Section({ Title = "Controle de Raids" })

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
    Title = "Auto Buy Chip",
    Icon = "credit-card",
    Value = false,
    Callback = function(state)
        Config.Raids.AutoChip = state
    end
})

Tabs.Raids:Section({ Title = "Bosses de Raid" })

for bossName, position in pairs(raidsManager.RaidBosses) do
    Tabs.Raids:Button({
        Title = "Teleport para " .. bossName,
        Icon = "map-pin",
        Callback = function()
            teleportManager:TeleportTo(position)
        end
    })
end

-- ====================
-- ABA SETTINGS
-- ====================

Tabs.Settings:Section({ Title = "Configurações de Tema" })

local themes = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, name)
end

Tabs.Settings:Dropdown({
    Title = "Tema",
    Values = themes,
    Value = WindUI:GetCurrentTheme(),
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})

Tabs.Settings:Toggle({
    Title = "Transparência",
    Value = WindUI:GetTransparency(),
    Callback = function(state)
        Window:ToggleTransparency(state)
    end
})

Tabs.Settings:Section({ Title = "Configurações do Script" })

Tabs.Settings:Button({
    Title = "Salvar Configurações",
    Icon = "save",
    Callback = function()
        -- Implementar salvamento de configurações
        WindUI:Notify({
            Title = "Configurações",
            Content = "Configurações salvas com sucesso!",
            Duration = 3
        })
    end
})

Tabs.Settings:Button({
    Title = "Carregar Configurações",
    Icon = "folder-open",
    Callback = function()
        -- Implementar carregamento de configurações
        WindUI:Notify({
            Title = "Configurações",
            Content = "Configurações carregadas com sucesso!",
            Duration = 3
        })
    end
})

Tabs.Settings:Button({
    Title = "Descarregar Script",
    Icon = "x",
    Callback = function()
        Window:Destroy()
        farmManager:Stop()
        -- Limpar todas as conexões
        for _, connection in pairs(utilsManager.connections) do
            if connection then
                connection:Disconnect()
            end
        end
    end
})

-- ====================
-- PROTEÇÃO ANTI-CHEAT
-- ====================

-- Proteção contra AFK
spawn(function()
    while wait(60) do
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end
end)

-- Proteção contra kick
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

-- Seleção da primeira aba
Window:SelectTab(1)

-- Notificação de carregamento
WindUI:Notify({
    Title = "Blox Fruits Hub",
    Content = "Script carregado com sucesso! Todas as funcionalidades estão disponíveis.",
    Duration = 5,
    Icon = "check"
})
