--|| Happy hub ||--
--[[ Services ]]
local TweenService     = game:GetService("TweenService")
local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--[[ Themes ]]
local THEMES = {
	Dark = {
		accent    = Color3.fromRGB(0, 210, 100),
		bg        = Color3.fromRGB(10, 10, 10),
		text      = Color3.fromRGB(255, 255, 255),
		subtext   = Color3.fromRGB(160, 160, 160),
		danger    = Color3.fromRGB(220, 60, 60),
		knobOff   = Color3.fromRGB(50, 50, 50),
		icon      = "rbxassetid://104348663064077",
	},
	Purple = {
		accent    = Color3.fromRGB(160, 80, 255),
		bg        = Color3.fromRGB(12, 8, 20),
		text      = Color3.fromRGB(240, 228, 255),
		subtext   = Color3.fromRGB(160, 140, 200),
		danger    = Color3.fromRGB(220, 60, 60),
		knobOff   = Color3.fromRGB(55, 35, 80),
		icon      = "rbxassetid://104348663064077",
	},
	Blue = {
		accent    = Color3.fromRGB(40, 160, 255),
		bg        = Color3.fromRGB(6, 12, 22),
		text      = Color3.fromRGB(215, 232, 255),
		subtext   = Color3.fromRGB(120, 160, 210),
		danger    = Color3.fromRGB(220, 60, 60),
		knobOff   = Color3.fromRGB(25, 45, 80),
		icon      = "rbxassetid://104348663064077",
	},
	Red = {
		accent    = Color3.fromRGB(230, 50, 50),
		bg        = Color3.fromRGB(15, 5, 5),
		text      = Color3.fromRGB(255, 228, 228),
		subtext   = Color3.fromRGB(190, 140, 140),
		danger    = Color3.fromRGB(230, 50, 50),
		knobOff   = Color3.fromRGB(70, 28, 28),
		icon      = "rbxassetid://104348663064077",
	},
	White = {
		accent    = Color3.fromRGB(0, 150, 80),
		bg        = Color3.fromRGB(236, 236, 236),
		text      = Color3.fromRGB(15, 15, 15),
		subtext   = Color3.fromRGB(90, 90, 90),
		danger    = Color3.fromRGB(200, 40, 40),
		knobOff   = Color3.fromRGB(170, 170, 170),
		icon      = "rbxassetid://104348663064077",
	},

	Valentine = {
		accent    = Color3.fromRGB(255, 105, 155),
		bg        = Color3.fromRGB(28, 8, 18),
		text      = Color3.fromRGB(255, 220, 235),
		subtext   = Color3.fromRGB(210, 150, 180),
		danger    = Color3.fromRGB(240, 50, 90),
		knobOff   = Color3.fromRGB(80, 25, 50),
		icon      = "rbxassetid://84155924426327",
	},

	Cat = {
		accent    = Color3.fromRGB(180, 180, 180),
		bg        = Color3.fromRGB(5, 5, 5),
		text      = Color3.fromRGB(230, 230, 230),
		subtext   = Color3.fromRGB(110, 110, 110),
		danger    = Color3.fromRGB(200, 60, 60),
		knobOff   = Color3.fromRGB(30, 30, 30),
		icon      = "rbxassetid://85240387254442",
	},
}

local currentThemeName = "Dark"
local function T() return THEMES[currentThemeName] end

local reg = {
	panels        = {},
	texts         = {},
	subtexts      = {},
	accentBgs     = {},
	accentTexts   = {},
	dangerTexts   = {},
	dangerStrokes = {},
	accentStrokes = {},
	pills         = {},
	sliderFills   = {},
	sliderHandles = {},
	sidebarBtns   = {},
	scrollBars    = {},
}

local activeTabName = "Movimiento"
local iconRefs = {}
local toggleBtn = nil
local closeBtn = nil

local function applyTheme()
	local th = T()
	for _, o in ipairs(reg.panels)        do if o and o.Parent then o.BackgroundColor3    = th.bg      end end
	for _, o in ipairs(reg.texts)         do if o and o.Parent then o.TextColor3           = th.text    end end
	for _, o in ipairs(reg.subtexts)      do if o and o.Parent then o.TextColor3           = th.subtext end end
	for _, o in ipairs(reg.accentBgs)     do if o and o.Parent then o.BackgroundColor3    = th.accent  end end
	for _, o in ipairs(reg.accentTexts)   do if o and o.Parent then o.TextColor3           = th.accent  end end
	for _, o in ipairs(reg.dangerTexts)   do if o and o.Parent then o.TextColor3           = th.danger  end end
	for _, o in ipairs(reg.dangerStrokes) do if o and o.Parent then o.Color                = th.danger  end end
	for _, o in ipairs(reg.accentStrokes) do if o and o.Parent then o.Color                = th.accent  end end
	for _, o in ipairs(reg.sliderFills)   do if o and o.Parent then o.BackgroundColor3    = th.accent  end end
	for _, o in ipairs(reg.sliderHandles) do if o and o.Parent then o.BackgroundColor3    = th.text    end end
	for _, o in ipairs(reg.scrollBars)    do if o and o.Parent then o.ScrollBarImageColor3 = th.accent  end end
	for _, d in ipairs(reg.pills) do
		local pill, knob, getState = d[1], d[2], d[3]
		if pill and pill.Parent then pill.BackgroundColor3 = getState() and th.accent or th.knobOff end
		if knob and knob.Parent then knob.BackgroundColor3 = th.text end
	end
	for _, d in ipairs(reg.sidebarBtns) do
		local btn, name = d[1], d[2]
		if btn and btn.Parent then
			if name == activeTabName then
				btn.BackgroundColor3       = th.accent
				btn.BackgroundTransparency = 0
				btn.TextColor3             = th.bg
				local ind = btn:FindFirstChild("Indicator")
				if ind then ind.BackgroundTransparency = 0 end
			else
				btn.BackgroundColor3       = th.bg
				btn.BackgroundTransparency = 0.35
				btn.TextColor3             = th.text
				local ind = btn:FindFirstChild("Indicator")
				if ind then ind.BackgroundTransparency = 1 end
			end
		end
	end
	
	for _, il in ipairs(iconRefs) do
		if il and il.Parent then
			if il:IsA("ImageLabel") or il:IsA("ImageButton") then
				il.ImageColor3 = th.accent
			end
		end
	end
	-- Toggle button
	if toggleBtn and toggleBtn.Parent then
		toggleBtn.BackgroundColor3 = th.bg
		toggleBtn.ImageColor3      = th.accent
		toggleBtn.Image            = th.icon
	end
	-- Close button (usa th.text, no accent)
	if closeBtn and closeBtn.Parent then
		closeBtn.ImageColor3 = th.text
	end
end

--[[ Configuration ]]
local PANEL_TRANSPARENCY = 0.75
local CARD_TRANSPARENCY = 1
local ICON_ID            = "rbxassetid://104348663064077"
local CLOSE_ICON_ID      = "rbxassetid://10844111750"
local ADD_WP_ICON_ID     = "rbxassetid://117786081881229"

local DEFAULT_WALKSPEED  = 16
local DEFAULT_JUMPPOWER  = 50
local DEFAULT_FLYSPEED   = 40

local waypoints = {}

--[[ some helpers ]]
local function getHRP()
	local c = player.Character
	return c and c:FindFirstChild("HumanoidRootPart")
end
local function getHumanoid()
	local c = player.Character
	return c and c:FindFirstChildOfClass("Humanoid")
end
local function nameExists(n)
	for _, wp in ipairs(waypoints) do if wp.name == n then return true end end
	return false
end
local function uniqueName(base)
	if not nameExists(base) then return base end
	local i = 2
	while nameExists(base.." ("..i..")") do i += 1 end
	return base.." ("..i..")"
end

--[[ Style helpers ]]
local function styleCorner(obj, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = radius or UDim.new(0, 10)
	c.Parent = obj
end
local function styleStroke(obj, t, color, thick)
	local s = Instance.new("UIStroke")
	s.Color        = color or T().text
	s.Thickness    = thick or 1
	s.Transparency = t or 0.78
	s.Parent = obj
	return s
end
local function stylePadding(obj, top, bot, left, right)
	local p = Instance.new("UIPadding")
	p.PaddingTop    = UDim.new(0, top   or 0)
	p.PaddingBottom = UDim.new(0, bot   or 0)
	p.PaddingLeft   = UDim.new(0, left  or 0)
	p.PaddingRight  = UDim.new(0, right or 0)
	p.Parent = obj
end
local twI = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

--[[ toggle rows ]]
local function makeToggleRow(parent, labelText, layoutOrder)
	local th = T()
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1,0,0,50)
	row.BackgroundColor3 = th.bg
	row.BackgroundTransparency = CARD_TRANSPARENCY
	row.BorderSizePixel = 0
	row.LayoutOrder = layoutOrder or 0
	row.Parent = parent
	styleCorner(row, UDim.new(0,10))
	styleStroke(row, 0.88)
	table.insert(reg.panels, row)

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1,-80,1,0)
	lbl.Position = UDim2.new(0,14,0,0)
	lbl.BackgroundTransparency = 1
	lbl.Text = labelText
	lbl.TextColor3 = th.text
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextSize = 15
	lbl.Font = Enum.Font.GothamSemibold
	lbl.Parent = row
	table.insert(reg.texts, lbl)

	local pill = Instance.new("TextButton")
	pill.Size = UDim2.new(0,56,0,30)
	pill.Position = UDim2.new(1,-66,0.5,-15)
	pill.BackgroundColor3 = th.knobOff
	pill.Text = ""
	pill.BorderSizePixel = 0
	pill.AutoButtonColor = false
	pill.Parent = row
	styleCorner(pill, UDim.new(1,0))

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0,24,0,24)
	knob.Position = UDim2.new(0,3,0.5,-12)
	knob.BackgroundColor3 = th.text
	knob.BorderSizePixel = 0
	knob.Parent = pill
	styleCorner(knob, UDim.new(1,0))

	local state = false
	local function setState(val)
		state = val
		TweenService:Create(pill, twI, {BackgroundColor3 = val and T().accent or T().knobOff}):Play()
		TweenService:Create(knob, twI, {
			Position = val and UDim2.new(0,29,0.5,-12) or UDim2.new(0,3,0.5,-12)
		}):Play()
	end
	local function getState() return state end
	table.insert(reg.pills, {pill, knob, getState})
	return pill, setState, getState
end

