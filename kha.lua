-- Fly Script bằng Double Jump cho Mobile
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local flying = false
local jumpCount = 0
local speed = 50 -- tốc độ bay

-- BodyVelocity để giữ bay
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(0,0,0)
bv.Velocity = Vector3.new(0,0,0)
bv.Parent = hrp

-- Reset đếm nhảy khi chạm đất
humanoid.StateChanged:Connect(function(_, state)
	if state == Enum.HumanoidStateType.Landed then
		jumpCount = 0
	end
end)

-- Khi nhảy
UserInputService.JumpRequest:Connect(function()
	jumpCount += 1
	if jumpCount == 2 then
		flying = not flying
		if flying then
			bv.MaxForce = Vector3.new(4000,4000,4000)
			print("🚀 Bay ON")
		else
			bv.MaxForce = Vector3.new(0,0,0)
			print("🛑 Bay OFF")
		end
		jumpCount = 0
	end
end)

-- Di chuyển khi bay (dùng joystick Roblox)
RunService.RenderStepped:Connect(function()
	if flying then
		bv.Velocity = humanoid.MoveDirection * speed
	else
		bv.Velocity = Vector3.new(0,0,0)
	end
end)
