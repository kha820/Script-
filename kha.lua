task.spawn(function()
    repeat task.wait() until game:IsLoaded()
    task.wait(2)

    -- Tìm GUI chính
    local cg = game:GetService("CoreGui")

    for _, gui in pairs(cg:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name:lower():find("void") then
            -- Tìm Frame chính (bản tím)
            local mainFrame = gui:FindFirstChildOfClass("Frame")
            if mainFrame then
                -- 👇 chỉnh size nhỏ hơn (400x300)
                mainFrame.Size = UDim2.new(0, 400, 0, 300)
                -- 👇 căn giữa màn hình
                mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
            end
        end
    end
end)
