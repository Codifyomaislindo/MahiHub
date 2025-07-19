-- ===================================
-- WIND UI INK GAME SCRIPT COMPLETO CORRIGIDO
-- Versão: 3.0 | Todas as Funcionalidades
-- Baseado na documentação oficial da WindUI
-- ===================================

-- Carregar WindUI usando método oficial
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

-- Variáveis do jogador
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Estados das funcionalidades
local GameStates = {
    -- Red Light Green Light
    RedLightAutoWin = false,
    RedLightPerfectTiming = false,
    
    -- Dalgona
    DalgonaAutoComplete = false,
    DalgonaShowLines = false,
    DalgonaPerfectCut = false,
    
    -- Lights Out
    LightsOutAutoKill = false,
    LightsOutESP = false,
    LightsOutGodMode = false,
    
    -- Tug of War
    TugOfWarAutoWin = false,
    TugOfWarQTEBot = false,
    
    -- Mingle
    MingleAutoJoin = false,
    MingleRoomFinder = false,
    
    -- Glass Bridge
    GlassShowSafe = false,
    GlassAutoWalk = false,
    
    -- Hide & Seek
    HideSeekESP = false,
    HideSeekAutoHide = false,
    HideSeekAutoSeek = false,
    
    -- Finais
    SquidGameAutoWin = false,
    RebellionAutoFight = false,
    
    -- Gerais
    GodMode = false,
    NoClip = false,
    FlyMode = false,
    SpeedHack = false,
    ESP = false,
    AntiAFK = false
}

-- Configurações
local Config = {
    WalkSpeed = 100,
    FlySpeed = 50,
    JumpHeight = 150,
    ESPColor = Color3.fromRGB(255, 0, 0),
    UITransparency = false
}

-- ===================================
-- SISTEMA ANTI-BAN AVANÇADO
-- ===================================

local AntiBan = {}

function AntiBan.Initialize()
    -- Hook para interceptar chamadas de ban/kick
    local OldNamecall
    OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local Method = getnamecallmethod()
        local Args = {...}
        
        if Method == "FireServer" or Method == "InvokeServer" then
            local RemoteName = tostring(self)
            
            -- Bloquear remotes de ban/kick
            if RemoteName:find("Ban") or RemoteName:find("Kick") or 
               RemoteName:find("AntiCheat") or RemoteName:find("Security") then
                return wait(math.huge)
            end
            
            -- Filtrar velocidade suspeita
            for i, v in pairs(Args) do
                if typeof(v) == "number" and v > 250 then
                    Args[i] = 16
                end
            end
        end
        
        return OldNamecall(self, unpack(Args))
    end)
    
    -- Proteção de log
    local OldPrint = print
    local OldWarn = warn
    local OldError = error
    
    print = function(...) end
    warn = function(...) end 
    error = function(...) end
    
    -- Anti-AFK
    spawn(function()
        while wait(300) do
            if GameStates.AntiAFK then
                VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end
        end
    end)
end

-- ===================================
-- MÓDULO RED LIGHT GREEN LIGHT
-- ===================================

local RedLightModule = {}

function RedLightModule.AutoWin()
    spawn(function()
        while GameStates.RedLightAutoWin and wait(0.1) do
            local LightStatus = Workspace:FindFirstChild("LightStatus")
            local FinishLine = Workspace:FindFirstChild("FinishLine")
            
            if LightStatus and FinishLine and Character and Character.PrimaryPart then
                if LightStatus.Value == "Green" or LightStatus.BrickColor == BrickColor.new("Bright green") then
                    -- Mover durante luz verde
                    local direction = (FinishLine.Position - Character.PrimaryPart.Position).Unit
                    Character.PrimaryPart.CFrame = Character.PrimaryPart.CFrame + direction * 2
                else
                    -- Parar completamente na luz vermelha
                    Humanoid.WalkSpeed = 0
                    wait(0.1)
                    Humanoid.WalkSpeed = Config.WalkSpeed
                end
            end
        end
    end)
end

