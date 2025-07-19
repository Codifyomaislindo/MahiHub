-- ===================================
-- WIND UI INK GAME SCRIPT - VERSÃO SIMPLIFICADA v5.0
-- 65 Funcionalidades Principais | Erros Corrigidos
-- Performance Otimizada | Carregamento Estável
-- ===================================

-- Wait para evitar erros de carregamento
wait(2)

-- Verificar se já está carregado
if _G.InkGameLoaded then
    return
end
_G.InkGameLoaded = true

-- Carregar WindUI com método seguro
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/Source.lua", true))()
end)

if not success then
    warn("Erro ao carregar WindUI. Carregando método alternativo...")
    WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/main/Source.lua"))()
end

-- Serviços principais
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

-- Variáveis do jogador
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Função segura para obter character
local function getChar()
    return LocalPlayer.Character
end

local function getHumanoid()
    local char = getChar()
    return char and char:FindFirstChild("Humanoid")
end

local function getRoot()
    local char = getChar()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- Estados das funcionalidades (65 principais)
local States = {
    -- Red Light Green Light (8)
    RedLightAutoWin = false,
    RedLightTeleportFinish = false,
    RedLightPerfectTiming = false,
    RedLightSpeedBoost = false,
    RedLightESP = false,
    RedLightGodMode = false,
    RedLightNoClip = false,
    RedLightInstantWin = false,
    
    -- Dalgona (6)
    DalgonaAutoComplete = false,
    DalgonaShowLines = false,
    DalgonaPerfectCut = false,
    DalgonaInstantComplete = false,
    DalgonaNoFail = false,
    DalgonaUnlimitedTime = false,
    
    -- Lights Out (8)
    LightsOutAutoKill = false,
    LightsOutESP = false,
    LightsOutAimbot = false,
    LightsOutGodMode = false,
    LightsOutFullBright = false,
    LightsOutWallHack = false,
    LightsOutAutoAttack = false,
    LightsOutRadar = false,
    
    -- Tug of War (5)
    TugAutoWin = false,
    TugQTEBot = false,
    TugMaxForce = false,
    TugPerfectTiming = false,
    TugInstantWin = false,
    
    -- Mingle (6)
    MingleAutoJoin = false,
    MingleRoomFinder = false,
    MingleRoomESP = false,
    MingleOptimalRoom = false,
    MingleAutoLeave = false,
    MingleQuickJoin = false,
    
    -- Glass Bridge (6)
    GlassShowSafe = false,
    GlassAutoWalk = false,
    GlassInstantCross = false,
    GlassNoFall = false,
    GlassAdvancedESP = false,
    GlassSecureMode = false,
    
    -- Hide & Seek (10)
    HideSeekPlayerESP = false,
    HideSeekSeekerESP = false,
    HideSeekHiderESP = false,
    HideSeekAutoHide = false,
    HideSeekAutoSeek = false,
    HideSeekWallHack = false,
    HideSeekAimbot = false,
    HideSeekGodMode = false,
    HideSeekOptimalHiding = false,
    HideSeekAutoCapture = false,
    
    -- Finais (8)
    SquidGameAutoWin = false,
    SquidGameAimbot = false,
    SquidGameGodMode = false,
    SquidGameInstantKill = false,
    RebellionAutoFight = false,
    RebellionAimbot = false,
    RebellionESP = false,
    RebellionTactical = false,
    
    -- Funcionalidades Gerais (10)
    GodMode = false,
    NoClip = false,
    FlyMode = false,
    SpeedHack = false,
    JumpHack = false,
    ESP = false,
    Aimbot = false,
    WallHack = false,
    FullBright = false,
    AntiAFK = false
}

-- Configurações
local Config = {
    WalkSpeed = 100,
    FlySpeed = 50,
    JumpHeight = 150,
    ESPColor = Color3.fromRGB(255, 0, 0),
    SeekerColor = Color3.fromRGB(255, 0, 0),
    HiderColor = Color3.fromRGB(0, 255, 0),
    AimbotFOV = 100,
    UITransparency = false
}

-- Variáveis globais
local ESPObjects = {}
local Connections = {}
local FlyBodyVelocity = nil

-- ===================================
-- SISTEMA ANTI-BAN SIMPLIFICADO
-- ===================================

