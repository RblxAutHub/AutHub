
function _print(...)
  rconsoleprint(...)
  rconsoleprint('\n')
end


local running = true

local plr = game:GetService("Players").LocalPlayer

local ScreenGui = Instance.new("ScreenGui",game.CoreGui)

if _G.AutHub then _G.AutHub() end

_G.AutHub = function()
   ScreenGui:Destroy()
  running = false 
end




local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Frame_2 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local Frame_3 = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")

--Properties:
Frame.Parent = ScreenGui
Frame.Active = true
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.500
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 300, 0, 140)

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

ImageLabel.Parent = Frame_3
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.BorderSizePixel = 0
ImageLabel.Position = UDim2.new(0.5, 0, 0.349999994, 0)
ImageLabel.Size = UDim2.new(1, 0, 0.600000024, 0)
ImageLabel.Image = "rbxassetid://1524285772"
ImageLabel.ScaleType = Enum.ScaleType.Fit

TextLabel.Parent = Frame_3
TextLabel.AnchorPoint = Vector2.new(0, 1)
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0, 0, 1, -10)
TextLabel.Size = UDim2.new(1, 0, 0, 25)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

function get_plot()
  local plot = nil
  
   for _, v in pairs(workspace.Plots:GetChildren()) do
       if tostring(v.Owner.Value) == plr.Name then
           plot = v   
       end
   end 
   return plot
end

TextLabel.Text = 'Please claim a plot'

local now = tick()

repeat task.wait() 
   ImageLabel.Rotation += (tick()-now)*300
   plot = get_plot()
   
   now = tick()
until plot or running == false

Frame:Destroy()

if running == false then return end


local buttons = {
   ['Auto-Farm'] = false
}



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

local farming = false
local isloading = false
local isselling = false
local clean = false
local filled = false

spawn(function()
   while task.wait(1) and running == true do
       if buttons['Auto-Farm'] == true then
           if farming == false then
              farming = true

              filled = false

              clean = false
              local root = plr.Character.HumanoidRootPart
              local a, b = pcall(function()
                  for _, v in pairs(plot.WashingMachines:GetChildren()) do 
                    if isselling == false and buttons['Auto-Farm'] == true and v.Config.Started.Value == false and running == true and v.Config.CycleFinished.Value == false then
                      isloading = true
                      filled = true
                      pcall(function()
                      repeat task.wait(0.1)  
                        root.CFrame = v.MAIN.CFrame * CFrame.new(0,0.4,5)    


                        if not plr.Character:FindFirstChild("Basket") then
                        task.wait(0.1)
                        for i = 1,5 do 
                          local items = workspace.Debris.Clothing:GetChildren()
                          clothing = items[math.random(1,#items)]   
                          root.CFrame = CFrame.new(clothing.Position)+Vector3.new(0,5,0)
                          task.wait(0.1)
                          game:GetService("ReplicatedStorage").Events.GrabClothing:FireServer(clothing)
                          clean = false
                        end
                        repeat task.wait() until plr.Character:FindFirstChild("Basket")
                      end

                        root.CFrame = v.MAIN.CFrame * CFrame.new(0,0.4,5)
                        game:GetService("ReplicatedStorage").Events.LoadWashingMachine:FireServer(v)
                        task.wait(0.1)
                        
                      until v.Config.Started.Value == true or v.Parent == nil or running == true
                      root.CFrame = v.MAIN.CFrame * CFrame.new(0,0.4,5)
                     end)
                      isloading = false
                    end
                  end 
                  clean = true
              end)
              if not a then
                _print(b)
              end
              if buttons['Auto-Farm'] == true and clean == true and isloading == false and filled == false then
              for _, v in pairs(plot.WashingMachines:GetChildren()) do 
                if v.Config.CycleFinished.Value == true and running == true and buttons['Auto-Farm'] == true then
                  isselling = true
                  local tries = 0
                  pcall(function()
                  root.CFrame = v.MAIN.CFrame * CFrame.new(0,0.4,5)
                  game:GetService("ReplicatedStorage").Events.UnloadWashingMachine:FireServer(v)
                  repeat task.wait(0.1)
                    tries += 1
                  until plr.Character:FindFirstChild("Basket") or running == false or tries > 10
                  tries = 0
                  plr.Character.HumanoidRootPart.CFrame = CFrame.new(-140,5,-12)
                  repeat task.wait(0.1) 
                    game:GetService("ReplicatedStorage").Events.DropClothesInChute:FireServer()
                    tries += 1
                  until not plr.Character:FindFirstChild("Basket") or running == false or tries > 10
                end)
                isselling = false
                end
              end
            end
              farming = false 
           end
       end
   end
end)

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

