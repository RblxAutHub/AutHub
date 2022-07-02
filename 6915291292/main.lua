
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

local farming = false
local plot = nil

function get_plot()
  local plot = nil
  
   for _, v in pairs(workspace.Plots:GetChildren()) do
       if v.Sign.OwnerName.TextLabel.Text == plr.Name.."'s Bakery" then
           plot = v   
       end
   end 
   return plot
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

TextLabel.Text = 'Please claim a factory'

local now = tick()

repeat task.wait() 
   ImageLabel.Rotation += (tick()-now)*300
   plot = get_plot()
   
   now = tick()
until plot

Frame:Destroy()

if running == false then return end

local placingitems = false

function get_oven()
  local obj = nil
  
   for _, v in pairs(plot.Ovens:GetChildren()) do 
      if v.ConverterData.CurrentlyCooking.Value == false then
          obj = v
       end
   end
   
  
  return obj   
end

function cook(Oven,Name)
   pcall(function()
   if Oven and running == true then
       Oven.ConverterData.noob:FireServer()
       task.wait(0.5)

       local args = {[1] = Oven,[2] = Name};game:GetService("ReplicatedStorage").Remotes.StartBake:FireServer(unpack(args))

       repeat task.wait(1) 
       until Oven.Screen.ContentsUI.Contents.Text == 'DONE'  or running == false or Oven.Parent == nil
       if running == true then
        repeat task.wait() until placingitems == false
        if running == true then
       Oven.ConverterData.__REMOTE:FireServer()
       task.wait(1)
       Oven.ConverterData.noob:FireServer()
       task.wait(1)
       plot.Shelf.Info:FireServer()
        end
       end
   end
end)
end



local buttons = {
   ['Auto-Farm Cookies'] = false
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

function farm(name)
   local d = 0
   local ovens = plot.Ovens:GetChildren()
   local total = 0
   if farming == false then
               local a, b = pcall(function()
               farming = true
               
                   for _, v in pairs(ovens) do 
                       if v.ConverterData.CurrentlyCooking.Value == false and running == true  then
                           game:GetService("ReplicatedStorage").Remotes.Trash:FireServer()
                           task.wait(0.2)
                           game:GetService("ReplicatedStorage").Remotes.Trash:FireServer()
                           placingitems = true
                          repeat task.wait(0.5)
                            if running == true then
                            local ingredient = nil
                             
                              plr.Character.HumanoidRootPart.CFrame = v.Bounds.CFrame*CFrame.new(-5,1,-1)*CFrame.Angles(0,-90,0)
                              plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping, true)
                              local items = workspace.Ingredients:GetChildren()
                              ingredient = items[math.random(1,#items)]
                              
                              task.wait()
                              if running == true then
                                local args = {[1] = ingredient}
                                  game:GetService("ReplicatedStorage").Remotes.TI_0:FireServer(unpack(args))
                                  task.wait(0.5)
                                end
                              end
                            until #v.ConverterData.ConverterContents.Ingredients:GetChildren() == v.ConverterData.MaxContents.Value or running == false
                          task.wait(1)
                          game:GetService("ReplicatedStorage").Remotes.Trash:FireServer()
           
                          task.wait(0.2)
                          placingitems = false
                                                  spawn(function()
                                                    cook(v,'Cookies')
                                                      d += 1
                                                    end)
                
                        end
                  end
                task.wait(1)
           end)
   repeat task.wait(1) until d == #ovens
       farming = false
   end
end

spawn(function()
   while task.wait(1) and running == true do
       if buttons['Auto-Farm Cookies'] == true then
           farm('Cookies')
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

