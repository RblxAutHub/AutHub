
function _print(...)
   rconsoleprint(...)
   rconsoleprint('\n')
end

_print("Pet simulator X")

local running = true

local ScreenGui = Instance.new("ScreenGui",game.CoreGui)

local buttons = {
    ['Auto-Farm'] = false,
    ['Auto orbs clear'] = false,
    ['Clear orbs'] = function()
        game:GetService("Workspace")["__THINGS"].Orbs:ClearAllChildren()
    end
}

if _G.AutHub then _G.AutHub() end

_G.AutHub = function()
    ScreenGui:Destroy()
   running = false 
end


-------GUI

function CreateButton()
   local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Button = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local Frame_2 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")

--Properties:

Frame.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
Frame.Size = UDim2.new(1, 0, 0, 26)

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

Button.Name = "Button"
Button.Parent = Frame
Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Button.BackgroundTransparency = 1.000
Button.BorderSizePixel = 0
Button.Size = UDim2.new(1, 0, 1, 0)
Button.Font = Enum.Font.SourceSans
Button.Text = ""
Button.TextColor3 = Color3.fromRGB(0, 0, 0)
Button.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.AnchorPoint = Vector2.new(0, 0.5)
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0, 10, 0.5, 0)
TextLabel.Size = UDim2.new(1, -10, 1, -8)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Auto-Farm"
TextLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

Frame_2.Parent = Frame
Frame_2.AnchorPoint = Vector2.new(1, 0.5)
Frame_2.BackgroundColor3 = Color3.fromRGB(230, 68, 68)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(1, -10, 0.5, 0)
Frame_2.Size = UDim2.new(0, 10, 0, 10)

UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = Frame_2
return Frame
end

---------


local plr = game:GetService("Players").LocalPlayer

local rendersize = 500


function farm()
    
    local closest = rendersize
    local obj = nil
    
    local region = Region3.new(plr.Character.HumanoidRootPart.CFrame.Position-Vector3.new(rendersize/2,rendersize/2,rendersize/2),plr.Character.HumanoidRootPart.CFrame.Position+Vector3.new(rendersize/2,rendersize/2,rendersize/2))
    local parts = workspace:FindPartsInRegion3(region,nil,math.huge)
    for _, v in pairs(parts) do
        if v.Parent.Parent == workspace['__THINGS'].Coins and v.Parent:FindFirstChild("Coin") then
            local dist = (v.Position-plr.Character.HumanoidRootPart.Position).Magnitude
            if dist < closest then
               closest = dist
               obj = v.Parent.Coin
            end
            
        end
    end
local a, b = pcall(function()    
plr.Character.Humanoid:MoveTo(obj.Position)
end)
if not a then
   _print(b) 
end
    
local t = {}

for _, v in pairs(workspace.__THINGS.Pets:GetChildren()) do
    if game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets:FindFirstChild(v.Name) then
        table.insert(t,v.Name) 
    end
end

local args = {[1] = {[1] = tostring(obj.Parent.Name),[2] = t}}
workspace.__THINGS.__REMOTES:FindFirstChild("join coin"):InvokeServer(unpack(args))

for _, v in pairs(t) do
    local args = {[1] = {[1] = tostring(obj.Parent.Name),[2] = v}}
    workspace.__THINGS.__REMOTES:FindFirstChild("farm coin"):FireServer(unpack(args))
end
end

function claimorbs()
    local rendersize = 100
    local region = Region3.new(plr.Character.HumanoidRootPart.CFrame.Position-Vector3.new(rendersize/2,rendersize/2,rendersize/2),plr.Character.HumanoidRootPart.CFrame.Position+Vector3.new(rendersize/2,rendersize/2,rendersize/2))
    local parts = workspace:FindPartsInRegion3(region,nil,math.huge)
    for _, v in pairs(parts) do
        if v.Parent == workspace['__THINGS'].Orbs then
            local args = {[1] = {[1] = {[1] = v.Name}}}
            workspace.__THINGS.__REMOTES:FindFirstChild("claim orbs"):FireServer(unpack(args))
        end
        task.wait()
    end
end

spawn(function()
    while task.wait(0.5) and running == true do
        if buttons['Auto-Farm'] == true then
        pcall(function()
       farm() 
        end)
 end
    end
end)


spawn(function() while task.wait(0.5) and running == true do if buttons['Auto-Farm'] == true then claimorbs() end end end)
spawn(function() while task.wait(1) and running == true do if buttons['Auto orbs clear'] == true then buttons['Clear orbs'] end end end)

local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Frame_2 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local Frame_3 = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Frame.Parent = ScreenGui
Frame.Active = true
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.500
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 250, 0, 120)
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame
Frame_2.Parent = Frame
Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_2.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame_2.Size = UDim2.new(1, -4, 1, -4)
UICorner_2.CornerRadius = UDim.new(0, 13)
UICorner_2.Parent = Frame_2
Frame_3.Parent = Frame_2
Frame_3.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_3.BackgroundTransparency = 1.000
Frame_3.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame_3.Size = UDim2.new(1, -10, 1, -10)
UIListLayout.Parent = Frame_3
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0,5)

Frame.Draggable = true

local a, b = pcall(function()

      for Text, Setting in pairs(buttons) do
         pcall(function()
         local button = CreateButton()
         button.Parent = Frame_3
         button.TextLabel.Text = Text
         if Setting == false or Setting == true then
            local function checkcolor()
               if buttons[Text] == true then
                  button.Frame.BackgroundColor3 = Color3.fromRGB(50,200,100)
               else
                  button.Frame.BackgroundColor3 = Color3.fromRGB(230, 68, 68) 
               end
            end
            checkcolor()  
            button.Button.MouseButton1Click:Connect(function()
                  buttons[Text] = buttons[Text] == false
                  checkcolor()
               end)
         else
            button.Frame:Destroy()
            button.Button.MouseButton1Click:Connect(function()
                  buttons[Text]()
               end)
         end
         end)
      end
end)

