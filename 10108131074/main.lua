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


		local zone = nil
		local target = nil
		
		local heat = 0

		Window.AddToggle("AutoFarm",function()

			local chr = plr.Character
			local humanoid: Humanoid = chr.Humanoid
			local root = chr.HumanoidRootPart
			
			local tool = plr.Backpack:FindFirstChildOfClass('Tool')
			
			if tool then
			
			local args = {
				[1] = tool,
				[2] = true
			}

				game:GetService("ReplicatedStorage").Remotes.Game.ClientToggleEquipTool:FireServer(unpack(args))
			end



			local grass = nil

			if target then
				if target.Parent then
					grass = target
				end
			end

			if not grass then
				local overlap = OverlapParams.new()
				overlap.FilterDescendantsInstances = {chr}
				overlap.FilterType = Enum.RaycastFilterType.Blacklist

				local parts = workspace:GetPartBoundsInRadius(root.Position, 100,overlap)
				local closest = 100
				for _, v in pairs(parts) do
					if v.Parent.Parent.Name == "Grass" then
						local dist = (v:GetPivot().Position - root.Position).Magnitude
						if dist < closest then
							closest = dist
							grass = v
						end
					end
				end
			end
			if grass then
				humanoid:MoveTo(grass:GetPivot().Position)
				--humanoid.WalkSpeed = 50
				
				
				if target == grass then
					heat += 1
				else
					heat = 0
				end
				
				if heat > 20 then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					repeat task.wait() until humanoid.FloorMaterial ~= Enum.Material.Air
					root.CFrame = grass:GetPivot() + Vector3.new(0,3,0)
				end
				
				target = grass
			end

		end,0.1)

		Window.AddToggle("Infinite Gas",function()

			local chr = plr.Character
			local root = chr.HumanoidRootPart

			local args = {
				[1] = zone.GasStation.GasPumps,
				[2] = true
			}

			game:GetService("ReplicatedStorage").Remotes.Game.ClientToggleUseGasStation:FireServer(unpack(args))


		end, 0.2)

		spawn(function()
			repeat task.wait()

				local a, b = pcall(function()

					local chr = plr.Character
					local root = chr.HumanoidRootPart

					local FoundZone = nil

					local Distance = 1000
					for _, SuperZone in pairs(workspace.Map.Zones:GetChildren()) do
						for _, Zone in pairs(SuperZone:GetChildren()) do
							--ConsolePrint(Zone:GetFullName())
							local Ground = Zone.Ground:GetChildren()[1]
							if Ground then
								local Dist = (Ground.Position-root.Position).Magnitude

								if (Dist < Distance) then
									Distance = Dist
									FoundZone = Zone
								end
							end
							task.wait()
						end
					end

					if FoundZone then
						zone = FoundZone
					end
				end)

				CheckForAnotherInstance()
			until Running == false
		end)




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


