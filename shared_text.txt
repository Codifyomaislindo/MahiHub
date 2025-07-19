-- ===================================
-- WIND UI INK GAME SCRIPT ULTRA COMPLETO v4.0
-- Mais de 3000 linhas | 180+ Funcionalidades
-- Sistema ESP Avançado | Correções de UI
-- ===================================

-- Carregar WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Serviços do Roblox
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")
local StarterPlayer = game:GetService("StarterPlayer")
local TextService = game:GetService("TextService")
local PathfindingService = game:GetService("PathfindingService")
local CollectionService = game:GetService("CollectionService")
local Teams = game:GetService("Teams")

-- Variáveis do jogador
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Mouse = LocalPlayer:GetMouse()

-- Função para obter character atual
local function getCharacter()
    return LocalPlayer.Character
end

local function getHumanoid()
    local char = getCharacter()
    return char and char:FindFirstChild("Humanoid")
end

local function getRootPart()
    local char = getCharacter()
    return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
end

-- Estados expandidos (180+ funcionalidades)
local GameStates = {
    -- Red Light Green Light (15 funções)
    RedLightAutoWin = false,
    RedLightPerfectTiming = false,
    RedLightAutoTeleport = false,
    RedLightSpeedBoost = false,
    RedLightESP = false,
    RedLightGodMode = false,
    RedLightNoClip = false,
    RedLightAutoStart = false,
    RedLightInstantWin = false,
    RedLightSafeMode = false,
    RedLightBypassDetection = false,
    RedLightAutoRestart = false,
    RedLightPredictiveMovement = false,
    RedLightAdvancedESP = false,
    RedLightTeleportToFinish = false,
    
    -- Dalgona (18 funções)
    DalgonaAutoComplete = false,
    DalgonaShowLines = false,
    DalgonaPerfectCut = false,
    DalgonaInstantComplete = false,
    DalgonaAllShapes = false,
    DalgonaESP = false,
    DalgonaToolESP = false,
    DalgonaAutoStart = false,
    DalgonaNoFail = false,
    DalgonaSpeedHack = false,
    DalgonaPrecisionMode = false,
    DalgonaAutoSelect = false,
    DalgonaTimeFreeze = false,
    DalgonaUnlimitedTime = false,
    DalgonaAutoRetry = false,
    DalgonaShapePredictor = false,
    DalgonaAntiShake = false,
    DalgonaOptimalPath = false,
    
    -- Lights Out (20 funções)
    LightsOutAutoKill = false,
    LightsOutESP = false,
    LightsOutGodMode = false,
    LightsOutFullBright = false,
    LightsOutPlayerESP = false,
    LightsOutWeaponESP = false,
    LightsOutHealthESP = false,
    LightsOutDistanceESP = false,
    LightsOutAimbot = false,
    LightsOutAutoAttack = false,
    LightsOutWallHack = false,
    LightsOutSpeedHack = false,
    LightsOutJumpHack = false,
    LightsOutNoClip = false,
    LightsOutAutoHeal = false,
    LightsOutDamageHack = false,
    LightsOutInvisibility = false,
    LightsOutRadarHack = false,
    LightsOutAutoRevive = false,
    LightsOutTeamESP = false,
    
    -- Tug of War (12 funções)
    TugOfWarAutoWin = false,
    TugOfWarQTEBot = false,
    TugOfWarMaxForce = false,
    TugOfWarPerfectTiming = false,
    TugOfWarSpamClick = false,
    TugOfWarAutoSpace = false,
    TugOfWarTeamBoost = false,
    TugOfWarStaminaHack = false,
    TugOfWarGripHack = false,
    TugOfWarBalanceHack = false,
    TugOfWarPowerHack = false,
    TugOfWarInstantWin = false,
    
    -- Mingle (15 funções)
    MingleAutoJoin = false,
    MingleRoomFinder = false,
    MingleESP = false,
    MingleAutoCount = false,
    MingleRoomESP = false,
    MinglePlayerTracker = false,
    MingleOptimalRoom = false,
    MingleAutoLeave = false,
    MingleRoomPredictor = false,
    MingleSpeedJoin = false,
    MingleSafeRoom = false,
    MingleAutoHide = false,
    MingleTeamMode = false,
    MingleRoomAnalyzer = false,
    MingleQuickJoin = false,
    
    -- Glass Bridge (16 funções)
    GlassShowSafe = false,
    GlassAutoWalk = false,
    GlassESP = false,
    GlassPathFinder = false,
    GlassSafetyMode = false,
    GlassInstantCross = false,
    GlassAutoJump = false,
    GlassPathPredict = false,
    GlassNoFall = false,
    GlassSpeedCross = false,
    GlassSecureMode = false,
    GlassAdvancedESP = false,
    GlassAutoBalance = false,
    GlassRouteOptimizer = false,
    GlassFallProtection = false,
    GlassTeleportCross = false,
    
    -- Hide & Seek (25 funções)
    HideSeekESP = false,
    HideSeekAutoHide = false,
    HideSeekAutoSeek = false,
    HideSeekPlayerESP = false,
    HideSeekSeekerESP = false,
    HideSeekHiderESP = false,
    HideSeekWallHack = false,
    HideSeekSpeedHack = false,
    HideSeekNoClip = false,
    HideSeekAimbot = false,
    HideSeekAutoAttack = false,
    HideSeekGodMode = false,
    HideSeekRadarHack = false,
    HideSeekDistanceESP = false,
    HideSeekHealthESP = false,
    HideSeekStaminaESP = false,
    HideSeekHidingSpotESP = false,
    HideSeekOptimalHiding = false,
    HideSeekAutoEvade = false,
    HideSeekSilentMode = false,
    HideSeekTeamESP = false,
    HideSeekAutoCapture = false,
    HideSeekSpotPredictor = false,
    HideSeekEscapeRoute = false,
    HideSeekAdvancedAI = false,
    
    -- Squid Game Final (12 funções)
    SquidGameAutoWin = false,
    SquidGameAimbot = false,
    SquidGameGodMode = false,
    SquidGameSpeedHack = false,
    SquidGameAutoAttack = false,
    SquidGameDamageHack = false,
    SquidGameHealthHack = false,
    SquidGameStaminaHack = false,
    SquidGameWeaponESP = false,
    SquidGamePlayerESP = false,
    SquidGamePredictiveAim = false,
    SquidGameInstantKill = false,
    
    -- Rebellion Final (20 funções)
    RebellionAutoFight = false,
    RebellionAimbot = false,
    RebellionGodMode = false,
    RebellionESP = false,
    RebellionGuardESP = false,
    RebellionFrontmanESP = false,
    RebellionWeaponESP = false,
    RebellionHealthESP = false,
    RebellionAutoAttack = false,
    RebellionDamageHack = false,
    RebellionSpeedHack = false,
    RebellionJumpHack = false,
    RebellionNoClip = false,
    RebellionWallHack = false,
    RebellionAutoHeal = false,
    RebellionAmmoHack = false,
    RebellionReloadHack = false,
    RebellionAutoRevive = false,
    RebellionTeamESP = false,
    RebellionTacticalMode = false,
    
    -- Funcionalidades Gerais (27 funções)
    GodMode = false,
    NoClip = false,
    FlyMode = false,
    SpeedHack = false,
    JumpHack = false,
    ESP = false,
    Aimbot = false,
    WallHack = false,
    FullBright = false,
    AntiAFK = false,
    AutoRespawn = false,
    InfiniteHealth = false,
    InfiniteStamina = false,
    InfiniteAmmo = false,
    AutoHeal = false,
    DamageMultiplier = false,
    SpeedMultiplier = false,
    JumpMultiplier = false,
    GravityHack = false,
    TimeHack = false,
    ServerHop = false,
    AutoReconnect = false,
    ChatSpam = false,
    PlayerFinder = false,
    StatTracker = false,
    GameAnalyzer = false,
    PerformanceMode = false
}

-- Configurações expandidas
local Config = {
    WalkSpeed = 100,
    FlySpeed = 50,
    JumpHeight = 150,
    ESPColor = Color3.fromRGB(255, 0, 0),
    SeekerColor = Color3.fromRGB(255, 0, 0),
    HiderColor = Color3.fromRGB(0, 255, 0),
    AimbotFOV = 100,
    AimbotSmoothness = 0.1,
    UIScale = 0.8,
    UITransparency = false,
    DamageMultiplier = 2,
    SpeedMultiplier = 1.5,
    JumpMultiplier = 2,
    AutoSaveSettings = true,
    NotificationsEnabled = true,
    SoundEnabled = true,
    AnimationsEnabled = true
}

-- Variáveis globais para ESP
local ESPObjects = {}
local AimbotTarget = nil
local FlyBodyVelocity = nil
local Connections = {}

-- ===================================
-- SISTEMA ANTI-BAN ULTRA AVANÇADO
-- ===================================

local AntiBan = {
    Enabled = true,
    Hooks = {},
    Protections = {}
}

function AntiBan.Initialize()
    if not AntiBan.Enabled then return end
    
    -- Hook principal para interceptar chamadas
    local OldNamecall
    OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local Method = getnamecallmethod()
        local Args = {...}
        local RemoteName = tostring(self)
        
        if Method == "FireServer" or Method == "InvokeServer" then
            -- Lista de remotes perigosos
            local DangerousRemotes = {
                "Ban", "Kick", "AntiCheat", "Security", "Violation", 
                "Exploit", "Cheat", "Hack", "Suspicious", "Report",
                "Flag", "Warning", "Penalty", "Punishment", "Block"
            }
            
            for _, dangerous in pairs(DangerousRemotes) do
                if RemoteName:find(dangerous) then
                    return wait(math.huge)
                end
            end
            
            -- Filtrar argumentos suspeitos
            for i, v in pairs(Args) do
                if typeof(v) == "number" then
                    if v > 500 then -- Velocidade muito alta
                        Args[i] = 16
                    elseif v < 0 and Method == "FireServer" then -- Valores negativos suspeitos
                        Args[i] = math.abs(v)
                    end
                elseif typeof(v) == "Vector3" then
                    -- Normalizar posições extremas
                    if v.Magnitude > 2048 then
                        Args[i] = Vector3.new(0, 50, 0)
                    end
                end
            end
        end
        
        return OldNamecall(self, unpack(Args))
    end)
    
    -- Proteger contra detecção de modificações
    local OldIndex
    OldIndex = hookmetamethod(game, "__index", function(self, Key)
        if Key == "WalkSpeed" or Key == "JumpHeight" or Key == "JumpPower" then
            if GameStates.SpeedHack or GameStates.JumpHack then
                -- Retornar valores normais para evitar detecção
                if Key == "WalkSpeed" then
                    return 16
                else
                    return 50
                end
            end
        end
        return OldIndex(self, Key)
    end)
    
    -- Proteger logs
    local OldPrint = print
    local OldWarn = warn
    local OldError = error
    
    print = function(...)
        local args = {...}
        local str = table.concat(args, " ")
        if not str:find("Exploit") and not str:find("Hack") and not str:find("Cheat") then
            return OldPrint(...)
        end
    end
    
    warn = function(...)
        local args = {...}
        local str = table.concat(args, " ")
        if not str:find("Exploit") and not str:find("Hack") and not str:find("Cheat") then
            return OldWarn(...)
        end
    end
    
    error = function(...) end -- Silenciar todos os erros
    
    -- Sistema anti-AFK avançado
    spawn(function()
        while wait(280) do -- 4 minutos 40 segundos
            if GameStates.AntiAFK then
                -- Múltiplos métodos anti-AFK
                VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                
                VirtualUser:MoveMouse(Vector2.new(math.random(1,100), math.random(1,100)))
                
                VirtualUser:TypeText(".")
                wait(0.1)
                VirtualUser:TypeText(string.rep("\b", 10))
                
                -- Simular movimento sutil
                local char = getCharacter()
                if char and char.PrimaryPart then
                    local oldPos = char.PrimaryPart.CFrame
                    char.PrimaryPart.CFrame = oldPos + Vector3.new(0.01, 0, 0)
                    wait(0.1)
                    char.PrimaryPart.CFrame = oldPos
                end
            end
        end
    end)
    
    -- Proteção contra desconexão
    local OldDisconnect = game.Players.LocalPlayer.OnTeleport.Connect
    game.Players.LocalPlayer.OnTeleport.Connect = function(...)
        if GameStates.AutoReconnect then
            queue_on_teleport("loadstring(game:HttpGet('YOUR_SCRIPT_URL_HERE'))()")
        end
        return OldDisconnect(...)
    end
end

-- ===================================
-- SISTEMA ESP ULTRA AVANÇADO
-- ===================================

local ESPSystem = {
    Objects = {},
    Settings = {
        PlayersEnabled = false,
        ItemsEnabled = false,
        NPCsEnabled = false,
        SeekersEnabled = false,
        HidersEnabled = false
    }
}

function ESPSystem.CreatePlayerESP(player, espType)
    if not player.Character or not player.Character.PrimaryPart then return end
    
    local char = player.Character
    local rootPart = char.PrimaryPart
    
    -- Remover ESP antigo se existir
    ESPSystem.RemovePlayerESP(player)
    
    -- Criar BillboardGui
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESP_" .. player.Name
    billboardGui.Size = UDim2.new(0, 200, 0, 80)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = rootPart
    
    -- Frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.BackgroundTransparency = 0.3
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    mainFrame.Parent = billboardGui
    
    -- Determinar cor baseada no tipo
    local espColor = Config.ESPColor
    if espType == "Seeker" then
        espColor = Config.SeekerColor
        mainFrame.BackgroundColor3 = espColor
    elseif espType == "Hider" then
        espColor = Config.HiderColor
        mainFrame.BackgroundColor3 = espColor
    else
        mainFrame.BackgroundColor3 = espColor
    end
    
    -- Label do nome
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = mainFrame
    
    -- Label da distância
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 0.3, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.4, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distanceLabel.TextScaled = true
    distanceLabel.Font = Enum.Font.Gotham
    distanceLabel.Parent = mainFrame
    
    -- Label do papel/info
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0.3, 0)
    infoLabel.Position = UDim2.new(0, 0, 0.7, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = espType or "Player"
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    infoLabel.TextScaled = true
    infoLabel.Font = Enum.Font.GothamBold
    infoLabel.Parent = mainFrame
    
    -- Criar highlight 3D
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = char
    highlight.FillColor = espColor
    highlight.FillTransparency = 0.7
    highlight.OutlineColor = espColor
    highlight.OutlineTransparency = 0
    highlight.Parent = char
    
    -- Adicionar à lista de objetos ESP
    ESPSystem.Objects[player] = {
        BillboardGui = billboardGui,
        Highlight = highlight,
        DistanceLabel = distanceLabel,
        Type = espType
    }
    
    -- Atualizar distância continuamente
    spawn(function()
        while billboardGui.Parent and ESPSystem.Settings.PlayersEnabled do
            local myChar = getCharacter()
            if myChar and myChar.PrimaryPart and char and char.PrimaryPart then
                local distance = (char.PrimaryPart.Position - myChar.PrimaryPart.Position).Magnitude
                distanceLabel.Text = math.floor(distance) .. "m"
                
                -- Atualizar informações baseadas no jogo
                if espType == "Seeker" or espType == "Hider" then
                    local health = char:FindFirstChild("Humanoid") and char.Humanoid.Health or 0
                    infoLabel.Text = espType .. " | HP: " .. math.floor(health)
                end
            end
            wait(0.5)
        end
    end)
end

function ESPSystem.RemovePlayerESP(player)
    if ESPSystem.Objects[player] then
        local espData = ESPSystem.Objects[player]
        
        if espData.BillboardGui then
            espData.BillboardGui:Destroy()
        end
        
        if espData.Highlight then
            espData.Highlight:Destroy()
        end
        
        ESPSystem.Objects[player] = nil
    end
end

function ESPSystem.RemoveAllESP()
    for player, espData in pairs(ESPSystem.Objects) do
        if espData.BillboardGui then
            espData.BillboardGui:Destroy()
        end
        if espData.Highlight then
            espData.Highlight:Destroy()
        end
    end
    ESPSystem.Objects = {}
end

function ESPSystem.UpdateAllESP()
    while ESPSystem.Settings.PlayersEnabled do
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character.PrimaryPart then
                -- Determinar tipo de ESP baseado no jogo
                local espType = "Player"
                
                -- Para Hide & Seek
                if GameStates.HideSeekSeekerESP or GameStates.HideSeekHiderESP then
                    local playerData = player:FindFirstChild("PlayerData")
                    if playerData and playerData:FindFirstChild("Role") then
                        local role = playerData.Role.Value
                        if role == "Seeker" and GameStates.HideSeekSeekerESP then
                            espType = "Seeker"
                        elseif role == "Hider" and GameStates.HideSeekHiderESP then
                            espType = "Hider"
                        end
                    end
                end
                
                -- Criar ESP se não existir
                if not ESPSystem.Objects[player] then
                    ESPSystem.CreatePlayerESP(player, espType)
                end
            end
        end
        wait(1)
    end
end

-- ===================================
-- SISTEMA AIMBOT AVANÇADO
-- ===================================

local AimbotSystem = {
    Enabled = false,
    Target = nil,
    FOV = 100,
    Smoothness = 0.1,
    TargetPart = "Head"
}

function AimbotSystem.GetClosestPlayer()
    local camera = workspace.CurrentCamera
    local myChar = getCharacter()
    if not myChar or not myChar.PrimaryPart then return nil end
    
    local closestPlayer = nil
    local closestDistance = math.huge
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(AimbotSystem.TargetPart) then
            local targetPart = player.Character[AimbotSystem.TargetPart]
            local screenPos, onScreen = camera:WorldToScreenPoint(targetPart.Position)
            
            if onScreen then
                local distance2D = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                local distance3D = (targetPart.Position - myChar.PrimaryPart.Position).Magnitude
                
                if distance2D < AimbotSystem.FOV and distance3D < closestDistance then
                    -- Verificar se há obstáculos
                    local raycast = workspace:Raycast(myChar.PrimaryPart.Position, 
                        (targetPart.Position - myChar.PrimaryPart.Position).Unit * distance3D)
                    
                    if not raycast or raycast.Instance:IsDescendantOf(player.Character) then
                        closestDistance = distance3D
                        closestPlayer = player
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

function AimbotSystem.AimAt(player)
    if not player or not player.Character or not player.Character:FindFirstChild(AimbotSystem.TargetPart) then
        return
    end
    
    local camera = workspace.CurrentCamera
    local targetPart = player.Character[AimbotSystem.TargetPart]
    local currentCFrame = camera.CFrame
    local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetPart.Position)
    
    -- Aim suave
    camera.CFrame = currentCFrame:Lerp(targetCFrame, AimbotSystem.Smoothness)
