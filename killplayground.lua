local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()


local colors = {
    SchemeColor = Color3.fromRGB(0, 180, 0),    -- Less vibrant, muted green
    Background = Color3.fromRGB(20, 20, 20),     -- Dark background
    Header = Color3.fromRGB(30, 30, 30),         -- Slightly lighter dark gray for the header
    TextColor = Color3.fromRGB(255, 255, 255),   -- White text for readability
    ElementColor = Color3.fromRGB(20, 40, 20)    -- Dark muted green for elements
}



local Window = Library.CreateLib("Bloody Playground by ohavelka1", colors)
local KillTab = Window:NewTab("Kill")
local KillSection = KillTab:NewSection("Kill")
local playertokill = nil
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local espGUIs = {}
local espToggleState = false





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

local function HealPart()
    local part = workspace.Map.Tower.Traps.Buttons:FindFirstChild("Heal100Brick")
    local character = game.Players.LocalPlayer and game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")

    if part and hrp then
        local originalCFrame = hrp.CFrame
        local camPart = Instance.new("Part", workspace)
        camPart.Size = Vector3.new(1, 1, 1)
        camPart.Position = game.Players.LocalPlayer.Character.Head.Position
        camPart.Anchored = true
        camPart.Transparency = 1
        local cam = workspace.CurrentCamera
        cam.CameraType = Enum.CameraType.Scriptable
        cam.CFrame = CFrame.new(camPart.Position, game.Players.LocalPlayer.Character.Head.Position)
        task.wait(0)
        hrp.CFrame = part.CFrame * CFrame.new(5, 0, 0)
        task.wait(0.12)
        hrp.CFrame = part.CFrame
        task.wait(0)
        hrp.CFrame = originalCFrame
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom camPart:Destroy()
    end
end

local function removebodyparts()
    local player = game.Players.LocalPlayer
    if not player or not player.Character then return end

    local char = player.Character
    local root = char:FindFirstChild("HumanoidRootPart")
    local breakJoints = workspace.Map.Tower.Traps.Buttons:FindFirstChild("BreakJoints")
    local originalCFrame = root.CFrame

    if root and breakJoints then
        root.CFrame = CFrame.new(757, 2389, 256)
        breakJoints.Size = Vector3.new(0.5, 0.5, 0.5)
        task.wait(0.5)
        root.CFrame = CFrame.new(757, 2389, 252)
        local bodyParts = {"Left Arm", "Right Arm", "Left Leg", "Right Leg"}
        for _, partName in ipairs(bodyParts) do
            local part = char:FindFirstChild(partName)
            if part then
                breakJoints.CFrame = part.CFrame
                task.wait(0.2)
            end
        end
        breakJoints.CFrame = CFrame.new(757, 2386, 248)
        breakJoints.Size = Vector3.new(4, 1, 4)
        root.CFrame = originalCFrame
    end
end
local function teleportAndUse(currentOption)
    local player = game.Players.LocalPlayer
    if not player or not player.Character then return end

    local char = player.Character
    local root = char:FindFirstChild("HumanoidRootPart")

    local locations = {
        Knife = workspace.Map["Weapon Tables"].Knife,
        Deagle = workspace.Map["Weapon Tables"].Deagle,
        AK47 = workspace.Map["Weapon Tables"].AK47
    }

    local target = locations[currentOption]

    if root and target then
        local originalCFrame = root.CFrame
        root.CFrame = target.CFrame + Vector3.new(0,0,5)
        local prompt = target:FindFirstChild("ProximityPrompt")
        task.wait(0.2)
        if prompt then
            fireproximityprompt(prompt)
        end
        task.wait(0)
        root.CFrame = originalCFrame
    end
end







KillSection:NewTextBox("Type Player to Kill", "Press enter when typing the name of the player", function(txt)
	print(txt)
    playertokill = txt
end)

KillSection:NewButton("Kill Player", "Kills the player duh.", function()
    killPlayer(playertokill)
end)

KillSection:NewLabel("Kill All Players!")

KillSection:NewButton("Kill All!", "Kills all!, not 100%. still in development", function()
    killAllPlayers()
end)

