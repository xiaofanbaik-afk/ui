--[[
    XIAOFAN HUB - LIGHT EDITION
    Simple, elegant, ringan. Flat design, checkbox toggle, sidebar list, collapsible section.
]]

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    task.wait()
    LocalPlayer = Players.LocalPlayer
end

local function getSafeParent()
    local ok, hui = pcall(function() return gethui and gethui() end)
    if ok and hui then return hui end
    local ok2 = pcall(function() return CoreGui end)
    if ok2 and CoreGui then return CoreGui end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local safeParent = getSafeParent()
if safeParent:FindFirstChild("XiaofanHubLight") then
    safeParent.XiaofanHubLight:Destroy()
end

----------------------------------------------------------------
-- PALETTE
----------------------------------------------------------------
local COL_BG        = Color3.fromRGB(15, 15, 18)   -- panel utama
local COL_SIDEBAR   = Color3.fromRGB(18, 18, 22)   -- sidebar dikit lebih gelap/beda
local COL_ACCENT    = Color3.fromRGB(168, 130, 255) -- ungu (kayak referensi), gampang diganti
local COL_TEXT      = Color3.fromRGB(220, 220, 225)
local COL_TEXT_DIM  = Color3.fromRGB(130, 130, 140)
local COL_DIVIDER   = Color3.fromRGB(30, 30, 35)

----------------------------------------------------------------
-- ROOT
----------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XiaofanHubLight"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
local pOk = pcall(function() ScreenGui.Parent = safeParent end)
if not pOk then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local TARGET_SIZE = UDim2.new(0, 500, 0, 320)
local TARGET_POS  = UDim2.new(0.5, -250, 0.5, -160)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = TARGET_SIZE
MainFrame.Position = TARGET_POS
MainFrame.BackgroundColor3 = COL_BG
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainFrame

----------------------------------------------------------------
-- TOP BAR (judul + minimize + close) - flat, tanpa background tebal
----------------------------------------------------------------
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 34)
TopBar.BackgroundTransparency = 1
TopBar.Parent = MainFrame

local TopDivider = Instance.new("Frame")
TopDivider.Size = UDim2.new(1, 0, 0, 1)
TopDivider.Position = UDim2.new(0, 0, 1, -1)
TopDivider.BackgroundColor3 = COL_DIVIDER
TopDivider.BorderSizePixel = 0
TopDivider.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Xiaofan Hub  "
Title.TextColor3 = COL_TEXT
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 160, 1, 0)
SubTitle.Position = UDim2.new(0, 100, 0, 0)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "v1.0 | Free"
SubTitle.TextColor3 = COL_ACCENT
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -13)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = COL_TEXT_DIM
CloseBtn.TextSize = 15
CloseBtn.Font = Enum.Font.Gotham
CloseBtn.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.Position = UDim2.new(1, -64, 0.5, -13)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = COL_TEXT_DIM
MinimizeBtn.TextSize = 15
MinimizeBtn.Font = Enum.Font.Gotham
MinimizeBtn.Parent = TopBar

----------------------------------------------------------------
-- SIDEBAR (list polos, gak ada kotak per item)
----------------------------------------------------------------
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 110, 1, -34)
Sidebar.Position = UDim2.new(0, 0, 0, 34)
Sidebar.BackgroundColor3 = COL_SIDEBAR
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SideDivider = Instance.new("Frame")
SideDivider.Size = UDim2.new(0, 1, 1, 0)
SideDivider.Position = UDim2.new(1, -1, 0, 0)
SideDivider.BackgroundColor3 = COL_DIVIDER
SideDivider.BorderSizePixel = 0
SideDivider.Parent = Sidebar

local TabList = Instance.new("ScrollingFrame")
TabList.Size = UDim2.new(1, 0, 1, -10)
TabList.Position = UDim2.new(0, 0, 0, 8)
TabList.BackgroundTransparency = 1
TabList.BorderSizePixel = 0
TabList.ScrollBarThickness = 2
TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabList.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Parent = TabList

----------------------------------------------------------------
-- CONTENT AREA
----------------------------------------------------------------
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -110, 1, -34)
ContentArea.Position = UDim2.new(0, 110, 0, 34)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local PageHolder = Instance.new("Frame")
PageHolder.Size = UDim2.new(1, -16, 1, -16)
PageHolder.Position = UDim2.new(0, 8, 0, 8)
PageHolder.BackgroundTransparency = 1
PageHolder.Parent = ContentArea

