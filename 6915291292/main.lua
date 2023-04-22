local plr = game:GetService('Players').LocalPlayer
local inst = game:GetService('HttpService'):GenerateGUID(false)

local start = os.clock()

local function round(num, decimals)
	local dec = math.pow(10,decimals)
	return math.round(num*dec)/dec
end

local Running = true

function ConvertTime(t)
	local a = ""
	
	a = a.. (t / 60)..':'
	a = a.. (t % 60)
	
	return a
end

local function ConsolePrint(str)
	if Running == false then
		rconsoleprint("["..round(os.clock()-start,2)..'] '..tostring("Instance Crashed").."\n")
		error("Instance Crashed!")
	else
		rconsoleprint("["..round(os.clock()-start,2)..'] '..tostring(str).."\n")
	end
end
--ConsolePrint(ConvertTime(100))

ConsolePrint("> (Starting) "..inst)



if _G.ResetFarm then
	_G.ResetFarm()
	task.wait(0.5)
end


local Config = {
	WindowColor = Color3.fromRGB(60, 60, 60),
	Color = Color3.fromRGB(46, 46, 46),
}

function Style(Obj, CornerRadius, Color)
	local Corner = Instance.new('UICorner',Obj)
	Corner.CornerRadius = UDim.new(0,CornerRadius)
	Obj.BackgroundColor3 = Color or Config.Color
	Obj.BorderSizePixel = 0
end

local usi = game:GetService('UserInputService')

function CreateWindow(Title)
	local self = {}

	local screengui = Instance.new("ScreenGui",game:GetService("CoreGui"))
	local Window = Instance.new("Frame",screengui)
	Window.Size = UDim2.new(0,300,0,250)
	Window.Active = true

	local stroke = Instance.new('UIStroke',Window)
	stroke.Thickness = 3
	stroke.Color = Color3.fromRGB(0, 0, 0)
	stroke.Transparency = 0.5

	local MouseUp = true
	Window.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			MouseUp = false
			local StartPos = input.Position

			local WindowPos = Vector2.new(Window.Position.X.Offset,Window.Position.Y.Offset-36)

			local a, b = pcall(function()
				repeat task.wait() 

					local mousePos = usi:GetMouseLocation()
					local newPos = Vector2.new((mousePos.X-StartPos.X) + WindowPos.X,(mousePos.Y-StartPos.Y) + WindowPos.Y)
					Window:TweenPosition(UDim2.new(0,newPos.X,0,newPos.Y),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.05,true)
				until not usi:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or  Running == false
			end)
		end
	end)

	local TitleLabel = Instance.new("TextLabel", Window)
	TitleLabel.Text = Title or "Window"
	TitleLabel.Position = UDim2.new(0,0,0,10)
	TitleLabel.Size = UDim2.new(1,0,0,20)
	TitleLabel.TextColor3 = Color3.fromRGB(222,222,222)
	TitleLabel.Font = Enum.Font.SourceSansBold
	TitleLabel.TextScaled = true
	TitleLabel.BackgroundTransparency = 1

	local ButtonFrame = Instance.new("Frame", Window)
	ButtonFrame.Position = UDim2.new(0,10,0,40)
	ButtonFrame.Size = UDim2.new(1,-20,1,-50)
	ButtonFrame.BackgroundTransparency = 1

	local list = Instance.new("UIListLayout",ButtonFrame)
	list.Padding = UDim.new(0,5)


	--local Tabs = Instance.new("Frame", Window)
	--Tabs.Position = UDim2.new(0,10,0,40)
	--Tabs.Size = UDim2.new(1,-20,0,30)
	--Style(Tabs,8,Config.Color)

	self.Style = function(...) Style(Window,...) end

	local Toggles = {}

	self.GetValue = function(Key) return Toggles[Key] end

	self.AddToggle = function(Name, Func, CoolDown, Thread)
		local Button = Instance.new("TextButton",ButtonFrame)
		Style(Button,14,Config.Color)
		Button.Size = UDim2.new(1,0,0,30)
		Button.AutoButtonColor = false
		Button.Text = ""

		local Label = Instance.new("TextLabel", Button)
		Label.Text = Name
		Label.TextColor3 = Color3.fromRGB(222,222,222)
		Label.Font = Enum.Font.SourceSansBold
		Label.BackgroundTransparency = 1
		Label.Size = UDim2.new(1,0,1,0)
		Label.Position = UDim2.new(0,10,0,0)
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.TextSize = 16

		local Toggled = Instance.new("Frame", Button)
		Style(Toggled,100)
		Toggled.BackgroundColor3 = Color3.fromRGB(255, 41, 41)
		Toggled.Size = UDim2.new(0,10,0,10)
		Toggled.Position = UDim2.new(1,-10,0.5,0)
		Toggled.AnchorPoint = Vector2.new(1,0.5)


		Toggles[Name] = false

		local Finished = false

		Button.MouseButton1Click:Connect(function()
			local Value = Toggles[Name] == false
			Toggles[Name] = Value

			if Value == true then
				Toggled.BackgroundColor3 = Color3.fromRGB(87, 238, 53)
			else
				Toggled.BackgroundColor3 = Color3.fromRGB(255, 41, 41)
			end



			if Value == false then
				return
			end
			repeat 
				Finished = true
				local a ,b = pcall(Func)
				if not a then
					ConsolePrint(Name..", Errored: "..tostring(b))
				end
				Finished = false
				task.wait(CoolDown)
			until Running == false or Toggles[Name] == false
		end)
	end

	self.AddButton = function(Name, Func)
		local self = {}

		local Button = Instance.new("TextButton",ButtonFrame)
		Style(Button,14,Config.Color)
		Button.Size = UDim2.new(1,0,0,30)
		Button.AutoButtonColor = false
		Button.Text = ""

		local Label = Instance.new("TextLabel", Button)
		Label.Text = Name
		Label.TextColor3 = Color3.fromRGB(222,222,222)
		Label.Font = Enum.Font.SourceSansBold
		Label.BackgroundTransparency = 1
		Label.Size = UDim2.new(1,0,1,0)
		Label.Position = UDim2.new(0,10,0,0)
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.TextSize = 16

		Button.MouseButton1Click:Connect(function()

			local a ,b = pcall(Func)
			if not a then
				ConsolePrint(Name..", Errored: "..tostring(b))
			end
		end)

		local destroyed = false
		self.Destroy = function() 
			if destroyed then return end
			destroyed = true
			Button:Destroy()
		end

		return self
	end

	--self.AddTab = function(Name)

	--end

	self.Destroy = function() screengui:Destroy() end

	return self
