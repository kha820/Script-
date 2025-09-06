-- Mobile Fly Script (UI Button + Bay lên/xuống)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local RunService = game:GetService("RunService")

local flying = false
local speed = 60
local upDown = 0 -- 1 = lên, -1 = xuống, 0 = đứng yên

-- BodyVelocity để điều khiển bay
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(0,0,0)
bv.Velocity = Vector3.new(0,0,0)
bv.Parent = hrp

-- 🟦 UI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

-- Nút bật/tắt bay
local flyBtn = Instance.new("TextButton", gui)
flyBtn.Size = UDim2.new(0,140,0,50)
flyBtn.Position = UDim2.new(0.05,0,0.7,0)
flyBtn.Text = "🚀 Fly: OFF"
flyBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
flyBtn.TextColor3 = Color3.fromRGB(255,255,255)
flyBtn.Font = Enum.Font.SourceSansBold
flyBtn.TextSize = 22
flyBtn.Draggable = true

-- Nút Bay Lên
local upBtn = Instance.new("TextButton", gui)
upBtn.Size = UDim2.new(0,80,0,50)
upBtn.Position = UDim2.new(0.8,0,0.6,0)
upBtn.Text = "🔼"
upBtn.BackgroundColor3 = Color3.fromRGB(0,100,200)
upBtn.TextColor3 = Color3.fromRGB(255,255,255)
upBtn.Font = Enum.Font.SourceSansBold
upBtn.TextSize = 26
upBtn.Visible = false

-- Nút Bay Xuống
local downBtn = Instance.new("TextButton", gui)
downBtn.Size = UDim2.new(0,80,0,50)
downBtn.Position = UDim2.new(0.8,0,0.7,0)
downBtn.Text = "🔽"
downBtn.BackgroundColor3 = Color3.fromRGB(200,100,0)
downBtn.TextColor3 = Color3.fromRGB(255,255,255)
downBtn.Font = Enum.Font.SourceSansBold
downBtn.TextSize = 26
downBtn.Visible = false

-- Toggle fly
flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		bv.MaxForce = Vector3.new(4000,4000,4000)
		flyBtn.Text = "🚀 Fly: ON"
		flyBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
		upBtn.Visible = true
		downBtn.Visible = true
	else
		bv.MaxForce = Vector3.new(0,0,0)
		bv.Velocity = Vector3.new(0,0,0)
		flyBtn.Text = "🚀 Fly: OFF"
		flyBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
		upBtn.Visible = false
		downBtn.Visible = false
	end
end)

-- Bay lên / xuống
upBtn.MouseButton1Down:Connect(function() upDown = 1 end)
upBtn.MouseButton1Up:Connect(function() upDown = 0 end)

downBtn.MouseButton1Down:Connect(function() upDown = -1 end)
downBtn.MouseButton1Up:Connect(function() upDown = 0 end)

-- Điều khiển bay
RunService.RenderStepped:Connect(function()
	if flying then
		local camCF = workspace.CurrentCamera.CFrame
		local moveDir = humanoid.MoveDirection

		local vel = Vector3.new(0,0,0)

		-- Di chuyển ngang theo camera
		if moveDir.Magnitude > 0 then
			local forward = camCF.LookVector
			local right = camCF.RightVector
			forward = Vector3.new(forward.X, 0, forward.Z).Unit
			right = Vector3.new(right.X, 0, right.Z).Unit
			local finalDir = (forward * moveDir.Z + right * moveDir.X).Unit
			vel = finalDir * speed
		end

		-- Bay lên/xuống
		if upDown ~= 0 then
			vel = vel + Vector3.new(0, upDown * speed, 0)
		end

		bv.Velocity = vel
	end
end)