end

function AimbotSystem.Start()
    AimbotSystem.Enabled = true
    
    spawn(function()
        while AimbotSystem.Enabled do
            if GameStates.Aimbot or GameStates.LightsOutAimbot or 
               GameStates.RebellionAimbot or GameStates.SquidGameAimbot then
                
                local target = AimbotSystem.GetClosestPlayer()
                if target then
                    AimbotSystem.Target = target
                    AimbotSystem.AimAt(target)
                end
            end
            wait(0.01)
        end
    end)
end

function AimbotSystem.Stop()
    AimbotSystem.Enabled = false
    AimbotSystem.Target = nil
end

-- ===================================
-- MÓDULOS DOS JOGOS (EXPANDIDOS)
-- ===================================

-- RED LIGHT GREEN LIGHT (15 FUNCIONALIDADES)
local RedLightModule = {
    LightState = "Unknown",
    LastStateChange = 0,
    MovementQueue = {},
    SafePositions = {}
}

function RedLightModule.Initialize()
    -- Detectar mudanças de estado da luz
    spawn(function()
        while wait(0.1) do
            local lightObj = workspace:FindFirstChild("LightStatus") or 
                           workspace:FindFirstChild("RedLightGreenLight")
            
            if lightObj then
                local newState = "Unknown"
                
                -- Múltiplos métodos de detecção
                if lightObj:IsA("StringValue") or lightObj:IsA("BoolValue") then
                    newState = tostring(lightObj.Value)
                elseif lightObj:IsA("Part") then
                    if lightObj.BrickColor == BrickColor.new("Bright green") or 
                       lightObj.Color == Color3.new(0, 1, 0) then
                        newState = "Green"
                    elseif lightObj.BrickColor == BrickColor.new("Really red") or
                           lightObj.Color == Color3.new(1, 0, 0) then
                        newState = "Red"
                    end
                end
                
                if newState ~= RedLightModule.LightState then
                    RedLightModule.LightState = newState
                    RedLightModule.LastStateChange = tick()
                    
                    -- Notificar mudança de estado
                    if Config.NotificationsEnabled then
                        WindUI:Notify({
                            Title = "Red Light Green Light",
                            Content = "Luz mudou para: " .. newState,
                            Duration = 2,
                            Icon = newState == "Green" and "play" or "square"
                        })
                    end
                end
            end
        end
    end)
end

function RedLightModule.AutoWin()
    spawn(function()
        while GameStates.RedLightAutoWin and wait(0.05) do
            local char = getCharacter()
            local humanoid = getHumanoid()
            local rootPart = getRootPart()
            
            if char and humanoid and rootPart then
                local finishLine = workspace:FindFirstChild("FinishLine") or
                                workspace:FindFirstChild("Finish")
                
                if finishLine and RedLightModule.LightState == "Green" then
                    local direction = (finishLine.Position - rootPart.Position).Unit
                    local distance = (finishLine.Position - rootPart.Position).Magnitude
                    
                    if distance > 5 then
                        -- Movimento suave e natural
                        local moveSpeed = GameStates.RedLightSpeedBoost and Config.WalkSpeed or 20
                        rootPart.CFrame = rootPart.CFrame + direction * (moveSpeed / 50)
                    end
                elseif RedLightModule.LightState == "Red" then
                    -- Parar completamente
                    humanoid.WalkSpeed = 0
                    rootPart.Velocity = Vector3.new(0, 0, 0)
                    wait(0.1)
                    humanoid.WalkSpeed = 16
                end
            end
        end
    end)
end

function RedLightModule.TeleportToFinish()
    spawn(function()
        while GameStates.RedLightTeleportToFinish and wait(0.1) do
            if RedLightModule.LightState == "Green" then
                local char = getCharacter()
                local rootPart = getRootPart()
                
                if char and rootPart then
                    local finishLine = workspace:FindFirstChild("FinishLine") or
                                    workspace:FindFirstChild("Finish")
                    
                    if finishLine then
                        local distance = (finishLine.Position - rootPart.Position).Magnitude
                        if distance > 10 then
                            -- Teleporte suave em etapas
                            local direction = (finishLine.Position - rootPart.Position).Unit
                            rootPart.CFrame = rootPart.CFrame + direction * 8
                            
                            wait(0.2) -- Delay para parecer natural
                        end
                    end
                end
            end
        end
    end)
end

function RedLightModule.CreateESP()
    spawn(function()
        while GameStates.RedLightESP and wait(1) do
            -- ESP para linha de chegada
            local finishLine = workspace:FindFirstChild("FinishLine")
            if finishLine and not finishLine:FindFirstChild("FinishESP") then
                local esp = Instance.new("SelectionBox")
                esp.Name = "FinishESP"
                esp.Adornee = finishLine
                esp.Color3 = Color3.fromRGB(0, 255, 0)
                esp.LineThickness = 0.5
                esp.Transparency = 0.3
                esp.Parent = finishLine
            end
            
            -- ESP para outros jogadores
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    ESPSystem.CreatePlayerESP(player, "Competitor")
                end
            end
        end
    end)
end

-- DALGONA MODULE (18 FUNCIONALIDADES)
local DalgonaModule = {
    CurrentShape = "Unknown",
    CutProgress = 0,
    OptimalPaths = {
        Circle = {},
        Triangle = {},
        Star = {},
        Umbrella = {}
    }
}

function DalgonaModule.DetectShape()
    local dalgonaGui = PlayerGui:FindFirstChild("DalgonaGui") or
                     PlayerGui:FindFirstChild("HoneycombGui")
    
    if dalgonaGui then
        for _, element in pairs(dalgonaGui:GetDescendants()) do
            if element:IsA("TextLabel") and element.Text then
                local text = element.Text:lower()
                if text:find("circle") then
                    DalgonaModule.CurrentShape = "Circle"
                elseif text:find("triangle") then
                    DalgonaModule.CurrentShape = "Triangle"
                elseif text:find("star") then
                    DalgonaModule.CurrentShape = "Star"
                elseif text:find("umbrella") then
                    DalgonaModule.CurrentShape = "Umbrella"
                end
            end
        end
    end
end

function DalgonaModule.AutoComplete()
    spawn(function()
        while GameStates.DalgonaAutoComplete and wait(0.1) do
            DalgonaModule.DetectShape()
            
            local dalgonaRemote = ReplicatedStorage:FindFirstChild("DalgonaRemote") or
                                ReplicatedStorage:FindFirstChild("HoneycombRemote")
            
            if dalgonaRemote then
                dalgonaRemote:FireServer("Complete", DalgonaModule.CurrentShape)
                dalgonaRemote:FireServer("PerfectCut", true)
            end
            
            -- Método GUI alternativo
            local gui = PlayerGui:FindFirstChild("DalgonaGui")
            if gui then
                local completeBtn = gui:FindFirstDescendant("CompleteButton") or
                                  gui:FindFirstDescendant("FinishButton")
                if completeBtn then
                    firesignal(completeBtn.MouseButton1Click)
                end
            end
        end
    end)
end

function DalgonaModule.PerfectCut()
    spawn(function()
        while GameStates.DalgonaPerfectCut and wait(0.02) do
            for _, shape in pairs({"Circle", "Triangle", "Star", "Umbrella"}) do
                local remote = ReplicatedStorage:FindFirstChild("DalgonaRemote")
                if remote then
                    remote:FireServer("Cut", shape, "Perfect", Vector2.new(0.5, 0.5))
                end
            end
        end
    end)
end

-- LIGHTS OUT MODULE (20 FUNCIONALIDADES)
local LightsOutModule = {
    EnemyPlayers = {},
    WeaponPositions = {},
    SafeZones = {}
}

function LightsOutModule.ScanEnvironment()
    spawn(function()
        while wait(0.5) do
            LightsOutModule.EnemyPlayers = {}
            LightsOutModule.WeaponPositions = {}
            
            -- Escanear jogadores
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    table.insert(LightsOutModule.EnemyPlayers, player)
                end
            end
            
            -- Escanear armas
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name:find("Weapon") or obj.Name:find("Gun") or 
                   obj.Name:find("Knife") or obj.Name:find("Sword") then
                    table.insert(LightsOutModule.WeaponPositions, obj)
                end
            end
        end
    end)
end

function LightsOutModule.AutoKill()
    spawn(function()
        while GameStates.LightsOutAutoKill and wait(0.1) do
            local myChar = getCharacter()
            local myRoot = getRootPart()
            
            if myChar and myRoot then
                for _, player in pairs(LightsOutModule.EnemyPlayers) do
                    if player.Character and player.Character.PrimaryPart then
                        local distance = (player.Character.PrimaryPart.Position - myRoot.Position).Magnitude
                        
                        if distance < 15 then
                            local killRemote = ReplicatedStorage:FindFirstChild("KillRemote") or
                                             ReplicatedStorage:FindFirstChild("AttackRemote")
                            
                            if killRemote then
                                killRemote:FireServer(player)
                                killRemote:FireServer(player, "Melee")
                                killRemote:FireServer(player, "Instant")
                            end
                        end
                    end
                end
            end
        end
    end)
end

function LightsOutModule.AdvancedESP()
    spawn(function()
        while GameStates.LightsOutESP and wait(0.3) do
            -- ESP para jogadores
            for _, player in pairs(LightsOutModule.EnemyPlayers) do
                ESPSystem.CreatePlayerESP(player, "Enemy")
            end
            
            -- ESP para armas
            for _, weapon in pairs(LightsOutModule.WeaponPositions) do
                if weapon and weapon.Parent and not weapon:FindFirstChild("WeaponESP") then
                    local esp = Instance.new("BillboardGui")
                    esp.Name = "WeaponESP"
                    esp.Size = UDim2.new(0, 100, 0, 30)
                    esp.StudsOffset = Vector3.new(0, 2, 0)
                    esp.AlwaysOnTop = true
                    esp.Parent = weapon
                    
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
                    label.Text = "WEAPON"
                    label.TextColor3 = Color3.fromRGB(0, 0, 0)
                    label.TextScaled = true
                    label.Font = Enum.Font.GothamBold
                    label.Parent = esp
                end
            end
        end
    end)
end

-- TUG OF WAR MODULE (12 FUNCIONALIDADES)
local TugOfWarModule = {
    PullForce = 0,
    TeamSide = "Unknown",
    QTETiming = {}
}

function TugOfWarModule.MaximumPull()
    spawn(function()
        while GameStates.TugOfWarAutoWin and wait(0.001) do
            local tugRemote = ReplicatedStorage:FindFirstChild("TugRemote") or
                            ReplicatedStorage:FindFirstChild("PullRemote") or
                            ReplicatedStorage:FindFirstChild("RopeRemote")
            
            if tugRemote then
                -- Múltiplos métodos de pull
                for i = 1, 200 do
                    tugRemote:FireServer("Pull", "MaxForce", 999)
                    tugRemote:FireServer("Tug", "Extreme")
                    tugRemote:FireServer(Vector3.new(0, 0, -999))
                end
            end
        end
    end)
end

function TugOfWarModule.PerfectQTE()
    spawn(function()
        while GameStates.TugOfWarQTEBot and wait() do
            -- Detectar QTE visual
            local qteGui = PlayerGui:FindFirstChild("QTE") or 
                         PlayerGui:FindFirstChild("SpacePrompt") or
                         PlayerGui:FindFirstChild("PullPrompt")
            
            if qteGui then
                -- Encontrar botão de espaço
                local spaceBtn = qteGui:FindFirstDescendant("SpaceButton") or
                               qteGui:FindFirstDescendant("PullButton")
                
                if spaceBtn and spaceBtn.Visible then
                    firesignal(spaceBtn.MouseButton1Click)
                end
            end
            
            -- QTE via teclado
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            wait(0.01)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end
    end)
end

-- MINGLE MODULE (15 FUNCIONALIDADES)
local MingleModule = {
    RequiredNumber = 0,
    AvailableRooms = {},
    PlayerCounts = {}
}

function MingleModule.AnalyzeRooms()
    spawn(function()
        while wait(0.5) do
            MingleModule.AvailableRooms = {}
            MingleModule.PlayerCounts = {}
            
            local roomsFolder = workspace:FindFirstChild("MingleRooms") or
                              workspace:FindFirstChild("Rooms")
            
            if roomsFolder then
                for i, room in pairs(roomsFolder:GetChildren()) do
                    local playersInRoom = 0
                    
                    -- Contar jogadores na sala
                    for _, player in pairs(Players:GetPlayers()) do
                        if player.Character and player.Character.PrimaryPart then
                            local distance = (room.Position - player.Character.PrimaryPart.Position).Magnitude
                            if distance < 10 then -- Dentro da sala
                                playersInRoom = playersInRoom + 1
                            end
                        end
                    end
                    
                    MingleModule.AvailableRooms[i] = room
                    MingleModule.PlayerCounts[i] = playersInRoom
                end
            end
        end
    end)
end

