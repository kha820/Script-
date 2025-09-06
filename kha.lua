-- Fly Script Mobile (Double Jump bật/tắt, joystick điều khiển, jump lên cao, crouch xuống)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local flying = false
local jumpCount = 0
local speed = 50 -- tốc độ bay ngang
local verticalSpeed = 50 -- tốc độ bay lên/xuống

-- BodyVelocity để di chuyển
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(0,0,0)
bv.Velocity = Vector3.new(0,0,0)
bv.Parent = hrp

-- Reset khi chạm đất
humanoid.StateChanged:Connect(function(_, state)
	if state == Enum.HumanoidStateType.Landed then
		jumpCount = 0
	end
end)

-- Double jump bật/tắt bay
UserInputService.JumpRequest:Connect(function()
	jumpCount += 1
	if jumpCount == 2 then
		flying = not flying
		if flying then
			bv.MaxForce = Vector3.new(4000,4000,4000)
			print("🚀 Fly ON")
		else
			bv.MaxForce = Vector3.new(0,0,0)
			print("🛑 Fly OFF")
		end
		jumpCount = 0
	end
end)

-- Điều khiển khi bay
RunService.RenderStepped:Connect(function()
	if flying then
		local moveDir = humanoid.MoveDirection * speed

		-- Giữ nút nhảy để bay lên
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			moveDir = moveDir + Vector3.new(0, verticalSpeed, 0)
		end

		-- Giữ Ctrl (hoặc crouch trên mobile) để bay xuống
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			moveDir = moveDir - Vector3.new(0, verticalSpeed, 0)
		end

		bv.Velocity = moveDir
	else
		bv.Velocity = Vector3.new(0,0,0)
	end
end)
