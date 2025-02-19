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
    local disparts = {
        workspace.Map.Tower.Traps.Buttons.Hurt35Brick,
        workspace.Map.Tower.Traps.Buttons.Heal50Brick,
        workspace.Map.Tower.Traps.Buttons.Heal5Brick,
        workspace.Map.Tower.Traps.Buttons.Hurt100Brick,
        workspace.Map.Tower.Traps.Buttons.Hurt15Brick,
    }
    
    for _, part in ipairs(disparts) do
        if part then
            part.CanCollide = false
            part.CanQuery = false
            part.CanTouch = false
        end
    end
    local healpart = workspace.Map.Tower.Traps.Buttons.Heal100Brick
    healpart.CanCollide = false
    healpart.Transparency = 1
    healpart.Size = Vector3.new(5,5,5)
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
        hrp.CFrame = part.CFrame * CFrame.new(5.5, 0, 0)
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

local running = false  

function ToggleLoop(state)
    running = state
    if running then
        while running do
            local A_1 = {
                "Right Shoulder", 
                "Left Shoulder", 
                "Neck"
            }

            local A_2 = {
                ["Left Shoulder"] = CFrame.new(-1, 0.5, 0, -1.1920929e-07, -0, -1, 0, 1, -0, 1, 0, -1.1920929e-07), 
                ["Right Shoulder"] = CFrame.new(1, 0.5, 0, -1.1920929e-07, 0, 1, 0, 1, 0, -1, 0, -1.1920929e-07), 
                ["Neck"] = CFrame.new(0, -100, 0, -1, 0.000413552742, -9.84977523e-05, -2.91038305e-11, 0.231693447, 0.97278893, 0.000425120787, 0.972788811, -0.231693566)
            }

            local Event = game:GetService("ReplicatedStorage").Remotes.LookAt
            Event:FireServer(A_1, A_2)
            task.wait(0)
        end
    else
        task.wait(0)
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


CharSection:NewToggle("Remove Head", "removes your head (it will still exist somewhere tho)", function(state)
    ToggleLoop(state)
end)

CharSection:NewButton("Remove Body Parts", "removes your arms and legs... youre disabled after pressing", function()
    removebodyparts()
end)
local infslidetoggled = false
local hasbeentoggleinfslide = false

CharSection:NewToggle("Toggle inf slide keybind", "just a keybind check the function itself for info!", function(state)
    if state then
        infslidetoggled = true
    else
        infslidetoggled = false
    end
end)

CharSection:NewKeybind("Infinity slide!", "makes you slide infinitly", Enum.KeyCode.F, function()
	if infslidetoggled == true then
    if hasbeentoggleinfslide == false then
        print("shoud be enabled")
        hasbeentoggleinfslide = true
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local hrp = character:WaitForChild("HumanoidRootPart")
        local camera = workspace.CurrentCamera
        local animScript = character:FindFirstChild("Animate")
        if animScript then
        	animScript.Disabled = true
        end
        humanoid.Sit = true
        task.wait(0.1)
        hrp.CFrame = hrp.CFrame * CFrame.Angles(math.rad(90), 0, 0)
        local bodyVel = Instance.new("BodyVelocity")
        bodyVel.Parent = hrp
        bodyVel.MaxForce = Vector3.new(5000, 10, 5000)
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Parent = hrp
        bodyGyro.MaxTorque = Vector3.new(5000, 5000, 5000)
        bodyGyro.D = 300  
        bodyGyro.P = 3000 
        local RunService = game:GetService("RunService")
        local heartbeatConn
        heartbeatConn = RunService.RenderStepped:Connect(function()
	        if not humanoid.Sit then
		        bodyVel:Destroy()
		        bodyGyro:Destroy()
		        if animScript then
			        animScript.Disabled = false
		        end
		        heartbeatConn:Disconnect()
                hasbeentoggleinfslide = false
                print("shoud be disabled")

		        return
	        end

        	local camLook = camera.CFrame.LookVector
	        local flatLookVector = Vector3.new(camLook.X, 0, camLook.Z).Unit
	        bodyGyro.CFrame = CFrame.new(hrp.Position, hrp.Position + flatLookVector) * CFrame.Angles(math.rad(90), 0, 0)
	        local adjustedForward = Vector3.new(-hrp.CFrame.UpVector.X, 0, -hrp.CFrame.UpVector.Z).Unit
	        bodyVel.Velocity = adjustedForward * 50
        end)
    end
    end
end)

