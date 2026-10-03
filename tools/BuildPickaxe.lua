-- Builds the redesigned Flint Pickaxe and puts it in StarterPack.
-- Paste this whole file into Roblox Studio's command bar (View > Command Bar) and press Enter.
-- Sizes are in studs and match the model sheet: 3.4 studs tall, head 2.6 across.

local StarterPack = game:GetService("StarterPack")

local old = StarterPack:FindFirstChild("Pickaxe")
if old then old:Destroy() end

local tool = Instance.new("Tool")
tool.Name = "Pickaxe"
tool.CanBeDropped = false
-- The hand holds the middle grip band, 0.9 studs below the Handle's center.
tool.GripPos = Vector3.new(0, -0.9, 0)

local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(0.2, 2.93, 0.2)
handle.Material = Enum.Material.Wood
handle.Color = Color3.fromHex("8A6240")
handle.CanCollide = false
handle.CFrame = CFrame.new(0, 5, 0)
handle.Parent = tool

local function addPart(name, className, size, material, hex, offset)
	local part = Instance.new(className)
	part.Name = name
	part.Size = size
	part.Material = material
	part.Color = Color3.fromHex(hex)
	part.CanCollide = false
	part.Massless = true
	part.CFrame = handle.CFrame * offset
	part.Parent = tool

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = handle
	weld.Part1 = part
	weld.Parent = part
	return part
end

-- Grip: three leather bands
for i, y in ipairs({ -0.686, -0.9, -1.114 }) do
	addPart("GripWrap" .. i, "Part", Vector3.new(0.26, 0.16, 0.26), Enum.Material.Fabric, "5A3A24", CFrame.new(0, y, 0))
end

-- Pommel at the bottom of the handle
addPart("Pommel", "Part", Vector3.new(0.28, 0.16, 0.28), Enum.Material.Wood, "6B4A2E", CFrame.new(0, -1.543, 0))

-- Head
addPart("HeadCore", "Part", Vector3.new(0.2, 0.13, 0.35), Enum.Material.Slate, "7F8079", CFrame.new(0, 1.729, 0))

-- Each pick arm is two wedges (light top, dark bottom) meeting in a point, drooping slightly.
local droop = math.rad(7)
local armSize = Vector3.new(0.35, 0.2, 1.3)
for _, side in ipairs({ -1, 1 }) do
	local label = side == -1 and "Left" or "Right"
	local base = CFrame.new(0, 1.464, 0) * CFrame.Angles(0, 0, -side * droop)
	local facing = CFrame.Angles(0, -side * math.pi / 2, 0)
	addPart("Pick" .. label .. "Top", "WedgePart", armSize, Enum.Material.Slate, "A3A39B",
		base * CFrame.new(side * 0.65, 0.1, 0) * facing)
	addPart("Pick" .. label .. "Bottom", "WedgePart", armSize, Enum.Material.Slate, "5C5D58",
		base * CFrame.new(side * 0.65, -0.1, 0) * facing * CFrame.Angles(0, 0, math.pi))
end

-- Twine lashing over the joint
addPart("Lashing", "Part", Vector3.new(0.4, 0.53, 0.45), Enum.Material.Fabric, "B08850", CFrame.new(0, 1.457, 0))

tool.Parent = StarterPack
print("Pickaxe built in StarterPack")