--[[ sliderrow ]]
local function makeSliderRow(parent, labelText, minVal, maxVal, defVal, onChange, layoutOrder)
	local th = T()
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1,0,0,62)
	row.BackgroundColor3 = th.bg
	row.BackgroundTransparency = CARD_TRANSPARENCY
	row.BorderSizePixel = 0
	row.LayoutOrder = layoutOrder or 0
	row.Parent = parent
	styleCorner(row, UDim.new(0,10))
	styleStroke(row, 0.88)
	table.insert(reg.panels, row)

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1,-70,0,24)
	lbl.Position = UDim2.new(0,14,0,8)
	lbl.BackgroundTransparency = 1
	lbl.Text = labelText
	lbl.TextColor3 = th.text
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextSize = 14
	lbl.Font = Enum.Font.GothamSemibold
	lbl.Parent = row
	table.insert(reg.texts, lbl)

	local valLbl = Instance.new("TextLabel")
	valLbl.Size = UDim2.new(0,58,0,24)
	valLbl.Position = UDim2.new(1,-66,0,8)
	valLbl.BackgroundTransparency = 1
	valLbl.Text = tostring(defVal)
	valLbl.TextColor3 = th.accent
	valLbl.TextXAlignment = Enum.TextXAlignment.Right
	valLbl.TextSize = 14
	valLbl.Font = Enum.Font.GothamBold
	valLbl.Parent = row
	table.insert(reg.accentTexts, valLbl)

	local track = Instance.new("Frame")
	track.Size = UDim2.new(1,-28,0,8)
	track.Position = UDim2.new(0,14,0,42)
	track.BackgroundColor3 = th.knobOff
	track.BorderSizePixel = 0
	track.Parent = row
	styleCorner(track, UDim.new(1,0))

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((defVal-minVal)/(maxVal-minVal),0,1,0)
	fill.BackgroundColor3 = th.accent
	fill.BorderSizePixel = 0
	fill.Parent = track
	styleCorner(fill, UDim.new(1,0))
	table.insert(reg.sliderFills, fill)

	local handle = Instance.new("TextButton")
	handle.Size = UDim2.new(0,22,0,22)
	handle.AnchorPoint = Vector2.new(0.5,0.5)
	handle.Position = UDim2.new((defVal-minVal)/(maxVal-minVal),0,0.5,0)
	handle.BackgroundColor3 = th.text
	handle.Text = ""
	handle.BorderSizePixel = 0
	handle.AutoButtonColor = false
	handle.Parent = track
	styleCorner(handle, UDim.new(1,0))
	table.insert(reg.sliderHandles, handle)

	local cur = defVal
	local sliding, activeInput = false, nil
	local function updateFromX(absX)
		local tp, ts = track.AbsolutePosition.X, track.AbsoluteSize.X
		if ts == 0 then return end
		local ratio = math.clamp((absX-tp)/ts,0,1)
		local nv = math.floor(minVal + ratio*(maxVal-minVal))
		if nv == cur then return end
		cur = nv
		fill.Size       = UDim2.new(ratio,0,1,0)
		handle.Position = UDim2.new(ratio,0,0.5,0)
		valLbl.Text     = tostring(cur)
		if onChange then onChange(cur) end
	end

	local conns = {}
	conns[#conns+1] = handle.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.Touch
			or inp.UserInputType == Enum.UserInputType.MouseButton1 then
			sliding = true; activeInput = inp
		end
	end)
	conns[#conns+1] = track.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.Touch
			or inp.UserInputType == Enum.UserInputType.MouseButton1 then
			sliding = true; activeInput = inp
			updateFromX(inp.Position.X)
		end
	end)
	conns[#conns+1] = UserInputService.InputChanged:Connect(function(inp)
		if not sliding then return end
		if inp.UserInputType == Enum.UserInputType.Touch then
			if activeInput and inp.Touch == activeInput.Touch then updateFromX(inp.Position.X) end
		elseif inp.UserInputType == Enum.UserInputType.MouseMovement then
			updateFromX(inp.Position.X)
		end
	end)
	conns[#conns+1] = UserInputService.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.Touch
			or inp.UserInputType == Enum.UserInputType.MouseButton1 then
			sliding = false; activeInput = nil
		end
	end)
	row.AncestryChanged:Connect(function()
		if not row:IsDescendantOf(game) then
			for _, c in ipairs(conns) do c:Disconnect() end
		end
	end)
	return row, function() return cur end
end

--[[ Principal UI ]]
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Happy hub"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Name = "MainPanel"
panel.Size = UDim2.new(0.4,0,0.55,0)
panel.Position = UDim2.new(0.05,0,0.05,0)
panel.BackgroundColor3 = T().bg
panel.BackgroundTransparency = PANEL_TRANSPARENCY
panel.BorderSizePixel = 0
panel.Visible = false
panel.Parent = screenGui
styleCorner(panel, UDim.new(0.015,0))
styleStroke(panel, 0.72)
table.insert(reg.panels, panel)


--[[ Header ]]
local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,58)
header.BackgroundColor3 = T().bg
header.BackgroundTransparency = 0.08
header.BorderSizePixel = 0
header.Parent = panel
styleCorner(header, UDim.new(0,16))
table.insert(reg.panels, header)

-- Línea separadora sutil entre header y body
local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1,-24,0,1)
headerLine.Position = UDim2.new(0,12,1,0)
headerLine.BackgroundColor3 = T().accent
headerLine.BackgroundTransparency = 0.7
headerLine.BorderSizePixel = 0
headerLine.Parent = header
table.insert(reg.accentBgs, headerLine)

-- Ícono principal
local headerIcon = Instance.new("ImageLabel")
headerIcon.Size = UDim2.new(0,30,0,30)
headerIcon.Position = UDim2.new(0,14,0.5,-15)
headerIcon.BackgroundTransparency = 1
headerIcon.Image = ICON_ID
headerIcon.ImageColor3 = T().accent
headerIcon.ScaleType = Enum.ScaleType.Fit
headerIcon.Parent = header
table.insert(iconRefs, headerIcon)

-- Título
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1,-110,1,0)
titleLabel.Position = UDim2.new(0,52,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Happy hub"
titleLabel.TextColor3 = T().text
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextSize = 20
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = header
table.insert(reg.texts, titleLabel)

-- Subtítulo autor
local authorLabel = Instance.new("TextLabel")
authorLabel.Size = UDim2.new(1,-110,0,16)
authorLabel.Position = UDim2.new(0,52,0,32)
authorLabel.BackgroundTransparency = 1
authorLabel.Text = "Legacy version · v5.6"
authorLabel.TextColor3 = T().subtext
authorLabel.TextXAlignment = Enum.TextXAlignment.Left
authorLabel.TextSize = 11
authorLabel.Font = Enum.Font.Gotham
authorLabel.Parent = header
table.insert(reg.subtexts, authorLabel)

-- Botón cerrar (imagen personalizada)
closeBtn = Instance.new("ImageButton")
closeBtn.Size = UDim2.new(0,38,0,38)
closeBtn.Position = UDim2.new(1,-46,0.5,-19)
closeBtn.BackgroundColor3 = T().bg
closeBtn.BackgroundTransparency = CARD_TRANSPARENCY
closeBtn.Image = CLOSE_ICON_ID
closeBtn.ImageColor3 = T().text
closeBtn.ScaleType = Enum.ScaleType.Fit
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = true
closeBtn.Parent = header
styleCorner(closeBtn, UDim.new(0,10))
styleStroke(closeBtn, 0.82)
table.insert(reg.panels, closeBtn)
-- closeBtn.ImageColor3 se actualiza en applyTheme con th.text, no en iconRefs

--[[ Side bar ]]
local sidebar = Instance.new("ScrollingFrame")
sidebar.Size = UDim2.new(0,118,1,-68)
sidebar.Position = UDim2.new(0,8,0,62)
sidebar.BackgroundColor3 = T().bg
sidebar.BackgroundTransparency = 0.38
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 0
sidebar.CanvasSize = UDim2.new(0,0,0,0)
sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
sidebar.ScrollingDirection = Enum.ScrollingDirection.Y
sidebar.Parent = panel
styleCorner(sidebar, UDim.new(0,10))
styleStroke(sidebar, 0.80)
stylePadding(sidebar, 8,8,6,6)
table.insert(reg.panels, sidebar)

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.Padding = UDim.new(0,6)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Parent = sidebar

-- Tabs
local tabDefs = {"Waypoints","ESP","Movimiento","Fly","Aimbot","Avatar","Settings","About"}
local tabBtns = {}
local tabIndicators = {}

for i, name in ipairs(tabDefs) do
	local btn = Instance.new("TextButton")
	btn.Name = name.."TabBtn"
	btn.Size = UDim2.new(1,0,0,40)
	btn.BackgroundColor3 = T().bg
	btn.BackgroundTransparency = 0.35
	btn.Text = "   "..name
	btn.TextColor3 = T().text
	btn.TextSize = 13
	btn.Font = Enum.Font.GothamSemibold
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = true
	btn.LayoutOrder = i
	btn.Parent = sidebar
	styleCorner(btn, UDim.new(0,8))
	styleStroke(btn, 0.88)
	tabBtns[name] = btn
	table.insert(reg.sidebarBtns, {btn, name})

	local indicator = Instance.new("Frame")
	indicator.Name = "Indicator"
	indicator.Size = UDim2.new(0,3,0,20)
	indicator.Position = UDim2.new(0,2,0.5,-10)
	indicator.BackgroundColor3 = T().accent
	indicator.BackgroundTransparency = 1
	indicator.BorderSizePixel = 0
	indicator.Parent = btn
	styleCorner(indicator, UDim.new(1,0))
	table.insert(reg.accentBgs, indicator)
	tabIndicators[name] = indicator
end

--[[ content area ]]
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1,-140,1,-68)
contentArea.Position = UDim2.new(0,134,0,62)
contentArea.BackgroundTransparency = 1
contentArea.BorderSizePixel = 0
contentArea.Parent = panel

