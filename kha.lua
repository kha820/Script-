-- Load Voidware gốc
loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua"))()

-- Chỉnh size GUI sau khi Voidware load
task.spawn(function()
    repeat task.wait() until game:IsLoaded()
    task.wait(5) -- đợi Voidware UI xuất hiện (có thể tăng lên 8-10 nếu máy chậm)

    local cg = game:GetService("CoreGui")

    local function resizeVoidware()
        for _, gui in pairs(cg:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name:lower():find("void") then
                for _, frame in pairs(gui:GetDescendants()) do
                    if frame:IsA("Frame") or frame:IsA("ScrollingFrame") then
                        frame.Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset * 0.7, frame.Size.Y.Scale, frame.Size.Y.Offset * 0.7)
                    end
                end
            end
        end
    end

    resizeVoidware()
    print("✅ Voidware GUI đã được resize nhỏ lại")
end)
