-- Fly Script có nút bật/tắt cho Mobile
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local flying = false
local speed = 50 -- tốc độ bay ngang
local verticalSpeed = 50 -- tốc độ bay lên/xuống

-- BodyVelocity để bay
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(0,0,0)
bv.Velocity = Vector3.new(0,0,0)
bv.Parent = hrp

-- 🟦 Tạo nút bấm UI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0,120,0,50)
button.Position = UDim2.new(0.05,0,0.8,0)
button.Text = "🚀 Fly: OFF"
button.BackgroundColor3 = Color3.fromRGB(50,50,50)
button.TextColor3 = Color3.fromRGB(255,255,255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.BackgroundTransparency = 0.2

-- Bấm nút để bật/tắt fly
button.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		bv.MaxForce = Vector3.new(4000,4000,4000)
		button.Text = "🚀 Fly: ON"
		button.BackgroundColor3 = Color3.fromRGB(0,170,0)
	else
		bv.MaxForce = Vector3.new(0,0,0)
		button.Text = "🚀 Fly: OFF"
		button.BackgroundColor3 = Color3.fromRGB(170,0,0)
	end
end)

-- Điều khiển khi bay
RunService.RenderStepped:Connect(function()
	if flying then
		local moveDir = humanoid.MoveDirection * speed

		-- Nhấn Jump để bay lên
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			moveDir = moveDir + Vector3.new(0, verticalSpeed, 0)
		end

		-- Nhấn Ctrl/crouch để bay xuống
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			moveDir = moveDir - Vector3.new(0, verticalSpeed, 0)
		end

		bv.Velocity = moveDir
	else
		bv.Velocity = Vector3.new(0,0,0)
	end
end)
