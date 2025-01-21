local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:WaitForChild("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)  
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = frame

local dragging = false
local dragInput, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging then
        updateDrag(input)
    end
end)

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 250, 0, 40)
textBox.Position = UDim2.new(0.5, -125, 0.2, 0)
textBox.PlaceholderText = "Enter target player's name"
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
textBox.Parent = frame

local textBoxCorner = Instance.new("UICorner")
textBoxCorner.CornerRadius = UDim.new(0, 12)
textBoxCorner.Parent = textBox

local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0, 200, 0, 40)
teleportButton.Position = UDim2.new(0.5, -100, 0.6, 0)
teleportButton.Text = "Kill that guy!"
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 12)
buttonCorner.Parent = teleportButton

local killallButton = Instance.new("TextButton")
killallButton.Size = UDim2.new(0, 200, 0, 40)
killallButton.Position = UDim2.new(0.5, -100, 0.8, 0)
killallButton.Text = "Kill All!"
killallButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
killallButton.TextColor3 = Color3.fromRGB(255, 255, 255)
killallButton.Parent = frame

local killallButtonCorner = Instance.new("UICorner")
killallButtonCorner.CornerRadius = UDim.new(0, 12)
killallButtonCorner.Parent = killallButton

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Parent = frame

local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(0, 6)
closeButtonCorner.Parent = closeButton

local function killPlayer(targetPlayerName)
local player = game.Players.LocalPlayer
local backpack = player.Backpack
local tool = backpack:FindFirstChild("Deagle")
local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
    if targetPlayer then
        if tool then
            tool.Parent = player.Character
        end
        local args = {
            [1] = game:GetService("Players").LocalPlayer.Character.Deagle,
            [2] = "Fire",
            [3] = {
                ["direction"] = nil,
                ["bullet"] = game:GetService("ReplicatedStorage"):WaitForChild("Models"):WaitForChild("Bullets"):WaitForChild("Default"),
                ["velocity"] = 500000,
                ["origin"] = nil
            }
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Fire"):FireServer(unpack(args))
        local args = {
            [1] = "Deagle",
            [2] = "Hit",
            [3] = {
                ["normal"] = Vector3.new(-0.4400511384010315, -0.12969748675823212, 0.8885570168495178),
                ["velocity"] = Vector3.new(3335.442626953125, 61.502159118652344, -3724.331298828125),
                ["hit"] = game:GetService("Players")[targetPlayerName].Character.Head,
                ["position"] = Vector3.new(617.7619018554688, 2391.036865234375, 514.4943237304688)
            }
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Fire"):FireServer(unpack(args))
        local args = {
            [1] = game:GetService("Players").LocalPlayer.Character.Deagle
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Reload"):InvokeServer(unpack(args))
        task.wait(2)
        
        tool.Parent = backpack


        print("Player not found!")
    end
end

local function killAllPlayers()
    local player = game.Players.LocalPlayer
    local backpack = player.Backpack
    local tool = backpack:FindFirstChild("Deagle")

    if tool then
        tool.Parent = player.Character
    end


    for _, targetPlayer in pairs(game.Players:GetPlayers()) do
        if targetPlayer ~= player then
            if targetPlayer.Name == "thevirtualboxgamer" then
                print("nah")
            else
            local argsFire = {
                [1] = game:GetService("Players").LocalPlayer.Character.Deagle,
                [2] = "Fire",
                [3] = {
                    ["direction"] = nil,
                    ["bullet"] = game:GetService("ReplicatedStorage"):WaitForChild("Models"):WaitForChild("Bullets"):WaitForChild("Default"),
                    ["velocity"] = 500000,
                    ["origin"] = nil
                }
            }

            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Fire"):FireServer(unpack(argsFire))

            local argsHit = {
                [1] = "Deagle",
                [2] = "Hit",
                [3] = {
                    ["normal"] = Vector3.new(-0.4400511384010315, -0.12969748675823212, 0.8885570168495178),
                    ["velocity"] = Vector3.new(3335.442626953125, 61.502159118652344, -3724.331298828125),
                    ["hit"] = targetPlayer.Character.Head,
                    ["position"] = targetPlayer.Character.Head.Position
                }
            }

            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Fire"):FireServer(unpack(argsHit))
            task.wait(0.5)
        end
        end
    end

    local argsReload = {
        [1] = game:GetService("Players").LocalPlayer.Character.Deagle
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Reload"):InvokeServer(unpack(argsReload))
    task.wait(2)

    if tool then
        tool.Parent = backpack
    end
end


killallButton.MouseButton1Click:Connect(function()
    killAllPlayers()
end)


teleportButton.MouseButton1Click:Connect(function()
    local targetPlayerName = textBox.Text
    if targetPlayerName and targetPlayerName ~= "" then
        killPlayer(targetPlayerName)
    else
        print("Please enter a valid player name!")
    end
end)











closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