end

function CheckForAnotherInstance()
	if Running == false then ConsolePrint("FORCE CLOSING"); error('Force Close, another instance started') end
end

local a, b = pcall(function()


	local Window = CreateWindow()
	spawn(function()
		Window.Style(12,Config.WindowColor)


		local plot = nil

		local ClaimBakery = Window.AddButton('Claim Bakery', function()

		end)

		repeat
			for _, v in pairs(workspace.Plots:GetChildren()) do
				if v.Sign.OwnerName.TextLabel.Text == plr.Name .. "'s Bakery" then
					plot = v
					break
				end
			end
			if not plot then
				task.wait(0.1)
			end
		until plot or Running == false

		if Running == false then
			return
		end

		ConsolePrint("Claimed plot: "..plot:GetFullName())

		ClaimBakery.Destroy()

		local Enemy = nil

		local finished = true
		
		local function getCapacity()
			local chr = plr.Character
			local cart = chr:FindFirstChildOfClass('Model')
			if cart then
				return game:GetService('ReplicatedStorage').Carts:FindFirstChild(cart.Name).Stats.Capacity.Value
			end
			return -1
		end

		local function MaxIngredients()
			local chr = plr.Character
			return #chr.CarryingContents.Ingredients:GetChildren() == getCapacity()
		end

		
		Window.AddToggle("AutoFarm",function()

			if finished == false then return end

			finished = false

			pcall(function()
				local chr = plr.Character
				local humanoid = chr.Humanoid
				local root = chr.HumanoidRootPart
				
				for _, v in pairs(plot.Ovens:GetChildren()) do
					pcall(function()
						if #v.ConverterData.ConverterContents.Ingredients:GetChildren() == v.ConverterData.MaxContents.Value
							and v.ConverterData.CurrentlyCooking.Value == false then
							local args = {
								[1] = v,
								[2] = "Cookies"
							}

							game:GetService("ReplicatedStorage").Remotes.StartBake:FireServer(unpack(args))
						end
					end)
					pcall(function()
						if #v.ConverterData.ConverterContents.Products:GetChildren() > 0 then
							v.ConverterData.__REMOTE:FireServer()
							repeat task.wait(0.1) until chr:FindFirstChild('Tray')
							plot.Shelf.Info:FireServer()
							repeat task.wait(0.1) until not chr:FindFirstChild('Tray')
						end
					end)
				end

				local gotIngredients = MaxIngredients()
				if gotIngredients == false then
					repeat task.wait()
						for _, v in pairs(workspace.Ingredients:GetChildren()) do
							
							gotIngredients = MaxIngredients()
							if gotIngredients == true then break end
							
							game:GetService("ReplicatedStorage").Remotes.TI_0:FireServer(v:GetChildren()[1])
							CheckForAnotherInstance()
							task.wait()
						end

					until gotIngredients == true or Window.GetValue('AutoFarm') == false
				end
				CheckForAnotherInstance()
				assert(Window.GetValue('AutoFarm'), 'Autofarm stopped')
				assert(MaxIngredients(),"More ingredients needed!")

				
				local oven = nil
				
				for _, v in pairs(plot.Ovens:GetChildren()) do
					if oven then break end
					local a, b = pcall(function()
						if #v.ConverterData.ConverterContents.Ingredients:GetChildren() <  v.ConverterData.MaxContents.Value
							and #v.ConverterData.ConverterContents.Products:GetChildren() == 0 then
							oven = v
						end
					end)
					if not a then
						ConsolePrint(b)
					end
				end
				
				if oven then
					oven.ConverterData.noob:FireServer()
				end
			end)

			finished = true

		end, 0.5)



	end)

	_G.ResetFarm = function()
		Running = false
		Window.Destroy()
	end
end)



if not a then
	Running = false
	ConsolePrint("> Stopped instance "..inst)
	ConsolePrint("Message: "..b)
	return
else
	ConsolePrint("> (Running!) "..inst)

end