local pages = {}
local function newPage(name)
	local page = Instance.new("ScrollingFrame")
	page.Name = name.."Page"
	page.Size = UDim2.new(1,0,1,0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = T().accent
	page.CanvasSize = UDim2.new(0,0,0,0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.ScrollingDirection = Enum.ScrollingDirection.Y
	page.Visible = false
	page.Parent = contentArea
	pages[name] = page
	table.insert(reg.scrollBars, page)
	return page
end

local function switchTab(name)
	activeTabName = name
	for n, page in pairs(pages) do page.Visible = (n == name) end
	local th = T()
	for n, btn in pairs(tabBtns) do
		if n == name then
			TweenService:Create(btn, twI, {BackgroundTransparency=0, BackgroundColor3=th.accent}):Play()
			btn.TextColor3 = th.bg
			TweenService:Create(tabIndicators[n], twI, {BackgroundTransparency=0}):Play()
		else
			TweenService:Create(btn, twI, {BackgroundTransparency=0.35, BackgroundColor3=th.bg}):Play()
			btn.TextColor3 = th.text
			TweenService:Create(tabIndicators[n], twI, {BackgroundTransparency=1}):Play()
		end
	end
end

for _, name in ipairs(tabDefs) do
	tabBtns[name].MouseButton1Click:Connect(function() switchTab(name) end)
end

-- Helpers de UI compartidos
local function makeSectionLabel(parent, text, lo)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1,0,0,24)
	lbl.BackgroundTransparency = 1
	lbl.Text = "  "..text
	lbl.TextColor3 = T().subtext
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 11
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.LayoutOrder = lo or 0
	lbl.Parent = parent
	table.insert(reg.subtexts, lbl)

	-- Línea decorativa
	local line = Instance.new("Frame")
	line.Size = UDim2.new(0.3,0,0,1)
	line.Position = UDim2.new(0,0,1,-1)
	line.BackgroundColor3 = T().accent
	line.BackgroundTransparency = 0.6
	line.BorderSizePixel = 0
	line.Parent = lbl
	table.insert(reg.accentBgs, line)
	return lbl
end

local function makeDangerBtn(parent, text, lo)
	local btn = Instance.new("TextButton")
	btn.LayoutOrder = lo or 0
	btn.Size = UDim2.new(1,0,0,50)
	btn.BackgroundColor3 = T().bg
	btn.BackgroundTransparency = CARD_TRANSPARENCY
	btn.Text = text
	btn.TextColor3 = T().danger
	btn.TextSize = 15
	btn.Font = Enum.Font.GothamSemibold
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = true
	btn.Parent = parent
	styleCorner(btn, UDim.new(0,10))
	local stroke = styleStroke(btn, 0.82, T().danger)
	table.insert(reg.panels,        btn)
	table.insert(reg.dangerTexts,   btn)
	table.insert(reg.dangerStrokes, stroke)
	return btn
end

-- Info card helper
local function makeInfoCard(parent, text, lo)
	local f = Instance.new("Frame")
	f.LayoutOrder = lo or 0
	f.Size = UDim2.new(1,0,0,52)
	f.BackgroundColor3 = T().bg
	f.BackgroundTransparency = CARD_TRANSPARENCY
	f.BorderSizePixel = 0
	f.Parent = parent
	styleCorner(f, UDim.new(0,10))
	styleStroke(f, 0.90)
	table.insert(reg.panels, f)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1,-20,1,0)
	lbl.Position = UDim2.new(0,10,0,0)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = T().subtext
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 11
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextYAlignment = Enum.TextYAlignment.Center
	lbl.TextWrapped = true
	lbl.Parent = f
	table.insert(reg.subtexts, lbl)
	return f
end

--[[ waypoints ]]
local wpPage = newPage("Waypoints")
do
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0,8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = wpPage
	stylePadding(wpPage, 0,8,0,4)

	-- Sección guardar
	local saveSection = Instance.new("Frame")
	saveSection.LayoutOrder = 1
	saveSection.Size = UDim2.new(1,0,0,94)
	saveSection.BackgroundColor3 = T().bg
	saveSection.BackgroundTransparency = PANEL_TRANSPARENCY
	saveSection.BorderSizePixel = 0
	saveSection.Parent = wpPage
	styleCorner(saveSection, UDim.new(0,12))
	styleStroke(saveSection, 0.78)
	stylePadding(saveSection, 10,10,10,10)
	table.insert(reg.panels, saveSection)

	local nameBox = Instance.new("TextBox")
	nameBox.Size = UDim2.new(1,-52,0,38)
	nameBox.BackgroundColor3 = T().bg
	nameBox.BackgroundTransparency = 0.15
	nameBox.TextColor3 = T().text
	nameBox.PlaceholderText = "Nombre del waypoint..."
	nameBox.PlaceholderColor3 = T().subtext
	nameBox.TextSize = 14
	nameBox.Font = Enum.Font.Gotham
	nameBox.ClearTextOnFocus = false
	nameBox.TextXAlignment = Enum.TextXAlignment.Left
	nameBox.BorderSizePixel = 0
	nameBox.Parent = saveSection
	styleCorner(nameBox, UDim.new(0,8))
	styleStroke(nameBox, 0.88)
	stylePadding(nameBox, 0,0,12,12)
	table.insert(reg.panels, nameBox)
	table.insert(reg.texts, nameBox)

	-- Botón "+" con imagen (solicitud del usuario)
	local saveBtn = Instance.new("ImageButton")
	saveBtn.Size = UDim2.new(0,38,0,38)
	saveBtn.Position = UDim2.new(1,-42,0,0)
	saveBtn.BackgroundColor3 = T().accent
	saveBtn.Image = ADD_WP_ICON_ID
	saveBtn.ImageColor3 = T().bg
	saveBtn.ScaleType = Enum.ScaleType.Fit
	saveBtn.BorderSizePixel = 0
	saveBtn.AutoButtonColor = true
	saveBtn.Parent = saveSection
	styleCorner(saveBtn, UDim.new(0,10))
	table.insert(reg.accentBgs, saveBtn)

	local wpListLbl = Instance.new("TextLabel")
	wpListLbl.LayoutOrder = 2
	wpListLbl.Size = UDim2.new(1,0,0,20)
	wpListLbl.BackgroundTransparency = 1
	wpListLbl.Text = "  WAYPOINTS GUARDADOS"
	wpListLbl.TextColor3 = T().subtext
	wpListLbl.Font = Enum.Font.GothamBold
	wpListLbl.TextSize = 10
	wpListLbl.TextXAlignment = Enum.TextXAlignment.Left
	wpListLbl.Parent = wpPage
	table.insert(reg.subtexts, wpListLbl)

	local listContainer = Instance.new("Frame")
	listContainer.Name = "ListContainer"
	listContainer.LayoutOrder = 3
	listContainer.Size = UDim2.new(1,0,0,0)
	listContainer.AutomaticSize = Enum.AutomaticSize.Y
	listContainer.BackgroundTransparency = 1
	listContainer.BorderSizePixel = 0
	listContainer.Parent = wpPage
	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0,6)
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Parent = listContainer

	local emptyLbl = Instance.new("TextLabel")
	emptyLbl.Name = "EmptyLabel"
	emptyLbl.Size = UDim2.new(1,0,0,44)
	emptyLbl.BackgroundTransparency = 1
	emptyLbl.Text = "Aún no hay waypoints guardados."
	emptyLbl.TextColor3 = T().subtext
	emptyLbl.Font = Enum.Font.Gotham
	emptyLbl.TextSize = 13
	emptyLbl.Parent = listContainer
	table.insert(reg.subtexts, emptyLbl)

	local function refreshList()
		for _, ch in ipairs(listContainer:GetChildren()) do
			if ch:IsA("Frame") and ch.Name == "WaypointRow" then ch:Destroy() end
		end
		emptyLbl.Visible = #waypoints == 0
		for idx, wp in ipairs(waypoints) do
			local th = T()
			local row = Instance.new("Frame")
			row.Name = "WaypointRow"
			row.LayoutOrder = idx
			row.Size = UDim2.new(1,0,0,50)
			row.BackgroundColor3 = th.bg
			row.BackgroundTransparency = CARD_TRANSPARENCY
			row.BorderSizePixel = 0
			row.Parent = listContainer
			styleCorner(row, UDim.new(0,10))
			styleStroke(row, 0.88)
			table.insert(reg.panels, row)

			local dot = Instance.new("Frame")
			dot.Size = UDim2.new(0,8,0,8)
			dot.Position = UDim2.new(0,12,0.5,-4)
			dot.BackgroundColor3 = th.accent
			dot.BorderSizePixel = 0
			dot.Parent = row
			styleCorner(dot, UDim.new(1,0))
			table.insert(reg.accentBgs, dot)

			local nameLbl = Instance.new("TextLabel")
			nameLbl.Size = UDim2.new(1,-160,1,0)
			nameLbl.Position = UDim2.new(0,28,0,0)
			nameLbl.BackgroundTransparency = 1
			nameLbl.Text = wp.name
			nameLbl.TextColor3 = th.text
			nameLbl.TextXAlignment = Enum.TextXAlignment.Left
			nameLbl.TextSize = 14
			nameLbl.Font = Enum.Font.GothamSemibold
			nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
			nameLbl.Parent = row
			table.insert(reg.texts, nameLbl)

			local tp = Instance.new("TextButton")
			tp.Size = UDim2.new(0,62,0,34)
			tp.Position = UDim2.new(1,-138,0.5,-17)
			tp.BackgroundColor3 = th.bg
			tp.BackgroundTransparency = 0.05
			tp.Text = "TP"
			tp.TextColor3 = th.accent
			tp.TextSize = 13
			tp.Font = Enum.Font.GothamBold
			tp.BorderSizePixel = 0
			tp.AutoButtonColor = true
			tp.Parent = row
			styleCorner(tp, UDim.new(0,8))
			local tpStroke = styleStroke(tp, 0.85, th.accent)
			table.insert(reg.panels, tp)
			table.insert(reg.accentTexts, tp)
			table.insert(reg.accentStrokes, tpStroke)

			local del = Instance.new("TextButton")
			del.Size = UDim2.new(0,62,0,34)
			del.Position = UDim2.new(1,-68,0.5,-17)
			del.BackgroundColor3 = th.bg
			del.BackgroundTransparency = 0.05
			del.Text = "DEL"
			del.TextColor3 = th.danger
			del.TextSize = 13
			del.Font = Enum.Font.GothamBold
			del.BorderSizePixel = 0
			del.AutoButtonColor = true
			del.Parent = row
			styleCorner(del, UDim.new(0,8))
			local delStroke = styleStroke(del, 0.85, th.danger)
			table.insert(reg.panels, del)
			table.insert(reg.dangerTexts, del)
			table.insert(reg.dangerStrokes, delStroke)

			tp.MouseButton1Click:Connect(function()
				local hrp = getHRP()
				if hrp then hrp.CFrame = CFrame.new(wp.position + Vector3.new(0,3,0)) end
			end)
			del.MouseButton1Click:Connect(function()
				for i, d in ipairs(waypoints) do
					if d == wp then table.remove(waypoints,i); break end
				end
				refreshList()
			end)
		end
	end

	saveBtn.MouseButton1Click:Connect(function()
		local hrp = getHRP()
		if not hrp then return end
		local raw = nameBox.Text
		if raw == "" then raw = "Waypoint "..tostring(#waypoints+1) end
		table.insert(waypoints, {name=uniqueName(raw), position=hrp.Position})
		nameBox.Text = ""
		refreshList()
	end)

	refreshList()
end

--[[ ESP  ]]
local espPage = newPage("ESP")
do
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0,8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = espPage
	stylePadding(espPage, 0,8,0,4)
end
makeSectionLabel(espPage, "Game presets", 1)
local pillPL,  setStatePL,  getStatePL  = makeToggleRow(espPage, "Prison Life",       2)
local pillMM2, setStateMM2, getStateMM2 = makeToggleRow(espPage, "Murder Mystery 2",  3)
local pillOG,  setStateOG,  getStateOG  = makeToggleRow(espPage, "another games",      4)
makeSectionLabel(espPage, "Options", 5)
local pillNameTag,  setStateNameTag,  getStateNameTag  = makeToggleRow(espPage, "Nametags",     6)
local pillTeamOnly, setStateTeamOnly, getStateTeamOnly = makeToggleRow(espPage, "Only enemies nametags",      7)

--[[ Movement ]]
local movPage = newPage("Movimiento")
do
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0,8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = movPage
	stylePadding(movPage, 0,8,0,4)
end

-- ── Velocidad ─────────────────────────────────────────────
makeSectionLabel(movPage, "Speed", 1)
local currentWalkSpeed = DEFAULT_WALKSPEED
local currentJumpPower = DEFAULT_JUMPPOWER
makeSliderRow(movPage,"Walk Speed",4,150,DEFAULT_WALKSPEED, function(v)
	currentWalkSpeed = v
	local hum = getHumanoid(); if hum then hum.WalkSpeed = v end
end, 2)
makeSliderRow(movPage,"Jump Power",10,200,DEFAULT_JUMPPOWER, function(v)
	currentJumpPower = v
	local hum = getHumanoid(); if hum then hum.JumpPower = v end
end, 3)
player.CharacterAdded:Connect(function(char)
	task.wait(0.5)
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then hum.WalkSpeed = currentWalkSpeed; hum.JumpPower = currentJumpPower end
end)

-- ── Mods del jugador ──────────────────────────────────────
makeSectionLabel(movPage, "Player mods", 4)

-- Noclip
local pillNoclip, setStateNoclip, getStateNoclip = makeToggleRow(movPage, "Noclip", 5)
local noclipConn = nil
pillNoclip.MouseButton1Click:Connect(function()
	local v = not getStateNoclip(); setStateNoclip(v)
	if v then
		noclipConn = RunService.Stepped:Connect(function()
			local c = player.Character
			if c then
				for _, p in ipairs(c:GetDescendants()) do
					if p:IsA("BasePart") then p.CanCollide = false end
				end
			end
		end)
	else
		if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
		local c = player.Character
		if c then
			for _, p in ipairs(c:GetDescendants()) do
				if p:IsA("BasePart") then p.CanCollide = (p.Name ~= "HumanoidRootPart") end
			end
		end
	end
end)

-- God Mode
local pillGod, setStateGod, getStateGod = makeToggleRow(movPage, "God Mode", 6)
local godConn = nil
pillGod.MouseButton1Click:Connect(function()
	local v = not getStateGod(); setStateGod(v)
	if v then
		godConn = RunService.Heartbeat:Connect(function()
			local hum = getHumanoid(); if hum then hum.Health = hum.MaxHealth end
		end)
	else
		if godConn then godConn:Disconnect(); godConn = nil end
	end
end)

-- Infinite Jump
local pillIJ, setStateIJ, getStateIJ = makeToggleRow(movPage, "Infinite Jump", 7)
local ijCooldown = false
pillIJ.MouseButton1Click:Connect(function() setStateIJ(not getStateIJ()) end)
UserInputService.JumpRequest:Connect(function()
	if getStateIJ() and not ijCooldown then
		ijCooldown = true
		local hum = getHumanoid()
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
		task.delay(0.15, function() ijCooldown = false end)
	end
end)

-- Anti-AFK
local pillAntiAFK, setStateAntiAFK, getStateAntiAFK = makeToggleRow(movPage, "Anti-AFK", 8)
local antiAFKConn = nil
pillAntiAFK.MouseButton1Click:Connect(function()
	local v = not getStateAntiAFK(); setStateAntiAFK(v)
	if v then
		local vu = game:GetService("VirtualUser")
		antiAFKConn = player.Idled:Connect(function()
			vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
			task.wait(1)
			vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
		end)
	else
		if antiAFKConn then antiAFKConn:Disconnect(); antiAFKConn = nil end
	end
end)

-- ── Animaciones ───────────────────────────────────────────
makeSectionLabel(movPage, "Animations", 9)

local laughBtn = Instance.new("TextButton")
laughBtn.LayoutOrder = 10
laughBtn.Size = UDim2.new(1,0,0,50)
laughBtn.BackgroundColor3 = T().bg
laughBtn.BackgroundTransparency = CARD_TRANSPARENCY
laughBtn.Text = "Laugh"
laughBtn.TextColor3 = T().accent
laughBtn.TextSize = 15
laughBtn.Font = Enum.Font.GothamSemibold
laughBtn.BorderSizePixel = 0
laughBtn.AutoButtonColor = true
laughBtn.Parent = movPage
styleCorner(laughBtn, UDim.new(0,10))
local laughStroke = styleStroke(laughBtn, 0.82, T().accent)
table.insert(reg.panels, laughBtn)
table.insert(reg.accentTexts, laughBtn)
table.insert(reg.accentStrokes, laughStroke)

laughBtn.MouseButton1Click:Connect(function()
	local char = player.Character
	local hum  = getHumanoid()
	if not char or not hum then return end
	pcall(function()
		local rs  = game:GetService("ReplicatedStorage")
		local evt = rs:FindFirstChild("DefaultChatSystemChatEvents")
		if evt then
			local req = evt:FindFirstChild("SayMessageRequest")
			if req then req:FireServer("/e laugh", "All") end
		end
	end)
	pcall(function()
		local animScript = char:FindFirstChild("Animate")
		if animScript then
			local playEmote = animScript:FindFirstChild("PlayEmote")
			if playEmote then playEmote:Fire("laugh") end
		end
	end)
	pcall(function()
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://3576686446"
		local track = hum:LoadAnimation(anim)
		track.Priority = Enum.AnimationPriority.Core
		track:Play()
		game:GetService("Debris"):AddItem(anim, 5)
	end)
end)

-- ── Zona de peligro ───────────────────────────────────────
makeSectionLabel(movPage, "For bugs", 11)
local resetBtn = makeDangerBtn(movPage, "Restart character", 12)
resetBtn.MouseButton1Click:Connect(function()
	local hum = getHumanoid(); if hum then hum.Health = 0 end
end)

--============================================================
-- PAGE: FLY
--============================================================
local flyPage = newPage("Fly")
do
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0,10)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = flyPage
	stylePadding(flyPage, 0,8,0,4)
