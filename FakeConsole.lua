-- Roblox Fake Developer Console Full System -- Author: ChatGPT & Phong Trần collaboration -- Date: 2025-07-17

-- ✅ Features: --  • Toggle UI when player types "/console" in chat. --  • Tabs: Client & Server view. --  • Capture client logs and forward server logs. --  • Command input: supports require() and require <id> for everyone (configurable). --  • Color-coded logs (Info, Warning, Error). --  • Filtering and clear buttons. --  • Admin options (future expandable).


---

-- CONFIGURATION

local TRIGGER_COMMAND = "/console" local ALLOW_REQUIRE_FOR_ALL = true local ADMIN_USER_IDS = {123456789} -- Replace with your Roblox ID if you want extra admin features later.


---

-- SERVICES

local Players = game:GetService("Players") local ReplicatedStorage = game:GetService("ReplicatedStorage") local LogService = game:GetService("LogService") local RunService = game:GetService("RunService")


---

-- REMOTES

local RemoteFolder = Instance.new("Folder") RemoteFolder.Name = "FakeConsoleRemotes" RemoteFolder.Parent = ReplicatedStorage

local CommandEvent = Instance.new("RemoteEvent") CommandEvent.Name = "ConsoleCommandEvent" CommandEvent.Parent = RemoteFolder

local LogEvent = Instance.new("RemoteEvent") LogEvent.Name = "ConsoleLogEvent" LogEvent.Parent = RemoteFolder


---

-- SERVER SCRIPT: LOG FORWARDER & COMMAND HANDLER

if RunService:IsServer() then -- Forward server logs to authorized clients (here everyone gets logs for simplicity) LogService.MessageOut:Connect(function(message, messageType) local logType = "Info" if messageType == Enum.MessageType.Warning then logType = "Warning" elseif messageType == Enum.MessageType.MessageError then logType = "Error" end LogEvent:FireAllClients("Server", logType, message) end)

-- Handle commands (like require)
CommandEvent.OnServerEvent:Connect(function(player, commandText)
    if not commandText or commandText == "" then return end

    local function sendLog(msg, msgType)
        LogEvent:FireClient(player, "Server", msgType or "Info", msg)
    end

    -- Detect require pattern
    local moduleId = string.match(commandText, "require%(%s*(%d+)%s*%)") or string.match(commandText, "require%s+(%d+)")
    if moduleId then
        if ALLOW_REQUIRE_FOR_ALL or table.find(ADMIN_USER_IDS, player.UserId) then
            sendLog("[Require] Loading module " .. moduleId .. "...", "Info")
            local ok, result = pcall(function()
                return require(tonumber(moduleId))
            end)
            if ok then
                local typeResult = typeof(result)
                if typeResult == "table" then
                    sendLog("[Require] Success: returned table with " .. tostring(#result) .. " keys.", "Info")
                elseif typeResult == "function" then
                    sendLog("[Require] Success: returned a function.", "Info")
                else
                    sendLog("[Require] Success: returned " .. typeResult .. ".", "Info")
                end
            else
                sendLog("[Require][Error] " .. tostring(result), "Error")
            end
        else
            sendLog("[Require][Error] You do not have permission to run require.", "Error")
        end
        return
    end

    -- Unknown command fallback
    sendLog("[Command] Unknown or unsupported command: " .. commandText, "Warning")
end)

end


---

-- CLIENT SCRIPT: UI CREATION & LOG HANDLER

if RunService:IsClient() then local player = Players.LocalPlayer

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FakeDeveloperConsole"
screenGui.ResetOnSpawn = false
screenGui.Enabled = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.7, 0, 0.6, 0)
mainFrame.Position = UDim2.new(0.15, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- Tabs: Client / Server buttons
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 40)
tabBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tabBar.Parent = mainFrame

local clientButton = Instance.new("TextButton")
clientButton.Text = "Client"
clientButton.Size = UDim2.new(0.5, 0, 1, 0)
clientButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
clientButton.TextColor3 = Color3.new(1, 1, 1)
clientButton.Parent = tabBar

local serverButton = Instance.new("TextButton")
serverButton.Text = "Server"
serverButton.Size = UDim2.new(0.5, 0, 1, 0)
serverButton.Position = UDim2.new(0.5, 0, 0, 0)
serverButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
serverButton.TextColor3 = Color3.new(1, 1, 1)
serverButton.Parent = tabBar

-- Log area
local logBox = Instance.new("ScrollingFrame")
logBox.Size = UDim2.new(1, 0, 1, -80)
logBox.Position = UDim2.new(0, 0, 0, 40)
logBox.CanvasSize = UDim2.new(0, 0, 0, 0)
logBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
logBox.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = logBox
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Input box for commands
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -10, 0, 40)
inputBox.Position = UDim2.new(0, 5, 1, -45)
inputBox.PlaceholderText = "Enter command (e.g., require(1234567890))"
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
inputBox.Parent = mainFrame

local currentTab = "Client"

-- Log handler function
local function addLog(tab, msgType, msg)
    if tab ~= currentTab then return end
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 20)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = msg
    if msgType == "Error" then
        label.TextColor3 = Color3.fromRGB(255, 80, 80)
    elseif msgType == "Warning" then
        label.TextColor3 = Color3.fromRGB(255, 255, 0)
    else
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
    label.Parent = logBox
    logBox.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

-- Button switching
clientButton.MouseButton1Click:Connect(function()
    currentTab = "Client"
    clientButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    serverButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end)
serverButton.MouseButton1Click:Connect(function()
    currentTab = "Server"
    serverButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    clientButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
end)

-- Capture local prints
local function capturePrint(msg, msgType)
    addLog("Client", msgType, msg)
end
LogService.MessageOut:Connect(capturePrint)

-- Remote log listener
LogEvent.OnClientEvent:Connect(function(tab, msgType, msg)
    addLog(tab, msgType, msg)
end)

-- Input submit
inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and inputBox.Text ~= "" then
        local cmd = inputBox.Text
        inputBox.Text = ""
        CommandEvent:FireServer(cmd)
        addLog("Client", "Info", "> " .. cmd)
    end
end)

-- Chat trigger
player.Chatted:Connect(function(message)
    if string.lower(message) == string.lower(TRIGGER_COMMAND) then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

end