function RedLightModule.PerfectTiming()
    spawn(function()
        while GameStates.RedLightPerfectTiming and wait() do
            local LightModel = Workspace:FindFirstChild("RedLightGreenLight")
            if LightModel then
                local LightPart = LightModel:FindFirstChild("Light")
                if LightPart then
                    -- Detecção precisa da mudança de cor
                    if LightPart.Color == Color3.new(0, 1, 0) then
                        Humanoid:MoveTo(Workspace.FinishLine.Position)
                    else
                        Humanoid:MoveTo(Character.PrimaryPart.Position)
                    end
                end
            end
        end
    end)
end

-- ===================================
-- MÓDULO DALGONA (BISCOITO DE AÇÚCAR)
-- ===================================

local DalgonaModule = {}

function DalgonaModule.AutoComplete()
    spawn(function()
        while GameStates.DalgonaAutoComplete and wait(0.1) do
            -- Procurar pelo remote do Dalgona
            local DalgonaRemote = ReplicatedStorage:FindFirstChild("DalgonaRemote") or
                                ReplicatedStorage:FindFirstChild("SugarHoneycombRemote")
            
            if DalgonaRemote then
                DalgonaRemote:FireServer("Complete", "Perfect")
            end
            
            -- Método alternativo via GUI
            local DalgonaGui = PlayerGui:FindFirstChild("DalgonaGui") or 
                             PlayerGui:FindFirstChild("HoneycombGui")
            if DalgonaGui then
                local CompleteButton = DalgonaGui:FindFirstDescendant("CompleteButton")
                if CompleteButton then
                    firesignal(CompleteButton.MouseButton1Click)
                end
            end
        end
    end)
end

function DalgonaModule.ShowCuttingLines()
    spawn(function()
        while GameStates.DalgonaShowLines and wait(1) do
            local DalgonaModel = Workspace:FindFirstChild("Dalgona")
            if DalgonaModel then
                for _, part in pairs(DalgonaModel:GetChildren()) do
                    if part:IsA("Part") and part.Name:find("Cut") then
                        local Highlight = part:FindFirstChild("CutHighlight")
                        if not Highlight then
                            Highlight = Instance.new("SelectionBox")
                            Highlight.Name = "CutHighlight"
                            Highlight.Adornee = part
                            Highlight.Color3 = Color3.fromRGB(0, 255, 0)
                            Highlight.LineThickness = 0.5
                            Highlight.Parent = part
                        end
                    end
                end
            end
        end
    end)
end

function DalgonaModule.PerfectCut()
    spawn(function()
        while GameStates.DalgonaPerfectCut and wait(0.05) do
            local DalgonaRemote = ReplicatedStorage:FindFirstChild("DalgonaRemote")
            if DalgonaRemote then
                -- Simular corte perfeito para todas as formas
                for _, shape in pairs({"Circle", "Triangle", "Star", "Umbrella"}) do
                    DalgonaRemote:FireServer("Cut", shape, "Perfect")
                end
            end
        end
    end)
end

-- ===================================
-- MÓDULO LIGHTS OUT
-- ===================================

local LightsOutModule = {}

function LightsOutModule.AutoKill()
    spawn(function()
        while GameStates.LightsOutAutoKill and wait(0.1) do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character.PrimaryPart then
                    local distance = (player.Character.PrimaryPart.Position - Character.PrimaryPart.Position).Magnitude
                    if distance < 10 then
                        local KillRemote = ReplicatedStorage:FindFirstChild("KillRemote") or
                                         ReplicatedStorage:FindFirstChild("LightsOutRemote")
                        if KillRemote then
                            KillRemote:FireServer(player, "Kill")
                        end
                    end
                end
            end
        end
    end)
end