end
makeSectionLabel(flyPage, "Fly", 1)
local pillFly, setStateFly, getStateFly = makeToggleRow(flyPage, "Enable Fly", 2)
local currentFlySpeed = DEFAULT_FLYSPEED
makeSliderRow(flyPage,"Velocidad de vuelo",5,200,DEFAULT_FLYSPEED, function(v) currentFlySpeed = v end, 3)
makeInfoCard(flyPage, "PC: WASD + Space/Ctrl o Q/E\nMóvil: usa el joystick del personaje.", 4)

local flyConn, flyBV, flyBG = nil, nil, nil
local function startFly()
	local hrp = getHRP(); local hum = getHumanoid()
	if not hrp or not hum then return end
	hum.PlatformStand = true
	flyBV = Instance.new("BodyVelocity")
	flyBV.Velocity = Vector3.zero
	flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
	flyBV.Parent = hrp
	flyBG = Instance.new("BodyGyro")
	flyBG.MaxTorque = Vector3.new(1e5,1e5,1e5)
	flyBG.P = 1e4
	flyBG.CFrame = hrp.CFrame
	flyBG.Parent = hrp
	flyConn = RunService.Heartbeat:Connect(function()
		local h = getHRP(); if not h then return end
		local cf = workspace.CurrentCamera.CFrame
		local mv = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then mv += cf.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then mv -= cf.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then mv -= cf.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then mv += cf.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) or UserInputService:IsKeyDown(Enum.KeyCode.E) then mv += Vector3.yAxis end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.Q) then mv -= Vector3.yAxis end
		if mv.Magnitude < 0.01 then
			local hum2 = getHumanoid()
			if hum2 then local md = hum2.MoveDirection
				if md.Magnitude > 0.1 then mv = md * Vector3.new(1,0,1) end
			end
		end
		flyBV.Velocity = mv.Magnitude > 0 and mv.Unit*currentFlySpeed or Vector3.zero
		flyBG.CFrame = cf
	end)
end
local function stopFly()
	if flyConn then flyConn:Disconnect(); flyConn = nil end
	if flyBV   then flyBV:Destroy();   flyBV = nil end
	if flyBG   then flyBG:Destroy();   flyBG = nil end
	local hum = getHumanoid(); if hum then hum.PlatformStand = false end
end
pillFly.MouseButton1Click:Connect(function()
	local v = not getStateFly(); setStateFly(v)
	if v then startFly() else stopFly() end
end)
player.CharacterAdded:Connect(function()
	if getStateFly() then setStateFly(false); stopFly() end
end)

--[[ aimbots ]]
local aimbotPage = newPage("Aimbot")
do
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0,10)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = aimbotPage
	stylePadding(aimbotPage, 0,10,0,4)
end

makeSectionLabel(aimbotPage, "Murder mistery 2", 1)
local pillAimbotMM2, setStateAimbotMM2, getStateAimbotMM2 = makeToggleRow(aimbotPage, "Lock-On Asesino", 2)
local aimbotSmooth = 8
makeSliderRow(aimbotPage, "Smoothness", 1, 30, aimbotSmooth, function(v) aimbotSmooth = v end, 3)
local aimbotRange = 500
makeSliderRow(aimbotPage, "max range", 50, 1000, aimbotRange, function(v) aimbotRange = v end, 4)

makeSectionLabel(aimbotPage, "General aimbot", 5)
local pillAimbotGeneral, setStateAimbotGeneral, getStateAimbotGeneral = makeToggleRow(aimbotPage, "Aimbot General (Mouse Lock)", 6)
local generalFOV = 500
makeSliderRow(aimbotPage, "max range", 50, 1200, generalFOV, function(v) generalFOV = v end, 7)
local generalSmooth = 4
makeSliderRow(aimbotPage, "Smoothness", 1, 15, generalSmooth, function(v) generalSmooth = v end, 8)

-- Status card
local aimbotStatusBox = Instance.new("Frame")
aimbotStatusBox.LayoutOrder = 9
aimbotStatusBox.Size = UDim2.new(1,0,0,50)
aimbotStatusBox.BackgroundColor3 = T().bg
aimbotStatusBox.BackgroundTransparency = CARD_TRANSPARENCY
aimbotStatusBox.BorderSizePixel = 0
aimbotStatusBox.Parent = aimbotPage
styleCorner(aimbotStatusBox, UDim.new(0,10))
styleStroke(aimbotStatusBox, 0.88)
table.insert(reg.panels, aimbotStatusBox)