KillSection:NewLabel("Click Kill Tool")
KillSection:NewButton("Click Kill Tool", "kills the player you click on. thats it...", function()
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local mouse = localPlayer:GetMouse()

local tool = Instance.new("Tool")
tool.Name = "ClickKill"
tool.RequiresHandle = false
tool.Parent = localPlayer:WaitForChild("Backpack")

local function onMouseClick()
    local target = mouse.Target
    if target then
        local character = target:FindFirstAncestorOfClass("Model")
        if character then
            local clickedPlayer = Players:GetPlayerFromCharacter(character)
            if clickedPlayer then
                killPlayer(clickedPlayer.Name)
            end
        end
    end
end

local clickConnection

tool.Equipped:Connect(function()
    clickConnection = mouse.Button1Down:Connect(onMouseClick)
end)

tool.Unequipped:Connect(function()
    if clickConnection then
        clickConnection:Disconnect()
        clickConnection = nil
    end
end)

end)

local CharTab = Window:NewTab("Character")
local CharSection = CharTab:NewSection("Character")

local autoHealEnabled = false

CharSection:NewToggle("Auto Heal", "automatically heals player if below 90 hp", function(state)
    autoHealEnabled = state
    while autoHealEnabled do
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            if game.Players.LocalPlayer.Character.Humanoid.Health <= 90 then
                HealPart()
            end
        end
        task.wait(0.1)
    end
end)

CharSection:NewButton("Remove Body Parts", "removes your arms and legs... youre disabled after pressing", function()
    removebodyparts()
end)


local ItemTab = Window:NewTab("Items")
local ItemSection = ItemTab:NewSection("Items")
local optiontogive = nil

ItemSection:NewDropdown("Choose a Weapon", "idk bro i am tired i am editing tis at 23:00", {"Deagle", "Knife", "AK47"}, function(currentOption)
    optiontogive = currentOption
end)

ItemSection:NewButton("Give Weapon", "gives you the weapon you clicked on in the list", function()
    teleportAndUse(optiontogive)
end)


local BoxTab = Window:NewTab("ESP-Hitbox")
local BoxSection = BoxTab:NewSection("ESP-Hitbox")

local headResizingEnabled = false



local function createESP(player)
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        if not character:FindFirstChild("ESP") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESP"
            billboard.Size = UDim2.new(8, 0, 10, 0)
            billboard.AlwaysOnTop = true
            billboard.Adornee = character.HumanoidRootPart
            billboard.Parent = character

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0.5, 0, 0.6, 0)
            frame.BackgroundTransparency = 0.7
            frame.BackgroundColor3 = Color3.new(1, 0, 0)
            frame.BorderColor3 = Color3.new(0, 0, 0)
            frame.Position = UDim2.new(0.255, 0, 0.22, 0)
            frame.Parent = billboard

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(3, 0, 0.6, 0)
            nameLabel.Position = UDim2.new(-1, 0, 0, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = Color3.new(1, 1, 1)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextScaled = true
            nameLabel.Font = Enum.Font.SourceSansBold
            nameLabel.Parent = billboard

            espGUIs[player.Name] = { billboard = billboard, frame = frame, nameLabel = nameLabel }
        end
    end
end

BoxSection:NewToggle("ESP Toggle - Doesnt Respawn", "Toggle ESP visibility", function(state)
    espToggleState = state

    if espToggleState == true then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer and not espGUIs[player.Name] then
                createESP(player)
            end
        end

        while true do
            wait(3)
            if espToggleState == true then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer and not espGUIs[player.Name] then
                    createESP(player)
                end
            end
        end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            local character = player.Character
            if character and character:FindFirstChild("ESP") then
                character.ESP:Destroy()
            end
        end
        espGUIs = {}
    end
end)


BoxSection:NewToggle("Toggle Head Resize", "Enable or Disable head resizing", function(state)
    headResizingEnabled = state
    print(state and "Head resizing enabled" or "Head resizing disabled")
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if headResizingEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") and player ~= Players.LocalPlayer then
                local head = player.Character.Head
                head.Size = Vector3.new(5, 5, 5)
                head.CanCollide = false
                --head.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2.5, 0)
            end
        end
    end
end)

local OtherTab = Window:NewTab("Other")
local OtherSection = OtherTab:NewSection("Other Stuff")

OtherSection:NewButton("Infinity Yield", "Infinity Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

OtherSection:NewButton("Invisibility", "Invisibility", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invisible-script-20557"))()
end)

