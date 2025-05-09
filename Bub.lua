--===[ Alimhub Custom UI with Toggle by ChatGPT ]===--
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

-- UI Container
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "AlimhubUI"

-- Rainbow Outline
local function rainbowOutline(frame)
	local ts = tick()
	game:GetService("RunService").RenderStepped:Connect(function()
		local hue = tick() - ts
		frame.BorderColor3 = Color3.fromHSV(hue % 1, 1, 1)
	end)
end

-- Main Panel
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 300, 0, 500)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 2
rainbowOutline(mainFrame)

local title = Instance.new("TextLabel", mainFrame)
title.Text = "Alimhub UI"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- Toggle Button (always visible)
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 100, 0, 30)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.Text = "Toggle UI"
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 14

-- Toggle function
local visible = true
toggleBtn.MouseButton1Click:Connect(function()
	visible = not visible
	mainFrame.Visible = visible
end)

-- Button creator
local function createButton(text, y, callback)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0, 260, 0, 30)
	btn.Position = UDim2.new(0, 20, 0, y)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 14
	btn.MouseButton1Click:Connect(callback)
end

local yOffset = 40

-- ESP
createButton("Toggle Player ESP", yOffset, function()
	for _,v in pairs(game.Players:GetPlayers()) do
		if v ~= plr and v.Character and v.Character:FindFirstChild("Head") then
			if not v.Character.Head:FindFirstChild("ESP") then
				local esp = Instance.new("BillboardGui", v.Character.Head)
				esp.Name = "ESP"
				esp.Size = UDim2.new(0,100,0,40)
				esp.AlwaysOnTop = true
				local tag = Instance.new("TextLabel", esp)
				tag.Size = UDim2.new(1,0,1,0)
				tag.Text = v.Name
				tag.TextColor3 = Color3.new(1,0,0)
				tag.BackgroundTransparency = 1
			end
		end
	end
end)
yOffset += 40

-- Kill Aura
createButton("Enable Kill Aura", yOffset, function()
	game:GetService("RunService").Stepped:Connect(function()
		for _,v in pairs(game.Players:GetPlayers()) do
			if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local dist = (v.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).magnitude
				if dist < 10 then
					local tool = char:FindFirstChildWhichIsA("Tool")
					if tool and tool:FindFirstChild("Handle") then
						firetouchinterest(tool.Handle, v.Character.HumanoidRootPart, 0)
						firetouchinterest(tool.Handle, v.Character.HumanoidRootPart, 1)
					end
				end
			end
		end
	end)
end)
yOffset += 40

-- Speed Boost
createButton("Set Speed x3", yOffset, function()
	char.Humanoid.WalkSpeed = 48
end)
yOffset += 40

-- Jump Boost
createButton("Enable Jump Boost", yOffset, function()
	char.Humanoid.JumpPower = 120
end)
yOffset += 40

-- Teleport to Spawn
createButton("Teleport to Spawn", yOffset, function()
	char:MoveTo(Vector3.new(0, 10, 0))
end)
yOffset += 40

-- Teleport to Safezone
createButton("Teleport to Safezone", yOffset, function()
	char:MoveTo(Vector3.new(100, 10, 100))
end)
yOffset += 40

-- Bring Items
createButton("Bring Items", yOffset, function()
	for _, obj in pairs(workspace:GetDescendants()) do
		if (obj:IsA("Tool") or obj.Name:lower():find("item")) and obj:FindFirstChild("Handle") then
			obj.Handle.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
		end
	end
end)