local aimbotStatusDot = Instance.new("Frame")
aimbotStatusDot.Size = UDim2.new(0,10,0,10)
aimbotStatusDot.Position = UDim2.new(0,14,0.5,-5)
aimbotStatusDot.BackgroundColor3 = T().knobOff
aimbotStatusDot.BorderSizePixel = 0
aimbotStatusDot.Parent = aimbotStatusBox
styleCorner(aimbotStatusDot, UDim.new(1,0))

local aimbotStatusLbl = Instance.new("TextLabel")
aimbotStatusLbl.Size = UDim2.new(1,-34,1,0)
aimbotStatusLbl.Position = UDim2.new(0,32,0,0)
aimbotStatusLbl.BackgroundTransparency = 1
aimbotStatusLbl.Text = "There are no murderers."
aimbotStatusLbl.TextColor3 = T().subtext
aimbotStatusLbl.TextXAlignment = Enum.TextXAlignment.Left
aimbotStatusLbl.Font = Enum.Font.GothamSemibold
aimbotStatusLbl.TextSize = 13
aimbotStatusLbl.Parent = aimbotStatusBox
table.insert(reg.subtexts, aimbotStatusLbl)

makeInfoCard(aimbotPage,
	"• Lock-On Asesino: solo funciona en MM2.\n• Aimbot General: se ajusta al jugador más cerca del cursor.",
	10)

--============================================================
-- AIMBOT LOGIC
--============================================================
local mm2Conn, generalConn = nil, nil

local function getMurderer()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr == player then continue end
		local char = plr.Character
		local bp   = plr:FindFirstChild("Backpack")
		if (char and char:FindFirstChild("Knife")) or (bp and bp:FindFirstChild("Knife")) then
			return plr
		end
	end
	return nil
end

local function startMM2Aimbot()
	mm2Conn = RunService.RenderStepped:Connect(function()
		if not getStateAimbotMM2() then return end
		local murderer = getMurderer()
		if not murderer or not murderer.Character then
			aimbotStatusDot.BackgroundColor3 = T().knobOff
			aimbotStatusLbl.Text = "No killer detected"
			aimbotStatusLbl.TextColor3 = T().subtext
			return
		end
		local murderHRP = murderer.Character:FindFirstChild("HumanoidRootPart")
		local myHRP     = getHRP()
		if not murderHRP or not myHRP then return end

		local dist = (myHRP.Position - murderHRP.Position).Magnitude
		if dist > aimbotRange then
			aimbotStatusDot.BackgroundColor3 = Color3.fromRGB(255,180,0)
			aimbotStatusLbl.Text = murderer.DisplayName.." — fuera de rango"
			aimbotStatusLbl.TextColor3 = Color3.fromRGB(255,180,0)
			return
		end

		local murderHum = murderer.Character:FindFirstChildOfClass("Humanoid")
		if not murderHum or murderHum.Health <= 0 then return end

		local camera = workspace.CurrentCamera

		-- === NUEVO AIMPOINT: entre piernas y torso ===
		local targetPos
		local lowerTorso = murderer.Character:FindFirstChild("LowerTorso")
		local torso      = murderer.Character:FindFirstChild("Torso")
		if lowerTorso then
			targetPos = lowerTorso.Position
		elseif torso then
			targetPos = torso.Position
		else
			-- fallback seguro
			targetPos = murderHRP.Position + Vector3.new(0, 0.6, 0)
		end
		-- =============================================

		local targetCF = CFrame.new(camera.CFrame.Position, targetPos)
		local alpha    = math.clamp(1/aimbotSmooth, 0.02, 1)
		camera.CFrame  = camera.CFrame:Lerp(targetCF, alpha)

		aimbotStatusDot.BackgroundColor3 = T().accent
		aimbotStatusLbl.Text = "🔴 Locked: "..murderer.DisplayName
		aimbotStatusLbl.TextColor3 = T().accent
	end)
end

local function stopMM2Aimbot()
	if mm2Conn then mm2Conn:Disconnect(); mm2Conn = nil end
	if aimbotStatusDot and aimbotStatusDot.Parent then
		aimbotStatusDot.BackgroundColor3 = T().knobOff
	end
	if aimbotStatusLbl and aimbotStatusLbl.Parent then
		aimbotStatusLbl.Text      = "No killer detected"
		aimbotStatusLbl.TextColor3 = T().subtext
	end
end

local function startGeneralAimbot()
	generalConn = RunService.RenderStepped:Connect(function()
		if not getStateAimbotGeneral() then return end
		local camera  = workspace.CurrentCamera
		local myHRP   = getHRP()
		if not myHRP then return end
		local mousePos = UserInputService:GetMouseLocation()
		local closest, closestDist = nil, generalFOV
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr == player then continue end
			local char = plr.Character
			if not char then continue end
			local hrp = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChildOfClass("Humanoid")
			if not hrp or not hum or hum.Health <= 0 then continue end
			local screenPos, onScreen = camera:WorldToScreenPoint(hrp.Position)
			if not onScreen then continue end
			local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
			if dist < closestDist then
				closestDist = dist
				closest = hrp
			end
		end
		if closest then
			local targetCF = CFrame.new(camera.CFrame.Position, closest.Position)
			local alpha    = math.clamp(1/generalSmooth, 0.05, 1)
			camera.CFrame  = camera.CFrame:Lerp(targetCF, alpha)
		end
	end)
end

local function stopGeneralAimbot()
	if generalConn then generalConn:Disconnect(); generalConn = nil end
end

pillAimbotMM2.MouseButton1Click:Connect(function()
	local v = not getStateAimbotMM2(); setStateAimbotMM2(v)
	if v then startMM2Aimbot() else stopMM2Aimbot() end
end)

pillAimbotGeneral.MouseButton1Click:Connect(function()
	local v = not getStateAimbotGeneral(); setStateAimbotGeneral(v)
	if v then startGeneralAimbot() else stopGeneralAimbot() end
end)

--============================================================
-- PAGE: AVATAR
--============================================================
local avatarPage = newPage("Avatar")
do
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0,8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = avatarPage
	stylePadding(avatarPage, 0,8,0,4)
end

local AVATAR_ITEMS = {}

-- ── Funciones de avatar ───────────────────────────────────

local function applyKorblox()
	local char = player.Character; if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
	if hum.RigType == Enum.HumanoidRigType.R15 then
		local rf = char:FindFirstChild("RightFoot")
		local rl = char:FindFirstChild("RightLowerLeg")
		local ru = char:FindFirstChild("RightUpperLeg")
		if ru and rl and rf then
			rf.Transparency = 1; rl.Transparency = 1
			ru.MeshId    = "http://www.roblox.com/asset/?id=902942096"
			ru.TextureID = "http://roblox.com/asset/?id=902843398"
			ru.Color = Color3.new(1,1,1); ru.Transparency = 0
		end
	else
		local rightLeg = char:FindFirstChild("Right Leg"); if not rightLeg then return end
		for _, v in ipairs(char:GetChildren()) do
			if v:IsA("CharacterMesh") and v.BodyPart == Enum.BodyPart.RightLeg then v:Destroy() end
		end
		local mesh = rightLeg:FindFirstChildOfClass("SpecialMesh")
		if not mesh then mesh = Instance.new("SpecialMesh"); mesh.Parent = rightLeg end
		rightLeg.Color = Color3.fromRGB(64,64,64); rightLeg.Transparency = 0
		mesh.MeshType = Enum.MeshType.FileMesh
		mesh.MeshId   = "rbxassetid://101851696"
		mesh.TextureId = "rbxassetid://101851254"
		mesh.Scale    = Vector3.new(1,1,1)
	end
end
local function removeKorblox()
	local char = player.Character; if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
	if hum.RigType == Enum.HumanoidRigType.R15 then
		local rf = char:FindFirstChild("RightFoot")
		local rl = char:FindFirstChild("RightLowerLeg")
		local ru = char:FindFirstChild("RightUpperLeg")
		if rf then rf.Transparency = 0 end
		if rl then rl.Transparency = 0 end
		if ru then ru.MeshId = ""; ru.TextureID = "" end
	else
		local rightLeg = char:FindFirstChild("Right Leg"); if not rightLeg then return end
		local mesh = rightLeg:FindFirstChildOfClass("SpecialMesh")
		if mesh then mesh:Destroy() end
		rightLeg.Color = Color3.fromRGB(163,162,165)
	end
end

local function applyShoulderAcc()
	local char = player.Character; if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
	for _, v in ipairs(char:GetChildren()) do
		if v:IsA("Accessory") and v.Name == "HHB_ShoulderAcc" then v:Destroy() end
	end
	local acc = Instance.new("Accessory"); acc.Name = "HHB_ShoulderAcc"
	local handle = Instance.new("Part")
	handle.Name = "Handle"; handle.Size = Vector3.new(1,1,1)
	handle.CanCollide = false; handle.Anchored = false
	local mesh = Instance.new("SpecialMesh")
	mesh.MeshType = Enum.MeshType.FileMesh
	mesh.MeshId   = "rbxassetid://110121730336323"
	mesh.Parent   = handle
	local att = Instance.new("Attachment"); att.Name = "BodyFrontAttachment"; att.Parent = handle
	handle.Parent = acc; acc.Parent = char
	hum:AddAccessory(acc)
end
local function removeShoulderAcc()
	local char = player.Character; if not char then return end
	for _, v in ipairs(char:GetChildren()) do
		if v:IsA("Accessory") and v.Name == "HHB_ShoulderAcc" then v:Destroy() end
	end
end

local _origTransparencies = {}
local function applyInvisible()
	local char = player.Character; if not char then return end
	_origTransparencies = {}
	for _, p in ipairs(char:GetDescendants()) do
		if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
			_origTransparencies[p] = p.Transparency; p.Transparency = 1
		end
	end
end
local function removeInvisible()
	local char = player.Character; if not char then return end
	for p, t in pairs(_origTransparencies) do
		if p and p.Parent then p.Transparency = t end
	end
	_origTransparencies = {}
end

local function applyNoobFace()
	local char = player.Character; if not char then return end
	local head = char:FindFirstChild("Head"); if not head then return end
	local face = head:FindFirstChildOfClass("Decal")
	if not face then face = Instance.new("Decal"); face.Name="face"; face.Parent=head end
	face.Texture = "rbxassetid://1079"
end
local function removeNoobFace()
	local char = player.Character; if not char then return end
	local head = char:FindFirstChild("Head"); if not head then return end
	local face = head:FindFirstChild("face")
	if face then face.Texture = "rbxassetid://1369239677" end
end