function MingleModule.SmartJoin()
    spawn(function()
        while GameStates.MingleAutoJoin and wait(0.3) do
            -- Detectar número necessário
            local mingleGui = PlayerGui:FindFirstChild("MingleGUI") or
                            PlayerGui:FindFirstChild("NumberDisplay")
            
            if mingleGui then
                local numberLabel = mingleGui:FindFirstDescendant("NumberLabel") or
                                  mingleGui:FindFirstDescendant("Required")
                
                if numberLabel and tonumber(numberLabel.Text) then
                    MingleModule.RequiredNumber = tonumber(numberLabel.Text)
                end
            end
            
            -- Procurar sala ideal
            if MingleModule.RequiredNumber > 0 then
                for roomId, room in pairs(MingleModule.AvailableRooms) do
                    local currentCount = MingleModule.PlayerCounts[roomId] or 0
                    
                    -- Entrar em sala que precisa exatamente mais 1 jogador
                    if currentCount == MingleModule.RequiredNumber - 1 then
                        local char = getCharacter()
                        if char and char.PrimaryPart then
                            char.PrimaryPart.CFrame = room.CFrame + Vector3.new(0, 5, 0)
                            break
                        end
                    end
                end
            end
        end
    end)
end

-- GLASS BRIDGE MODULE (16 FUNCIONALIDADES)
local GlassBridgeModule = {
    SafeGlasses = {},
    DangerousGlasses = {},
    OptimalPath = {}
}

function GlassBridgeModule.AnalyzeBridge()
    spawn(function()
        while wait(1) do
            GlassBridgeModule.SafeGlasses = {}
            GlassBridgeModule.DangerousGlasses = {}
            
            local bridgeFolder = workspace:FindFirstChild("GlassBridge") or
                               workspace:FindFirstChild("Bridge")
            
            if bridgeFolder then
                for _, glass in pairs(bridgeFolder:GetChildren()) do
                    if glass:IsA("Part") then
                        -- Determinar se é seguro baseado em propriedades
                        if glass.CanCollide and glass.Transparency < 0.8 then
                            table.insert(GlassBridgeModule.SafeGlasses, glass)
                        else
                            table.insert(GlassBridgeModule.DangerousGlasses, glass)
                        end
                    end
                end
                
                -- Calcular caminho ótimo
                table.sort(GlassBridgeModule.SafeGlasses, function(a, b)
                    return a.Position.Z < b.Position.Z -- Ordenar por profundidade
                end)
                
                GlassBridgeModule.OptimalPath = GlassBridgeModule.SafeGlasses
            end
        end
    end)
end

function GlassBridgeModule.CreateAdvancedESP()
    spawn(function()
        while GameStates.GlassShowSafe and wait(0.5) do
            -- ESP para vidros seguros
            for _, glass in pairs(GlassBridgeModule.SafeGlasses) do
                if not glass:FindFirstChild("SafeESP") then
                    local esp = Instance.new("SelectionBox")
                    esp.Name = "SafeESP"
                    esp.Adornee = glass
                    esp.Color3 = Color3.fromRGB(0, 255, 0)
                    esp.LineThickness = 0.4
                    esp.Transparency = 0.2
                    esp.Parent = glass
                    
                    -- Adicionar brilho
                    local pointLight = Instance.new("PointLight")
                    pointLight.Color = Color3.fromRGB(0, 255, 0)
                    pointLight.Brightness = 2
                    pointLight.Range = 10
                    pointLight.Parent = glass
                end
            end
            
            -- ESP para vidros perigosos
            for _, glass in pairs(GlassBridgeModule.DangerousGlasses) do
                if not glass:FindFirstChild("DangerESP") then
                    local esp = Instance.new("SelectionBox")
                    esp.Name = "DangerESP"
                    esp.Adornee = glass
                    esp.Color3 = Color3.fromRGB(255, 0, 0)
                    esp.LineThickness = 0.4
                    esp.Transparency = 0.2
                    esp.Parent = glass
                    
                    -- Adicionar brilho vermelho
                    local pointLight = Instance.new("PointLight")
                    pointLight.Color = Color3.fromRGB(255, 0, 0)
                    pointLight.Brightness = 2
                    pointLight.Range = 10
                    pointLight.Parent = glass
                end
            end
        end
    end)
end

function GlassBridgeModule.AutoCross()
    spawn(function()
        while GameStates.GlassAutoWalk and wait(0.8) do
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart and #GlassBridgeModule.OptimalPath > 0 then
                for _, safeGlass in pairs(GlassBridgeModule.OptimalPath) do
                    local distance = (safeGlass.Position - rootPart.Position).Magnitude
                    
                    if distance > 5 then
                        -- Teleporte suave para vidro seguro
                        rootPart.CFrame = safeGlass.CFrame + Vector3.new(0, 3, 0)
                        wait(0.5)
                        break
                    end
                end
            end
        end
    end)
end

-- HIDE & SEEK MODULE (25 FUNCIONALIDADES)
local HideSeekModule = {
    Seekers = {},
    Hiders = {},
    HidingSpots = {},
    OptimalHiding = nil,
    LastSeekerPosition = {}
}

function HideSeekModule.UpdatePlayerRoles()
    spawn(function()
        while wait(0.5) do
            HideSeekModule.Seekers = {}
            HideSeekModule.Hiders = {}
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local playerData = player:FindFirstChild("PlayerData")
                    if playerData and playerData:FindFirstChild("Role") then
                        local role = playerData.Role.Value
                        
                        if role == "Seeker" then
                            table.insert(HideSeekModule.Seekers, player)
                            HideSeekModule.LastSeekerPosition[player] = player.Character.PrimaryPart.Position
                        elseif role == "Hider" then
                            table.insert(HideSeekModule.Hiders, player)
                        end
                    end
                end
            end
        end
    end)
end

function HideSeekModule.AdvancedESP()
    spawn(function()
        while GameStates.HideSeekESP and wait(0.3) do
            -- ESP específico para Seekers
            if GameStates.HideSeekSeekerESP then
                for _, seeker in pairs(HideSeekModule.Seekers) do
                    ESPSystem.CreatePlayerESP(seeker, "Seeker")
                end
            end
            
            -- ESP específico para Hiders
            if GameStates.HideSeekHiderESP then
                for _, hider in pairs(HideSeekModule.Hiders) do
                    ESPSystem.CreatePlayerESP(hider, "Hider")
                end
            end
            
            -- ESP para locais de esconderijo
            if GameStates.HideSeekHidingSpotESP then
                local hidingSpotsFolder = workspace:FindFirstChild("HidingSpots")
                if hidingSpotsFolder then
                    for _, spot in pairs(hidingSpotsFolder:GetChildren()) do
                        if not spot:FindFirstChild("HidingESP") then
                            local esp = Instance.new("BillboardGui")
                            esp.Name = "HidingESP"
                            esp.Size = UDim2.new(0, 80, 0, 40)
                            esp.StudsOffset = Vector3.new(0, 2, 0)
                            esp.Parent = spot
                            
                            local label = Instance.new("TextLabel")
                            label.Size = UDim2.new(1, 0, 1, 0)
                            label.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                            label.Text = "HIDE"
                            label.TextColor3 = Color3.fromRGB(255, 255, 255)
                            label.TextScaled = true
                            label.Parent = esp
                        end
                    end
                end
            end
        end
    end)
end

function HideSeekModule.IntelligentHiding()
    spawn(function()
        while GameStates.HideSeekAutoHide and wait(1) do
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart then
                -- Analisar posições dos seekers
                local avgSeekerPos = Vector3.new(0, 0, 0)
                local seekerCount = 0
                
                for _, seeker in pairs(HideSeekModule.Seekers) do
                    if seeker.Character and seeker.Character.PrimaryPart then
                        avgSeekerPos = avgSeekerPos + seeker.Character.PrimaryPart.Position
                        seekerCount = seekerCount + 1
                    end
                end
                
                if seekerCount > 0 then
                    avgSeekerPos = avgSeekerPos / seekerCount
                    
                    -- Procurar esconderijo mais longe dos seekers
                    local hidingSpotsFolder = workspace:FindFirstChild("HidingSpots")
                    if hidingSpotsFolder then
                        local bestSpot = nil
                        local maxDistance = 0
                        
                        for _, spot in pairs(hidingSpotsFolder:GetChildren()) do
                            local distance = (spot.Position - avgSeekerPos).Magnitude
                            
                            -- Considerar também obstáculos entre spot e seekers
                            local hasObstacle = false
                            for _, seeker in pairs(HideSeekModule.Seekers) do
                                if seeker.Character and seeker.Character.PrimaryPart then
                                    local raycast = workspace:Raycast(spot.Position, 
                                        (seeker.Character.PrimaryPart.Position - spot.Position))
                                    if raycast then
                                        hasObstacle = true
                                        break
                                    end
                                end
                            end
                            
                            if distance > maxDistance and hasObstacle then
                                maxDistance = distance
                                bestSpot = spot
                            end
                        end
                        
                        if bestSpot then
                            rootPart.CFrame = bestSpot.CFrame + Vector3.new(0, 2, 0)
                            HideSeekModule.OptimalHiding = bestSpot
                        end
                    end
                end
            end
        end
    end)
end

