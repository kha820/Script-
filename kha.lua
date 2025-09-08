-- 1. Gọi Voidware như bình thường
loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua"))()

-- 2. Sau khi Voidware đã load xong, chỉnh size GUI
task.spawn(function()
    repeat task.wait() until game:IsLoaded()
    task.wait(3) -- đợi UI hiển thị

    local cg = game:GetService("CoreGui")

    for _, gui in pairs(cg:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name:lower():find("void") then
            local mainFrame = gui:FindFirstChildOfClass("Frame")
            if mainFrame then
                mainFrame.Size = UDim2.new(0, 400, 0, 300) -- size nhỏ
                mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150) -- căn giữa
            end
        end
    end
end)