local _origBodyColors = {}
local function applyRainbowBody()
	local char = player.Character; if not char then return end
	_origBodyColors = {}
	local parts = {"Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg",
		"UpperTorso","LowerTorso","LeftUpperArm","LeftLowerArm","LeftHand",
		"RightUpperArm","RightLowerArm","RightHand","LeftUpperLeg","LeftLowerLeg",
		"LeftFoot","RightUpperLeg","RightLowerLeg","RightFoot"}
	for _, n in ipairs(parts) do
		local p = char:FindFirstChild(n)
		if p and p:IsA("BasePart") then
			_origBodyColors[n] = p.Color
			p.Color = Color3.fromHSV(math.random(), 0.9, 1)
		end
	end
end
local function removeRainbowBody()
	local char = player.Character; if not char then return end
	for n, col in pairs(_origBodyColors) do
		local p = char:FindFirstChild(n)
		if p and p:IsA("BasePart") then p.Color = col end
	end
	_origBodyColors = {}
end

local avatarCatalog = {
	{ id="korblox",   label="Korblox Deathspeaker",  desc="Pierna derecha de hueso.\nR15 y R6.",            apply=applyKorblox,    remove=removeKorblox    },
	{ id="shoulder",  label="Shoulder Accessory",    desc="Accesorio en el hombro\nfrontal del personaje.", apply=applyShoulderAcc, remove=removeShoulderAcc },
	{ id="invisible", label="Invisible",             desc="Vuelve invisible todo\nel personaje (local).",   apply=applyInvisible,  remove=removeInvisible   },
	{ id="noobface",  label="Cara Noob Clásica",     desc="Reemplaza la cara con\nel noob original.",       apply=applyNoobFace,   remove=removeNoobFace    },
	{ id="rainbow",   label="Rainbow Body",          desc="Colorea aleatoriamente\ncada parte del cuerpo.", apply=applyRainbowBody, remove=removeRainbowBody },
}
for _, item in ipairs(avatarCatalog) do item.state = false end

makeSectionLabel(avatarPage, "Simple catalog avatar", 2)