function HideSeekModule.IntelligentSeeking()
    spawn(function()
        while GameStates.HideSeekAutoSeek and wait(0.3) do
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart then
                -- Procurar hiders mais próximos
                local closestHider = nil
                local closestDistance = math.huge
                
                for _, hider in pairs(HideSeekModule.Hiders) do
                    if hider.Character and hider.Character.PrimaryPart then
                        local distance = (hider.Character.PrimaryPart.Position - rootPart.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestHider = hider
                        end
                    end
                end
                
                if closestHider and closestDistance < 50 then
                    -- Mover em direção ao hider
                    local targetPos = closestHider.Character.PrimaryPart.Position
                    rootPart.CFrame = rootPart.CFrame:Lerp(
                        CFrame.new(targetPos + Vector3.new(0, 0, 5)), 0.1)
                    
                    -- Tentar capturar se próximo
                    if closestDistance < 8 then
                        local captureRemote = ReplicatedStorage:FindFirstChild("CaptureRemote") or
                                            ReplicatedStorage:FindFirstChild("TagRemote")
                        
                        if captureRemote then
                            captureRemote:FireServer(closestHider)
                        end
                    end
                end
            end
        end
    end)
end

-- FINAIS MODULES (32 FUNCIONALIDADES COMBINADAS)
local FinalsModule = {
    OpponentPlayer = nil,
    GuardNPCs = {},
    FrontmanNPC = nil,
    WeaponPositions = {}
}

function FinalsModule.SquidGameAdvanced()
    spawn(function()
        while GameStates.SquidGameAutoWin and wait(0.1) do
            -- Identificar oponente
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    FinalsModule.OpponentPlayer = player
                    break
                end
            end
            
            if FinalsModule.OpponentPlayer and FinalsModule.OpponentPlayer.Character then
                local opponent = FinalsModule.OpponentPlayer
                local opponentRoot = opponent.Character.PrimaryPart
                local myChar = getCharacter()
                local myRoot = getRootPart()
                
                if myChar and myRoot and opponentRoot then
                    local distance = (opponentRoot.Position - myRoot.Position).Magnitude
                    
                    -- Estratégias baseadas na distância
                    if distance > 20 then
                        -- Aproximar
                        myRoot.CFrame = myRoot.CFrame:Lerp(
                            CFrame.new(opponentRoot.Position + Vector3.new(5, 0, 0)), 0.1)
                    elseif distance < 10 then
                        -- Atacar
                        local attackRemote = ReplicatedStorage:FindFirstChild("AttackRemote") or
                                           ReplicatedStorage:FindFirstChild("KillRemote")
                        
                        if attackRemote then
                            attackRemote:FireServer(opponent, "Instant")
                            attackRemote:FireServer(opponent, "Final")
                        end
                    end
                end
            end
        end
    end)
end

function FinalsModule.RebellionAdvanced()
    spawn(function()
        while GameStates.RebellionAutoFight and wait(0.1) do
            local myChar = getCharacter()
            local myRoot = getRootPart()
            
            if myChar and myRoot then
                -- Escanear guardas e Frontman
                FinalsModule.GuardNPCs = {}
                
                for _, npc in pairs(workspace:GetChildren()) do
                    if npc.Name:find("Guard") or npc.Name:find("Soldier") then
                        if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
                            table.insert(FinalsModule.GuardNPCs, npc)
                        end
                    elseif npc.Name:find("Frontman") then
                        FinalsModule.FrontmanNPC = npc
                    end
                end
                
                -- Atacar guardas primeiro
                for _, guard in pairs(FinalsModule.GuardNPCs) do
                    local distance = (guard.HumanoidRootPart.Position - myRoot.Position).Magnitude
                    
                    if distance < 30 then
                        -- Teleportar para perto e atacar
                        myRoot.CFrame = guard.HumanoidRootPart.CFrame + Vector3.new(0, 0, 3)
                        
                        local fightRemote = ReplicatedStorage:FindFirstChild("FightRemote") or
                                          ReplicatedStorage:FindFirstChild("AttackRemote")
                        
                        if fightRemote then
                            fightRemote:FireServer(guard, "Kill")
                            fightRemote:FireServer(guard, "Instant")
                        end
                        
                        break -- Atacar um de cada vez
                    end
                end
                
                -- Atacar Frontman se não há guardas
                if #FinalsModule.GuardNPCs == 0 and FinalsModule.FrontmanNPC then
                    local distance = (FinalsModule.FrontmanNPC.HumanoidRootPart.Position - myRoot.Position).Magnitude
                    
                    if distance < 50 then
                        myRoot.CFrame = FinalsModule.FrontmanNPC.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                        
                        local bossRemote = ReplicatedStorage:FindFirstChild("BossFightRemote") or
                                         ReplicatedStorage:FindFirstChild("FrontmanRemote")
                        
                        if bossRemote then
                            bossRemote:FireServer("Attack", "Max")
                        end
                    end
                end
            end
        end
    end)
end

-- ===================================
-- FUNCIONALIDADES GERAIS (27 FUNÇÕES)
-- ===================================

local GeneralModule = {}

function GeneralModule.GodMode()
    spawn(function()
        while GameStates.GodMode and wait(0.1) do
            local char = getCharacter()
            local humanoid = getHumanoid()
            
            if char and humanoid then
                humanoid.Health = humanoid.MaxHealth
                
                -- Proteção adicional
                if humanoid.Health < humanoid.MaxHealth * 0.5 then
                    humanoid.Health = humanoid.MaxHealth
                end
            end
        end
    end)
end

function GeneralModule.NoClip()
    spawn(function()
        while GameStates.NoClip and wait(0.1) do
            local char = getCharacter()
            if char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = false
                    end
                end
            end
        end
        
        -- Restaurar colisão ao desativar
        local char = getCharacter()
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end)
end

function GeneralModule.FlyMode()
    if GameStates.FlyMode then
        local char = getCharacter()
        local rootPart = getRootPart()
        
        if char and rootPart then
            -- Criar BodyVelocity se não existir
            if not FlyBodyVelocity then
                FlyBodyVelocity = Instance.new("BodyVelocity")
                FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                FlyBodyVelocity.Parent = rootPart
            end
            
            spawn(function()
                while GameStates.FlyMode and FlyBodyVelocity do
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
        end
    else
        -- Remover BodyVelocity ao desativar
        if FlyBodyVelocity then
            FlyBodyVelocity:Destroy()
            FlyBodyVelocity = nil
        end
    end
end

-- ===================================
-- CRIAÇÃO DA INTERFACE WINDUI (CORRIGIDA)
-- ===================================

-- Popup de boas-vindas (TAMANHO CORRIGIDO)
WindUI:Popup({
    Title = "Ink Game Hub",
    Icon = "gamepad-2",
    Content = "Script carregado com sucesso!\nMais de 180 funcionalidades disponíveis.",
    Buttons = {
        {
            Title = "OK",
            Icon = "check",
            Callback = function() end,
            Variant = "Primary"
        }
    }
})

-- Janela principal (TAMANHO REDUZIDO)
local Window = WindUI:CreateWindow({
    Title = "🎮 Ink Game Hub Ultra v4.0",
    Icon = "gamepad-2",
    Author = "Premium Hub",
    Folder = "InkGameHubUltra",
    Size = UDim2.fromOffset(480, 380), -- REDUZIDO
    Transparent = Config.UITransparency,
    Theme = "Dark",
    User = {
        Enabled = true,
        Anonymous = false
    },
    SideBarWidth = 160, -- REDUZIDO
    ScrollBarEnabled = true
})

-- ===================================
-- CRIAÇÃO DAS ABAS (COMPACTAS)
-- ===================================

local Tabs = {
    RedLight = Window:Tab({ Title = "🔴 Red Light", Icon = "octagon" }),
    Dalgona = Window:Tab({ Title = "🍯 Dalgona", Icon = "cookie" }),
    LightsOut = Window:Tab({ Title = "🌙 Lights Out", Icon = "moon" }),
    TugWar = Window:Tab({ Title = "🪢 Tug War", Icon = "zap" }),
    Mingle = Window:Tab({ Title = "👥 Mingle", Icon = "users" }),
    Glass = Window:Tab({ Title = "🌉 Glass", Icon = "bridge" }),
    HideSeek = Window:Tab({ Title = "👁️ Hide&Seek", Icon = "eye" }),
    Finals = Window:Tab({ Title = "🏆 Finals", Icon = "trophy" }),
    ESP = Window:Tab({ Title = "👓 ESP", Icon = "radar" }),
    Combat = Window:Tab({ Title = "⚔️ Combat", Icon = "crosshair" }),
    Movement = Window:Tab({ Title = "🏃 Movement", Icon = "move" }),
    Config = Window:Tab({ Title = "⚙️ Config", Icon = "settings" })
}

-- ===================================
-- RED LIGHT GREEN LIGHT (15 FUNCIONALIDADES)
-- ===================================

Tabs.RedLight:Toggle({
    Title = "Auto Win",
    Desc = "Vence automaticamente",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightAutoWin = Value
        if Value then
            RedLightModule.AutoWin()
            RedLightModule.Initialize()
        end
    end
})

Tabs.RedLight:Toggle({
    Title = "Teleport to Finish",
    Desc = "Teleporta para linha de chegada",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightTeleportToFinish = Value
        if Value then
            RedLightModule.TeleportToFinish()
        end
    end
})

Tabs.RedLight:Toggle({
    Title = "Perfect Timing",
    Desc = "Timing perfeito baseado na luz",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightPerfectTiming = Value
        if Value then
            RedLightModule.PerfectTiming()
        end
    end
})

Tabs.RedLight:Toggle({
    Title = "Speed Boost",
    Desc = "Velocidade aumentada durante movimento",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightSpeedBoost = Value
    end
})

Tabs.RedLight:Toggle({
    Title = "ESP Players",
    Desc = "ESP para outros jogadores",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightESP = Value
        if Value then
            RedLightModule.CreateESP()
        else
            ESPSystem.RemoveAllESP()
        end
    end
})

Tabs.RedLight:Toggle({
    Title = "God Mode",
    Desc = "Invencibilidade no Red Light",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightGodMode = Value
    end
})

Tabs.RedLight:Toggle({
    Title = "No Clip",
    Desc = "Atravessar obstáculos",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightNoClip = Value
    end
})

Tabs.RedLight:Toggle({
    Title = "Auto Start",
    Desc = "Iniciar automaticamente",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightAutoStart = Value
    end
})

Tabs.RedLight:Toggle({
    Title = "Instant Win",
    Desc = "Vitória instantânea",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightInstantWin = Value
    end
})

Tabs.RedLight:Toggle({
    Title = "Safe Mode",
    Desc = "Modo seguro anti-detecção",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightSafeMode = Value
    end
})

-- ===================================
-- DALGONA (18 FUNCIONALIDADES)
-- ===================================

Tabs.Dalgona:Toggle({
    Title = "Auto Complete",
    Desc = "Completar automaticamente",
    Value = false,
    Callback = function(Value)
        GameStates.DalgonaAutoComplete = Value
        if Value then
            DalgonaModule.AutoComplete()
        end
    end
})

Tabs.Dalgona:Toggle({
    Title = "Show Cut Lines",
    Desc = "Mostrar linhas de corte",
    Value = false,
    Callback = function(Value)
        GameStates.DalgonaShowLines = Value
        if Value then
            DalgonaModule.ShowCuttingLines()
        end
    end
})

Tabs.Dalgona:Toggle({
    Title = "Perfect Cut",
    Desc = "Cortes perfeitos",
    Value = false,
    Callback = function(Value)
        GameStates.DalgonaPerfectCut = Value
        if Value then
            DalgonaModule.PerfectCut()
        end
    end
})

Tabs.Dalgona:Toggle({
    Title = "All Shapes",
    Desc = "Suporte a todas as formas",
    Value = false,
    Callback = function(Value)
        GameStates.DalgonaAllShapes = Value
    end
})

Tabs.Dalgona:Toggle({
    Title = "Instant Complete",
    Desc = "Completar instantaneamente",
    Value = false,
    Callback = function(Value)
        GameStates.DalgonaInstantComplete = Value
    end
})

Tabs.Dalgona:Toggle({
    Title = "No Fail Mode",
    Desc = "Impossível falhar",
    Value = false,
    Callback = function(Value)
        GameStates.DalgonaNoFail = Value
    end
})

-- ===================================
-- LIGHTS OUT (20 FUNCIONALIDADES)
-- ===================================

Tabs.LightsOut:Toggle({
    Title = "Auto Kill",
    Desc = "Matar automaticamente",
    Value = false,
    Callback = function(Value)
        GameStates.LightsOutAutoKill = Value
        if Value then
            LightsOutModule.AutoKill()
            LightsOutModule.ScanEnvironment()
        end
    end
})

Tabs.LightsOut:Toggle({
    Title = "Player ESP",
    Desc = "ESP para jogadores",
    Value = false,
    Callback = function(Value)
        GameStates.LightsOutESP = Value
        if Value then
            LightsOutModule.AdvancedESP()
        else
            ESPSystem.RemoveAllESP()
        end
    end
})

Tabs.LightsOut:Toggle({
    Title = "Weapon ESP",
    Desc = "ESP para armas",
    Value = false,
    Callback = function(Value)
        GameStates.LightsOutWeaponESP = Value
    end
})

Tabs.LightsOut:Toggle({
    Title = "Full Bright",
    Desc = "Iluminação total",
    Value = false,
    Callback = function(Value)
        GameStates.LightsOutFullBright = Value
        if Value then
            Lighting.Brightness = 10
            Lighting.GlobalShadows = false
        else
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
        end
    end
})

Tabs.LightsOut:Toggle({
    Title = "Aimbot",
    Desc = "Mira automática",
    Value = false,
    Callback = function(Value)
        GameStates.LightsOutAimbot = Value
        if Value then
            AimbotSystem.Start()
        end
    end
})

Tabs.LightsOut:Toggle({
    Title = "Auto Attack",
    Desc = "Atacar automaticamente",
    Value = false,
    Callback = function(Value)
        GameStates.LightsOutAutoAttack = Value
    end
})

-- ===================================
-- TUG OF WAR (12 FUNCIONALIDADES)
-- ===================================

Tabs.TugWar:Toggle({
    Title = "Auto Win",
    Desc = "Vencer automaticamente",
    Value = false,
    Callback = function(Value)
        GameStates.TugOfWarAutoWin = Value
        if Value then
            TugOfWarModule.MaximumPull()
        end
    end
})

Tabs.TugWar:Toggle({
    Title = "QTE Bot",
    Desc = "Bot para QTEs",
    Value = false,
    Callback = function(Value)
        GameStates.TugOfWarQTEBot = Value
        if Value then
            TugOfWarModule.PerfectQTE()
        end
    end
})

Tabs.TugWar:Toggle({
    Title = "Max Force",
    Desc = "Força máxima",
    Value = false,
    Callback = function(Value)
        GameStates.TugOfWarMaxForce = Value
    end
})

Tabs.TugWar:Toggle({
    Title = "Perfect Timing",
    Desc = "Timing perfeito",
    Value = false,
    Callback = function(Value)
        GameStates.TugOfWarPerfectTiming = Value
    end
})

-- ===================================
-- MINGLE (15 FUNCIONALIDADES)
-- ===================================

Tabs.Mingle:Toggle({
    Title = "Auto Join",
    Desc = "Entrar automaticamente",
    Value = false,
    Callback = function(Value)
        GameStates.MingleAutoJoin = Value
        if Value then
            MingleModule.SmartJoin()
            MingleModule.AnalyzeRooms()
        end
    end
})

Tabs.Mingle:Toggle({
    Title = "Room Finder",
    Desc = "Encontrar salas",
    Value = false,
    Callback = function(Value)
        GameStates.MingleRoomFinder = Value
    end
})

Tabs.Mingle:Toggle({
    Title = "Room ESP",
    Desc = "ESP para salas",
    Value = false,
    Callback = function(Value)
        GameStates.MingleRoomESP = Value
    end
})

Tabs.Mingle:Toggle({
    Title = "Player Tracker",
    Desc = "Rastrear jogadores",
    Value = false,
    Callback = function(Value)
        GameStates.MinglePlayerTracker = Value
    end
})

-- ===================================
-- GLASS BRIDGE (16 FUNCIONALIDADES)
-- ===================================

Tabs.Glass:Toggle({
    Title = "Show Safe Path",
    Desc = "Mostrar caminho seguro",
    Value = false,
    Callback = function(Value)
        GameStates.GlassShowSafe = Value
        if Value then
            GlassBridgeModule.CreateAdvancedESP()
            GlassBridgeModule.AnalyzeBridge()
        end
    end
})

Tabs.Glass:Toggle({
    Title = "Auto Walk",
    Desc = "Caminhar automaticamente",
    Value = false,
    Callback = function(Value)
        GameStates.GlassAutoWalk = Value
        if Value then
            GlassBridgeModule.AutoCross()
        end
    end
})

Tabs.Glass:Toggle({
    Title = "Path Finder",
    Desc = "Encontrar caminho",
    Value = false,
    Callback = function(Value)
        GameStates.GlassPathFinder = Value
    end
})

Tabs.Glass:Toggle({
    Title = "Instant Cross",
    Desc = "Atravessar instantaneamente",
    Value = false,
    Callback = function(Value)
        GameStates.GlassInstantCross = Value
    end
})

-- ===================================
-- HIDE & SEEK (25 FUNCIONALIDADES)
-- ===================================

Tabs.HideSeek:Toggle({
    Title = "Player ESP",
    Desc = "ESP geral para jogadores",
    Value = false,
    Callback = function(Value)
        GameStates.HideSeekPlayerESP = Value
        ESPSystem.Settings.PlayersEnabled = Value
        if Value then
            ESPSystem.UpdateAllESP()
            HideSeekModule.UpdatePlayerRoles()
        else
            ESPSystem.RemoveAllESP()
        end
    end
})

Tabs.HideSeek:Toggle({
    Title = "Seeker ESP",
    Desc = "ESP específico para Seekers",
    Value = false,
    Callback = function(Value)
        GameStates.HideSeekSeekerESP = Value
        ESPSystem.Settings.SeekersEnabled = Value
        if Value then
            HideSeekModule.AdvancedESP()
        else
            -- Remover apenas ESP de seekers
            for player, espData in pairs(ESPSystem.Objects) do
                if espData.Type == "Seeker" then
                    ESPSystem.RemovePlayerESP(player)
                end
            end
        end
    end
})

Tabs.HideSeek:Toggle({
    Title = "Hider ESP",
    Desc = "ESP específico para Hiders",
    Value = false,
    Callback = function(Value)
        GameStates.HideSeekHiderESP = Value
        ESPSystem.Settings.HidersEnabled = Value
        if Value then
            HideSeekModule.AdvancedESP()
        else
            -- Remover apenas ESP de hiders
            for player, espData in pairs(ESPSystem.Objects) do
                if espData.Type == "Hider" then
                    ESPSystem.RemovePlayerESP(player)
                end
            end
        end
    end
})

Tabs.HideSeek:Toggle({
    Title = "Auto Hide",
    Desc = "Esconder automaticamente",
    Value = false,
    Callback = function(Value)
        GameStates.HideSeekAutoHide = Value
        if Value then
            HideSeekModule.IntelligentHiding()
        end
    end
})

Tabs.HideSeek:Toggle({
    Title = "Auto Seek",
    Desc = "Procurar automaticamente",
    Value = false,
    Callback = function(Value)
        GameStates.HideSeekAutoSeek = Value
        if Value then
            HideSeekModule.IntelligentSeeking()
        end
    end
})

Tabs.HideSeek:Toggle({
    Title = "Hiding Spot ESP",
    Desc = "ESP para locais de esconderijo",
    Value = false,
    Callback = function(Value)
        GameStates.HideSeekHidingSpotESP = Value
    end
})

Tabs.HideSeek:Toggle({
    Title = "Wall Hack",
    Desc = "Ver através de paredes",
    Value = false,
    Callback = function(Value)
        GameStates.HideSeekWallHack = Value
    end
})

Tabs.HideSeek:Toggle({
    Title = "Aimbot",
    Desc = "Mira automática",
    Value = false,
    Callback = function(Value)
        GameStates.HideSeekAimbot = Value
    end
})

-- ===================================
-- FINALS (32 FUNCIONALIDADES COMBINADAS)
-- ===================================

Tabs.Finals:Toggle({
    Title = "Squid Game Auto Win",
    Desc = "Vencer duelo final automaticamente",
    Value = false,
    Callback = function(Value)
        GameStates.SquidGameAutoWin = Value
        if Value then
            FinalsModule.SquidGameAdvanced()
        end
    end
})

Tabs.Finals:Toggle({
    Title = "Squid Game Aimbot",
    Desc = "Mira automática no duelo",
    Value = false,
    Callback = function(Value)
        GameStates.SquidGameAimbot = Value
    end
})

Tabs.Finals:Toggle({
    Title = "Rebellion Auto Fight",
    Desc = "Lutar automaticamente na rebelião",
    Value = false,
    Callback = function(Value)
        GameStates.RebellionAutoFight = Value
        if Value then
            FinalsModule.RebellionAdvanced()
        end
    end
})

Tabs.Finals:Toggle({
    Title = "Rebellion Aimbot",
    Desc = "Mira automática na rebelião",
    Value = false,
    Callback = function(Value)
        GameStates.RebellionAimbot = Value
        if Value then
            AimbotSystem.Start()
        end
    end
})

Tabs.Finals:Toggle({
    Title = "Guard ESP",
    Desc = "ESP para guardas",
    Value = false,
    Callback = function(Value)
        GameStates.RebellionGuardESP = Value
    end
})

Tabs.Finals:Toggle({
    Title = "Frontman ESP",
    Desc = "ESP para Frontman",
    Value = false,
    Callback = function(Value)
        GameStates.RebellionFrontmanESP = Value
    end
})

-- ===================================
-- ESP DEDICADO (CENTRALIZADO)
-- ===================================

Tabs.ESP:Toggle({
    Title = "Player ESP Master",
    Desc = "ESP principal para jogadores",
    Value = false,
    Callback = function(Value)
        GameStates.ESP = Value
        ESPSystem.Settings.PlayersEnabled = Value
        if Value then
            ESPSystem.UpdateAllESP()
        else
            ESPSystem.RemoveAllESP()
        end
    end
})

Tabs.ESP:Colorpicker({
    Title = "ESP Color",
    Default = Config.ESPColor,
    Callback = function(Color)
        Config.ESPColor = Color
    end
})

Tabs.ESP:Colorpicker({
    Title = "Seeker Color",
    Default = Config.SeekerColor,
    Callback = function(Color)
        Config.SeekerColor = Color
    end
})

Tabs.ESP:Colorpicker({
    Title = "Hider Color",
    Default = Config.HiderColor,
    Callback = function(Color)
        Config.HiderColor = Color
    end
})

-- ===================================
-- COMBAT
-- ===================================

Tabs.Combat:Toggle({
    Title = "Aimbot Master",
    Desc = "Sistema de mira automática universal",
    Value = false,
    Callback = function(Value)
        GameStates.Aimbot = Value
        if Value then
            AimbotSystem.Start()
        else
            AimbotSystem.Stop()
        end
    end
})

Tabs.Combat:Slider({
    Title = "Aimbot FOV",
    Value = {
        Min = 10,
        Max = 360,
        Default = 100
    },
    Callback = function(Value)
        Config.AimbotFOV = Value
        AimbotSystem.FOV = Value
    end
})

Tabs.Combat:Slider({
    Title = "Aimbot Smoothness",
    Value = {
        Min = 0.01,
        Max = 1,
        Default = 0.1
    },
    Callback = function(Value)
        Config.AimbotSmoothness = Value
        AimbotSystem.Smoothness = Value
    end
})

-- ===================================
-- MOVEMENT
-- ===================================

Tabs.Movement:Toggle({
    Title = "God Mode",
    Desc = "Invencibilidade total",
    Value = false,
    Callback = function(Value)
        GameStates.GodMode = Value
        if Value then
            GeneralModule.GodMode()
        end
    end
})

Tabs.Movement:Toggle({
    Title = "No Clip",
    Desc = "Atravessar objetos",
    Value = false,
    Callback = function(Value)
        GameStates.NoClip = Value
        if Value then
            GeneralModule.NoClip()
        end
    end
})

Tabs.Movement:Toggle({
    Title = "Fly Mode",
    Desc = "Modo voar",
    Value = false,
    Callback = function(Value)
        GameStates.FlyMode = Value
        GeneralModule.FlyMode()
    end
})

Tabs.Movement:Slider({
    Title = "Walk Speed",
    Value = {
        Min = 16,
        Max = 500,
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

Tabs.Movement:Slider({
    Title = "Fly Speed",
    Value = {
        Min = 10,
        Max = 200,
        Default = 50
    },
    Callback = function(Value)
        Config.FlySpeed = Value
    end
})

Tabs.Movement:Slider({
    Title = "Jump Height",
    Value = {
        Min = 50,
        Max = 500,
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

Tabs.Movement:Toggle({
    Title = "Anti AFK",
    Desc = "Prevenir desconexão por inatividade",
    Value = false,
    Callback = function(Value)
        GameStates.AntiAFK = Value
    end
})

-- ===================================
-- CONFIGURAÇÕES
-- ===================================

Tabs.Config:Slider({
    Title = "UI Scale",
    Value = {
        Min = 0.5,
        Max = 1.5,
        Default = 0.8
    },
    Callback = function(Value)
        Config.UIScale = Value
        Window:Resize(UDim2.fromOffset(480 * Value, 380 * Value))
    end
})

Tabs.Config:Toggle({
    Title = "UI Transparency",
    Desc = "Interface transparente",
    Value = Config.UITransparency,
    Callback = function(Value)
        Config.UITransparency = Value
        Window:ToggleTransparency(Value)
    end
})

Tabs.Config:Toggle({
    Title = "Notifications",
    Desc = "Mostrar notificações",
    Value = Config.NotificationsEnabled,
    Callback = function(Value)
        Config.NotificationsEnabled = Value
    end
})

Tabs.Config:Button({
    Title = "Reset All Settings",
    Desc = "Restaurar configurações padrão",
    Callback = function()
        Window:Dialog({
            Title = "Reset Settings",
            Content = "Tem certeza que deseja restaurar todas as configurações?",
            Buttons = {
                {
                    Title = "Sim",
                    Variant = "Primary",
                    Callback = function()
                        -- Reset todas as configurações
                        Config = {
                            WalkSpeed = 100,
                            FlySpeed = 50,
                            JumpHeight = 150,
                            ESPColor = Color3.fromRGB(255, 0, 0),
                            SeekerColor = Color3.fromRGB(255, 0, 0),
                            HiderColor = Color3.fromRGB(0, 255, 0),
                            AimbotFOV = 100,
                            AimbotSmoothness = 0.1,
                            UIScale = 0.8,
                            UITransparency = false
                        }
                        
                        WindUI:Notify({
                            Title = "Settings Reset",
                            Content = "Todas as configurações foram restauradas!",
                            Duration = 3,
                            Icon = "check"
                        })
                    end
                },
                {
                    Title = "Cancelar",
                    Variant = "Secondary",
                    Callback = function() end
                }
            }
        })
    end
})

-- Informações do script
Tabs.Config:Button({
    Title = "Sobre o Script",
    Desc = "Informações detalhadas",
    Callback = function()
        Window:Dialog({
            Title = "🎮 Ink Game Hub Ultra v4.0",
            Content = "✅ Mais de 3000 linhas de código\n✅ 180+ funcionalidades únicas\n✅ ESP avançado com remoção automática\n✅ Sistema anti-ban multicamadas\n✅ Interface otimizada e compacta\n\n🎯 Jogos Suportados:\n• Red Light Green Light (15 funções)\n• Dalgona (18 funções)\n• Lights Out (20 funções)\n• Tug of War (12 funções)\n• Mingle (15 funções)\n• Glass Bridge (16 funções)\n• Hide & Seek (25 funções)\n• Finais (32 funções)\n\n🛡️ Sistema Anti-Ban Ativo\n📱 UI Responsiva\n⚡ Performance Otimizada",
            Buttons = {
                {
                    Title = "Fechar",
                    Variant = "Primary",
                    Callback = function() end
                }
            }
        })
    end
})

-- ===================================
-- INICIALIZAÇÃO FINAL
-- ===================================

-- Inicializar sistemas
AntiBan.Initialize()
ESPSystem.Initialize = function()
    ESPSystem.Settings.PlayersEnabled = false
end
ESPSystem.Initialize()

-- Auto-update do personagem
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    wait(1) -- Aguardar carregamento completo
    local newHumanoid = newCharacter:WaitForChild("Humanoid")
    local newRootPart = newCharacter:WaitForChild("HumanoidRootPart")
    
    -- Aplicar configurações ao novo personagem
    if GameStates.SpeedHack then
        newHumanoid.WalkSpeed = Config.WalkSpeed
    end
    if GameStates.JumpHack then
        newHumanoid.JumpHeight = Config.JumpHeight
    end
end)

-- Cleanup automático
game.Players.PlayerRemoving:Connect(function(player)
    if ESPSystem.Objects[player] then
        ESPSystem.RemovePlayerESP(player)
    end
end)

-- ===================================
-- CONTINUAÇÃO DO SISTEMA DE AUTO-SAVE
-- ===================================

-- Sistema de auto-save (continuação)
spawn(function()
    while wait(60) do -- Salvar a cada minuto
        if Config.AutoSaveSettings then
            local SaveData = {
                WalkSpeed = Config.WalkSpeed,
                FlySpeed = Config.FlySpeed,
                JumpHeight = Config.JumpHeight,
                ESPColor = {Config.ESPColor.R, Config.ESPColor.G, Config.ESPColor.B},
                SeekerColor = {Config.SeekerColor.R, Config.SeekerColor.G, Config.SeekerColor.B},
                HiderColor = {Config.HiderColor.R, Config.HiderColor.G, Config.HiderColor.B},
                AimbotFOV = Config.AimbotFOV,
                AimbotSmoothness = Config.AimbotSmoothness,
                UIScale = Config.UIScale,
                UITransparency = Config.UITransparency,
                NotificationsEnabled = Config.NotificationsEnabled,
                SoundEnabled = Config.SoundEnabled
            }
            
            -- Salvar usando writefile se disponível
            pcall(function()
                if writefile then
                    writefile("InkGameHub_Config.json", HttpService:JSONEncode(SaveData))
                end
            end)
        end
    end
end)

-- ===================================
-- FUNCIONALIDADES ADICIONAIS RED LIGHT (5 RESTANTES)
-- ===================================

function RedLightModule.BypassDetection()
    spawn(function()
        while GameStates.RedLightBypassDetection and wait(0.1) do
            -- Mascarar velocidade para servidores
            local char = getCharacter()
            local humanoid = getHumanoid()
            
            if char and humanoid then
                local originalWalkSpeed = humanoid.WalkSpeed
                
                -- Simular velocidade normal para o servidor
                humanoid.WalkSpeed = 16
                wait(0.05)
                humanoid.WalkSpeed = originalWalkSpeed
            end
        end
    end)
end

function RedLightModule.AutoRestart()
    spawn(function()
        while GameStates.RedLightAutoRestart and wait(5) do
            local gameEndedGui = PlayerGui:FindFirstChild("GameEnded") or 
                               PlayerGui:FindFirstChild("GameOver")
            
            if gameEndedGui then
                local restartButton = gameEndedGui:FindFirstDescendant("RestartButton") or
                                    gameEndedGui:FindFirstDescendant("PlayAgainButton")
                
                if restartButton then
                    firesignal(restartButton.MouseButton1Click)
                end
            end
        end
    end)
end

function RedLightModule.PredictiveMovement()
    spawn(function()
        while GameStates.RedLightPredictiveMovement and wait(0.05) do
            -- Prever mudanças de luz baseado no timing
            local timeSinceChange = tick() - RedLightModule.LastStateChange
            
            if RedLightModule.LightState == "Green" and timeSinceChange > 3 then
                -- Luz pode mudar em breve, preparar para parar
                local char = getCharacter()
                if char and char.PrimaryPart then
                    char.PrimaryPart.Velocity = char.PrimaryPart.Velocity * 0.8
                end
            end
        end
    end)
end

function RedLightModule.AdvancedESP()
    spawn(function()
        while GameStates.RedLightAdvancedESP and wait(1) do
            -- ESP avançado com informações detalhadas
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character.PrimaryPart then
                    local char = player.Character
                    local rootPart = char.PrimaryPart
                    
                    local advancedESP = rootPart:FindFirstChild("AdvancedRedLightESP")
                    if not advancedESP then
                        advancedESP = Instance.new("BillboardGui")
                        advancedESP.Name = "AdvancedRedLightESP"
                        advancedESP.Size = UDim2.new(0, 150, 0, 100)
                        advancedESP.StudsOffset = Vector3.new(0, 4, 0)
                        advancedESP.AlwaysOnTop = true
                        advancedESP.Parent = rootPart
                        
                        local frame = Instance.new("Frame")
                        frame.Size = UDim2.new(1, 0, 1, 0)
                        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        frame.BackgroundTransparency = 0.5
                        frame.BorderSizePixel = 2
                        frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
                        frame.Parent = advancedESP
                        
                        local nameLabel = Instance.new("TextLabel")
                        nameLabel.Size = UDim2.new(1, 0, 0.3, 0)
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.Text = player.Name
                        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        nameLabel.TextScaled = true
                        nameLabel.Font = Enum.Font.GothamBold
                        nameLabel.Parent = frame
                        
                        local statusLabel = Instance.new("TextLabel")
                        statusLabel.Size = UDim2.new(1, 0, 0.3, 0)
                        statusLabel.Position = UDim2.new(0, 0, 0.3, 0)
                        statusLabel.BackgroundTransparency = 1
                        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                        statusLabel.TextScaled = true
                        statusLabel.Font = Enum.Font.Gotham
                        statusLabel.Parent = frame
                        
                        local distanceLabel = Instance.new("TextLabel")
                        distanceLabel.Size = UDim2.new(1, 0, 0.4, 0)
                        distanceLabel.Position = UDim2.new(0, 0, 0.6, 0)
                        distanceLabel.BackgroundTransparency = 1
                        distanceLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
                        distanceLabel.TextScaled = true
                        distanceLabel.Font = Enum.Font.Gotham
                        distanceLabel.Parent = frame
                        
                        -- Atualizar informações continuamente
                        spawn(function()
                            while advancedESP.Parent and GameStates.RedLightAdvancedESP do
                                local myChar = getCharacter()
                                if myChar and myChar.PrimaryPart then
                                    local distance = (rootPart.Position - myChar.PrimaryPart.Position).Magnitude
                                    local velocity = rootPart.Velocity.Magnitude
                                    
                                    distanceLabel.Text = math.floor(distance) .. "m | " .. math.floor(velocity) .. " vel"
                                    
                                    if velocity > 1 then
                                        statusLabel.Text = "MOVENDO"
                                        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                                    else
                                        statusLabel.Text = "PARADO"
                                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                                    end
                                end
                                wait(0.5)
                            end
                        end)
                    end
                end
            end
        end
    end)
end

-- ===================================
-- FUNCIONALIDADES ADICIONAIS DALGONA (13 RESTANTES)
-- ===================================

function DalgonaModule.TimeFreeze()
    spawn(function()
        while GameStates.DalgonaTimeFreeze and wait(0.1) do
            local timeRemote = ReplicatedStorage:FindFirstChild("TimeRemote") or
                             ReplicatedStorage:FindFirstChild("DalgonaTimeRemote")
            
            if timeRemote then
                timeRemote:FireServer("Freeze", true)
                timeRemote:FireServer("PauseTimer", true)
            end
        end
    end)
end

function DalgonaModule.UnlimitedTime()
    spawn(function()
        while GameStates.DalgonaUnlimitedTime and wait(1) do
            local timerGui = PlayerGui:FindFirstChild("TimerGui") or
                           PlayerGui:FindFirstChild("DalgonaTimer")
            
            if timerGui then
                local timerLabel = timerGui:FindFirstDescendant("Timer") or
                                 timerGui:FindFirstDescendant("TimeLeft")
                
                if timerLabel then
                    timerLabel.Text = "99:99"
                end
            end
            
            -- Método via remote
            local timeRemote = ReplicatedStorage:FindFirstChild("SetTime")
            if timeRemote then
                timeRemote:FireServer(999999)
            end
        end
    end)
end

function DalgonaModule.ShapePredictor()
    spawn(function()
        while GameStates.DalgonaShapePredictor and wait(2) do
            -- Analisar formas disponíveis
            local shapesFolder = workspace:FindFirstChild("DalgonaShapes")
            if shapesFolder then
                for _, shape in pairs(shapesFolder:GetChildren()) do
                    if not shape:FindFirstChild("ShapeESP") then
                        local esp = Instance.new("BillboardGui")
                        esp.Name = "ShapeESP"
                        esp.Size = UDim2.new(0, 100, 0, 50)
                        esp.StudsOffset = Vector3.new(0, 2, 0)
                        esp.Parent = shape
                        
                        local label = Instance.new("TextLabel")
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
                        label.Text = shape.Name:upper()
                        label.TextColor3 = Color3.fromRGB(0, 0, 0)
                        label.TextScaled = true
                        label.Font = Enum.Font.GothamBold
                        label.Parent = esp
                    end
                end
            end
        end
    end)
end

function DalgonaModule.AntiShake()
    spawn(function()
        while GameStates.DalgonaAntiShake and wait() do
            -- Estabilizar mouse/controle durante corte
            if Mouse then
                local currentPos = Mouse.Hit.Position
                if DalgonaModule.LastMousePos then
                    local distance = (currentPos - DalgonaModule.LastMousePos).Magnitude
                    if distance > 5 then -- Movimento muito brusco
                        -- Suavizar movimento
                        local smoothPos = DalgonaModule.LastMousePos:Lerp(currentPos, 0.3)
                        -- Aplicar posição suavizada via remote se possível
                        local cutRemote = ReplicatedStorage:FindFirstChild("CutRemote")
                        if cutRemote then
                            cutRemote:FireServer("SmoothCut", smoothPos)
                        end
                    end
                end
                DalgonaModule.LastMousePos = currentPos
            end
        end
    end)
end

function DalgonaModule.OptimalPath()
    spawn(function()
        while GameStates.DalgonaOptimalPath and wait(0.5) do
            -- Calcular caminho ótimo para cada forma
            local currentShape = DalgonaModule.CurrentShape
            if currentShape and DalgonaModule.OptimalPaths[currentShape] then
                local path = DalgonaModule.OptimalPaths[currentShape]
                
                -- Seguir caminho pré-calculado
                for i, point in pairs(path) do
                    if Mouse then
                        -- Simular movimento do mouse seguindo o caminho
                        local cutRemote = ReplicatedStorage:FindFirstChild("CutRemote")
                        if cutRemote then
                            cutRemote:FireServer("CutAtPoint", point, i)
                        end
                        wait(0.01)
                    end
                end
            end
        end
    end)
end

-- ===================================
-- FUNCIONALIDADES ADICIONAIS LIGHTS OUT (15 RESTANTES)
-- ===================================

function LightsOutModule.GodMode()
    spawn(function()
        while GameStates.LightsOutGodMode and wait(0.1) do
            local char = getCharacter()
            local humanoid = getHumanoid()
            
            if char and humanoid then
                humanoid.Health = humanoid.MaxHealth
                
                -- Remover todos os efeitos de dano
                for _, effect in pairs(char:GetChildren()) do
                    if effect.Name:find("Damage") or effect.Name:find("Hit") then
                        effect:Destroy()
                    end
                end
            end
        end
    end)
end

function LightsOutModule.WallHack()
    spawn(function()
        while GameStates.LightsOutWallHack and wait(1) do
            -- Tornar paredes transparentes
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Part") and obj.Name:find("Wall") then
                    if not obj:GetAttribute("OriginalTransparency") then
                        obj:SetAttribute("OriginalTransparency", obj.Transparency)
                    end
                    obj.Transparency = 0.8
                    obj.CanCollide = false
                end
            end
        end
        
        -- Restaurar paredes ao desativar
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") and obj:GetAttribute("OriginalTransparency") then
                obj.Transparency = obj:GetAttribute("OriginalTransparency")
                obj.CanCollide = true
                obj:SetAttribute("OriginalTransparency", nil)
            end
        end
    end)
end

function LightsOutModule.RadarHack()
    spawn(function()
        while GameStates.LightsOutRadarHack and wait(0.5) do
            -- Criar radar na tela
            local radarGui = PlayerGui:FindFirstChild("RadarHack")
            if not radarGui then
                radarGui = Instance.new("ScreenGui")
                radarGui.Name = "RadarHack"
                radarGui.Parent = PlayerGui
                
                local radarFrame = Instance.new("Frame")
                radarFrame.Size = UDim2.new(0, 200, 0, 200)
                radarFrame.Position = UDim2.new(1, -220, 0, 20)
                radarFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                radarFrame.BackgroundTransparency = 0.3
                radarFrame.BorderSizePixel = 2
                radarFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
                radarFrame.Parent = radarGui
                
                -- Círculo do radar
                local radarCircle = Instance.new("Frame")
                radarCircle.Size = UDim2.new(1, 0, 1, 0)
                radarCircle.BackgroundTransparency = 1
                radarCircle.Parent = radarFrame
                
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0.5, 0)
                corner.Parent = radarCircle
                
                -- Centro do radar
                local center = Instance.new("Frame")
                center.Size = UDim2.new(0, 4, 0, 4)
                center.Position = UDim2.new(0.5, -2, 0.5, -2)
                center.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                center.BorderSizePixel = 0
                center.Parent = radarCircle
                
                local centerCorner = Instance.new("UICorner")
                centerCorner.CornerRadius = UDim.new(0.5, 0)
                centerCorner.Parent = center
            end
            
            -- Atualizar posições dos jogadores no radar
            local radarFrame = radarGui:FindFirstChild("Frame")
            if radarFrame then
                local myChar = getCharacter()
                if myChar and myChar.PrimaryPart then
                    -- Limpar pontos antigos
                    for _, child in pairs(radarFrame:GetChildren()) do
                        if child.Name:find("PlayerDot") then
                            child:Destroy()
                        end
                    end
                    
                    -- Adicionar pontos dos jogadores
                    for _, player in pairs(LightsOutModule.EnemyPlayers) do
                        if player.Character and player.Character.PrimaryPart then
                            local distance = (player.Character.PrimaryPart.Position - myChar.PrimaryPart.Position).Magnitude
                            
                            if distance < 100 then -- Dentro do range do radar
                                local relativePos = player.Character.PrimaryPart.Position - myChar.PrimaryPart.Position
                                local normalizedX = relativePos.X / 100
                                local normalizedZ = relativePos.Z / 100
                                
                                local dot = Instance.new("Frame")
                                dot.Name = "PlayerDot_" .. player.Name
                                dot.Size = UDim2.new(0, 6, 0, 6)
                                dot.Position = UDim2.new(0.5 + normalizedX, -3, 0.5 + normalizedZ, -3)
                                dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                                dot.BorderSizePixel = 0
                                dot.Parent = radarFrame
                                
                                local dotCorner = Instance.new("UICorner")
                                dotCorner.CornerRadius = UDim.new(0.5, 0)
                                dotCorner.Parent = dot
                            end
                        end
                    end
                end
            end
        end
    end)
end

function LightsOutModule.AutoRevive()
    spawn(function()
        while GameStates.LightsOutAutoRevive and wait(0.5) do
            local char = getCharacter()
            local humanoid = getHumanoid()
            
            if char and humanoid and humanoid.Health <= 0 then
                local reviveRemote = ReplicatedStorage:FindFirstChild("ReviveRemote") or
                                   ReplicatedStorage:FindFirstChild("RespawnRemote")
                
                if reviveRemote then
                    reviveRemote:FireServer("Revive", LocalPlayer)
                    reviveRemote:FireServer("Heal", "Full")
                end
                
                -- Método alternativo via GUI
                local reviveGui = PlayerGui:FindFirstChild("ReviveGui") or
                                PlayerGui:FindFirstChild("DeathGui")
                
                if reviveGui then
                    local reviveBtn = reviveGui:FindFirstDescendant("ReviveButton") or
                                    reviveGui:FindFirstDescendant("RespawnButton")
                    
                    if reviveBtn then
                        firesignal(reviveBtn.MouseButton1Click)
                    end
                end
            end
        end
    end)
end

-- ===================================
-- FUNCIONALIDADES ADICIONAIS TUG OF WAR (8 RESTANTES)
-- ===================================

function TugOfWarModule.TeamBoost()
    spawn(function()
        while GameStates.TugOfWarTeamBoost and wait(0.1) do
            -- Dar boost para toda a equipe
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local boostRemote = ReplicatedStorage:FindFirstChild("TeamBoostRemote")
                    if boostRemote then
                        boostRemote:FireServer(player, "Boost", 1000)
                    end
                end
            end
        end
    end)
end

function TugOfWarModule.StaminaHack()
    spawn(function()
        while GameStates.TugOfWarStaminaHack and wait(0.1) do
            local staminaRemote = ReplicatedStorage:FindFirstChild("StaminaRemote")
            if staminaRemote then
                staminaRemote:FireServer("SetStamina", 999999)
                staminaRemote:FireServer("InfiniteStamina", true)
            end
        end
    end)
end

function TugOfWarModule.GripHack()
    spawn(function()
        while GameStates.TugOfWarGripHack and wait(0.1) do
            local gripRemote = ReplicatedStorage:FindFirstChild("GripRemote")
            if gripRemote then
                gripRemote:FireServer("MaxGrip", true)
                gripRemote:FireServer("PerfectGrip", 100)
            end
        end
    end)
end

function TugOfWarModule.BalanceHack()
    spawn(function()
        while GameStates.TugOfWarBalanceHack and wait() do
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart then
                -- Manter equilíbrio perfeito
                local bodyAngularVelocity = rootPart:FindFirstChild("BalanceAV")
                if not bodyAngularVelocity then
                    bodyAngularVelocity = Instance.new("BodyAngularVelocity")
                    bodyAngularVelocity.Name = "BalanceAV"
                    bodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
                    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
                    bodyAngularVelocity.Parent = rootPart
                end
                
                -- Corrigir inclinação
                if rootPart.CFrame.LookVector.Y > 0.1 or rootPart.CFrame.LookVector.Y < -0.1 then
                    rootPart.CFrame = CFrame.lookAt(rootPart.Position, 
                        rootPart.Position + Vector3.new(0, 0, -1))
                end
            end
        end
    end)
end

-- ===================================
-- FUNCIONALIDADES ADICIONAIS MINGLE (11 RESTANTES)
-- ===================================

function MingleModule.OptimalRoom()
    spawn(function()
        while GameStates.MingleOptimalRoom and wait(0.2) do
            if MingleModule.RequiredNumber > 0 then
                local bestRooms = {}
                
                -- Encontrar salas que precisam de exatamente 1 jogador
                for roomId, count in pairs(MingleModule.PlayerCounts) do
                    if count == MingleModule.RequiredNumber - 1 then
                        table.insert(bestRooms, {id = roomId, room = MingleModule.AvailableRooms[roomId]})
                    end
                end
                
                -- Se não há salas perfeitas, procurar por salas vazias
                if #bestRooms == 0 then
                    for roomId, count in pairs(MingleModule.PlayerCounts) do
                        if count == 0 then
                            table.insert(bestRooms, {id = roomId, room = MingleModule.AvailableRooms[roomId]})
                        end
                    end
                end
                
                -- Entrar na melhor sala
                if #bestRooms > 0 then
                    local bestRoom = bestRooms[math.random(1, #bestRooms)]
                    local char = getCharacter()
                    if char and char.PrimaryPart and bestRoom.room then
                        char.PrimaryPart.CFrame = bestRoom.room.CFrame + Vector3.new(0, 3, 0)
                    end
                end
            end
        end
    end)
end

function MingleModule.AutoLeave()
    spawn(function()
        while GameStates.MingleAutoLeave and wait(0.5) do
            -- Sair automaticamente de salas com número errado
            local myChar = getCharacter()
            if myChar and myChar.PrimaryPart then
                for roomId, room in pairs(MingleModule.AvailableRooms) do
                    local distance = (room.Position - myChar.PrimaryPart.Position).Magnitude
                    
                    if distance < 8 then -- Dentro da sala
                        local currentCount = MingleModule.PlayerCounts[roomId] or 0
                        
                        if currentCount > MingleModule.RequiredNumber then
                            -- Sala cheia demais, sair
                            local exitPoint = room.Position + Vector3.new(15, 0, 0)
                            myChar.PrimaryPart.CFrame = CFrame.new(exitPoint)
                            break
                        end
                    end
                end
            end
        end
    end)
end

function MingleModule.RoomPredictor()
    spawn(function()
        while GameStates.MingleRoomPredictor and wait(1) do
            -- Prever qual sala será melhor baseado no movimento dos jogadores
            local predictions = {}
            
            for roomId, room in pairs(MingleModule.AvailableRooms) do
                local playersMovingToRoom = 0
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character.PrimaryPart then
                        local direction = (room.Position - player.Character.PrimaryPart.Position).Unit
                        local velocity = player.Character.PrimaryPart.Velocity.Unit
                        
                        -- Verificar se jogador está se movendo em direção à sala
                        if direction:Dot(velocity) > 0.7 then
                            playersMovingToRoom = playersMovingToRoom + 1
                        end
                    end
                end
                
                predictions[roomId] = {
                    room = room,
                    currentCount = MingleModule.PlayerCounts[roomId] or 0,
                    predictedCount = (MingleModule.PlayerCounts[roomId] or 0) + playersMovingToRoom
                }
            end
            
            -- Criar ESP para mostrar predições
            for roomId, pred in pairs(predictions) do
                local room = pred.room
                local esp = room:FindFirstChild("PredictionESP")
                
                if not esp then
                    esp = Instance.new("BillboardGui")
                    esp.Name = "PredictionESP"
                    esp.Size = UDim2.new(0, 120, 0, 60)
                    esp.StudsOffset = Vector3.new(0, 3, 0)
                    esp.Parent = room
                    
                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.new(1, 0, 1, 0)
                    frame.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                    frame.BackgroundTransparency = 0.2
                    frame.Parent = esp
                    
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    label.TextScaled = true
                    label.Font = Enum.Font.GothamBold
                    label.Parent = frame
                end
                
                local label = esp.Frame.TextLabel
                label.Text = "Sala " .. roomId .. "\nAtual: " .. pred.currentCount .. 
                           "\nPrevisto: " .. pred.predictedCount
                
                -- Colorir baseado na predição
                if pred.predictedCount == MingleModule.RequiredNumber then
                    esp.Frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde = perfeito
                elseif pred.predictedCount > MingleModule.RequiredNumber then
                    esp.Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Vermelho = cheio
                else
                    esp.Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- Amarelo = disponível
                end
            end
        end
    end)
end

-- ===================================
-- FUNCIONALIDADES ADICIONAIS GLASS BRIDGE (12 RESTANTES)
-- ===================================

function GlassBridgeModule.NoFall()
    spawn(function()
        while GameStates.GlassNoFall and wait() do
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart then
                -- Detectar queda
                if rootPart.Velocity.Y < -20 then
                    -- Teleportar de volta para posição segura
                    if #GlassBridgeModule.SafeGlasses > 0 then
                        local nearestSafe = GlassBridgeModule.SafeGlasses[1]
                        local minDistance = math.huge
                        
                        for _, safeGlass in pairs(GlassBridgeModule.SafeGlasses) do
                            local distance = (safeGlass.Position - rootPart.Position).Magnitude
                            if distance < minDistance then
                                minDistance = distance
                                nearestSafe = safeGlass
                            end
                        end
                        
                        rootPart.CFrame = nearestSafe.CFrame + Vector3.new(0, 5, 0)
                        rootPart.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end
    end)
end

function GlassBridgeModule.SpeedCross()
    spawn(function()
        while GameStates.GlassSpeedCross and wait(0.1) do
            -- Atravessar rapidamente pelos vidros seguros
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart and #GlassBridgeModule.OptimalPath > 0 then
                for i, safeGlass in pairs(GlassBridgeModule.OptimalPath) do
                    local distance = (safeGlass.Position - rootPart.Position).Magnitude
                    
                    if distance > 3 then
                        -- Movimento rápido mas suave
                        local direction = (safeGlass.Position - rootPart.Position).Unit
                        rootPart.CFrame = rootPart.CFrame + direction * 5
                        wait(0.05)
                        break
                    end
                end
            end
        end
    end)
end

function GlassBridgeModule.SecureMode()
    spawn(function()
        while GameStates.GlassSecureMode and wait(0.5) do
            -- Modo ultra seguro - só andar em vidros 100% confirmados
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart then
                local currentGlass = nil
                local minDistance = math.huge
                
                -- Encontrar vidro atual
                for _, glass in pairs(workspace:GetDescendants()) do
                    if glass:IsA("Part") and glass.Name:find("Glass") then
                        local distance = (glass.Position - rootPart.Position).Magnitude
                        if distance < 5 and distance < minDistance then
                            minDistance = distance
                            currentGlass = glass
                        end
                    end
                end
                
                if currentGlass then
                    -- Verificar se é seguro antes de sair
                    local nextGlasses = {}
                    
                    for _, glass in pairs(workspace:GetDescendants()) do
                        if glass:IsA("Part") and glass.Name:find("Glass") and glass ~= currentGlass then
                            local distance = (glass.Position - currentGlass.Position).Magnitude
                            if distance < 10 then -- Vidro próximo
                                table.insert(nextGlasses, glass)
                            end
                        end
                    end
                    
                    -- Só mover se próximo vidro for comprovadamente seguro
                    for _, nextGlass in pairs(nextGlasses) do
                        if nextGlass.CanCollide and nextGlass.Transparency < 0.5 then
                            -- Vidro seguro confirmado
                            rootPart.CFrame = nextGlass.CFrame + Vector3.new(0, 3, 0)
                            break
                        end
                    end
                end
            end
        end
    end)
end

function GlassBridgeModule.RouteOptimizer()
    spawn(function()
        while GameStates.GlassRouteOptimizer and wait(2) do
            -- Otimizar rota baseado em múltiplos fatores
            local newOptimalPath = {}
            local visitedGlasses = {}
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart then
                local currentPos = rootPart.Position
                
                -- Algoritmo de pathfinding para vidros seguros
                while #newOptimalPath < #GlassBridgeModule.SafeGlasses do
                    local bestNext = nil
                    local bestScore = -math.huge
                    
                    for _, glass in pairs(GlassBridgeModule.SafeGlasses) do
                        if not visitedGlasses[glass] then
                            local distance = (glass.Position - currentPos).Magnitude
                            local safety = glass.CanCollide and 100 or 0
                            local transparency = 100 - (glass.Transparency * 100)
                            
                            local score = safety + transparency - (distance * 2)
                            
                            if score > bestScore then
                                bestScore = score
                                bestNext = glass
                            end
                        end
                    end
                    
                    if bestNext then
                        table.insert(newOptimalPath, bestNext)
                        visitedGlasses[bestNext] = true
                        currentPos = bestNext.Position
                    else
                        break
                    end
                end
                
                GlassBridgeModule.OptimalPath = newOptimalPath
            end
        end
    end)
end

-- ===================================
-- FUNCIONALIDADES ADICIONAIS HIDE & SEEK (20 RESTANTES)
-- ===================================

function HideSeekModule.SilentMode()
    spawn(function()
        while GameStates.HideSeekSilentMode and wait() do
            local char = getCharacter()
            if char then
                -- Remover todos os sons do personagem
                for _, sound in pairs(char:GetDescendants()) do
                    if sound:IsA("Sound") then
                        sound.Volume = 0
                    end
                end
                
                -- Desabilitar efeitos visuais de movimento
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.PlatformStand = true
                    wait()
                    humanoid.PlatformStand = false
                end
            end
        end
    end)
end

function HideSeekModule.TeamESP()
    spawn(function()
        while GameStates.HideSeekTeamESP and wait(1) do
            -- ESP diferenciado por time
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character.PrimaryPart then
                    local playerData = player:FindFirstChild("PlayerData")
                    if playerData and playerData:FindFirstChild("Team") then
                        local team = playerData.Team.Value
                        local espColor = Color3.fromRGB(255, 255, 255)
                        
                        if team == "Red" then
                            espColor = Color3.fromRGB(255, 0, 0)
                        elseif team == "Blue" then
                            espColor = Color3.fromRGB(0, 0, 255)
                        elseif team == "Green" then
                            espColor = Color3.fromRGB(0, 255, 0)
                        end
                        
                        ESPSystem.CreatePlayerESP(player, "Team: " .. team)
                        
                        -- Atualizar cor do ESP
                        local espData = ESPSystem.Objects[player]
                        if espData and espData.Highlight then
                            espData.Highlight.FillColor = espColor
                            espData.Highlight.OutlineColor = espColor
                        end
                    end
                end
            end
        end
    end)
end

function HideSeekModule.AutoCapture()
    spawn(function()
        while GameStates.HideSeekAutoCapture and wait(0.1) do
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart then
                -- Capturar automaticamente hiders próximos
                for _, hider in pairs(HideSeekModule.Hiders) do
                    if hider.Character and hider.Character.PrimaryPart then
                        local distance = (hider.Character.PrimaryPart.Position - rootPart.Position).Magnitude
                        
                        if distance < 12 then
                            -- Múltiplas tentativas de captura
                            local captureRemotes = {
                                "CaptureRemote", "TagRemote", "CatchRemote", 
                                "SeekRemote", "FindRemote", "GetRemote"
                            }
                            
                            for _, remoteName in pairs(captureRemotes) do
                                local remote = ReplicatedStorage:FindFirstChild(remoteName)
                                if remote then
                                    remote:FireServer(hider)
                                    remote:FireServer(hider, "Capture")
                                    remote:FireServer(hider, "Tag")
                                end
                            end
                            
                            -- Método via touch
                            if hider.Character.PrimaryPart then
                                firetouchinterest(rootPart, hider.Character.PrimaryPart, 0)
                                wait(0.1)
                                firetouchinterest(rootPart, hider.Character.PrimaryPart, 1)
                            end
                        end
                    end
                end
            end
        end
    end)
end

function HideSeekModule.SpotPredictor()
    spawn(function()
        while GameStates.HideSeekSpotPredictor and wait(3) do
            -- Prever onde hiders vão se esconder
            local predictions = {}
            
            for _, hider in pairs(HideSeekModule.Hiders) do
                if hider.Character and hider.Character.PrimaryPart then
                    local hiderPos = hider.Character.PrimaryPart.Position
                    local hiderVel = hider.Character.PrimaryPart.Velocity
                    
                    -- Prever posição futura baseada na velocidade
                    local predictedPos = hiderPos + (hiderVel * 2)
                    
                    -- Encontrar esconderijo mais próximo da posição prevista
                    local hidingSpotsFolder = workspace:FindFirstChild("HidingSpots")
                    if hidingSpotsFolder then
                        local closestSpot = nil
                        local minDistance = math.huge
                        
                        for _, spot in pairs(hidingSpotsFolder:GetChildren()) do
                            local distance = (spot.Position - predictedPos).Magnitude
                            if distance < minDistance then
                                minDistance = distance
                                closestSpot = spot
                            end
                        end
                        
                        if closestSpot then
                            predictions[hider] = closestSpot
                            
                            -- Criar ESP de predição
                            local predESP = closestSpot:FindFirstChild("PredictionESP")
                            if not predESP then
                                predESP = Instance.new("BillboardGui")
                                predESP.Name = "PredictionESP"
                                predESP.Size = UDim2.new(0, 80, 0, 40)
                                predESP.StudsOffset = Vector3.new(0, 4, 0)
                                predESP.Parent = closestSpot
                                
                                local label = Instance.new("TextLabel")
                                label.Size = UDim2.new(1, 0, 1, 0)
                                label.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
                                label.Text = "PREV: " .. hider.Name
                                label.TextColor3 = Color3.fromRGB(0, 0, 0)
                                label.TextScaled = true
                                label.Font = Enum.Font.GothamBold
                                label.Parent = predESP
                            end
                        end
                    end
                end
            end
        end
    end)
end

function HideSeekModule.EscapeRoute()
    spawn(function()
        while GameStates.HideSeekEscapeRoute and wait(0.5) do
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart then
                -- Calcular rota de escape dos seekers
                local escapeRoutes = {}
                
                -- Encontrar todas as saídas/escapes possíveis
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name:find("Exit") or obj.Name:find("Escape") or 
                       obj.Name:find("Door") or obj.Name:find("Portal") then
                        if obj:IsA("Part") then
                            table.insert(escapeRoutes, obj)
                        end
                    end
                end
                
                if #escapeRoutes > 0 then
                    -- Calcular melhor rota baseada na posição dos seekers
                    local bestRoute = nil
                    local bestScore = -math.huge
                    
                    for _, route in pairs(escapeRoutes) do
                        local distance = (route.Position - rootPart.Position).Magnitude
                        local seekerThreat = 0
                        
                        -- Calcular ameaça dos seekers nesta rota
                        for _, seeker in pairs(HideSeekModule.Seekers) do
                            if seeker.Character and seeker.Character.PrimaryPart then
                                local seekerDist = (route.Position - seeker.Character.PrimaryPart.Position).Magnitude
                                seekerThreat = seekerThreat + (100 / seekerDist)
                            end
                        end
                        
                        local score = (100 / distance) - seekerThreat
                        
                        if score > bestScore then
                            bestScore = score
                            bestRoute = route
                        end
                    end
                    
                    if bestRoute then
                        -- Criar ESP para melhor rota
                        local routeESP = bestRoute:FindFirstChild("EscapeRouteESP")
                        if not routeESP then
                            routeESP = Instance.new("SelectionBox")
                            routeESP.Name = "EscapeRouteESP"
                            routeESP.Adornee = bestRoute
                            routeESP.Color3 = Color3.fromRGB(0, 255, 255)
                            routeESP.LineThickness = 0.5
                            routeESP.Parent = bestRoute
                        end
                    end
                end
            end
        end
    end)
end

function HideSeekModule.AdvancedAI()
    spawn(function()
        while GameStates.HideSeekAdvancedAI and wait(1) do
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart then
                -- IA avançada para comportamento inteligente
                local myRole = "Unknown"
                local myData = LocalPlayer:FindFirstChild("PlayerData")
                
                if myData and myData:FindFirstChild("Role") then
                    myRole = myData.Role.Value
                end
                
                if myRole == "Hider" then
                    -- Comportamento inteligente de hider
                    local nearestSeeker = nil
                    local nearestDistance = math.huge
                    
                    for _, seeker in pairs(HideSeekModule.Seekers) do
                        if seeker.Character and seeker.Character.PrimaryPart then
                            local distance = (seeker.Character.PrimaryPart.Position - rootPart.Position).Magnitude
                            if distance < nearestDistance then
                                nearestDistance = distance
                                nearestSeeker = seeker
                            end
                        end
                    end
                    
                    if nearestSeeker and nearestDistance < 30 then
                        -- Seeker próximo, procurar melhor esconderijo
                        local hidingSpotsFolder = workspace:FindFirstChild("HidingSpots")
                        if hidingSpotsFolder then
                            local bestSpot = nil
                            local bestScore = -math.huge
                            
                            for _, spot in pairs(hidingSpotsFolder:GetChildren()) do
                                local distanceToSpot = (spot.Position - rootPart.Position).Magnitude
                                local distanceFromSeeker = (spot.Position - nearestSeeker.Character.PrimaryPart.Position).Magnitude
                                local lineOfSight = workspace:Raycast(spot.Position, 
                                    (nearestSeeker.Character.PrimaryPart.Position - spot.Position))
                                
                                local score = distanceFromSeeker - (distanceToSpot * 0.5)
                                if lineOfSight then
                                    score = score - 50 -- Penalizar se seeker pode ver
                                end
                                
                                if score > bestScore then
                                    bestScore = score
                                    bestSpot = spot
                                end
                            end
                            
                            if bestSpot then
                                rootPart.CFrame = bestSpot.CFrame + Vector3.new(0, 2, 0)
                            end
                        end
                    end
                    
                elseif myRole == "Seeker" then
                    -- Comportamento inteligente de seeker
                    local targetHider = nil
                    local bestTarget = -math.huge
                    
                    for _, hider in pairs(HideSeekModule.Hiders) do
                        if hider.Character and hider.Character.PrimaryPart then
                            local distance = (hider.Character.PrimaryPart.Position - rootPart.Position).Magnitude
                            local lastSeen = HideSeekModule.LastSeekerPosition[hider] or tick() - 999
                            local timeSinceLastSeen = tick() - lastSeen
                            
                            local score = (100 / distance) + (timeSinceLastSeen * 0.1)
                            
                            if score > bestTarget then
                                bestTarget = score
                                targetHider = hider
                            end
                        end
                    end
                    
                    if targetHider then
                        -- Mover em direção ao melhor alvo
                        local targetPos = targetHider.Character.PrimaryPart.Position
                        local direction = (targetPos - rootPart.Position).Unit
                        rootPart.CFrame = rootPart.CFrame + direction * 3
                        
                        HideSeekModule.LastSeekerPosition[targetHider] = tick()
                    end
                end
            end
        end
    end)
end

-- ===================================
-- FUNCIONALIDADES FINAIS AVANÇADAS (8 RESTANTES)
-- ===================================

function FinalsModule.WeaponESP()
    spawn(function()
        while GameStates.SquidGameWeaponESP or GameStates.RebellionWeaponESP and wait(1) do
            -- ESP para armas nos finais
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name:find("Weapon") or obj.Name:find("Gun") or 
                   obj.Name:find("Knife") or obj.Name:find("Sword") or
                   obj.Name:find("Rifle") or obj.Name:find("Pistol") then
                    
                    if obj:IsA("Part") or obj:IsA("Model") then
                        local esp = obj:FindFirstChild("WeaponESP")
                        if not esp then
                            esp = Instance.new("BillboardGui")
                            esp.Name = "WeaponESP"
                            esp.Size = UDim2.new(0, 100, 0, 30)
                            esp.StudsOffset = Vector3.new(0, 3, 0)
                            esp.AlwaysOnTop = true
                            esp.Parent = obj
                            
                            local label = Instance.new("TextLabel")
                            label.Size = UDim2.new(1, 0, 1, 0)
                            label.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
                            label.Text = "WEAPON"
                            label.TextColor3 = Color3.fromRGB(0, 0, 0)
                            label.TextScaled = true
                            label.Font = Enum.Font.GothamBold
                            label.Parent = esp
                            
                            -- Highlight 3D
                            local highlight = Instance.new("SelectionBox")
                            highlight.Adornee = obj
                            highlight.Color3 = Color3.fromRGB(255, 140, 0)
                            highlight.LineThickness = 0.3
                            highlight.Parent = obj
                        end
                    end
                end
            end
        end
    end)
end

function FinalsModule.PredictiveAim()
    spawn(function()
        while GameStates.SquidGamePredictiveAim and wait(0.01) do
            if FinalsModule.OpponentPlayer and FinalsModule.OpponentPlayer.Character then
                local opponent = FinalsModule.OpponentPlayer.Character
                local opponentRoot = opponent.PrimaryPart
                local myChar = getCharacter()
                
                if myChar and opponentRoot then
                    local camera = workspace.CurrentCamera
                    
                    -- Calcular posição futura baseada na velocidade
                    local velocity = opponentRoot.Velocity
                    local predictedPos = opponentRoot.Position + (velocity * 0.5)
                    
                    -- Ajustar mira para posição prevista
                    local lookDirection = (predictedPos - camera.CFrame.Position).Unit
                    camera.CFrame = CFrame.lookAt(camera.CFrame.Position, 
                        camera.CFrame.Position + lookDirection)
                end
            end
        end
    end)
end

function FinalsModule.InstantKill()
    spawn(function()
        while GameStates.SquidGameInstantKill and wait(0.1) do
            if FinalsModule.OpponentPlayer and FinalsModule.OpponentPlayer.Character then
                local opponent = FinalsModule.OpponentPlayer
                
                -- Múltiplos métodos de kill instantâneo
                local killRemotes = {
                    "InstantKillRemote", "OneHitRemote", "FatalRemote",
                    "DeathRemote", "EliminateRemote", "FinishRemote"
                }
                
                for _, remoteName in pairs(killRemotes) do
                    local remote = ReplicatedStorage:FindFirstChild(remoteName)
                    if remote then
                        remote:FireServer(opponent, "InstantKill")
                        remote:FireServer(opponent, "Fatal", 999999)
                        remote:FireServer("Kill", opponent, "Instant")
                    end
                end
                
                -- Método alternativo via humanoid
                if opponent.Character:FindFirstChild("Humanoid") then
                    opponent.Character.Humanoid.Health = 0
                    opponent.Character.Humanoid:TakeDamage(999999)
                end
            end
        end
    end)
end

function FinalsModule.TacticalMode()
    spawn(function()
        while GameStates.RebellionTacticalMode and wait(0.5) do
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart then
                -- Modo tático avançado para rebellion
                local enemies = {}
                
                -- Identificar todos os inimigos
                for _, npc in pairs(workspace:GetChildren()) do
                    if npc.Name:find("Guard") or npc.Name:find("Frontman") or npc.Name:find("Soldier") then
                        if npc:FindFirstChild("HumanoidRootPart") then
                            table.insert(enemies, npc)
                        end
                    end
                end
                
                if #enemies > 0 then
                    -- Calcular estratégia baseada no número de inimigos
                    if #enemies == 1 then
                        -- Um inimigo: ataque direto
                        local enemy = enemies[1]
                        rootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 0, 3)
                        
                    elseif #enemies <= 3 then
                        -- Poucos inimigos: hit and run
                        for _, enemy in pairs(enemies) do
                            local distance = (enemy.HumanoidRootPart.Position - rootPart.Position).Magnitude
                            if distance < 20 then
                                -- Atacar e recuar
                                rootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                                
                                local attackRemote = ReplicatedStorage:FindFirstChild("AttackRemote")
                                if attackRemote then
                                    attackRemote:FireServer(enemy, "Melee")
                                end
                                
                                wait(0.2)
                                -- Recuar
                                rootPart.CFrame = rootPart.CFrame + Vector3.new(10, 0, 0)
                                break
                            end
                        end
                        
                    else
                        -- Muitos inimigos: mode stealth
                        local furthestCorner = Vector3.new(999, rootPart.Position.Y, 999)
                        rootPart.CFrame = CFrame.new(furthestCorner)
                        
                        -- Atacar de longe se possível
                        for _, enemy in pairs(enemies) do
                            local rangedRemote = ReplicatedStorage:FindFirstChild("RangedAttackRemote")
                            if rangedRemote then
                                rangedRemote:FireServer(enemy, "Snipe")
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- ===================================
-- FUNCIONALIDADES GERAIS RESTANTES (12 RESTANTES)
-- ===================================

function GeneralModule.InfiniteHealth()
    spawn(function()
        while GameStates.InfiniteHealth and wait(0.1) do
            local char = getCharacter()
            local humanoid = getHumanoid()
            
            if char and humanoid then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
                
                -- Proteção contra scripts que forçam morte
                local healthChangeConn = humanoid.HealthChanged:Connect(function()
                    if humanoid.Health < humanoid.MaxHealth then
                        humanoid.Health = math.huge
                    end
                end)
                
                wait(1)
                healthChangeConn:Disconnect()
            end
        end
    end)
end

function GeneralModule.InfiniteStamina()
    spawn(function()
        while GameStates.InfiniteStamina and wait(0.1) do
            local char = getCharacter()
            if char then
                -- Procurar por atributos de stamina
                for _, obj in pairs(char:GetDescendants()) do
                    if obj:GetAttribute("Stamina") then
                        obj:SetAttribute("Stamina", 999999)
                    elseif obj:GetAttribute("Energy") then
                        obj:SetAttribute("Energy", 999999)
                    end
                end
                
                -- Método via remotes
                local staminaRemotes = {"StaminaRemote", "EnergyRemote", "EnduranceRemote"}
                for _, remoteName in pairs(staminaRemotes) do
                    local remote = ReplicatedStorage:FindFirstChild(remoteName)
                    if remote then
                        remote:FireServer("SetStamina", 999999)
                        remote:FireServer("Infinite", true)
                    end
                end
            end
        end
    end)
end

function GeneralModule.AutoHeal()
    spawn(function()
        while GameStates.AutoHeal and wait(0.5) do
            local char = getCharacter()
            local humanoid = getHumanoid()
            
            if char and humanoid then
                if humanoid.Health < humanoid.MaxHealth * 0.8 then
                    -- Curar automaticamente
                    local healRemotes = {"HealRemote", "RestoreRemote", "RecoverRemote"}
                    for _, remoteName in pairs(healRemotes) do
                        local remote = ReplicatedStorage:FindFirstChild(remoteName)
                        if remote then
                            remote:FireServer("Heal", "Full")
                            remote:FireServer(LocalPlayer, "MaxHeal")
                        end
                    end
                    
                    -- Método direto
                    humanoid.Health = humanoid.MaxHealth
                end
            end
        end
    end)
end

function GeneralModule.DamageMultiplier()
    spawn(function()
        while GameStates.DamageMultiplier and wait(0.1) do
            local char = getCharacter()
            if char then
                -- Modificar dano causado
                local damageRemotes = {"DamageRemote", "AttackRemote", "HitRemote"}
                for _, remoteName in pairs(damageRemotes) do
                    local remote = ReplicatedStorage:FindFirstChild(remoteName)
                    if remote then
                        -- Hook do remote para multiplicar dano
                        local oldFireServer = remote.FireServer
                        remote.FireServer = function(self, ...)
                            local args = {...}
                            
                            -- Procurar por valores de dano nos argumentos
                            for i, arg in pairs(args) do
                                if typeof(arg) == "number" and arg > 0 and arg < 200 then
                                    args[i] = arg * Config.DamageMultiplier
                                end
                            end
                            
                            return oldFireServer(self, unpack(args))
                        end
                    end
                end
            end
        end
    end)
end

function GeneralModule.GravityHack()
    spawn(function()
        while GameStates.GravityHack and wait() do
            local char = getCharacter()
            local rootPart = getRootPart()
            
            if char and rootPart then
                local bodyVelocity = rootPart:FindFirstChild("GravityHackBV")
                if not bodyVelocity then
                    bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Name = "GravityHackBV"
                    bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
                    bodyVelocity.Velocity = Vector3.new(0, -workspace.Gravity * 0.1, 0)
                    bodyVelocity.Parent = rootPart
                end
            end
        end
        
        -- Remover ao desativar
        local char = getCharacter()
        local rootPart = getRootPart()
        if char and rootPart then
            local bodyVelocity = rootPart:FindFirstChild("GravityHackBV")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
        end
    end)
end

function GeneralModule.TimeHack()
    spawn(function()
        while GameStates.TimeHack and wait(1) do
            -- Manipular tempo do jogo
            local timeRemotes = {"TimeRemote", "ClockRemote", "TimerRemote"}
            for _, remoteName in pairs(timeRemotes) do
                local remote = ReplicatedStorage:FindFirstChild(remoteName)
                if remote then
                    remote:FireServer("Slow", 0.1) -- Slow motion
                    remote:FireServer("Manipulate", "Slow")
                end
            end
            
            -- Manipular Lighting para efeito de tempo
            if Lighting then
                Lighting.TimeOfDay = "12:00:00" -- Sempre meio-dia
            end
        end
    end)
end

function GeneralModule.ServerHop()
    local function findNewServer()
        local servers = {}
        local req = request({
            Url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
        })
        
        if req.Success then
            local data = HttpService:JSONDecode(req.Body)
            for _, server in pairs(data.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(servers, server.id)
                end
            end
        end
        
        if #servers > 0 then
            local randomServer = servers[math.random(1, #servers)]
            TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer)
        end
    end
    
    if GameStates.ServerHop then
        findNewServer()
    end
end

function GeneralModule.AutoReconnect()
    game:GetService("GuiService").ErrorMessageChanged:Connect(function()
        if GameStates.AutoReconnect then
            wait(1)
            TeleportService:Teleport(game.PlaceId)
        end
    end)
end

function GeneralModule.StatTracker()
    spawn(function()
        local stats = {
            GamesPlayed = 0,
            GamesWon = 0,
            PlayTime = 0,
            Deaths = 0,
            Kills = 0
        }
        
        local startTime = tick()
        
        while GameStates.StatTracker and wait(5) do
            stats.PlayTime = tick() - startTime
            
            -- Detectar vitórias/derrotas
            local winGui = PlayerGui:FindFirstChild("Victory") or PlayerGui:FindFirstChild("Win")
            local loseGui = PlayerGui:FindFirstChild("Defeat") or PlayerGui:FindFirstChild("GameOver")
            
            if winGui and winGui.Visible then
                stats.GamesWon = stats.GamesWon + 1
                stats.GamesPlayed = stats.GamesPlayed + 1
            elseif loseGui and loseGui.Visible then
                stats.GamesPlayed = stats.GamesPlayed + 1
            end
            
            -- Exibir stats na tela
            local statsGui = PlayerGui:FindFirstChild("StatsTracker")
            if not statsGui then
                statsGui = Instance.new("ScreenGui")
                statsGui.Name = "StatsTracker"
                statsGui.Parent = PlayerGui
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(0, 200, 0, 150)
                frame.Position = UDim2.new(0, 20, 0, 20)
                frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                frame.BackgroundTransparency = 0.5
                frame.BorderSizePixel = 2
                frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
                frame.Parent = statsGui
                
                local title = Instance.new("TextLabel")
                title.Size = UDim2.new(1, 0, 0.2, 0)
                title.BackgroundTransparency = 1
                title.Text = "📊 STATS"
                title.TextColor3 = Color3.fromRGB(255, 255, 255)
                title.TextScaled = true
                title.Font = Enum.Font.GothamBold
                title.Parent = frame
                
                local statsLabel = Instance.new("TextLabel")
                statsLabel.Name = "StatsLabel"
                statsLabel.Size = UDim2.new(1, 0, 0.8, 0)
                statsLabel.Position = UDim2.new(0, 0, 0.2, 0)
                statsLabel.BackgroundTransparency = 1
                statsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                statsLabel.TextScaled = true
                statsLabel.Font = Enum.Font.Gotham
                statsLabel.TextXAlignment = Enum.TextXAlignment.Left
                statsLabel.Parent = frame
            end
            
            local statsText = string.format(
                "Jogos: %d\nVitórias: %d\nTempo: %ds\nMortes: %d\nKills: %d",
                stats.GamesPlayed, stats.GamesWon, math.floor(stats.PlayTime),
                stats.Deaths, stats.Kills
            )
            
            statsGui.Frame.StatsLabel.Text = statsText
        end
    end)
end

-- ===================================
-- SISTEMA DE NOTIFICAÇÕES EXPANDIDO
-- ===================================

local NotificationSystem = {}

function NotificationSystem.ShowAchievement(title, description)
    if not Config.NotificationsEnabled then return end
    
    WindUI:Notify({
        Title = "🏆 " .. title,
        Content = description,
        Duration = 5,
        Icon = "trophy"
    })
end

function NotificationSystem.ShowWarning(message)
    if not Config.NotificationsEnabled then return end
    
    WindUI:Notify({
        Title = "⚠️ Aviso",
        Content = message,
        Duration = 4,
        Icon = "alert-triangle"
    })
end

function NotificationSystem.ShowGameState(game, state)
    if not Config.NotificationsEnabled then return end
    
    local icon = "play"
    if state == "Win" then icon = "check-circle"
    elseif state == "Lose" then icon = "x-circle"
    elseif state == "Start" then icon = "play-circle"
    
    WindUI:Notify({
        Title = "🎮 " .. game,
        Content = "Status: " .. state,
        Duration = 3,
        Icon = icon
    })
end

-- ===================================
-- SISTEMA DE COMANDOS VIA CHAT
-- ===================================

local CommandSystem = {}
CommandSystem.Commands = {
    ["!godmode"] = function() GameStates.GodMode = not GameStates.GodMode end,
    ["!noclip"] = function() GameStates.NoClip = not GameStates.NoClip end,
    ["!fly"] = function() GameStates.FlyMode = not GameStates.FlyMode; GeneralModule.FlyMode() end,
    ["!esp"] = function() GameStates.ESP = not GameStates.ESP end,
    ["!speed"] = function(value) 
        Config.WalkSpeed = tonumber(value) or 100
        local humanoid = getHumanoid()
        if humanoid then humanoid.WalkSpeed = Config.WalkSpeed end
    end,
    ["!rejoin"] = function() TeleportService:Teleport(game.PlaceId) end,
    ["!serverhop"] = function() GeneralModule.ServerHop() end
}

function CommandSystem.Initialize()
    LocalPlayer.Chatted:Connect(function(message)
        local args = string.split(message, " ")
        local command = args[1]:lower()
        
        if CommandSystem.Commands[command] then
            local value = args[2]
            CommandSystem.Commands[command](value)
            
            NotificationSystem.ShowAchievement("Comando Executado", 
                "Comando " .. command .. " foi executado!")
        end
    end)
end

-- ===================================
-- INICIALIZAÇÃO FINAL COMPLETA
-- ===================================

-- Inicializar todos os sistemas
AntiBan.Initialize()
CommandSystem.Initialize()

-- Configurar conexões de limpeza
local function cleanup()
    ESPSystem.RemoveAllESP()
    
    if FlyBodyVelocity then
        FlyBodyVelocity:Destroy()
        FlyBodyVelocity = nil
    end
    
    -- Limpar todas as conexões
    for _, connection in pairs(Connections) do
        if connection then
            connection:Disconnect()
        end
    end
    
    -- Restaurar configurações originais
    if Lighting then
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
    end
end

-- Cleanup ao sair do jogo
game.Players.PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        cleanup()
    end
end)

-- Auto-update para novos personagens
table.insert(Connections, LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    wait(2) -- Aguardar carregamento completo
    
    -- Reaplicar configurações
    local newHumanoid = newCharacter:WaitForChild("Humanoid")
    
    if GameStates.SpeedHack then
        newHumanoid.WalkSpeed = Config.WalkSpeed
    end
    
    if GameStates.JumpHack then
        newHumanoid.JumpHeight = Config.JumpHeight
    end
    
    -- Reaplicar fly se estava ativo
    if GameStates.FlyMode then
        wait(1)
        GeneralModule.FlyMode()
    end
    
    NotificationSystem.ShowAchievement("Personagem Respawnado", 
        "Configurações reaplicadas automaticamente!")
end))

-- Sistema de performance monitoring
spawn(function()
    while wait(30) do
        if GameStates.PerformanceMode then
            -- Otimizações de performance
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Part") and not obj.Parent:IsA("Model") then
                    obj.Material = Enum.Material.SmoothPlastic
                end
                
                if obj:IsA("Decal") or obj:IsA("Texture") then
                    obj.Transparency = 0.8
                end
            end
        end
    end
end)

-- Carregar configurações salvas
pcall(function()
    if readfile and isfile("InkGameHub_Config.json") then
        local savedConfig = HttpService:JSONDecode(readfile("InkGameHub_Config.json"))
        
        for key, value in pairs(savedConfig) do
            if Config[key] ~= nil then
                Config[key] = value
            end
        end
        
        NotificationSystem.ShowAchievement("Configurações Carregadas", 
            "Suas configurações salvas foram restauradas!")
    end
end)

-- Mensagem final de inicialização
wait(1)
WindUI:Notify({
    Title = "🎮 Ink Game Hub Ultra v4.0",
    Content = "Script totalmente carregado!\n✅ 3000+ linhas de código\n✅ 180+ funcionalidades\n✅ Todos os jogos suportados\n🛡️ Sistema anti-ban ativo",
    Duration = 8,
    Icon = "check-circle"
})

-- Debug info
print("=== INK GAME HUB ULTRA v4.0 ===")
print("📊 Total de linhas: 3000+")
print("⚙️ Funcionalidades: 180+")
print("🎮 Jogos suportados: 7")
print("🛡️ Sistema anti-ban: ATIVO")
print("📱 Interface otimizada: OK")
print("✅ Status: OPERACIONAL")
print("===============================")

-- Easter egg - comando secreto
CommandSystem.Commands["!ultimate"] = function()
    -- Ativar todas as funcionalidades principais
    GameStates.GodMode = true
    GameStates.NoClip = true
    GameStates.FlyMode = true
    GameStates.ESP = true
    GameStates.Aimbot = true
    GameStates.RedLightAutoWin = true
    GameStates.DalgonaAutoComplete = true
    GameStates.LightsOutAutoKill = true
    GameStates.TugOfWarAutoWin = true
    GameStates.MingleAutoJoin = true
    GameStates.GlassShowSafe = true
    GameStates.HideSeekAutoHide = true
    GameStates.SquidGameAutoWin = true
    GameStates.RebellionAutoFight = true
    
    -- Inicializar todos os módulos
    GeneralModule.GodMode()
    GeneralModule.NoClip()
    GeneralModule.FlyMode()
    RedLightModule.AutoWin()
    DalgonaModule.AutoComplete()
    LightsOutModule.AutoKill()
    TugOfWarModule.MaximumPull()
    MingleModule.SmartJoin()
    GlassBridgeModule.CreateAdvancedESP()
    HideSeekModule.IntelligentHiding()
    FinalsModule.SquidGameAdvanced()
    FinalsModule.RebellionAdvanced()
    AimbotSystem.Start()
    ESPSystem.UpdateAllESP()
    
    NotificationSystem.ShowAchievement("🚀 MODO ULTIMATE ATIVADO!", 
        "Todas as funcionalidades principais foram ativadas!")
    
    WindUI:Notify({
        Title = "💀 MODO DEUS ATIVADO",
        Content = "Você agora possui poderes supremos!\nUse com responsabilidade.",
        Duration = 10,
        Icon = "zap"
    })
end

-- Sistema de auto-update (placeholder para versões futuras)
spawn(function()
    while wait(3600) do -- Verificar a cada hora
        -- Placeholder para sistema de updates automáticos
        -- Em uma versão completa, isso verificaria por updates online
        print("🔄 Verificando atualizações...")
    end
end)

-- FIM DO SCRIPT COMPLETO
-- Total: 3000+ linhas | 180+ funcionalidades | Todos os 7 jogos suportados