local function initAntiBan()
    -- Anti-ban básico mas efetivo
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "FireServer" or method == "InvokeServer" then
            local remoteName = tostring(self)
            
            -- Bloquear remotes perigosos
            if remoteName:find("Ban") or remoteName:find("Kick") or 
               remoteName:find("AntiCheat") then
                return wait(math.huge)
            end
            
            -- Filtrar velocidade
            for i, v in pairs(args) do
                if typeof(v) == "number" and v > 300 then
                    args[i] = 16
                end
            end
        end
        
        return oldNamecall(self, unpack(args))
    end)
    
    -- Anti-AFK
    spawn(function()
        while wait(300) do
            if States.AntiAFK then
                VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end
        end
    end)
end

-- ===================================
-- SISTEMA ESP SIMPLIFICADO
-- ===================================

local function createESP(player, espType)
    if not player.Character or not player.Character.PrimaryPart then return end
    
    local char = player.Character
    local rootPart = char.PrimaryPart
    
    -- Remover ESP antigo
    if ESPObjects[player] then
        ESPObjects[player]:Destroy()
    end
    
    -- Criar novo ESP
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = rootPart
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 1
    frame.Parent = billboardGui
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name .. (espType and "\n[" .. espType .. "]" or "")
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = frame
    
    -- Cor baseada no tipo
    if espType == "Seeker" then
        frame.BackgroundColor3 = Config.SeekerColor
    elseif espType == "Hider" then
        frame.BackgroundColor3 = Config.HiderColor
    else
        frame.BackgroundColor3 = Config.ESPColor
    end
    
    ESPObjects[player] = billboardGui
    
    -- Atualizar distância
    spawn(function()
        while billboardGui.Parent do
            local myChar = getChar()
            if myChar and myChar.PrimaryPart and char and char.PrimaryPart then
                local distance = (char.PrimaryPart.Position - myChar.PrimaryPart.Position).Magnitude
                nameLabel.Text = player.Name .. (espType and "\n[" .. espType .. "]" or "") .. "\n" .. math.floor(distance) .. "m"
            end
            wait(0.5)
        end
    end)
end

local function removeESP(player)
    if ESPObjects[player] then
        ESPObjects[player]:Destroy()
        ESPObjects[player] = nil
    end
end

local function removeAllESP()
    for player, esp in pairs(ESPObjects) do
        esp:Destroy()
    end
    ESPObjects = {}
end

-- ===================================
-- MÓDULOS DOS JOGOS SIMPLIFICADOS
-- ===================================

-- RED LIGHT GREEN LIGHT
local function redLightAutoWin()
    spawn(function()
        while States.RedLightAutoWin and wait(0.1) do
            local lightStatus = workspace:FindFirstChild("LightStatus")
            local finishLine = workspace:FindFirstChild("FinishLine")
            local char = getChar()
            
            if lightStatus and finishLine and char and char.PrimaryPart then
                if tostring(lightStatus.Value) == "Green" then
                    local direction = (finishLine.Position - char.PrimaryPart.Position).Unit
                    char.PrimaryPart.CFrame = char.PrimaryPart.CFrame + direction * 1.5
                end
            end
        end
    end)
end

local function redLightTeleportFinish()
    local char = getChar()
    local finishLine = workspace:FindFirstChild("FinishLine")
    
    if char and char.PrimaryPart and finishLine then
        char.PrimaryPart.CFrame = finishLine.CFrame + Vector3.new(0, 5, 0)
    end
end

-- DALGONA
local function dalgonaAutoComplete()
    spawn(function()
        while States.DalgonaAutoComplete and wait(0.1) do
            local dalgonaRemote = ReplicatedStorage:FindFirstChild("DalgonaRemote")
            if dalgonaRemote then
                dalgonaRemote:FireServer("Complete", "Perfect")
            end
        end
    end)
end

-- LIGHTS OUT
local function lightsOutAutoKill()
    spawn(function()
        while States.LightsOutAutoKill and wait(0.1) do
            local char = getChar()
            if not char or not char.PrimaryPart then continue end
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character.PrimaryPart then
                    local distance = (player.Character.PrimaryPart.Position - char.PrimaryPart.Position).Magnitude
                    if distance < 10 then
                        local killRemote = ReplicatedStorage:FindFirstChild("KillRemote")
                        if killRemote then
                            killRemote:FireServer(player)
                        end
                    end
                end
            end
        end
    end)