----------------------------------------------------------------
-- NOTIFIKASI (toast flat, kanan bawah)
----------------------------------------------------------------
local NotifHolder = Instance.new("Frame")
NotifHolder.Size = UDim2.new(0, 220, 1, -20)
NotifHolder.Position = UDim2.new(1, -230, 0, 10)
NotifHolder.BackgroundTransparency = 1
NotifHolder.Parent = ScreenGui

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.Padding = UDim.new(0, 6)
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.Parent = NotifHolder

----------------------------------------------------------------
-- MINIMIZE / CLOSE LOGIC
----------------------------------------------------------------
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    Sidebar.Visible = not isMinimized
    ContentArea.Visible = not isMinimized
    TweenService:Create(MainFrame, TweenInfo.new(0.2), {
        Size = isMinimized and UDim2.new(0, TARGET_SIZE.X.Offset, 0, 34) or TARGET_SIZE
    }):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    local tw = TweenService:Create(MainFrame, TweenInfo.new(0.18), {
        Size = UDim2.new(0, TARGET_SIZE.X.Offset, 0, 0),
        BackgroundTransparency = 1
    })
    tw:Play()
    tw.Completed:Wait()
    ScreenGui:Destroy()
end)

----------------------------------------------------------------
-- LIBRARY API
----------------------------------------------------------------
local Library = {}
Library.Tabs = {}

