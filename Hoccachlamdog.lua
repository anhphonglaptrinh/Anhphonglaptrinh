local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- ⚠️ Kiểm tra Rig
if humanoid.RigType ~= Enum.HumanoidRigType.R15 then
	warn("Chỉ hoạt động với nhân vật R15!")
	return
end

-- 📦 1. TẠO TOOL SỦA
local tool = Instance.new("Tool")
tool.Name = "Sủa!"
tool.RequiresHandle = false
tool.CanBeDropped = false

-- Âm thanh sủa
local barkSound = Instance.new("Sound")
barkSound.Name = "BarkSound"
barkSound.SoundId = "rbxassetid://138087015" -- tiếng sủa
barkSound.Volume = 1
barkSound.Parent = tool

-- Khi dùng tool
tool.Activated:Connect(function()
	if barkSound.IsPlaying then
		barkSound:Stop()
	end
	barkSound:Play()
end)

-- Cho Tool vào balo
tool.Parent = player:WaitForChild("Backpack")

-- 🐕 2. TƯ THẾ BÒ BẰNG 4 CHÂN
local function applyCrawlPose()
	local joints = {
		["UpperTorso"] = Vector3.new(0, 90, 0),
		["LowerTorso"] = Vector3.new(0, 30, 0),
		["RightUpperLeg"] = Vector3.new(-90, 0, 0),
		["LeftUpperLeg"] = Vector3.new(-90, 0, 0),
		["RightLowerLeg"] = Vector3.new(90, 0, 0),
		["LeftLowerLeg"] = Vector3.new(90, 0, 0),
		["RightUpperArm"] = Vector3.new(-120, 0, 0),
		["LeftUpperArm"] = Vector3.new(-120, 0, 0),
		["RightLowerArm"] = Vector3.new(-30, 0, 0),
		["LeftLowerArm"] = Vector3.new(-30, 0, 0),
	}

	for name, rotation in pairs(joints) do
		local part = char:FindFirstChild(name)
		if part and part:FindFirstChildWhichIsA("Motor6D") then
			local joint = part:FindFirstChildWhichIsA("Motor6D")
			joint.Transform = CFrame.Angles(
				math.rad(rotation.X),
				math.rad(rotation.Y),
				math.rad(rotation.Z)
			)
		end
	end
end

-- Gập tư thế và hạ người
applyCrawlPose()
humanoid.HipHeight = 0.5 -- sát đất
