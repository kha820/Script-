-- Simple Fly Script
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = char:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 50 -- tốc độ bay

-- Tạo BodyVelocity để điều khiển chuyển động
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(0, 0, 0)
bv.Velocity = Vector3.new(0, 0, 0)
bv.Parent = humanoidRootPart

-- Bật/tắt bay bằng phím "F"
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then
        flying = not flying
        if flying then
            bv.MaxForce = Vector3.new(4000, 4000, 4000)
            print("🚀 Fly ON")
        else
            bv.MaxForce = Vector3.new(0, 0, 0)
            print("🛑 Fly OFF")
        end
    end
end)

-- Điều khiển hướng bay theo camera
game:GetService("RunService").RenderStepped:Connect(function()
    if flying then
        local camCF = workspace.CurrentCamera.CFrame
        local moveDir = Vector3.new()
        local uis = game:GetService("UserInputService")

        if uis:IsKeyDown(Enum.KeyCode.W) then
            moveDir = moveDir + camCF.LookVector
        end
        if uis:IsKeyDown(Enum.KeyCode.S) then
            moveDir = moveDir - camCF.LookVector
        end
        if uis:IsKeyDown(Enum.KeyCode.A) then
            moveDir = moveDir - camCF.RightVector
        end
        if uis:IsKeyDown(Enum.KeyCode.D) then
            moveDir = moveDir + camCF.RightVector
        end
        if uis:IsKeyDown(Enum.KeyCode.Space) then
            moveDir = moveDir + camCF.UpVector
        end
        if uis:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDir = moveDir - camCF.UpVector
        end

        bv.Velocity = moveDir * speed
    end
end)