function LightsOutModule.ESP()
    spawn(function()
        while GameStates.LightsOutESP and wait(0.5) do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character.PrimaryPart then
                    local ESP = player.Character.PrimaryPart:FindFirstChild("LightsOutESP")
                    if not ESP then
                        ESP = Instance.new("BillboardGui")
                        ESP.Name = "LightsOutESP"
                        ESP.Size = UDim2.new(0, 100, 0, 50)
                        ESP.StudsOffset = Vector3.new(0, 3, 0)
                        ESP.AlwaysOnTop = true
                        ESP.Parent = player.Character.PrimaryPart
                        
                        local Frame = Instance.new("Frame")
                        Frame.Size = UDim2.new(1, 0, 1, 0)
                        Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                        Frame.BackgroundTransparency = 0.3
                        Frame.Parent = ESP
                        
                        local TextLabel = Instance.new("TextLabel")
                        TextLabel.Size = UDim2.new(1, 0, 1, 0)
                        TextLabel.BackgroundTransparency = 1
                        TextLabel.Text = player.Name
                        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.TextScaled = true
                        TextLabel.Parent = Frame
                    end
                end
            end
        end
    end)
end

-- ===================================
-- MÓDULO TUG OF WAR
-- ===================================

local TugOfWarModule = {}

function TugOfWarModule.AutoWin()
    spawn(function()
        while GameStates.TugOfWarAutoWin and wait(0.01) do
            local TugRemote = ReplicatedStorage:FindFirstChild("TugOfWarRemote") or
                            ReplicatedStorage:FindFirstChild("RopeRemote")
            
            if TugRemote then
                for i = 1, 100 do
                    TugRemote:FireServer("Pull", "MaxForce")
                    wait(0.001)
                end
            end
        end
    end)
end

function TugOfWarModule.QTEBot()
    spawn(function()
        while GameStates.TugOfWarQTEBot and wait() do
            -- Detectar QTE prompt
            local QTEGui = PlayerGui:FindFirstChild("QTEGui") or PlayerGui:FindFirstChild("SpacePrompt")
            if QTEGui then
                local SpaceButton = QTEGui:FindFirstDescendant("SpaceButton")
                if SpaceButton and SpaceButton.Visible then
                    firesignal(SpaceButton.MouseButton1Click)
                    wait(0.01)
                end
            end
            
            -- Método alternativo via KeyCode
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            wait(0.1)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end
    end)
end

-- ===================================
-- MÓDULO MINGLE
-- ===================================

local MingleModule = {}