for idx, item in ipairs(avatarCatalog) do
	local card = Instance.new("Frame")
	card.LayoutOrder = idx + 2
	card.Size = UDim2.new(1,0,0,76)
	card.BackgroundColor3 = T().bg
	card.BackgroundTransparency = CARD_TRANSPARENCY
	card.BorderSizePixel = 0
	card.Parent = avatarPage
	styleCorner(card, UDim.new(0,10))
	styleStroke(card, 0.82)
	table.insert(reg.panels, card)

	local dot = Instance.new("Frame")
	dot.Size = UDim2.new(0,10,0,10)
	dot.Position = UDim2.new(0,14,0.5,-5)
	dot.BackgroundColor3 = T().knobOff
	dot.BorderSizePixel = 0
	dot.Parent = card
	styleCorner(dot, UDim.new(1,0))

	local nameLbl = Instance.new("TextLabel")
	nameLbl.Size = UDim2.new(1,-82,0,26)
	nameLbl.Position = UDim2.new(0,32,0,10)
	nameLbl.BackgroundTransparency = 1
	nameLbl.Text = item.label
	nameLbl.TextColor3 = T().text
	nameLbl.TextXAlignment = Enum.TextXAlignment.Left
	nameLbl.TextSize = 14
	nameLbl.Font = Enum.Font.GothamSemibold
	nameLbl.Parent = card
	table.insert(reg.texts, nameLbl)

	local descLbl = Instance.new("TextLabel")
	descLbl.Size = UDim2.new(1,-82,0,30)
	descLbl.Position = UDim2.new(0,32,0,36)
	descLbl.BackgroundTransparency = 1
	descLbl.Text = item.desc
	descLbl.TextColor3 = T().subtext
	descLbl.TextXAlignment = Enum.TextXAlignment.Left
	descLbl.TextYAlignment = Enum.TextYAlignment.Top
	descLbl.TextSize = 11
	descLbl.Font = Enum.Font.Gotham
	descLbl.TextWrapped = true
	descLbl.Parent = card
	table.insert(reg.subtexts, descLbl)

	local equipBtn = Instance.new("TextButton")
	equipBtn.Size = UDim2.new(0,64,0,34)
	equipBtn.Position = UDim2.new(1,-74,0.5,-17)
	equipBtn.BackgroundColor3 = T().bg
	equipBtn.BackgroundTransparency = 0.05
	equipBtn.Text = "Equipar"
	equipBtn.TextColor3 = T().accent
	equipBtn.TextSize = 12
	equipBtn.Font = Enum.Font.GothamBold
	equipBtn.BorderSizePixel = 0
	equipBtn.AutoButtonColor = true
	equipBtn.Parent = card
	styleCorner(equipBtn, UDim.new(0,8))
	local equipStroke = styleStroke(equipBtn, 0.82, T().accent)
	table.insert(reg.panels, equipBtn)
	table.insert(reg.accentTexts, equipBtn)
	table.insert(reg.accentStrokes, equipStroke)

	local function updateCardVisual()
		if item.state then
			dot.BackgroundColor3  = T().accent
			equipBtn.Text         = "remove"
			equipBtn.TextColor3   = T().danger
			equipStroke.Color     = T().danger
		else
			dot.BackgroundColor3  = T().knobOff
			equipBtn.Text         = "Equip"
			equipBtn.TextColor3   = T().accent
			equipStroke.Color     = T().accent
		end
	end

	equipBtn.MouseButton1Click:Connect(function()
		item.state = not item.state
		if item.state then pcall(item.apply) else pcall(item.remove) end
		updateCardVisual()
	end)

	AVATAR_ITEMS[#AVATAR_ITEMS+1] = { item = item, updateVisual = updateCardVisual }
end

player.CharacterAdded:Connect(function()
	task.wait(0.6)
	for _, entry in ipairs(AVATAR_ITEMS) do
		if entry.item.state then pcall(entry.item.apply) end
	end
end)

do
	local clearBtn = makeDangerBtn(avatarPage, "Remove all mods", #avatarCatalog + 4)
	clearBtn.MouseButton1Click:Connect(function()
		for _, entry in ipairs(AVATAR_ITEMS) do
			if entry.item.state then
				entry.item.state = false
				pcall(entry.item.remove)
				entry.updateVisual()
			end
		end
	end)
end

--============================================================
-- PAGE: SETTINGS
--============================================================
local settingsPage = newPage("Settings")
do
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0,10)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = settingsPage
	stylePadding(settingsPage, 0,12,0,4)
end

makeSectionLabel(settingsPage, "theme", 1)

local themeBox = Instance.new("Frame")
themeBox.LayoutOrder = 2
themeBox.Size = UDim2.new(1,0,0,0)
themeBox.AutomaticSize = Enum.AutomaticSize.Y
themeBox.BackgroundColor3 = T().bg
themeBox.BackgroundTransparency = CARD_TRANSPARENCY
themeBox.BorderSizePixel = 0
themeBox.Parent = settingsPage
styleCorner(themeBox, UDim.new(0,10))
styleStroke(themeBox, 0.88)
stylePadding(themeBox, 10,14,10,10)
table.insert(reg.panels, themeBox)

local themeBoxLayout = Instance.new("UIListLayout")
themeBoxLayout.Padding = UDim.new(0,12)
themeBoxLayout.SortOrder = Enum.SortOrder.LayoutOrder
themeBoxLayout.Parent = themeBox

local themeCurLbl = Instance.new("TextLabel")
themeCurLbl.Size = UDim2.new(1,0,0,20)
themeCurLbl.BackgroundTransparency = 1
themeCurLbl.Text = "Actual theme"..currentThemeName
themeCurLbl.TextColor3 = T().subtext
themeCurLbl.Font = Enum.Font.GothamSemibold
themeCurLbl.TextSize = 13
themeCurLbl.TextXAlignment = Enum.TextXAlignment.Left
themeCurLbl.LayoutOrder = 1
themeCurLbl.Parent = themeBox
table.insert(reg.subtexts, themeCurLbl)

-- Fila 1: temas clásicos
local swatchRow1 = Instance.new("Frame")
swatchRow1.LayoutOrder = 2
swatchRow1.Size = UDim2.new(1,0,0,46)
swatchRow1.BackgroundTransparency = 1
swatchRow1.BorderSizePixel = 0
swatchRow1.Parent = themeBox
local swatchL1 = Instance.new("UIListLayout")
swatchL1.FillDirection = Enum.FillDirection.Horizontal
swatchL1.Padding = UDim.new(0,8)
swatchL1.SortOrder = Enum.SortOrder.LayoutOrder
swatchL1.VerticalAlignment = Enum.VerticalAlignment.Center
swatchL1.Parent = swatchRow1

-- Separador "Exclusivos"
local exclusiveLbl = Instance.new("TextLabel")
exclusiveLbl.LayoutOrder = 3
exclusiveLbl.Size = UDim2.new(1,0,0,18)
exclusiveLbl.BackgroundTransparency = 1
exclusiveLbl.Text = "Exclusive themes"
exclusiveLbl.TextColor3 = T().subtext
exclusiveLbl.Font = Enum.Font.GothamBold
exclusiveLbl.TextSize = 11
exclusiveLbl.TextXAlignment = Enum.TextXAlignment.Left
exclusiveLbl.Parent = themeBox
table.insert(reg.subtexts, exclusiveLbl)

-- Fila 2: temas exclusivos
local swatchRow2 = Instance.new("Frame")
swatchRow2.LayoutOrder = 4
swatchRow2.Size = UDim2.new(1,0,0,46)
swatchRow2.BackgroundTransparency = 1
swatchRow2.BorderSizePixel = 0
swatchRow2.Parent = themeBox
local swatchL2 = Instance.new("UIListLayout")
swatchL2.FillDirection = Enum.FillDirection.Horizontal
swatchL2.Padding = UDim.new(0,8)
swatchL2.SortOrder = Enum.SortOrder.LayoutOrder
swatchL2.VerticalAlignment = Enum.VerticalAlignment.Center
swatchL2.Parent = swatchRow2

local SWATCH_DEFS = {
	{ name="Dark",      col=Color3.fromRGB(30,30,30),       row=swatchRow1 },
	{ name="Purple",    col=Color3.fromRGB(160,80,255),      row=swatchRow1 },
	{ name="Blue",      col=Color3.fromRGB(40,160,255),      row=swatchRow1 },
	{ name="Red",       col=Color3.fromRGB(230,50,50),       row=swatchRow1 },
	{ name="White",     col=Color3.fromRGB(210,210,210),     row=swatchRow1 },
	{ name="Valentine", col=Color3.fromRGB(255,105,155),     row=swatchRow2 },
	{ name="Cat",   col=Color3.fromRGB(30,30,30),        row=swatchRow2 },
}

local swatchData = {}

for i, def in ipairs(SWATCH_DEFS) do
	local sw = Instance.new("ImageButton")
	sw.Size = UDim2.new(0,42,0,42)
	sw.BackgroundColor3 = def.col
	sw.Image = THEMES[def.name].icon
	sw.ImageColor3 = Color3.new(1,1,1)
	sw.ImageTransparency = 0.55
	sw.ScaleType = Enum.ScaleType.Fit
	sw.BorderSizePixel = 0
	sw.AutoButtonColor = false
	sw.LayoutOrder = i
	sw.Parent = def.row
	styleCorner(sw, UDim.new(0,10))
	local stroke = styleStroke(sw, 0.92, Color3.new(1,1,1), 1)

	-- Nome pequeño debajo del swatch
	local nameLbl2 = Instance.new("TextLabel")
	nameLbl2.Size = UDim2.new(1,0,0,14)
	nameLbl2.Position = UDim2.new(0,0,1,2)
	nameLbl2.BackgroundTransparency = 1
	nameLbl2.Text = def.name
	nameLbl2.TextColor3 = T().subtext
	nameLbl2.Font = Enum.Font.Gotham
	nameLbl2.TextSize = 9
	nameLbl2.TextXAlignment = Enum.TextXAlignment.Center
	nameLbl2.Parent = sw
	table.insert(reg.subtexts, nameLbl2)

	swatchData[def.name] = {btn=sw, stroke=stroke}

	sw.MouseButton1Click:Connect(function()
		for _, d in pairs(swatchData) do
			d.stroke.Transparency = 0.92
			d.stroke.Thickness    = 1
			d.stroke.Color        = Color3.new(1,1,1)
		end
		stroke.Color        = THEMES[def.name].accent
		stroke.Transparency = 0
		stroke.Thickness    = 2.5

		currentThemeName = def.name
		themeCurLbl.Text = "Actual theme "..def.name
		applyTheme()
		switchTab(activeTabName)
	end)
end

-- Marcar default en primer frame
task.defer(function()
	local d = swatchData[currentThemeName]
	if d then
		d.stroke.Color        = THEMES[currentThemeName].accent
		d.stroke.Transparency = 0
		d.stroke.Thickness    = 2.5
	end
end)

-- ── Ícono del botón toggle ─────────────────────────────────
makeSectionLabel(settingsPage, "Button icons", 2)

local iconBox = Instance.new("Frame")
iconBox.LayoutOrder = 4
iconBox.Size = UDim2.new(1,0,0,84)
iconBox.BackgroundColor3 = T().bg
iconBox.BackgroundTransparency = CARD_TRANSPARENCY
iconBox.BorderSizePixel = 0
iconBox.Parent = settingsPage
styleCorner(iconBox, UDim.new(0,10))
styleStroke(iconBox, 0.88)
stylePadding(iconBox, 10,10,10,10)
table.insert(reg.panels, iconBox)

local iconPreview = Instance.new("ImageLabel")
iconPreview.Size = UDim2.new(0,52,0,52)
iconPreview.Position = UDim2.new(0,0,0.5,-26)
iconPreview.BackgroundTransparency = 1
iconPreview.Image = ICON_ID
iconPreview.ImageColor3 = T().accent
iconPreview.ScaleType = Enum.ScaleType.Fit
iconPreview.Parent = iconBox
table.insert(iconRefs, iconPreview)

local iconIdHint = Instance.new("TextLabel")
iconIdHint.Size = UDim2.new(1,-68,0,20)
iconIdHint.Position = UDim2.new(0,62,0,2)
iconIdHint.BackgroundTransparency = 1
iconIdHint.Text = "Asset ID  (número o rbxassetid://…)"
iconIdHint.TextColor3 = T().subtext
iconIdHint.Font = Enum.Font.Gotham
iconIdHint.TextSize = 11
iconIdHint.TextXAlignment = Enum.TextXAlignment.Left
iconIdHint.TextWrapped = true
iconIdHint.Parent = iconBox
table.insert(reg.subtexts, iconIdHint)

local iconIdBox = Instance.new("TextBox")
iconIdBox.Size = UDim2.new(1,-68,0,34)
iconIdBox.Position = UDim2.new(0,62,0,28)
iconIdBox.BackgroundColor3 = T().bg
iconIdBox.BackgroundTransparency = 0.1
iconIdBox.TextColor3 = T().text
iconIdBox.PlaceholderText = "rbxassetid://104348663064077"
iconIdBox.Text = ICON_ID
iconIdBox.TextSize = 12
iconIdBox.Font = Enum.Font.Gotham
iconIdBox.ClearTextOnFocus = false
iconIdBox.TextXAlignment = Enum.TextXAlignment.Left
iconIdBox.BorderSizePixel = 0
iconIdBox.Parent = iconBox
styleCorner(iconIdBox, UDim.new(0,7))
styleStroke(iconIdBox, 0.88)
stylePadding(iconIdBox, 0,0,8,8)
table.insert(reg.panels, iconIdBox)
table.insert(reg.texts, iconIdBox)

iconIdBox.FocusLost:Connect(function()
	local raw = iconIdBox.Text
	local id  = raw:match("rbxassetid://(%d+)") or raw:match("^(%d+)$")
	if id then
		local full = "rbxassetid://"..id
		iconIdBox.Text    = full
		iconPreview.Image = full
		headerIcon.Image  = full
		if toggleBtn then toggleBtn.Image = full end
	end
end)

-- ── Zona de peligro ───────────────────────────────────────
makeSectionLabel(settingsPage, "UI removal", 5)
local deleteGuiBtn = makeDangerBtn(settingsPage, "Remove UI", 6)
deleteGuiBtn.MouseButton1Click:Connect(function()
	-- Limpiar todo ordenadamente antes de destruir
	pcall(stopFly)
	pcall(stopMM2Aimbot)
	pcall(stopGeneralAimbot)
	espLoopActive = false
	if noclipConn  then pcall(function() noclipConn:Disconnect()  end); noclipConn  = nil end
	if godConn     then pcall(function() godConn:Disconnect()     end); godConn     = nil end
	if antiAFKConn then pcall(function() antiAFKConn:Disconnect() end); antiAFKConn = nil end
	for _, entry in ipairs(AVATAR_ITEMS) do
		if entry.item.state then
			entry.item.state = false
			pcall(entry.item.remove)
		end
	end
	-- Destruir la GUI
	if screenGui and screenGui.Parent then
		screenGui:Destroy()
	end
end)

--|| Info ||
local aboutPage = newPage("About")
do
	local box = Instance.new("Frame")
	box.Size = UDim2.new(1,0,0,400)
	box.BackgroundColor3 = T().bg
	box.BackgroundTransparency = CARD_TRANSPARENCY
	box.BorderSizePixel = 0
	box.Parent = aboutPage
	styleCorner(box, UDim.new(0,12))
	styleStroke(box, 0.80)
	stylePadding(box, 18,18,16,16)
	table.insert(reg.panels, box)

	local txt = Instance.new("TextLabel")
	txt.Size = UDim2.new(1,0,1,0)
	txt.BackgroundTransparency = 1
	txt.Text =
		" Happy Hub  v5\n"..
		"By replicatedman  · Open source \n\n"..
		"Waypoints  ·  Save and teleport.\n\n"..
		" ESP  ·  Highlights by team/role\n"..
		"for PL, MM2, and other games.\n"..
		"Live distance tags.\n\n"..
		"Movement ·  WalkSpeed · JumpPower\n"..
		"Noclip · God Mode · Infinite jump\n"..
		"Anti-AFK · /e laugh · Reset.\n\n"..
		"Fly  ·   fly with BodyVelocity.\n"..
		"WASD + Space/Ctrl · Q/E · joystick.\n\n"..
		"Aimbot  ·  Lock-On MM2 + General.\n"..
		"Suavidad y rango ajustables.\n\n"..
		" Avatar  ·  local Catalog.\n"..
		"Korblox · Shoulder · Invisible\n"..
		"Noob Face · Rainbow Body.\n\n"..
		"Settings  ·  7 themes (2 exclusive)\n"..
		"Icono personalizable · Delete Gui.\n\n"..
		"Keybind PC: F3"
	txt.TextColor3 = T().text
	txt.Font = Enum.Font.Gotham
	txt.TextSize = 13
	txt.TextXAlignment = Enum.TextXAlignment.Left
	txt.TextYAlignment = Enum.TextYAlignment.Top
	txt.TextWrapped = true
	txt.Parent = box
	table.insert(reg.texts, txt)
end

--============================================================
-- ESP LOGIC  (bug fix: reaplica ESP y NameTags tras muerte)
--============================================================
local TEAM_COLORS = {
	Criminals = Color3.fromRGB(255,60,60),
	Guards    = Color3.fromRGB(60,160,255),
	Inmates   = Color3.fromRGB(255,180,40),
	Neutral   = Color3.fromRGB(255,255,255),
}
local function getTeamColor(plr)
	return (plr.Team and TEAM_COLORS[plr.Team.Name]) or Color3.new(1,1,1)
end
local function isEnemy(plr)
	if not getStateTeamOnly() then return true end
	return plr.Team ~= player.Team
end

local espPL, espMM2, espOG = {}, {}, {}

-- ── Prison Life ESP ───────────────────────────────────────
local function applyESP_PL(plr, char)
	char = char or plr.Character
	if plr == player or not char or not isEnemy(plr) then return end
	-- Limpiar highlight muerto/inválido previo
	local ex = char:FindFirstChild("HHB_ESP_PL")
	if ex then ex.FillColor = getTeamColor(plr); espPL[plr]=ex; return end
	local h = Instance.new("Highlight")
	h.Name="HHB_ESP_PL"; h.FillColor=getTeamColor(plr); h.OutlineColor=Color3.new(1,1,1)
	h.FillTransparency=0.5; h.OutlineTransparency=0
	h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; h.Parent=char
	espPL[plr] = h
end
local function enableESP_PL()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character then applyESP_PL(p, p.Character) end
	end
end
local function disableESP_PL()
	for _, h in pairs(espPL) do if h and h.Parent then h:Destroy() end end
	espPL = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character then
			local h = p.Character:FindFirstChild("HHB_ESP_PL")
			if h then h:Destroy() end
		end
	end
end

-- ── MM2 ESP ────────────────────────────────────────────────
local ROLE_COLS = {
	Murderer=Color3.fromRGB(255, 0, 0),
	Sheriff=Color3.fromRGB(0, 132, 255),
	Innocent=Color3.fromRGB(56, 255, 112)
}
local function getRoleMM2(plr)
	if not plr.Character then return "Innocent" end
	local bp, ch = plr:FindFirstChild("Backpack"), plr.Character
	if (bp and bp:FindFirstChild("Knife")) or (ch and ch:FindFirstChild("Knife")) then return "Murderer" end
	if (bp and bp:FindFirstChild("Gun"))   or (ch and ch:FindFirstChild("Gun"))   then return "Sheriff"  end
	return "Innocent"
end
local function applyESP_MM2(plr)
	if plr==player or not plr.Character then return end
	local col = ROLE_COLS[getRoleMM2(plr)]
	local ex  = plr.Character:FindFirstChild("HHB_ESP_MM2")
	if ex then if ex.FillColor ~= col then ex.FillColor=col; ex.OutlineColor=col end; espMM2[plr]=ex; return end
	local h = Instance.new("Highlight")
	h.Name="HHB_ESP_MM2"; h.FillColor=col; h.OutlineColor=col
	h.FillTransparency=0.5; h.OutlineTransparency=1
	h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; h.Adornee=plr.Character; h.Parent=plr.Character
	espMM2[plr]=h
end
local function enableESP_MM2()
	for _, p in ipairs(Players:GetPlayers()) do applyESP_MM2(p) end
end
local function disableESP_MM2()
	for _, h in pairs(espMM2) do if h and h.Parent then h:Destroy() end end espMM2={}
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character then
			local h = p.Character:FindFirstChild("HHB_ESP_MM2")
			if h then h:Destroy() end
		end
	end
end

-- ── OG ESP ────────────────────────────────────────────────
local function applyESP_OG(plr)
	if plr==player or not plr.Character then return end
	local ex = plr.Character:FindFirstChild("HHB_ESP_OG"); if ex then espOG[plr]=ex; return end
	local h = Instance.new("Highlight")
	h.Name="HHB_ESP_OG"; h.FillColor=Color3.new(1,1,1); h.OutlineColor=Color3.new(1,1,1)
	h.FillTransparency=0.5; h.OutlineTransparency=1
	h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; h.Adornee=plr.Character; h.Parent=plr.Character
	espOG[plr]=h
end
local function enableESP_OG()
	for _, p in ipairs(Players:GetPlayers()) do applyESP_OG(p) end
end
local function disableESP_OG()
	for _, h in pairs(espOG) do if h and h.Parent then h:Destroy() end end espOG={}
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character then
			local h = p.Character:FindFirstChild("HHB_ESP_OG")
			if h then h:Destroy() end
		end
	end
end

-- ── Name Tags ─────────────────────────────────────────────
local ntObjs = {}
local function createNameTag(plr)
	if plr==player then return end
	local ch = plr.Character; if not ch then return end
	local hrp = ch:FindFirstChild("HumanoidRootPart"); if not hrp then return end
	-- Eliminar tag previo si existe (podría ser del personaje anterior)
	if ntObjs[plr] and ntObjs[plr].bb and ntObjs[plr].bb.Parent then
		ntObjs[plr].bb:Destroy()
	end
	if hrp:FindFirstChild("HHB_NameTag") then hrp:FindFirstChild("HHB_NameTag"):Destroy() end

	local bb = Instance.new("BillboardGui")
	bb.Name="HHB_NameTag"; bb.Size=UDim2.new(0,110,0,32)
	bb.StudsOffset=Vector3.new(0,3.5,0); bb.AlwaysOnTop=true
	bb.Adornee=hrp; bb.Parent=hrp
	local lbl = Instance.new("TextLabel")
	lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1
	lbl.TextColor3=Color3.new(1,1,1); lbl.Font=Enum.Font.GothamBold; lbl.TextSize=13
	lbl.TextStrokeTransparency=0.4; lbl.TextStrokeColor3=Color3.new(0,0,0)
	lbl.Parent=bb
	ntObjs[plr]={bb=bb,lbl=lbl}
end
local function removeNameTag(plr)
	if ntObjs[plr] then
		if ntObjs[plr].bb and ntObjs[plr].bb.Parent then ntObjs[plr].bb:Destroy() end
		ntObjs[plr]=nil
	end
end
local function enableNameTags()
	for _, p in ipairs(Players:GetPlayers()) do createNameTag(p) end
end
local function disableNameTags()
	for p in pairs(ntObjs) do removeNameTag(p) end
end

-- Heartbeat: actualiza distancia en name tags
RunService.Heartbeat:Connect(function()
	if not getStateNameTag() then return end
	local myHRP = getHRP()
	for plr, data in pairs(ntObjs) do
		if plr.Character and data.lbl then
			local theirHRP = plr.Character:FindFirstChild("HumanoidRootPart")
			if theirHRP and myHRP then
				data.lbl.Text = plr.DisplayName.."\n"..math.floor((myHRP.Position-theirHRP.Position).Magnitude).."m"
			else
				data.lbl.Text = plr.DisplayName
			end
		end
	end
end)

-- ── ESP Pill connections ───────────────────────────────────
pillPL.MouseButton1Click:Connect(function()
	local v=not getStatePL(); setStatePL(v)
	if v then enableESP_PL() else disableESP_PL() end
end)
pillMM2.MouseButton1Click:Connect(function()
	local v=not getStateMM2(); setStateMM2(v)
	if v then enableESP_MM2() else disableESP_MM2() end
end)
pillOG.MouseButton1Click:Connect(function()
	local v=not getStateOG(); setStateOG(v)
	if v then enableESP_OG() else disableESP_OG() end
end)
pillNameTag.MouseButton1Click:Connect(function()
	local v=not getStateNameTag(); setStateNameTag(v)
	if v then enableNameTags() else disableNameTags() end
end)
pillTeamOnly.MouseButton1Click:Connect(function()
	setStateTeamOnly(not getStateTeamOnly())
	if getStatePL() then disableESP_PL(); enableESP_PL() end
end)

-- ── CharacterAdded global: reaplica ESP + NameTags al respawn ──
-- BUG FIX: ahora escucha a todos los jugadores existentes Y los que se unan
local function connectPlayerESP(plr)
	plr.CharacterAdded:Connect(function(char)
		task.wait(0.5) -- esperar que el personaje cargue bien
		if getStatePL()      then applyESP_PL(plr, char)  end
		if getStateMM2()     then applyESP_MM2(plr)        end
		if getStateOG()      then applyESP_OG(plr)         end
		if getStateNameTag() then createNameTag(plr)        end
	end)
	plr:GetPropertyChangedSignal("Team"):Connect(function()
		if getStatePL() then
			local h = plr.Character and plr.Character:FindFirstChild("HHB_ESP_PL")
			if h then h.FillColor = getTeamColor(plr) end
		end
	end)
end

-- Conectar a todos los jugadores ya en el servidor
for _, plr in ipairs(Players:GetPlayers()) do
	if plr ~= player then connectPlayerESP(plr) end
end

Players.PlayerAdded:Connect(function(plr)
	connectPlayerESP(plr)
end)
Players.PlayerRemoving:Connect(function(plr)
	removeNameTag(plr)
	espPL[plr]=nil; espMM2[plr]=nil; espOG[plr]=nil
end)

-- Refresh loop para MM2 y OG (por cambios de rol en juego)
local espLoopActive = true
task.spawn(function()
	while espLoopActive do
		task.wait(2)
		if not espLoopActive then break end
		if getStateMM2() then enableESP_MM2() end
		if getStateOG()  then enableESP_OG()  end
		if getStatePL()  then
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local h = plr.Character:FindFirstChild("HHB_ESP_PL")
					if h and not isEnemy(plr) then h:Destroy(); espPL[plr]=nil
					elseif not h and isEnemy(plr) then applyESP_PL(plr, plr.Character) end
				end
			end
		end
	end
end)

--|| Open/Close anims ||--
local panelScale = Instance.new("UIScale")
panelScale.Scale = 1
panelScale.Parent = panel

local tweenInfo = TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfoOut = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

local function openGui()
	panel.Visible = true
	panel.Position = UDim2.new(0.5,0,0.5,0)
	panel.BackgroundTransparency = 0.5
	panelScale.Scale = 0.5
	TweenService:Create(panel, tweenInfo, {
		Position = UDim2.new(0.04,0,0.08,0),
		BackgroundTransparency = PANEL_TRANSPARENCY,
	}):Play()
	TweenService:Create(panelScale, tweenInfo, {Scale = 1}):Play()
end

local function closeGui()
	local tw = TweenService:Create(panel, tweenInfoOut, {
		Position = UDim2.new(1.5,0,0.5,0),
		BackgroundTransparency = 0.5,
	})
	tw:Play()
	TweenService:Create(panelScale, tweenInfoOut, {Scale = 0.92}):Play()
	tw.Completed:Once(function() panel.Visible = false; panelScale.Scale = 1 end)
end

closeBtn.MouseButton1Click:Connect(closeGui)

UserInputService.InputBegan:Connect(function(inp, processed)
	if processed then return end
	if inp.KeyCode == Enum.KeyCode.F3 then
		if panel.Visible then closeGui() else openGui() end
	end
end)

--||toggles ||--
local toggle = Instance.new("ImageButton")
toggle.Name = "HHBToggle"
toggle.Size = UDim2.new(0,62,0,62)
toggle.Position = UDim2.new(1,-80,1,-90)
toggle.BackgroundColor3 = T().bg
toggle.BackgroundTransparency = 0.12
toggle.AutoButtonColor = true
toggle.Image = ICON_ID
toggle.ImageColor3 = T().accent
toggle.ScaleType = Enum.ScaleType.Fit
toggle.BorderSizePixel = 0
toggle.Parent = screenGui
styleCorner(toggle, UDim.new(0,14))
styleStroke(toggle, 0.85)
table.insert(reg.panels, toggle)

toggleBtn = toggle

local dragging, wasDragged, dragInput, dragStart, startPos = false, false, nil, nil, nil
local DRAG_THRESHOLD = 10

toggle.InputBegan:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.Touch
		or inp.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging=true; wasDragged=false
		dragStart=inp.Position; startPos=toggle.AbsolutePosition; dragInput=inp
	end
end)
UserInputService.InputChanged:Connect(function(inp)
	if not dragging then return end
	if inp ~= dragInput and inp.UserInputType ~= Enum.UserInputType.MouseMovement then
		if inp.UserInputType ~= Enum.UserInputType.Touch then return end
	end
	if dragStart then
		local delta = inp.Position - dragStart
		if delta.Magnitude >= DRAG_THRESHOLD then wasDragged = true end
		local vp = workspace.CurrentCamera.ViewportSize
		local bw, bh = toggle.AbsoluteSize.X, toggle.AbsoluteSize.Y
		toggle.Position = UDim2.new(0,
			math.clamp(startPos.X + delta.X, 0, vp.X - bw), 0,
			math.clamp(startPos.Y + delta.Y, 0, vp.Y - bh))
	end
end)
UserInputService.InputEnded:Connect(function(inp)
	if inp == dragInput then dragging=false; dragInput=nil end
end)
toggle.MouseButton1Click:Connect(function()
	if wasDragged then wasDragged=false; return end
	if panel.Visible then closeGui() else openGui() end
end)

--|| Hello! ||--
switchTab("Waypoints")
applyTheme()

print(" · · · Happy Hub by replicatedman  | legacy  · · · ")
--[ i love this hub, is my best proyect :]