CharSection:NewSlider("Gravity slider", "changes gravity when you move the slider", 300, 0, function(g) 
    game.workspace.Gravity = g
end)
CharSection:NewButton("original Gravity", "set original gravity ", function()
    game.workspace.Gravity = 196.2
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

local BotTab = Window:NewTab("Bot")
local BotSection = BotTab:NewSection("Bot")

local Players2 = game:GetService("Players")
local localPlayer2 = Players2.LocalPlayer
local character2 = localPlayer2.Character or localPlayer2.CharacterAdded:Wait()
local hrp2 = character2:WaitForChild("HumanoidRootPart")
local debugMode = false
local enabled = false
local hasFired = false

local function downplayer(targetPlayer)
	for i = 1, 20 do
        local args = {
            [1] = game:GetService("Players").LocalPlayer.Character:WaitForChild("Combat"),
            [2] = "Hit",
            [3] = game:GetService("Players"):WaitForChild(targetPlayer.Name).Character:FindFirstChild("Head")
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Swing"):FireServer(unpack(args))
        --task.wait(0)
        end
end

local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge

    for _, player in ipairs(Players2:GetPlayers()) do
        if player ~= localPlayer2 then
            local success, err = pcall(function()
                -- Update the player's character reference
                local targetCharacter = player.Character
                if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
                    local humanoid = targetCharacter:FindFirstChild("Humanoid")
                    if humanoid and humanoid.Health >= 1 then
                        local distance = (targetCharacter.HumanoidRootPart.Position - hrp2.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end)

            if not success then
                warn("Error in getClosestPlayer for player " .. player.Name .. ": " .. err)
            end
        end
    end

    return closestPlayer, closestDistance
end

local huntBotRunning = false 
local enabled = false  

local velfloat = nil  

local function float(state)
    if state then
        if not velfloat then  
            velfloat = Instance.new("BodyVelocity")
            velfloat.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            velfloat.Velocity = Vector3.new(0, 0, 0)
            velfloat.Parent = localPlayer2.Character:FindFirstChild("HumanoidRootPart")  
        end
    else
        if velfloat then
            velfloat:Destroy()  
            velfloat = nil
        end
    end
end

local collisionsDisabled = nil

local function toggleCollisions(state)
    local character = localPlayer2.Character or localPlayer2.CharacterAdded:Wait()
    local bodyParts = {
        "Head",
        "HumanoidRootPart",
        "Torso",
        "LeftLeg",
        "RightLeg",
        "LeftArm",
        "RightArm"
    }

    if state then
        if not collisionsDisabled then
            for _, partName in ipairs(bodyParts) do
                local part = character:FindFirstChild(partName)
                if part then
                    part.CanCollide = false  
                end
            end
            collisionsDisabled = true
        end
    else
        if collisionsDisabled then
            for _, partName in ipairs(bodyParts) do
                local part = character:FindFirstChild(partName)
                if part then
                    part.CanCollide = true  
                end
            end
            collisionsDisabled = false
        end
    end
end





local function huntLoop()
    huntBotRunning = true
    while enabled do
        local targetPlayer, distance = getClosestPlayer()
        if targetPlayer then
            local targetCharacter = targetPlayer.Character  
            if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
                local targetPosition = targetCharacter.HumanoidRootPart.Position
                
                character2 = localPlayer2.Character or localPlayer2.CharacterAdded:Wait()
                hrp2 = character2:WaitForChild("HumanoidRootPart")
                toggleCollisions(true)

                if distance > 5 then
                    local direction = (targetPosition - hrp2.Position).Unit
                    local newPosition = hrp2.Position + direction * 1
                    hrp2.CFrame = CFrame.new(newPosition)
                else
                    downplayer(targetPlayer)  
                    task.wait(0.5)
                end
            end
        end
        task.wait(0) 
    end
    huntBotRunning = false  
end

BotSection:NewToggle("HuntBot", "hunts down players", function(state)
    enabled = state

    if enabled then
        float(state)
        toggleCollisions(state)
        if not huntBotRunning then
            task.spawn(huntLoop)  
        end
    else
        float(state)
        toggleCollisions(state)
        huntBotRunning = false  
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

