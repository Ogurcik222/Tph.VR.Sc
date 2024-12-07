local a = Instance.new("ScreenGui")
local b = Instance.new("Frame")
local title = Instance.new("TextLabel")
local closeButton = Instance.new("TextButton")
local i = Instance.new("UICorner")
local LocalPlayer = game:GetService("Players").LocalPlayer

a.Parent = LocalPlayer:WaitForChild("PlayerGui")
a.Name = "TeleportMenu"

i.CornerRadius = UDim.new(0, 8)

b.Parent = a
b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
b.Position = UDim2.new(0.5, -150, 0.5, -80)
b.Size = UDim2.new(0, 300, 0, 180)
b.BorderSizePixel = 0
i:Clone().Parent = b

title.Parent = b
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 0, 0, 5)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Teleports"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

closeButton.Parent = b
closeButton.Position = UDim2.new(1, -30, 0, 10)
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSans
closeButton.TextSize = 16
i:Clone().Parent = closeButton

local function createButton(parent, position, size, text, teleportPosition)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Position = position
    button.Size = size
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 14
    i:Clone().Parent = button
    button.MouseButton1Click:Connect(function()
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
        end
    end)
    return button
end

createButton(b, UDim2.new(0.1, 0, 0.3, 0), UDim2.new(0.35, 0, 0.2, 0), "Base CoR", Vector3.new(334.41, 29.66, -1566.36))
createButton(b, UDim2.new(0.55, 0, 0.3, 0), UDim2.new(0.35, 0, 0.2, 0), "Ventilation", Vector3.new(-866.94, -3.64, 834.63))
createButton(b, UDim2.new(0.1, 0, 0.6, 0), UDim2.new(0.35, 0, 0.2, 0), "Exit", Vector3.new(-68.11, -23.00, 728.22))
createButton(b, UDim2.new(0.55, 0, 0.6, 0), UDim2.new(0.35, 0, 0.2, 0), "Complex", Vector3.new(-2296.05, -24.69, 2497.61))

local dragging, dragStart, startPos
local dragConnection, changeConnection

local function updateDrag(input)
    local delta = input.Position - dragStart
    b.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

b.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = b.Position

        changeConnection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                if changeConnection then changeConnection:Disconnect() end
            end
        end)
    end
end)

b.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateDrag(input)
    end
end)

closeButton.MouseButton1Click:Connect(function()
    b.Visible = false
end)