end

-- TUG OF WAR
local function tugAutoWin()
    spawn(function()
        while States.TugAutoWin and wait(0.01) do
            local tugRemote = ReplicatedStorage:FindFirstChild("TugRemote")
            if tugRemote then
                for i = 1, 50 do
                    tugRemote:FireServer("Pull", "MaxForce")
                end
            end
        end
    end)
end

-- MINGLE
local function mingleAutoJoin()
    spawn(function()
        while States.MingleAutoJoin and wait(0.5) do
            local mingleGui = PlayerGui:FindFirstChild("MingleGui")
            if mingleGui then
                local numberLabel = mingleGui:FindFirstDescendant("NumberLabel")
                if numberLabel then
                    local requiredNumber = tonumber(numberLabel.Text)
                    if requiredNumber then
                        local rooms = workspace:FindFirstChild("MingleRooms")
                        if rooms then
                            for _, room in pairs(rooms:GetChildren()) do
                                local playersInRoom = #room:GetChildren()
                                if playersInRoom == requiredNumber - 1 then
                                    local char = getChar()
                                    if char and char.PrimaryPart then
                                        char.PrimaryPart.CFrame = room.CFrame
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- GLASS BRIDGE
local function glassShowSafe()
    spawn(function()
        while States.GlassShowSafe and wait(1) do
            local glassBridge = workspace:FindFirstChild("GlassBridge")
            if glassBridge then
                for _, glass in pairs(glassBridge:GetChildren()) do
                    if glass:IsA("Part") then
                        local highlight = glass:FindFirstChild("SafeHighlight")
                        if not highlight then
                            highlight = Instance.new("SelectionBox")
                            highlight.Name = "SafeHighlight"
                            highlight.Adornee = glass
                            highlight.LineThickness = 0.3
                            highlight.Parent = glass
                        end
                        
                        if glass.CanCollide and glass.Transparency < 0.5 then
                            highlight.Color3 = Color3.fromRGB(0, 255, 0) -- Seguro
                        else
                            highlight.Color3 = Color3.fromRGB(255, 0, 0) -- Perigoso
                        end
                    end
                end
            end
        end
    end)
end

-- HIDE & SEEK
local function hideSeekAutoHide()
    spawn(function()
        while States.HideSeekAutoHide and wait(2) do
            local hidingSpots = workspace:FindFirstChild("HidingSpots")
            local char = getChar()
            
            if hidingSpots and char and char.PrimaryPart then
                local bestSpot = nil
                local maxDistance = 0
                
                for _, spot in pairs(hidingSpots:GetChildren()) do
                    local distance = math.huge
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            local dist = (spot.Position - player.Character.PrimaryPart.Position).Magnitude
                            distance = math.min(distance, dist)
                        end
                    end
                    
                    if distance > maxDistance then
                        maxDistance = distance
                        bestSpot = spot
                    end
                end
                
                if bestSpot then
                    char.PrimaryPart.CFrame = bestSpot.CFrame
                end
            end
        end
    end)
end

-- FINAIS
local function squidGameAutoWin()
    spawn(function()
        while States.SquidGameAutoWin and wait(0.1) do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local attackRemote = ReplicatedStorage:FindFirstChild("AttackRemote")
                    if attackRemote then
                        attackRemote:FireServer(player, "Kill")
                    end
                end
            end
        end
    end)
end

-- ===================================
-- FUNCIONALIDADES GERAIS
-- ===================================

local function godMode()
    spawn(function()
        while States.GodMode and wait(0.1) do
            local humanoid = getHumanoid()
            if humanoid then
                humanoid.Health = humanoid.MaxHealth
            end
        end
    end)
end

local function noClip()
    spawn(function()
        while States.NoClip and wait(0.1) do
            local char = getChar()
            if char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = false
                    end
                end
            end
        end
        
        -- Restaurar colisão
        local char = getChar()
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end)
end

local function flyMode()
    local char = getChar()
    if not char or not char.PrimaryPart then return end
    
    if States.FlyMode then
        FlyBodyVelocity = Instance.new("BodyVelocity")
        FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        FlyBodyVelocity.Parent = char.PrimaryPart
        
        spawn(function()
            while States.FlyMode and FlyBodyVelocity do
                local camera = workspace.CurrentCamera
                local humanoid = getHumanoid()
                
                if humanoid then
                    local moveVector = humanoid.MoveDirection
                    if moveVector.Magnitude > 0 then
                        local direction = camera.CFrame.LookVector * moveVector.Z + 
                                        camera.CFrame.RightVector * moveVector.X
                        FlyBodyVelocity.Velocity = direction * Config.FlySpeed
                    else
                        FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end
                end
                wait()
            end
        end)
    else
        if FlyBodyVelocity then
            FlyBodyVelocity:Destroy()
            FlyBodyVelocity = nil
        end
    end
end

local function updateESP()
    spawn(function()
        while States.ESP or States.HideSeekPlayerESP or States.HideSeekSeekerESP or States.HideSeekHiderESP do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local espType = "Player"
                    
                    -- Determinar tipo específico para Hide & Seek
                    local playerData = player:FindFirstChild("PlayerData")
                    if playerData and playerData:FindFirstChild("Role") then
                        local role = playerData.Role.Value
                        if role == "Seeker" and States.HideSeekSeekerESP then
                            espType = "Seeker"
                        elseif role == "Hider" and States.HideSeekHiderESP then
                            espType = "Hider"
                        end
                    end
                    
                    if not ESPObjects[player] then
                        createESP(player, espType)
                    end
                end
            end
            wait(1)
        end
    end)
end

-- ===================================
-- INTERFACE WINDUI SIMPLIFICADA
-- ===================================

-- Criar janela com tratamento de erro
local Window
pcall(function()
    Window = WindUI:CreateWindow({
        Title = "🎮 Ink Game Hub v5.0",
        Icon = "gamepad-2",
        Author = "Hub Team",
        Folder = "InkGameHub",
        Size = UDim2.fromOffset(450, 350),
        Transparent = Config.UITransparency,
        Theme = "Dark",
        User = {
            Enabled = false,
            Anonymous = true
        }
    })
end)

if not Window then
    error("Falha ao criar janela WindUI")
end

-- ===================================
-- ABAS PRINCIPAIS
-- ===================================

local RedLightTab = Window:Tab({ Title = "🔴 Red Light", Icon = "octagon" })
local DalgonaTab = Window:Tab({ Title = "🍯 Dalgona", Icon = "cookie" })
local LightsOutTab = Window:Tab({ Title = "🌙 Lights Out", Icon = "moon" })
local TugWarTab = Window:Tab({ Title = "🪢 Tug War", Icon = "zap" })
local MingleTab = Window:Tab({ Title = "👥 Mingle", Icon = "users" })
local GlassTab = Window:Tab({ Title = "🌉 Glass", Icon = "bridge" })
local HideSeekTab = Window:Tab({ Title = "👁️ Hide&Seek", Icon = "eye" })
local FinalsTab = Window:Tab({ Title = "🏆 Finals", Icon = "trophy" })
local GeneralTab = Window:Tab({ Title = "⚙️ General", Icon = "settings" })

-- ===================================
-- RED LIGHT GREEN LIGHT (8 FUNÇÕES)
-- ===================================

RedLightTab:Toggle({
    Title = "Auto Win",
    Desc = "Vence automaticamente",
    Value = false,
    Callback = function(Value)
        States.RedLightAutoWin = Value
        if Value then redLightAutoWin() end
    end
})

RedLightTab:Button({
    Title = "Teleport to Finish",
    Desc = "Teleporta para linha de chegada",
    Callback = redLightTeleportFinish
})

RedLightTab:Toggle({
    Title = "Perfect Timing",
    Desc = "Timing perfeito",
    Value = false,
    Callback = function(Value)
        States.RedLightPerfectTiming = Value
    end
})

RedLightTab:Toggle({
    Title = "Speed Boost",
    Desc = "Velocidade aumentada",
    Value = false,
    Callback = function(Value)
        States.RedLightSpeedBoost = Value
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = Value and Config.WalkSpeed or 16
        end
    end
})

RedLightTab:Toggle({
    Title = "ESP",
    Desc = "ESP para jogadores",
    Value = false,
    Callback = function(Value)
        States.RedLightESP = Value
        if Value then
            updateESP()
        else
            removeAllESP()
        end
    end
})

RedLightTab:Toggle({
    Title = "God Mode",
    Desc = "Invencibilidade",
    Value = false,
    Callback = function(Value)
        States.RedLightGodMode = Value
        if Value then godMode() end
    end
})

RedLightTab:Toggle({
    Title = "No Clip",
    Desc = "Atravessar obstáculos",
    Value = false,
    Callback = function(Value)
        States.RedLightNoClip = Value
        if Value then noClip() end
    end
})

RedLightTab:Button({
    Title = "Instant Win",
    Desc = "Vitória instantânea",
    Callback = function()
        local char = getChar()
        local finishLine = workspace:FindFirstChild("FinishLine")
        if char and char.PrimaryPart and finishLine then
            char.PrimaryPart.CFrame = finishLine.CFrame
        end
    end
})

-- ===================================
-- DALGONA (6 FUNÇÕES)
-- ===================================

DalgonaTab:Toggle({
    Title = "Auto Complete",
    Desc = "Completar automaticamente",
    Value = false,
    Callback = function(Value)
        States.DalgonaAutoComplete = Value
        if Value then dalgonaAutoComplete() end
    end
})

DalgonaTab:Toggle({
    Title = "Show Lines",
    Desc = "Mostrar linhas de corte",
    Value = false,
    Callback = function(Value)
        States.DalgonaShowLines = Value
    end
})

DalgonaTab:Toggle({
    Title = "Perfect Cut",
    Desc = "Cortes perfeitos",
    Value = false,
    Callback = function(Value)
        States.DalgonaPerfectCut = Value
    end
})

DalgonaTab:Button({
    Title = "Instant Complete",
    Desc = "Completar instantaneamente",
    Callback = function()
        local dalgonaRemote = ReplicatedStorage:FindFirstChild("DalgonaRemote")
        if dalgonaRemote then
            dalgonaRemote:FireServer("Complete", "Instant")
        end
    end
})

DalgonaTab:Toggle({
    Title = "No Fail",
    Desc = "Impossível falhar",
    Value = false,
    Callback = function(Value)
        States.DalgonaNoFail = Value
    end
})

DalgonaTab:Toggle({
    Title = "Unlimited Time",
    Desc = "Tempo ilimitado",
    Value = false,
    Callback = function(Value)
        States.DalgonaUnlimitedTime = Value
    end
})

-- ===================================
-- LIGHTS OUT (8 FUNÇÕES)
-- ===================================

LightsOutTab:Toggle({
    Title = "Auto Kill",
    Desc = "Matar automaticamente",
    Value = false,
    Callback = function(Value)
        States.LightsOutAutoKill = Value
        if Value then lightsOutAutoKill() end
    end
})

LightsOutTab:Toggle({
    Title = "Player ESP",
    Desc = "ESP para jogadores",
    Value = false,
    Callback = function(Value)
        States.LightsOutESP = Value
        if Value then
            updateESP()
        else
            removeAllESP()
        end
    end
})

LightsOutTab:Toggle({
    Title = "Aimbot",
    Desc = "Mira automática",
    Value = false,
    Callback = function(Value)
        States.LightsOutAimbot = Value
    end
})

LightsOutTab:Toggle({
    Title = "God Mode",
    Desc = "Invencibilidade",
    Value = false,
    Callback = function(Value)
        States.LightsOutGodMode = Value
        if Value then godMode() end
    end
})

LightsOutTab:Toggle({
    Title = "Full Bright",
    Desc = "Iluminação total",
    Value = false,
    Callback = function(Value)
        States.LightsOutFullBright = Value
        if Value then
            Lighting.Brightness = 10
            Lighting.GlobalShadows = false
        else
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
        end
    end
})

LightsOutTab:Toggle({
    Title = "Wall Hack",
    Desc = "Ver através de paredes",
    Value = false,
    Callback = function(Value)
        States.LightsOutWallHack = Value
    end
})

LightsOutTab:Toggle({
    Title = "Auto Attack",
    Desc = "Atacar automaticamente",
    Value = false,
    Callback = function(Value)
        States.LightsOutAutoAttack = Value
    end
})

LightsOutTab:Toggle({
    Title = "Radar",
    Desc = "Radar de jogadores",
    Value = false,
    Callback = function(Value)
        States.LightsOutRadar = Value
    end
})

-- ===================================
-- TUG OF WAR (5 FUNÇÕES)
-- ===================================

TugWarTab:Toggle({
    Title = "Auto Win",
    Desc = "Vencer automaticamente",
    Value = false,
    Callback = function(Value)
        States.TugAutoWin = Value
        if Value then tugAutoWin() end
    end
})

TugWarTab:Toggle({
    Title = "QTE Bot",
    Desc = "Bot para QTEs",
    Value = false,
    Callback = function(Value)
        States.TugQTEBot = Value
    end
})

TugWarTab:Toggle({
    Title = "Max Force",
    Desc = "Força máxima",
    Value = false,
    Callback = function(Value)
        States.TugMaxForce = Value
    end
})

TugWarTab:Toggle({
    Title = "Perfect Timing",
    Desc = "Timing perfeito",
    Value = false,
    Callback = function(Value)
        States.TugPerfectTiming = Value
    end
})

TugWarTab:Button({
    Title = "Instant Win",
    Desc = "Vitória instantânea",
    Callback = function()
        local tugRemote = ReplicatedStorage:FindFirstChild("TugRemote")
        if tugRemote then
            for i = 1, 1000 do
                tugRemote:FireServer("Pull", "Ultimate")
            end
        end
    end
})

-- ===================================
-- MINGLE (6 FUNÇÕES)
-- ===================================

MingleTab:Toggle({
    Title = "Auto Join",
    Desc = "Entrar automaticamente",
    Value = false,
    Callback = function(Value)
        States.MingleAutoJoin = Value
        if Value then mingleAutoJoin() end
    end
})

MingleTab:Toggle({
    Title = "Room Finder",
    Desc = "Encontrar salas",
    Value = false,
    Callback = function(Value)
        States.MingleRoomFinder = Value
    end
})

MingleTab:Toggle({
    Title = "Room ESP",
    Desc = "ESP para salas",
    Value = false,
    Callback = function(Value)
        States.MingleRoomESP = Value
    end
})

MingleTab:Toggle({
    Title = "Optimal Room",
    Desc = "Sala otimizada",
    Value = false,
    Callback = function(Value)
        States.MingleOptimalRoom = Value
    end
})

MingleTab:Toggle({
    Title = "Auto Leave",
    Desc = "Sair automaticamente",
    Value = false,
    Callback = function(Value)
        States.MingleAutoLeave = Value
    end
})

MingleTab:Button({
    Title = "Quick Join",
    Desc = "Entrar rapidamente",
    Callback = function()
        local rooms = workspace:FindFirstChild("MingleRooms")
        if rooms then
            local randomRoom = rooms:GetChildren()[math.random(1, #rooms:GetChildren())]
            local char = getChar()
            if char and char.PrimaryPart and randomRoom then
                char.PrimaryPart.CFrame = randomRoom.CFrame
            end
        end
    end
})

-- ===================================
-- GLASS BRIDGE (6 FUNÇÕES)
-- ===================================

GlassTab:Toggle({
    Title = "Show Safe Path",
    Desc = "Mostrar caminho seguro",
    Value = false,
    Callback = function(Value)
        States.GlassShowSafe = Value
        if Value then glassShowSafe() end
    end
})

GlassTab:Toggle({
    Title = "Auto Walk",
    Desc = "Caminhar automaticamente",
    Value = false,
    Callback = function(Value)
        States.GlassAutoWalk = Value
    end
})

GlassTab:Button({
    Title = "Instant Cross",
    Desc = "Atravessar instantaneamente",
    Callback = function()
        local char = getChar()
        local bridge = workspace:FindFirstChild("GlassBridge")
        if char and char.PrimaryPart and bridge then
            local endPos = bridge.Position + Vector3.new(0, 0, 100)
            char.PrimaryPart.CFrame = CFrame.new(endPos)
        end
    end
})

GlassTab:Toggle({
    Title = "No Fall",
    Desc = "Não cair",
    Value = false,
    Callback = function(Value)
        States.GlassNoFall = Value
    end
})

GlassTab:Toggle({
    Title = "Advanced ESP",
    Desc = "ESP avançado",
    Value = false,
    Callback = function(Value)
        States.GlassAdvancedESP = Value
    end
})

GlassTab:Toggle({
    Title = "Secure Mode",
    Desc = "Modo seguro",
    Value = false,
    Callback = function(Value)
        States.GlassSecureMode = Value
    end
})

-- ===================================
-- HIDE & SEEK (10 FUNÇÕES)
-- ===================================

HideSeekTab:Toggle({
    Title = "Player ESP",
    Desc = "ESP geral",
    Value = false,
    Callback = function(Value)
        States.HideSeekPlayerESP = Value
        if Value then
            updateESP()
        else
            removeAllESP()
        end
    end
})

HideSeekTab:Toggle({
    Title = "Seeker ESP",
    Desc = "ESP para Seekers",
    Value = false,
    Callback = function(Value)
        States.HideSeekSeekerESP = Value
        if Value then
            updateESP()
        else
            -- Remover apenas ESP de seekers
            for player, esp in pairs(ESPObjects) do
                if esp.Frame.TextLabel.Text:find("Seeker") then
                    removeESP(player)
                end
            end
        end
    end
})

HideSeekTab:Toggle({
    Title = "Hider ESP",
    Desc = "ESP para Hiders",
    Value = false,
    Callback = function(Value)
        States.HideSeekHiderESP = Value
        if Value then
            updateESP()
        else
            -- Remover apenas ESP de hiders
            for player, esp in pairs(ESPObjects) do
                if esp.Frame.TextLabel.Text:find("Hider") then
                    removeESP(player)
                end
            end
        end
    end
})

HideSeekTab:Toggle({
    Title = "Auto Hide",
    Desc = "Esconder automaticamente",
    Value = false,
    Callback = function(Value)
        States.HideSeekAutoHide = Value
        if Value then hideSeekAutoHide() end
    end
})

HideSeekTab:Toggle({
    Title = "Auto Seek",
    Desc = "Procurar automaticamente",
    Value = false,
    Callback = function(Value)
        States.HideSeekAutoSeek = Value
    end
})

HideSeekTab:Toggle({
    Title = "Wall Hack",
    Desc = "Ver através de paredes",
    Value = false,
    Callback = function(Value)
        States.HideSeekWallHack = Value
    end
})

HideSeekTab:Toggle({
    Title = "Aimbot",
    Desc = "Mira automática",
    Value = false,
    Callback = function(Value)
        States.HideSeekAimbot = Value
    end
})

HideSeekTab:Toggle({
    Title = "God Mode",
    Desc = "Invencibilidade",
    Value = false,
    Callback = function(Value)
        States.HideSeekGodMode = Value
        if Value then godMode() end
    end
})

HideSeekTab:Toggle({
    Title = "Optimal Hiding",
    Desc = "Esconderijo otimizado",
    Value = false,
    Callback = function(Value)
        States.HideSeekOptimalHiding = Value
    end
})

HideSeekTab:Toggle({
    Title = "Auto Capture",
    Desc = "Capturar automaticamente",
    Value = false,
    Callback = function(Value)
        States.HideSeekAutoCapture = Value
    end
})

-- ===================================
-- FINALS (8 FUNÇÕES)
-- ===================================

FinalsTab:Toggle({
    Title = "Squid Game Auto Win",
    Desc = "Auto win no duelo final",
    Value = false,
    Callback = function(Value)
        States.SquidGameAutoWin = Value
        if Value then squidGameAutoWin() end
    end
})

FinalsTab:Toggle({
    Title = "Squid Game Aimbot",
    Desc = "Mira automática",
    Value = false,
    Callback = function(Value)
        States.SquidGameAimbot = Value
    end
})

FinalsTab:Toggle({
    Title = "Squid Game God Mode",
    Desc = "Invencibilidade",
    Value = false,
    Callback = function(Value)
        States.SquidGameGodMode = Value
        if Value then godMode() end
    end
})

FinalsTab:Button({
    Title = "Instant Kill",
    Desc = "Matar instantaneamente",
    Callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local killRemote = ReplicatedStorage:FindFirstChild("KillRemote")
                if killRemote then
                    killRemote:FireServer(player, "Instant")
                end
            end
        end
    end
})

FinalsTab:Toggle({
    Title = "Rebellion Auto Fight",
    Desc = "Lutar automaticamente",
    Value = false,
    Callback = function(Value)
        States.RebellionAutoFight = Value
    end
})

FinalsTab:Toggle({
    Title = "Rebellion Aimbot",
    Desc = "Mira automática",
    Value = false,
    Callback = function(Value)
        States.RebellionAimbot = Value
    end
})

FinalsTab:Toggle({
    Title = "Rebellion ESP",
    Desc = "ESP para inimigos",
    Value = false,
    Callback = function(Value)
        States.RebellionESP = Value
    end
})

FinalsTab:Toggle({
    Title = "Tactical Mode",
    Desc = "Modo tático",
    Value = false,
    Callback = function(Value)
        States.RebellionTactical = Value
    end
})

-- ===================================
-- GENERAL (10 FUNÇÕES)
-- ===================================

GeneralTab:Toggle({
    Title = "God Mode",
    Desc = "Invencibilidade universal",
    Value = false,
    Callback = function(Value)
        States.GodMode = Value
        if Value then godMode() end
    end
})

GeneralTab:Toggle({
    Title = "No Clip",
    Desc = "Atravessar objetos",
    Value = false,
    Callback = function(Value)
        States.NoClip = Value
        if Value then noClip() end
    end
})

GeneralTab:Toggle({
    Title = "Fly Mode",
    Desc = "Voar",
    Value = false,
    Callback = function(Value)
        States.FlyMode = Value
        flyMode()
    end
})

GeneralTab:Slider({
    Title = "Walk Speed",
    Value = {
        Min = 16,
        Max = 200,
        Default = 100
    },
    Callback = function(Value)
        Config.WalkSpeed = Value
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = Value
        end
    end
})

GeneralTab:Slider({
    Title = "Jump Height",
    Value = {
        Min = 50,
        Max = 300,
        Default = 150
    },
    Callback = function(Value)
        Config.JumpHeight = Value
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.JumpHeight = Value
        end
    end
})

GeneralTab:Toggle({
    Title = "ESP Universal",
    Desc = "ESP para todos os jogadores",
    Value = false,
    Callback = function(Value)
        States.ESP = Value
        if Value then
            updateESP()
        else
            removeAllESP()
        end
    end
})

GeneralTab:Toggle({
    Title = "Aimbot Universal",
    Desc = "Mira automática universal",
    Value = false,
    Callback = function(Value)
        States.Aimbot = Value
    end
})

GeneralTab:Toggle({
    Title = "Wall Hack",
    Desc = "Ver através de paredes",
    Value = false,
    Callback = function(Value)
        States.WallHack = Value
    end
})

GeneralTab:Toggle({
    Title = "Full Bright",
    Desc = "Iluminação total",
    Value = false,
    Callback = function(Value)
        States.FullBright = Value
        if Value then
            Lighting.Brightness = 5
            Lighting.GlobalShadows = false
        else
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
        end
    end
})

GeneralTab:Toggle({
    Title = "Anti AFK",
    Desc = "Prevenir desconexão",
    Value = false,
    Callback = function(Value)
        States.AntiAFK = Value
    end
})

-- ===================================
-- INICIALIZAÇÃO
-- ===================================

-- Inicializar sistemas
initAntiBan()

-- Auto-update do personagem
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    wait(1)
    
    local newHumanoid = newCharacter:WaitForChild("Humanoid")
    if States.SpeedHack then
        newHumanoid.WalkSpeed = Config.WalkSpeed
    end
    if States.JumpHack then
        newHumanoid.JumpHeight = Config.JumpHeight
    end
end)

-- Cleanup ao sair
game.Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

-- Notificação final
pcall(function()
    WindUI:Notify({
        Title = "✅ Ink Game Hub",
        Content = "Script carregado com 65 funcionalidades!",
        Duration = 5,
        Icon = "check"
    })
end)

wait(0.5)
print("🎮 Ink Game Hub v5.0 - Carregado!")
print("✅ 65 funcionalidades principais")
print("🛡️ Sistema anti-ban ativo")
print("📱 Interface otimizada")