function Library:Notify(text, duration)
    duration = duration or 2.5
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(1, 0, 0, 36)
    Notif.BackgroundColor3 = COL_SIDEBAR
    Notif.BackgroundTransparency = 1
    Notif.BorderSizePixel = 0
    Notif.Parent = NotifHolder

    local NC = Instance.new("UICorner")
    NC.CornerRadius = UDim.new(0, 5)
    NC.Parent = Notif

    local NBar = Instance.new("Frame")
    NBar.Size = UDim2.new(0, 3, 1, 0)
    NBar.BackgroundColor3 = COL_ACCENT
    NBar.BackgroundTransparency = 1
    NBar.BorderSizePixel = 0
    NBar.Parent = Notif
    local NBarCorner = Instance.new("UICorner")
    NBarCorner.CornerRadius = UDim.new(0, 5)
    NBarCorner.Parent = NBar

    local NText = Instance.new("TextLabel")
    NText.Size = UDim2.new(1, -16, 1, 0)
    NText.Position = UDim2.new(0, 12, 0, 0)
    NText.BackgroundTransparency = 1
    NText.Text = text
    NText.TextColor3 = COL_TEXT
    NText.TextSize = 12
    NText.Font = Enum.Font.Gotham
    NText.TextXAlignment = Enum.TextXAlignment.Left
    NText.TextTransparency = 1
    NText.TextWrapped = true
    NText.Parent = Notif

    TweenService:Create(Notif, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    TweenService:Create(NBar, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    TweenService:Create(NText, TweenInfo.new(0.2), {TextTransparency = 0}):Play()

    task.delay(duration, function()
        if not Notif.Parent then return end
        TweenService:Create(Notif, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(NBar, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        local tw = TweenService:Create(NText, TweenInfo.new(0.2), {TextTransparency = 1})
        tw:Play()
        tw.Completed:Wait()
        Notif:Destroy()
    end)
end

function Library:CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 30)
    TabButton.BackgroundTransparency = 1
    TabButton.Text = ""
    TabButton.AutoButtonColor = false
    TabButton.LayoutOrder = #Library.Tabs + 1
    TabButton.Parent = TabList

    local ActiveBar = Instance.new("Frame")
    ActiveBar.Size = UDim2.new(0, 3, 0, 16)
    ActiveBar.Position = UDim2.new(0, 0, 0.5, -8)
    ActiveBar.BackgroundColor3 = COL_ACCENT
    ActiveBar.BackgroundTransparency = 1
    ActiveBar.BorderSizePixel = 0
    ActiveBar.Parent = TabButton

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 1, 0)
    Label.Position = UDim2.new(0, 16, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = COL_TEXT_DIM
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = TabButton

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 2
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Page.Parent = PageHolder

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 4)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Parent = Page

    local TabObj = {Page = Page, Name = name}

    local function selectTab()
        for _, t in pairs(Library.Tabs) do
            t.Page.Visible = false
            TweenService:Create(t.ActiveBar, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
            TweenService:Create(t.Label, TweenInfo.new(0.15), {TextColor3 = COL_TEXT_DIM}):Play()
        end
        Page.Visible = true
        TweenService:Create(ActiveBar, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
        TweenService:Create(Label, TweenInfo.new(0.15), {TextColor3 = COL_TEXT}):Play()
    end

    TabButton.MouseButton1Click:Connect(selectTab)
    TabObj.ActiveBar = ActiveBar
    TabObj.Label = Label
    table.insert(Library.Tabs, TabObj)
    if #Library.Tabs == 1 then selectTab() end

    ------------------------------------------------------------
    -- SECTION (collapsible, kayak "Auto Fishing ⌄" di referensi)
    ------------------------------------------------------------
    function TabObj:CreateSection(title)
        local Section = Instance.new("Frame")
        Section.Size = UDim2.new(1, 0, 0, 26)
        Section.BackgroundTransparency = 1
        Section.AutomaticSize = Enum.AutomaticSize.Y
        Section.Parent = Page

        local SecLayout = Instance.new("UIListLayout")
        SecLayout.SortOrder = Enum.SortOrder.LayoutOrder
        SecLayout.Parent = Section

        local Header = Instance.new("TextButton")
        Header.Size = UDim2.new(1, 0, 0, 22)
        Header.BackgroundTransparency = 1
        Header.Text = ""
        Header.AutoButtonColor = false
        Header.Parent = Section

        local HeaderText = Instance.new("TextLabel")
        HeaderText.Size = UDim2.new(1, -20, 1, 0)
        HeaderText.BackgroundTransparency = 1
        HeaderText.Text = title
        HeaderText.TextColor3 = COL_ACCENT
        HeaderText.TextSize = 12
        HeaderText.Font = Enum.Font.GothamBold
        HeaderText.TextXAlignment = Enum.TextXAlignment.Left
        HeaderText.Parent = Header

        local Chevron = Instance.new("TextLabel")
        Chevron.Size = UDim2.new(0, 20, 1, 0)
        Chevron.Position = UDim2.new(1, -20, 0, 0)
        Chevron.BackgroundTransparency = 1
        Chevron.Text = "⌄"
        Chevron.TextColor3 = COL_TEXT_DIM
        Chevron.TextSize = 14
        Chevron.Font = Enum.Font.Gotham
        Chevron.Parent = Header

        local Body = Instance.new("Frame")
        Body.Size = UDim2.new(1, 0, 0, 0)
        Body.AutomaticSize = Enum.AutomaticSize.Y
        Body.BackgroundTransparency = 1
        Body.Visible = true
        Body.LayoutOrder = 2
        Body.Parent = Section

        local BodyLayout = Instance.new("UIListLayout")
        BodyLayout.Padding = UDim.new(0, 4)
        BodyLayout.SortOrder = Enum.SortOrder.LayoutOrder
        BodyLayout.Parent = Body

        local expanded = true
        Header.MouseButton1Click:Connect(function()
            expanded = not expanded
            Body.Visible = expanded
            Chevron.Text = expanded and "⌄" or "›"
        end)

        local SecObj = {Body = Body}

        function SecObj:CreateToggle(text, default, callback)
            callback = callback or function() end
            local state = default or false

            local Row = Instance.new("TextButton")
            Row.Size = UDim2.new(1, 0, 0, 24)
            Row.BackgroundTransparency = 1
            Row.Text = ""
            Row.AutoButtonColor = false
            Row.Parent = Body

            local Box = Instance.new("Frame")
            Box.Size = UDim2.new(0, 15, 0, 15)
            Box.Position = UDim2.new(0, 2, 0.5, -7)
            Box.BackgroundColor3 = COL_SIDEBAR
            Box.BorderSizePixel = 0
            Box.Parent = Row

            local BoxCorner = Instance.new("UICorner")
            BoxCorner.CornerRadius = UDim.new(0, 4)
            BoxCorner.Parent = Box

            local BoxStroke = Instance.new("UIStroke")
            BoxStroke.Color = COL_TEXT_DIM
            BoxStroke.Thickness = 1
            BoxStroke.Parent = Box

            local Check = Instance.new("Frame")
            Check.Size = UDim2.new(0, 9, 0, 9)
            Check.Position = UDim2.new(0.5, -4.5, 0.5, -4.5)
            Check.BackgroundColor3 = COL_ACCENT
            Check.BackgroundTransparency = state and 0 or 1
            Check.BorderSizePixel = 0
            Check.Parent = Box
            local CheckCorner = Instance.new("UICorner")
            CheckCorner.CornerRadius = UDim.new(0, 2)
            CheckCorner.Parent = Check

            local Label2 = Instance.new("TextLabel")
            Label2.Size = UDim2.new(1, -30, 1, 0)
            Label2.Position = UDim2.new(0, 26, 0, 0)
            Label2.BackgroundTransparency = 1
            Label2.Text = text
            Label2.TextColor3 = COL_TEXT
            Label2.TextSize = 12
            Label2.Font = Enum.Font.Gotham
            Label2.TextXAlignment = Enum.TextXAlignment.Left
            Label2.Parent = Row

            Row.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(Check, TweenInfo.new(0.12), {BackgroundTransparency = state and 0 or 1}):Play()
                BoxStroke.Color = state and COL_ACCENT or COL_TEXT_DIM
                local ok, err = pcall(callback, state)
                if not ok then warn("[XiaofanHub] toggle error: " .. tostring(err)) end
            end)

            return Row
        end

        function SecObj:CreateSlider(text, min, max, default, callback)
            callback = callback or function() end
            min, max = min or 0, max or 100
            default = math.clamp(default or min, min, max)

            local Holder = Instance.new("Frame")
            Holder.Size = UDim2.new(1, 0, 0, 34)
            Holder.BackgroundTransparency = 1
            Holder.Parent = Body

            local Label2 = Instance.new("TextLabel")
            Label2.Size = UDim2.new(1, -40, 0, 16)
            Label2.BackgroundTransparency = 1
            Label2.Text = text
            Label2.TextColor3 = COL_TEXT
            Label2.TextSize = 12
            Label2.Font = Enum.Font.Gotham
            Label2.TextXAlignment = Enum.TextXAlignment.Left
            Label2.Parent = Holder

            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 40, 0, 16)
            ValueLabel.Position = UDim2.new(1, -40, 0, 0)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(default)
            ValueLabel.TextColor3 = COL_ACCENT
            ValueLabel.TextSize = 12
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Parent = Holder

            local Track = Instance.new("Frame")
            Track.Size = UDim2.new(1, 0, 0, 4)
            Track.Position = UDim2.new(0, 0, 0, 22)
            Track.BackgroundColor3 = COL_SIDEBAR
            Track.BorderSizePixel = 0
            Track.Parent = Holder
            local TrackCorner = Instance.new("UICorner")
            TrackCorner.CornerRadius = UDim.new(1, 0)
            TrackCorner.Parent = Track

            local Fill = Instance.new("Frame")
            local pct = (default - min) / (max - min)
            Fill.Size = UDim2.new(pct, 0, 1, 0)
            Fill.BackgroundColor3 = COL_ACCENT
            Fill.BorderSizePixel = 0
            Fill.Parent = Track
            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = Fill

            local dragging = false
            local function update(input)
                local rel = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * rel)
                Fill.Size = UDim2.new(rel, 0, 1, 0)
                ValueLabel.Text = tostring(value)
                local ok, err = pcall(callback, value)
                if not ok then warn("[XiaofanHub] slider error: " .. tostring(err)) end
            end

            Track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    update(input)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    update(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            return Holder
        end

        function SecObj:CreateButton(text, callback)
            callback = callback or function() end
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 26)
            Btn.BackgroundColor3 = COL_SIDEBAR
            Btn.Text = text
            Btn.TextColor3 = COL_TEXT
            Btn.TextSize = 12
            Btn.Font = Enum.Font.GothamBold
            Btn.AutoButtonColor = false
            Btn.Parent = Body

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 4)
            BtnCorner.Parent = Btn

            Btn.MouseButton1Click:Connect(function()
                TweenService:Create(Btn, TweenInfo.new(0.08), {BackgroundColor3 = COL_ACCENT}):Play()
                task.wait(0.08)
                TweenService:Create(Btn, TweenInfo.new(0.12), {BackgroundColor3 = COL_SIDEBAR}):Play()
                local ok, err = pcall(callback)
                if not ok then warn("[XiaofanHub] button error: " .. tostring(err)) end
            end)

            return Btn
        end

        return SecObj
    end

    return TabObj
end

----------------------------------------------------------------
-- CONTOH PEMAKAIAN (ganti/hapus sesuai kebutuhan)
----------------------------------------------------------------
local MainTab = Library:CreateTab("Main")
local ItemsTab = Library:CreateTab("Items")
local SettingsTab = Library:CreateTab("Settings")

local GeneralSection = MainTab:CreateSection("General")
GeneralSection:CreateToggle("Enable Feature A", false, function(state)
    print("Feature A:", state)
end)
GeneralSection:CreateToggle("Enable Feature B", false, function(state)
    print("Feature B:", state)
end)
GeneralSection:CreateSlider("Speed", 16, 100, 16, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

local AdvancedSection = MainTab:CreateSection("Advanced")
AdvancedSection:CreateButton("Run Action", function()
    Library:Notify("Action berhasil dijalankan")
end)

return Library
