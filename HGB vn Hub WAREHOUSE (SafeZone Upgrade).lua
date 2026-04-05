-- Script by: hoangbao2k11

-- [THÔNG BÁO]
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "HGB vn Hub WAREHOUSE",
    Text = "by: hoangbao2k11🗿",
    Icon = "rbxassetid://6023457106",
    Duration = 10
})

if game.CoreGui:FindFirstChild("HGB_vn_Hub_Warehouse_UI") then
    game.CoreGui.HGB_Warehouse_UI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local OpenBtn = Instance.new("TextButton")
local UIList = Instance.new("UIListLayout")

ScreenGui.Name = "HGB_vn_HubWarehouse_UI"
ScreenGui.Parent = game.CoreGui

-- NÚT MỞ MENU
OpenBtn.Parent = ScreenGui
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
OpenBtn.Position = UDim2.new(0, 20, 0, 200)
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Text = "HGB"
OpenBtn.Draggable = true
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 10)

-- KHUNG CHÍNH
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 420)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "HGB WAREHOUSE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", Title)

UIList.Parent = MainFrame
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.SortOrder = Enum.SortOrder.LayoutOrder

local Spacer = Instance.new("Frame", MainFrame)
Spacer.Size = UDim2.new(1, 0, 0, 40)
Spacer.BackgroundTransparency = 1

-- BIẾN HỆ THỐNG
local _SPEED_ENABLED = false
local _SPEED_VALUE = 0.8
local _ESP_ENABLED = false
local _SAFE_ZONE = false
local _FULLBRIGHT = false
local _UNLOCK_CAM = false
local _ESP_DISTANCE = 600
local oldPos = nil
local zoneFolder = nil

-- HÀM TẠO NÚT
local function CreateToggle(name, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = name .. ": TẮT"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", btn)

    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = name .. (enabled and ": BẬT" or ": TẮT")
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(50, 50, 50)
        callback(enabled)
    end)
end

-- DANH SÁCH CHỨC NĂNG
CreateToggle("Chạy Nhanh (CFrame)", function(v) _SPEED_ENABLED = v end)
CreateToggle("Nhìn Đêm (Siêu Sáng)", function(v) _FULLBRIGHT = v end)
CreateToggle("Mở Khóa Camera", function(v) 
    _UNLOCK_CAM = v 
    if not v then game.Players.LocalPlayer.CameraMaxZoomDistance = 12.8 end
end)
CreateToggle("ESP Bảo Vệ", function(v) 
    _ESP_ENABLED = v 
    if not v then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:FindFirstChild("HGB_HL") then obj.HGB_HL:Destroy() end
        end
    end
end)

-- VÙNG AN TOÀN (CẬP NHẬT THÊM TƯỜNG)
CreateToggle("Vùng An Toàn", function(v)
    _SAFE_ZONE = v
    local lp = game.Players.LocalPlayer
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    if _SAFE_ZONE then
        oldPos = hrp.CFrame
        zoneFolder = Instance.new("Folder", workspace)
        zoneFolder.Name = "HGB_SafeZone_Upgraded"
        
        -- Tọa độ xây nhà an toàn (Dưới map)
        local buildPos = hrp.Position + Vector3.new(0, -250, 0)

        local function create(size, offset, name)
            local p = Instance.new("Part", zoneFolder)
            p.Name = name or "SafePart"
            p.Size = size
            p.Position = buildPos + offset
            p.Anchored = true
            p.CanCollide = true
            p.Material = Enum.Material.ForceField
            p.Color = Color3.fromRGB(0, 255, 255)
            p.Transparency = 0.3
            return p
        end

        -- Xây cấu trúc Hộp An Toàn
        create(Vector3.new(50, 2, 50), Vector3.new(0, -1, 0), "Floor") -- Sàn rộng hơn
        create(Vector3.new(50, 2, 50), Vector3.new(0, 20, 0), "Ceiling") -- Trần cao hơn
        
        -- 4 Bức tường bao quanh (Cao 20 units)
        create(Vector3.new(50, 20, 1), Vector3.new(0, 10, 25), "Wall1")
        create(Vector3.new(50, 20, 1), Vector3.new(0, 10, -25), "Wall2")
        create(Vector3.new(1, 20, 50), Vector3.new(25, 10, 0), "Wall3")
        create(Vector3.new(1, 20, 50), Vector3.new(-25, 10, 0), "Wall4")

        task.wait(0.2)
        hrp.CFrame = CFrame.new(buildPos + Vector3.new(0, 5, 0))
    else
        if oldPos then hrp.CFrame = oldPos end
        if zoneFolder then zoneFolder:Destroy() zoneFolder = nil end
    end
end)

OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- VÒNG LẶP HỆ THỐNG
game:GetService("RunService").RenderStepped:Connect(function()
    local lp = game.Players.LocalPlayer
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    if _SPEED_ENABLED and char.Humanoid.MoveDirection.Magnitude > 0 then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (char.Humanoid.MoveDirection * _SPEED_VALUE)
    end

    if _FULLBRIGHT then
        local l = game:GetService("Lighting")
        l.Brightness = 2
        l.ClockTime = 14
        l.GlobalShadows = false
        l.Ambient = Color3.fromRGB(200, 200, 200)
        l.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
    end

    if _UNLOCK_CAM then lp.CameraMaxZoomDistance = 1000 end
end)

-- VÒNG LẶP ESP
task.spawn(function()
    while task.wait(0.7) do
        if _ESP_ENABLED then
            local lp = game.Players.LocalPlayer
            local myPos = lp.Character.HumanoidRootPart.Position
            for _, v in pairs(workspace:GetDescendants()) do
                if not _ESP_ENABLED then break end
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
                    local target = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Head")
                    if target and (target.Position - myPos).Magnitude < _ESP_DISTANCE then
                        if not v:FindFirstChild("HGB_HL") then
                            local hl = Instance.new("Highlight", v)
                            hl.Name = "HGB_HL"
                            hl.FillColor = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
                if v:IsA("TouchTransmitter") then
                    local item = v.Parent
                    if item and item:IsA("BasePart") and (item.Position - myPos).Magnitude < _ESP_DISTANCE then
                        if not item:FindFirstChild("HGB_HL") then
                            local hl = Instance.new("Highlight", item)
                            hl.Name = "HGB_HL"
                            hl.FillColor = Color3.fromRGB(0, 255, 255)
                        end
                    end
                end
            end
        end
    end
end)