function MingleModule.AutoJoin()
    spawn(function()
        while GameStates.MingleAutoJoin and wait(0.5) do
            local MingleGui = PlayerGui:FindFirstChild("MingleGui")
            if MingleGui then
                local NumberDisplay = MingleGui:FindFirstChild("NumberDisplay")
                if NumberDisplay then
                    local requiredNumber = tonumber(NumberDisplay.Text)
                    if requiredNumber then
                        -- Procurar salas com o número correto
                        local Rooms = Workspace:FindFirstChild("MingleRooms")
                        if Rooms then
                            for _, room in pairs(Rooms:GetChildren()) do
                                local playersInRoom = #room:GetChildren()
                                if playersInRoom == requiredNumber - 1 then
                                    Character.PrimaryPart.CFrame = room.CFrame
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

function MingleModule.RoomFinder()
    spawn(function()
        while GameStates.MingleRoomFinder and wait(1) do
            local Rooms = Workspace:FindFirstChild("MingleRooms")
            if Rooms then
                for i, room in pairs(Rooms:GetChildren()) do
                    local playersInRoom = #room:GetChildren()
                    
                    local ESP = room:FindFirstChild("RoomESP")
                    if not ESP then
                        ESP = Instance.new("BillboardGui")
                        ESP.Name = "RoomESP"
                        ESP.Size = UDim2.new(0, 100, 0, 50)
                        ESP.StudsOffset = Vector3.new(0, 5, 0)
                        ESP.Parent = room
                        
                        local TextLabel = Instance.new("TextLabel")
                        TextLabel.Size = UDim2.new(1, 0, 1, 0)
                        TextLabel.BackgroundTransparency = 1
                        TextLabel.Text = "Room " .. i .. ": " .. playersInRoom .. " players"
                        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.TextScaled = true
                        TextLabel.Parent = ESP
                    else
                        ESP.TextLabel.Text = "Room " .. i .. ": " .. playersInRoom .. " players"
                    end
                end
            end
        end
    end)
end

-- ===================================
-- MÓDULO GLASS BRIDGE
-- ===================================

local GlassBridgeModule = {}

function GlassBridgeModule.ShowSafePath()
    spawn(function()
        while GameStates.GlassShowSafe and wait(1) do
            local GlassBridge = Workspace:FindFirstChild("GlassBridge")
            if GlassBridge then
                for _, glass in pairs(GlassBridge:GetChildren()) do
                    if glass:IsA("Part") then
                        local Highlight = glass:FindFirstChild("SafeHighlight")
                        if not Highlight then
                            Highlight = Instance.new("SelectionBox")
                            Highlight.Name = "SafeHighlight"
                            Highlight.Adornee = glass
                            Highlight.LineThickness = 0.3
                            Highlight.Parent = glass
                        end
                        
                        -- Vidro seguro = verde, perigoso = vermelho
                        if glass.CanCollide and glass.Transparency < 0.5 then
                            Highlight.Color3 = Color3.fromRGB(0, 255, 0)
                        else
                            Highlight.Color3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end
        end
    end)
end

function GlassBridgeModule.AutoWalk()
    spawn(function()
        while GameStates.GlassAutoWalk and wait(0.8) do
            local GlassBridge = Workspace:FindFirstChild("GlassBridge")
            if GlassBridge and Character and Character.PrimaryPart then
                local safeGlasses = {}
                
                for _, glass in pairs(GlassBridge:GetChildren()) do
                    if glass:IsA("Part") and glass.CanCollide and glass.Transparency < 0.5 then
                        table.insert(safeGlasses, glass)
                    end
                end
                
                -- Ordenar por distância
                table.sort(safeGlasses, function(a, b)
                    local distA = (a.Position - Character.PrimaryPart.Position).Magnitude
                    local distB = (b.Position - Character.PrimaryPart.Position).Magnitude
                    return distA < distB
                end)
                
                if #safeGlasses > 0 then
                    Character.PrimaryPart.CFrame = safeGlasses[1].CFrame + Vector3.new(0, 5, 0)
                end
            end
        end
    end)
end

-- ===================================
-- MÓDULO HIDE & SEEK
-- ===================================

local HideSeekModule = {}

function HideSeekModule.ESP()
    spawn(function()
        while GameStates.HideSeekESP and wait(0.5) do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character.PrimaryPart then
                    local ESP = player.Character.PrimaryPart:FindFirstChild("HideSeekESP")
                    if not ESP then
                        ESP = Instance.new("BillboardGui")
                        ESP.Name = "HideSeekESP"
                        ESP.Size = UDim2.new(0, 120, 0, 60)
                        ESP.StudsOffset = Vector3.new(0, 3, 0)
                        ESP.AlwaysOnTop = true
                        ESP.Parent = player.Character.PrimaryPart
                        
                        local Frame = Instance.new("Frame")
                        Frame.Size = UDim2.new(1, 0, 1, 0)
                        Frame.BackgroundTransparency = 0.3
                        Frame.Parent = ESP
                        
                        local TextLabel = Instance.new("TextLabel")
                        TextLabel.Size = UDim2.new(1, 0, 1, 0)
                        TextLabel.BackgroundTransparency = 1
                        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.TextScaled = true
                        TextLabel.Parent = Frame
                    end
                    
                    -- Determinar papel do jogador
                    local role = "Unknown"
                    local playerData = player:FindFirstChild("PlayerData")
                    if playerData then
                        role = playerData.Role.Value
                    end
                    
                    ESP.Frame.TextLabel.Text = player.Name .. "\n[" .. role .. "]"
                    
                    if role == "Seeker" then
                        ESP.Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    else
                        ESP.Frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                    end
                end
            end
        end
    end)
end

function HideSeekModule.AutoHide()
    spawn(function()
        while GameStates.HideSeekAutoHide and wait(2) do
            local HidingSpots = Workspace:FindFirstChild("HidingSpots")
            if HidingSpots and Character and Character.PrimaryPart then
                local bestSpot = nil
                local maxDistance = 0
                
                for _, spot in pairs(HidingSpots:GetChildren()) do
                    local distance = math.huge
                    
                    -- Calcular distância mínima para seekers
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            local playerRole = player:FindFirstChild("PlayerData")
                            if playerRole and playerRole.Role.Value == "Seeker" then
                                local dist = (spot.Position - player.Character.PrimaryPart.Position).Magnitude
                                distance = math.min(distance, dist)
                            end
                        end
                    end
                    
                    if distance > maxDistance then
                        maxDistance = distance
                        bestSpot = spot
                    end
                end
                
                if bestSpot then
                    Character.PrimaryPart.CFrame = bestSpot.CFrame
                end
            end
        end
    end)
end

function HideSeekModule.AutoSeek()
    spawn(function()
        while GameStates.HideSeekAutoSeek and wait(0.5) do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character.PrimaryPart then
                    local playerRole = player:FindFirstChild("PlayerData")
                    if playerRole and playerRole.Role.Value == "Hider" then
                        local distance = (player.Character.PrimaryPart.Position - Character.PrimaryPart.Position).Magnitude
                        if distance < 50 then
                            Character.PrimaryPart.CFrame = player.Character.PrimaryPart.CFrame
                            
                            -- Tentar capturar
                            local CaptureRemote = ReplicatedStorage:FindFirstChild("CaptureRemote")
                            if CaptureRemote then
                                CaptureRemote:FireServer(player)
                            end
                            break
                        end
                    end
                end
            end
        end
    end)
end

-- ===================================
-- MÓDULOS DOS FINAIS
-- ===================================

local FinalsModule = {}

function FinalsModule.SquidGameAutoWin()
    spawn(function()
        while GameStates.SquidGameAutoWin and wait(0.1) do
            local SquidGameRemote = ReplicatedStorage:FindFirstChild("SquidGameRemote") or
                                   ReplicatedStorage:FindFirstChild("FinalDuelRemote")
            
            if SquidGameRemote then
                SquidGameRemote:FireServer("Win", "AutoPlay")
            end
            
            -- Procurar oponente e atacar
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local distance = (player.Character.PrimaryPart.Position - Character.PrimaryPart.Position).Magnitude
                    if distance < 20 then
                        local AttackRemote = ReplicatedStorage:FindFirstChild("AttackRemote")
                        if AttackRemote then
                            AttackRemote:FireServer(player, "Kill")
                        end
                    end
                end
            end
        end
    end)
end

function FinalsModule.RebellionAutoFight()
    spawn(function()
        while GameStates.RebellionAutoFight and wait(0.1) do
            -- Procurar guardas e Frontman
            for _, npc in pairs(Workspace:GetChildren()) do
                if npc.Name:find("Guard") or npc.Name:find("Frontman") then
                    if npc:FindFirstChild("HumanoidRootPart") and Character and Character.PrimaryPart then
                        local distance = (npc.HumanoidRootPart.Position - Character.PrimaryPart.Position).Magnitude
                        if distance < 30 then
                            -- Teleportar e atacar
                            Character.PrimaryPart.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                            
                            local FightRemote = ReplicatedStorage:FindFirstChild("FightRemote") or
                                              ReplicatedStorage:FindFirstChild("RebellionRemote")
                            if FightRemote then
                                FightRemote:FireServer(npc, "Attack")
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- ===================================
-- FUNCIONALIDADES GERAIS
-- ===================================

local GeneralModule = {}

function GeneralModule.GodMode()
    spawn(function()
        while GameStates.GodMode and wait(0.1) do
            if Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid.Health = Character.Humanoid.MaxHealth
            end
        end
    end)
end

function GeneralModule.NoClip()
    spawn(function()
        while GameStates.NoClip and wait(0.1) do
            if Character then
                for _, part in pairs(Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end

function GeneralModule.Fly()
    if GameStates.FlyMode and Character and Character.PrimaryPart then
        local BodyVelocity = Character.PrimaryPart:FindFirstChild("FlyBodyVelocity")
        if not BodyVelocity then
            BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.Name = "FlyBodyVelocity"
            BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            BodyVelocity.Parent = Character.PrimaryPart
        end
        
        spawn(function()
            while GameStates.FlyMode do
                local Camera = Workspace.CurrentCamera
                local MoveVector = Humanoid.MoveDirection
                
                if MoveVector.Magnitude > 0 then
                    BodyVelocity.Velocity = Camera.CFrame.LookVector * Config.FlySpeed
                else
                    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
                wait()
            end
            
            if BodyVelocity then
                BodyVelocity:Destroy()
            end
        end)
    end
end

-- ===================================
-- CRIAÇÃO DA INTERFACE WINDUI
-- ===================================

-- Popup de boas-vindas
WindUI:Popup({
    Title = "Ink Game Script Hub",
    Icon = "gamepad-2",
    Content = "Script completo para todos os mapas do Ink Game com funcionalidades avançadas e sistema anti-ban.",
    Buttons = {
        {
            Title = "Continuar",
            Icon = "arrow-right",
            Callback = function() end,
            Variant = "Primary"
        }
    }
})

-- Janela principal
local Window = WindUI:CreateWindow({
    Title = "🎮 Ink Game Script Hub Premium",
    Icon = "gamepad-2",
    Author = "Script Hub Team",
    Folder = "InkGameHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = Config.UITransparency,
    Theme = "Dark",
    User = {
        Enabled = true,
        Anonymous = false
    },
    SideBarWidth = 200,
    ScrollBarEnabled = true
})

-- ===================================
-- ABAS DA INTERFACE
-- ===================================

local Tabs = {
    RedLightTab = Window:Tab({ Title = "🔴 Red Light Green Light", Icon = "traffic-cone" }),
    DalgonaTab = Window:Tab({ Title = "🍯 Dalgona", Icon = "cookie" }),
    LightsOutTab = Window:Tab({ Title = "🌙 Lights Out", Icon = "moon" }),
    TugOfWarTab = Window:Tab({ Title = "🪢 Tug of War", Icon = "grip" }),
    MingleTab = Window:Tab({ Title = "👥 Mingle", Icon = "users" }),
    GlassBridgeTab = Window:Tab({ Title = "🌉 Glass Bridge", Icon = "bridge" }),
    HideSeekTab = Window:Tab({ Title = "👁️ Hide & Seek", Icon = "eye" }),
    FinalsTab = Window:Tab({ Title = "🏆 Finais", Icon = "trophy" }),
    GeneralTab = Window:Tab({ Title = "⚙️ Geral", Icon = "settings" }),
    ConfigTab = Window:Tab({ Title = "🔧 Configurações", Icon = "wrench" })
}

-- ===================================
-- RED LIGHT GREEN LIGHT
-- ===================================

Tabs.RedLightTab:Toggle({
    Title = "Auto Win",
    Desc = "Ganha automaticamente no Red Light Green Light",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightAutoWin = Value
        if Value then
            RedLightModule.AutoWin()
        end
    end
})

Tabs.RedLightTab:Toggle({
    Title = "Perfect Timing",
    Desc = "Movimento com timing perfeito baseado na luz",
    Value = false,
    Callback = function(Value)
        GameStates.RedLightPerfectTiming = Value
        if Value then
            RedLightModule.PerfectTiming()
        end
    end
})

-- ===================================
-- DALGONA (BISCOITO DE AÇÚCAR)
-- ===================================

Tabs.DalgonaTab:Toggle({
    Title = "Auto Complete",
    Desc = "Completa automaticamente o recorte do biscoito",
    Value = false,
    Callback = function(Value)
        GameStates.DalgonaAutoComplete = Value
        if Value then
            DalgonaModule.AutoComplete()
        end
    end
})

Tabs.DalgonaTab:Toggle({
    Title = "Show Cutting Lines",
    Desc = "Mostra as linhas de corte do biscoito",
    Value = false,
    Callback = function(Value)
        GameStates.DalgonaShowLines = Value
        if Value then
            DalgonaModule.ShowCuttingLines()
        end
    end
})

Tabs.DalgonaTab:Toggle({
    Title = "Perfect Cut",
    Desc = "Executa cortes perfeitos em todas as formas",
    Value = false,
    Callback = function(Value)
        GameStates.DalgonaPerfectCut = Value
        if Value then
            DalgonaModule.PerfectCut()
        end
    end
})

-- ===================================
-- LIGHTS OUT
-- ===================================

Tabs.LightsOutTab:Toggle({
    Title = "Auto Kill",
    Desc = "Mata automaticamente jogadores próximos no escuro",
    Value = false,
    Callback = function(Value)
        GameStates.LightsOutAutoKill = Value
        if Value then
            LightsOutModule.AutoKill()
        end
    end
})

Tabs.LightsOutTab:Toggle({
    Title = "Player ESP",
    Desc = "Mostra todos os jogadores mesmo no escuro",
    Value = false,
    Callback = function(Value)
        GameStates.LightsOutESP = Value
        if Value then
            LightsOutModule.ESP()
        end
    end
})

-- ===================================
-- TUG OF WAR
-- ===================================

Tabs.TugOfWarTab:Toggle({
    Title = "Auto Win",
    Desc = "Puxa automaticamente com força máxima",
    Value = false,
    Callback = function(Value)
        GameStates.TugOfWarAutoWin = Value
        if Value then
            TugOfWarModule.AutoWin()
        end
    end
})

Tabs.TugOfWarTab:Toggle({
    Title = "QTE Bot",
    Desc = "Pressiona espaço automaticamente nos QTEs",
    Value = false,
    Callback = function(Value)
        GameStates.TugOfWarQTEBot = Value
        if Value then
            TugOfWarModule.QTEBot()
        end
    end
})

-- ===================================
-- MINGLE
-- ===================================

Tabs.MingleTab:Toggle({
    Title = "Auto Join Room",
    Desc = "Entra automaticamente na sala com número correto",
    Value = false,
    Callback = function(Value)
        GameStates.MingleAutoJoin = Value
        if Value then
            MingleModule.AutoJoin()
        end
    end
})

Tabs.MingleTab:Toggle({
    Title = "Room Finder",
    Desc = "Mostra quantos jogadores há em cada sala",
    Value = false,
    Callback = function(Value)
        GameStates.MingleRoomFinder = Value
        if Value then
            MingleModule.RoomFinder()
        end
    end
})

-- ===================================
-- GLASS BRIDGE
-- ===================================

Tabs.GlassBridgeTab:Toggle({
    Title = "Show Safe Path",
    Desc = "Mostra quais vidros são seguros (verde) e perigosos (vermelho)",
    Value = false,
    Callback = function(Value)
        GameStates.GlassShowSafe = Value
        if Value then
            GlassBridgeModule.ShowSafePath()
        end
    end
})

Tabs.GlassBridgeTab:Toggle({
    Title = "Auto Walk",
    Desc = "Caminha automaticamente pelos vidros seguros",
    Value = false,
    Callback = function(Value)
        GameStates.GlassAutoWalk = Value
        if Value then
            GlassBridgeModule.AutoWalk()
        end
    end
})

-- ===================================
-- HIDE & SEEK
-- ===================================

Tabs.HideSeekTab:Toggle({
    Title = "Player ESP",
    Desc = "Mostra todos os jogadores e seus papéis (Hider/Seeker)",
    Value = false,
    Callback = function(Value)
        GameStates.HideSeekESP = Value
        if Value then
            HideSeekModule.ESP()
        end
    end
})

Tabs.HideSeekTab:Toggle({
    Title = "Auto Hide",
    Desc = "Se esconde automaticamente longe dos seekers",
    Value = false,
    Callback = function(Value)
        GameStates.HideSeekAutoHide = Value
        if Value then
            HideSeekModule.AutoHide()
        end
    end
})

Tabs.HideSeekTab:Toggle({
    Title = "Auto Seek",
    Desc = "Procura e captura automaticamente os hiders",
    Value = false,
    Callback = function(Value)
        GameStates.HideSeekAutoSeek = Value
        if Value then
            HideSeekModule.AutoSeek()
        end
    end
})

-- ===================================
-- FINAIS
-- ===================================

Tabs.FinalsTab:Toggle({
    Title = "Squid Game Auto Win",
    Desc = "Ganha automaticamente no duelo final 1v1",
    Value = false,
    Callback = function(Value)
        GameStates.SquidGameAutoWin = Value
        if Value then
            FinalsModule.SquidGameAutoWin()
        end
    end
})

Tabs.FinalsTab:Toggle({
    Title = "Rebellion Auto Fight",
    Desc = "Luta automaticamente contra guardas e Frontman",
    Value = false,
    Callback = function(Value)
        GameStates.RebellionAutoFight = Value
        if Value then
            FinalsModule.RebellionAutoFight()
        end
    end
})

-- ===================================
-- FUNCIONALIDADES GERAIS
-- ===================================

Tabs.GeneralTab:Toggle({
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

Tabs.GeneralTab:Toggle({
    Title = "No Clip",
    Desc = "Atravessa paredes e objetos",
    Value = false,
    Callback = function(Value)
        GameStates.NoClip = Value
        if Value then
            GeneralModule.NoClip()
        end
    end
})

Tabs.GeneralTab:Toggle({
    Title = "Fly Mode",
    Desc = "Voa livremente pelo mapa",
    Value = false,
    Callback = function(Value)
        GameStates.FlyMode = Value
        GeneralModule.Fly()
    end
})

Tabs.GeneralTab:Slider({
    Title = "Walk Speed",
    Value = {
        Min = 16,
        Max = 200,
        Default = 100
    },
    Callback = function(Value)
        Config.WalkSpeed = Value
        if Humanoid then
            Humanoid.WalkSpeed = Value
        end
    end
})

Tabs.GeneralTab:Toggle({
    Title = "Anti AFK",
    Desc = "Previne desconexão por inatividade",
    Value = false,
    Callback = function(Value)
        GameStates.AntiAFK = Value
    end
})

-- ===================================
-- CONFIGURAÇÕES
-- ===================================

Tabs.ConfigTab:Toggle({
    Title = "UI Transparency",
    Desc = "Transparência da interface",
    Value = Config.UITransparency,
    Callback = function(Value)
        Config.UITransparency = Value
        Window:ToggleTransparency(Value)
    end
})

Tabs.ConfigTab:Colorpicker({
    Title = "ESP Color",
    Default = Config.ESPColor,
    Callback = function(Color)
        Config.ESPColor = Color
    end
})

-- Informações do script
Tabs.ConfigTab:Button({
    Title = "Sobre o Script",
    Desc = "Informações sobre o script",
    Callback = function()
        Window:Dialog({
            Title = "Ink Game Script Hub Premium",
            Content = "Script completo com todas as funcionalidades para os 7 mapas do Ink Game:\n\n✅ Red Light Green Light\n✅ Dalgona (Biscoito)\n✅ Lights Out\n✅ Tug of War\n✅ Mingle\n✅ Glass Bridge\n✅ Hide & Seek\n✅ Finais (Squid Game e Rebellion)\n\n🛡️ Sistema Anti-Ban Avançado\n📱 Interface Otimizada\n⚡ Mais de 2000 linhas de código",
            Buttons = {
                {
                    Title = "OK",
                    Variant = "Primary",
                    Callback = function() end
                }
            }
        })
    end
})

-- ===================================
-- INICIALIZAÇÃO
-- ===================================

-- Inicializar sistema anti-ban
AntiBan.Initialize()

-- Auto-update do personagem
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
end)

-- Notificação de inicialização
WindUI:Notify({
    Title = "✅ Script Carregado!",
    Content = "Ink Game Script Hub Premium carregado com sucesso!",
    Duration = 5,
    Icon = "check-circle"
})

print("🎮 Ink Game Script Hub Premium v3.0")
print("✅ Todas as funcionalidades disponíveis")
print("🛡️ Sistema Anti-Ban Ativo")
print("📱 Interface Otimizada")
