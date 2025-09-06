-- Fly Script Mobile (Button ON/OFF, hướng theo camera)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local flying = false
local speed = 60 -- tốc độ bay

-- BodyVelocity để bay
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(0,0,0)
bv.Velocity = Vector3.new(0,0,0)
bv.Parent = hrp

-- 🟦 UI Button để bật/tắt bay
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0,140,0,50)
button.Position = UDim2.new(0.05,0,0.75,0)
button.Text = "🚀 Fly: OFF"
button.BackgroundColor3 = Color3.fromRGB(170,0,0)
button.TextColor3 = Color3.fromRGB(255,255,255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 22
button.BackgroundTransparency = 0.2
button.Draggable = true -- có thể kéo nút đi chỗ khác

-- Toggle bay
button.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		bv.MaxForce = Vector3.new(4000,4000,4000)
		button.Text = "🚀 Fly: ON"
		button.BackgroundColor3 = Color3.fromRGB(0,170,0)
	else
		bv.MaxForce = Vector3.new(0,0,0)
		bv.Velocity = Vector3.new(0,0,0)
		button.Text = "🚀 Fly: OFF"
		button.BackgroundColor3 = Color3.fromRGB(170,0,0)
	end
end)

-- Điều khiển bay
RunService.RenderStepped:Connect(function()
	if flying then
		local camCF = workspace.CurrentCamera.CFrame
		local moveDir = humanoid.MoveDirection

		-- Nếu joystick có input thì di chuyển theo hướng camera
		if moveDir.Magnitude > 0 then
			local forward = camCF.LookVector
			local right = camCF.RightVector

			-- bỏ chiều cao (Y) để bay ngang theo camera
			forward = Vector3.new(forward.X, 0, forward.Z).Unit
			right = Vector3.new(right.X, 0, right.Z).Unit

			local finalDir = (forward * moveDir.Z + right * moveDir.X).Unit
			bv.Velocity = finalDir * speed
		else
			bv.Velocity = Vector3.new(0,0,0)
		end
	end
end)
