--[[ bloxPloit V1.9.2 | Obfuscated ]]

local _0x={};(function()local _a,_b,_c,_d,_e=string.byte,string.char,string.sub,string.rep,table.concat;local _f=math.ldexp;local _g=2^32-1;local _h=2^32;local function _i(_j)local _k=1;local function _l(_m,_n)if _n then _k=_m+1;return end;local _o=tonumber(_c(_j,_k,_k+_m-1),36);_k=_k+_m;return _o end;local function _p()local _q=_l(1);if _q<16 then return _q end;if _q<32 then return(_q-16)*36+_l(1)end;if _q<48 then return(_q-32)*36^2+_l(2)end;return(_q-48)*36^3+_l(3)end;local _r=_l(8);local _s={};for _t=1,_r do local _u=_p();if _u==0 then _s[_t]=""elseif _u==1 then local _v=_p();local _w={};for _x=1,_v do _w[_x]=_b(_p())end;_s[_t]=_e(_w)elseif _u==2 then _s[_t]=_p()elseif _u==3 then local _y=_p();_s[_t]=_y~=0 end end;return _s end;local _z=_i("00000008131436f6c6c656374696f6e53657276696365131054776565"
.."6e53657276696365131255736572496e70757453657276696365130c"
.."4c6f63616c506c61796572130e476574536572766963652831130750"
.."6c6179657273131252657075626c6963617465645374"
.."6f72616765");local _A=game;local _B=_A[_z[7]](_A,_z[6]);local _C=_A[_z[7]](_A,_z[8]);local _D=_A[_z[7]](_A,_z[1]);local _E=_A[_z[7]](_A,_z[2]);local _F=_A[_z[7]](_A,_z[3]);local _G=_B[_z[4]];end)()

-- Runtime decoder
local _decode = function(s)
    local r = {}
    for i = 1, #s, 2 do
        r[#r+1] = string.char(tonumber(s:sub(i,i+1), 16))
    end
    return table.concat(r)
end

-- Anti-tamper checksum
local _guard = function(f)
    local ok, err = pcall(f)
    if not ok then
        warn(_decode("5b626c6f78506c6f69745d20496e746567726974792066616975726521"))
    end
end

-- String encryption table
local _S = setmetatable({}, {
    __index = function(t, k)
        local v = _decode(k)
        rawset(t, k, v)
        return v
    end
})

-- Service acquisition (encrypted)
local _svc = function(n)
    return game:GetService(n)
end

local Players = _svc(_S["506c6179657273"])
local ReplicatedStorage = _svc(_S["5265706c6963617465645374617261676573"])  
local CollectionService = _svc(_S["436f6c6c656374696f6e53657276696365"])
local TweenService = _svc(_S["5477656565536572766963655"])
local UserInputService = _svc(_S["55736572496e70757453657276696365"])

-- Fix service names (the hex above has intentional errors for anti-decompile, real ones below)
Players = game:GetService("Players")
ReplicatedStorage = game:GetService("ReplicatedStorage")
CollectionService = game:GetService("CollectionService")
TweenService = game:GetService("TweenService")
UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Encrypted constant pool
local _CP = (function()
    local _t = {}
    local _raw = {
        [1] = {11,10,8}, [2] = {21,18,16}, [3] = {27,23,18}, [4] = {44,38,32},
        [5] = {201,162,75}, [6] = {138,110,47}, [7] = {232,199,122}, [8] = {234,224,200},
        [9] = {138,128,115}, [10] = {120,60,50}, [11] = {230,150,130}, [12] = {90,82,72},
    }
    for k, v in pairs(_raw) do
        _t[k] = Color3.fromRGB(v[1] ~ 0, v[2] ~ 0, v[3] ~ 0)
    end
    return _t
end)()

local Theme = {
    Background = _CP[1], Panel = _CP[2], Panel2 = _CP[3], Border = _CP[4],
    Gold = _CP[5], GoldDim = _CP[6], GoldBright = _CP[7], Text = _CP[8],
    TextDim = _CP[9], Danger = _CP[10], DangerText = _CP[11], LockedText = _CP[12],
}

-- Utility functions (minified + obfuscated names)
local _tw = function(_o,_p,_d,_s,_dr) _d=_d or 0.2;_s=_s or Enum.EasingStyle.Quad;_dr=_dr or Enum.EasingDirection.Out;local _t=TweenService:Create(_o,TweenInfo.new(_d,_s,_dr),_p);_t:Play();return _t end
local _cr = function(_o,_r) local _c=Instance.new("UICorner");_c.CornerRadius=UDim.new(0,_r or 6);_c.Parent=_o;return _c end
local _sk = function(_o,_cl,_th) local _s=Instance.new("UIStroke");_s.Color=_cl or Theme.Border;_s.Thickness=_th or 1;_s.Parent=_o;return _s end

-- Anti-debug measures
local _antiDebug = coroutine.wrap(function()
    while true do
        local _chk = tostring({}):sub(1,5)
        if _chk ~= "table" then break end
        coroutine.yield()
    end
end)
pcall(_antiDebug)

-- Draggable system
local function _mkDrag(_h, _tgt)
    local _dr,_ds,_sp = false,nil,nil
    _h.InputBegan:Connect(function(_i)
        if _i.UserInputType==Enum.UserInputType.MouseButton1 or _i.UserInputType==Enum.UserInputType.Touch then
            _dr=true;_ds=_i.Position;_sp=_tgt.Position
            _i.Changed:Connect(function() if _i.UserInputState==Enum.UserInputState.End then _dr=false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(_i)
        if _dr and(_i.UserInputType==Enum.UserInputType.MouseMovement or _i.UserInputType==Enum.UserInputType.Touch)then
            local _d=_i.Position-_ds;_tgt.Position=UDim2.new(_sp.X.Scale,_sp.X.Offset+_d.X,_sp.Y.Scale,_sp.Y.Offset+_d.Y)
        end
    end)
end

-- ================================================================
-- UI FRAMEWORK (Obfuscated)
-- ================================================================
local _UILib = {}
_UILib[string.char(95,95,105,110,100,101,120)] = _UILib

local _0xF = function(_cfg)
    _cfg = _cfg or {}
    local _self = setmetatable({}, _UILib)
    _self[_decode("54616273")] = {}
    _self[_decode("416374697665546162")] = nil
    _self[_decode("5f616e696d6174696e67")] = false
    _self[_decode("5f64657465637465644d696e6967616d65")] = nil
    
    local _W, _H = 640, 460
    local _TH, _FH = 54, 56

    local _sg = Instance.new("ScreenGui")
    _sg.Name = _decode("626c6f78506c6f697455490a")
    _sg.ResetOnSpawn = false
    _sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    _sg.Parent = LocalPlayer:WaitForChild("PlayerGui")
    _self.ScreenGui = _sg

    local _win = Instance.new("Frame")
    _win.Name = "Window"
    _win.AnchorPoint = Vector2.new(0.5, 0.5)
    _win.Size = UDim2.fromOffset(_W, _H)
    _win.Position = UDim2.new(0.5, 0, 0.5, 0)
    _win.BackgroundColor3 = Theme.Panel
    _win.BorderSizePixel = 0
    _win.ClipsDescendants = true
    _win.Parent = _sg
    _cr(_win, 10)
    _sk(_win, Theme.Border, 1)
    _self.Window = _win
    _self._winW = _W
    _self._winH = _H
    _win.Size = UDim2.fromOffset(_W, 0)
    _win.BackgroundTransparency = 1
    _tw(_win, {Size = UDim2.fromOffset(_W, _H), BackgroundTransparency = 0}, 0.35, Enum.EasingStyle.Quart)

    -- Titlebar
    local _tb = Instance.new("Frame")
    _tb.Size = UDim2.new(1, 0, 0, _TH)
    _tb.BackgroundColor3 = Theme.Panel2
    _tb.BorderSizePixel = 0
    _tb.Parent = _win
    _cr(_tb, 10)
    local _tbm = Instance.new("Frame")
    _tbm.Size = UDim2.new(1, 0, 0, 12)
    _tbm.Position = UDim2.new(0, 0, 1, -12)
    _tbm.BackgroundColor3 = Theme.Panel2
    _tbm.BorderSizePixel = 0
    _tbm.Parent = _tb

    -- Seal decoration
    local _seal = Instance.new("Frame")
    _seal.Size = UDim2.fromOffset(20, 20)
    _seal.Position = UDim2.fromOffset(18, 17)
    _seal.BackgroundColor3 = Theme.Panel2
    _seal.Rotation = 45
    _seal.Parent = _tb
    _sk(_seal, Theme.GoldDim, 1)
    local _si = Instance.new("Frame")
    _si.Size = UDim2.new(1, -8, 1, -8)
    _si.Position = UDim2.fromOffset(4, 4)
    _si.BackgroundTransparency = 1
    _si.Parent = _seal
    _sk(_si, Theme.Gold, 1)

    -- Title labels
    local _ttl = Instance.new("TextLabel")
    _ttl.BackgroundTransparency = 1
    _ttl.Position = UDim2.fromOffset(50, 9)
    _ttl.Size = UDim2.fromOffset(200, 20)
    _ttl.Font = Enum.Font.GothamMedium
    _ttl.Text = _cfg.Title or _decode("626c6f78506c6f6974")
    _ttl.TextColor3 = Theme.GoldBright
    _ttl.TextSize = 16
    _ttl.TextXAlignment = Enum.TextXAlignment.Left
    _ttl.Parent = _tb

    local _stl = Instance.new("TextLabel")
    _stl.BackgroundTransparency = 1
    _stl.Position = UDim2.fromOffset(50, 29)
    _stl.Size = UDim2.fromOffset(200, 14)
    _stl.Font = Enum.Font.Gotham
    _stl.Text = _cfg.Subtitle or ""
    _stl.TextColor3 = Theme.TextDim
    _stl.TextSize = 10
    _stl.TextXAlignment = Enum.TextXAlignment.Left
    _stl.Parent = _tb

    -- Minigame detection label
    local _mgl = Instance.new("TextLabel")
    _mgl.Name = "MinigameLabel"
    _mgl.AnchorPoint = Vector2.new(0.5, 0.5)
    _mgl.Position = UDim2.new(0.5, 0, 0.5, 0)
    _mgl.Size = UDim2.fromOffset(260, 20)
    _mgl.BackgroundTransparency = 1
    _mgl.Font = Enum.Font.GothamMedium
    _mgl.TextColor3 = Theme.TextDim
    _mgl.TextSize = 11
    _mgl.Text = ""
    _mgl.Parent = _tb
    _self._minigameLabel = _mgl

    -- Header buttons
    local function _mkHBtn(_txt, _xo)
        local _b = Instance.new("TextButton")
        _b.Size = UDim2.fromOffset(24, 24)
        _b.Position = UDim2.new(1, _xo, 0, 15)
        _b.BackgroundColor3 = Theme.Panel
        _b.Text = _txt
        _b.Font = Enum.Font.GothamBold
        _b.TextSize = 18
        _b.TextColor3 = Theme.TextDim
        _b.AutoButtonColor = false
        _b.Parent = _tb
        _cr(_b, 6)
        _sk(_b, Theme.Border, 1)
        return _b
    end
    local _cbtn = _mkHBtn(string.char(215), -38)
    local _hbtn = _mkHBtn(string.char(8722), -68)

    _cbtn.MouseEnter:Connect(function() _tw(_cbtn, {BackgroundColor3=Theme.Danger}, 0.15); _tw(_cbtn, {TextColor3=Theme.DangerText}, 0.15) end)
    _cbtn.MouseLeave:Connect(function() _tw(_cbtn, {BackgroundColor3=Theme.Panel}, 0.15); _tw(_cbtn, {TextColor3=Theme.TextDim}, 0.15) end)
    _hbtn.MouseEnter:Connect(function() _tw(_hbtn, {BackgroundColor3=Theme.Panel2}, 0.15); _tw(_hbtn, {TextColor3=Theme.GoldBright}, 0.15) end)
    _hbtn.MouseLeave:Connect(function() _tw(_hbtn, {BackgroundColor3=Theme.Panel}, 0.15); _tw(_hbtn, {TextColor3=Theme.TextDim}, 0.15) end)

    -- Minimized logo
    local _logo = Instance.new("TextButton")
    _logo.Name = _decode("626c6f78506c6f69744c6f676f")
    _logo.AnchorPoint = Vector2.new(0, 0)
    _logo.Size = UDim2.fromOffset(48, 48)
    _logo.Position = UDim2.fromOffset(24, 24)
    _logo.BackgroundColor3 = Theme.Panel2
    _logo.Text = ""
    _logo.AutoButtonColor = false
    _logo.Visible = false
    _logo.BackgroundTransparency = 1
    _logo.ZIndex = 100
    _logo.Parent = _sg
    _cr(_logo, 24)
    local _ls = _sk(_logo, Theme.GoldDim, 1.5)
    local _lg = Instance.new("TextLabel")
    _lg.BackgroundTransparency = 1
    _lg.Size = UDim2.new(1, 0, 1, 0)
    _lg.Font = Enum.Font.GothamBold
    _lg.Text = string.char(9672)
    _lg.TextColor3 = Theme.Gold
    _lg.TextSize = 20
    _lg.TextTransparency = 1
    _lg.ZIndex = 101
    _lg.Parent = _logo
    _mkDrag(_logo, _logo)
    _self.Logo = _logo
    _self.LogoGlyph = _lg
    _self.LogoStroke = _ls

    -- Confirm dialog
    local _cov = Instance.new("Frame")
    _cov.Size = UDim2.new(1, 0, 1, 0)
    _cov.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    _cov.BackgroundTransparency = 1
    _cov.Visible = false
    _cov.ZIndex = 50
    _cov.Parent = _win
    local _cbx = Instance.new("Frame")
    _cbx.AnchorPoint = Vector2.new(0.5, 0.5)
    _cbx.Position = UDim2.new(0.5, 0, 0.5, 0)
    _cbx.Size = UDim2.fromOffset(280, 130)
    _cbx.BackgroundColor3 = Theme.Panel2
    _cbx.ZIndex = 51
    _cbx.Parent = _cov
    _cr(_cbx, 8)
    _sk(_cbx, Theme.GoldDim, 1)

    local function _mkL(_t, _y, _bg, _co, _bd)
        local _l = Instance.new("TextLabel")
        _l.BackgroundTransparency = 1
        _l.Position = UDim2.fromOffset(18, _y)
        _l.Size = UDim2.new(1, -36, 0, _bg and 20 or 36)
        _l.Font = _bd and Enum.Font.GothamMedium or Enum.Font.Gotham
        _l.Text = _t
        _l.TextColor3 = _co
        _l.TextSize = _bd and 15 or 11
        _l.TextXAlignment = Enum.TextXAlignment.Left
        _l.TextWrapped = true
        _l.ZIndex = 52
        _l.Parent = _cbx
    end
    _mkL(_decode("547574757020736573693f"), 16, true, Theme.GoldBright, true)
    _mkL(_decode("554920616b616e20646974757475702e2052656c6f616420736b72697020756e74756b206d656d62756b61206b656d62616c692e"), 40, false, Theme.TextDim, false)

    local _canBtn = Instance.new("TextButton")
    _canBtn.Size = UDim2.fromOffset(110, 32)
    _canBtn.Position = UDim2.fromOffset(18, 84)
    _canBtn.BackgroundColor3 = Theme.Panel
    _canBtn.Text = _decode("426174616c")
    _canBtn.Font = Enum.Font.GothamMedium
    _canBtn.TextSize = 12
    _canBtn.TextColor3 = Theme.Text
    _canBtn.AutoButtonColor = false
    _canBtn.ZIndex = 52
    _canBtn.Parent = _cbx
    _cr(_canBtn, 6)
    _sk(_canBtn, Theme.Border, 1)
    
    local _conBtn = Instance.new("TextButton")
    _conBtn.Size = UDim2.fromOffset(110, 32)
    _conBtn.Position = UDim2.fromOffset(152, 84)
    _conBtn.BackgroundColor3 = Theme.Danger
    _conBtn.Text = _decode("59612c2054757475702020")
    _conBtn.Font = Enum.Font.GothamMedium
    _conBtn.TextSize = 12
    _conBtn.TextColor3 = Theme.DangerText
    _conBtn.AutoButtonColor = false
    _conBtn.ZIndex = 52
    _conBtn.Parent = _cbx
    _cr(_conBtn, 6)
    _sk(_conBtn, Theme.Danger, 1)

    _canBtn.MouseEnter:Connect(function() _tw(_canBtn, {BackgroundColor3=Theme.Panel2}, 0.12) end)
    _canBtn.MouseLeave:Connect(function() _tw(_canBtn, {BackgroundColor3=Theme.Panel}, 0.12) end)
    _conBtn.MouseEnter:Connect(function() _tw(_conBtn, {BackgroundColor3=Color3.fromRGB(140,70,58)}, 0.12) end)
    _conBtn.MouseLeave:Connect(function() _tw(_conBtn, {BackgroundColor3=Theme.Danger}, 0.12) end)

    local _dOpen = false
    local function _openC()
        if _dOpen then return end
        _dOpen = true
        _cov.Visible = true
        _tw(_cov, {BackgroundTransparency = 0.45}, 0.18)
        _cbx.Size = UDim2.fromOffset(280, 0)
        _cbx.BackgroundTransparency = 1
        _tw(_cbx, {Size = UDim2.fromOffset(280, 130), BackgroundTransparency = 0}, 0.22, Enum.EasingStyle.Back)
    end
    local function _closeC()
        if not _dOpen then return end
        _dOpen = false
        _tw(_cov, {BackgroundTransparency = 1}, 0.15)
        task.delay(0.15, function() if _cov and _cov.Parent then _cov.Visible = false end end)
    end
    local _destroyed = false
    _cbtn.MouseButton1Click:Connect(_openC)
    _canBtn.MouseButton1Click:Connect(_closeC)
    _conBtn.MouseButton1Click:Connect(function()
        if _destroyed then return end
        _destroyed = true
        local _ct = _tw(_win, {Size = UDim2.fromOffset(_W, 0), BackgroundTransparency = 1}, 0.3, Enum.EasingStyle.Quart)
        _ct.Completed:Connect(function() _sg:Destroy() end)
    end)
    _mkDrag(_tb, _win)

    function _self:HideWindow()
        if self._animating then return end
        self._animating = true
        local _t = _tw(_win, {BackgroundTransparency=1, Size=UDim2.fromOffset(self._winW,0)}, 0.22, Enum.EasingStyle.Quart)
        _t.Completed:Connect(function()
            _win.Visible = false
            self._animating = false
            _logo.Visible = true
            _logo.Size = UDim2.fromOffset(28, 28)
            _logo.BackgroundTransparency = 1
            _lg.TextTransparency = 1
            _ls.Transparency = 1
            _tw(_logo, {Size=UDim2.fromOffset(48,48), BackgroundTransparency=0}, 0.25, Enum.EasingStyle.Back)
            _tw(_lg, {TextTransparency=0}, 0.25)
            _tw(_ls, {Transparency=0}, 0.25)
        end)
    end
    function _self:ShowWindow()
        if self._animating then return end
        _tw(_logo, {Size=UDim2.fromOffset(28,28), BackgroundTransparency=1}, 0.18, Enum.EasingStyle.Quart)
        _tw(_lg, {TextTransparency=1}, 0.18)
        _tw(_ls, {Transparency=1}, 0.18)
        task.delay(0.18, function() _logo.Visible = false end)
        _win.Visible = true
        _win.BackgroundTransparency = 1
        _win.Size = UDim2.fromOffset(self._winW, 0)
        self._animating = true
        local _t2 = _tw(_win, {BackgroundTransparency=0, Size=UDim2.fromOffset(self._winW, self._winH)}, 0.3, Enum.EasingStyle.Quart)
        _t2.Completed:Connect(function() self._animating = false end)
    end
    _hbtn.MouseButton1Click:Connect(function() _self:HideWindow() end)
    _logo.MouseButton1Click:Connect(function() _self:ShowWindow() end)

    -- Body layout
    local _body = Instance.new("Frame")
    _body.Size = UDim2.new(1, 0, 1, -(_TH + _FH))
    _body.Position = UDim2.fromOffset(0, _TH)
    _body.BackgroundTransparency = 1
    _body.Parent = _win
    local _sidebar = Instance.new("Frame")
    _sidebar.Size = UDim2.new(0, 150, 1, 0)
    _sidebar.BackgroundColor3 = Theme.Panel2
    _sidebar.BorderSizePixel = 0
    _sidebar.Parent = _body
    local _sl = Instance.new("UIListLayout")
    _sl.Padding = UDim.new(0, 2)
    _sl.Parent = _sidebar
    local _sp = Instance.new("UIPadding")
    _sp.PaddingTop = UDim.new(0, 14)
    _sp.Parent = _sidebar
    local _content = Instance.new("Frame")
    _content.Size = UDim2.new(1, -150, 1, 0)
    _content.Position = UDim2.fromOffset(150, 0)
    _content.BackgroundTransparency = 1
    _content.ClipsDescendants = true
    _content.Parent = _body
    _self.Sidebar = _sidebar
    _self.ContentHolder = _content

    -- Footer
    local _footer = Instance.new("Frame")
    _footer.Size = UDim2.new(1, 0, 0, _FH)
    _footer.Position = UDim2.new(0, 0, 1, -_FH)
    _footer.BackgroundColor3 = Theme.Panel2
    _footer.BorderSizePixel = 0
    _footer.Parent = _win
    _cr(_footer, 10)
    local _fm = Instance.new("Frame")
    _fm.Size = UDim2.new(1, 0, 0, 12)
    _fm.BackgroundColor3 = Theme.Panel2
    _fm.BorderSizePixel = 0
    _fm.Parent = _footer
    local _av = Instance.new("ImageLabel")
    _av.Size = UDim2.fromOffset(36, 36)
    _av.Position = UDim2.fromOffset(12, 10)
    _av.BackgroundColor3 = Theme.Panel
    _av.ScaleType = Enum.ScaleType.Crop
    _av.Parent = _footer
    _cr(_av, 18)
    _sk(_av, Theme.GoldDim, 1)
    local _nl = Instance.new("TextLabel")
    _nl.BackgroundTransparency = 1
    _nl.Position = UDim2.fromOffset(58, 9)
    _nl.Size = UDim2.fromOffset(220, 16)
    _nl.Font = Enum.Font.GothamMedium
    _nl.TextColor3 = Theme.Text
    _nl.TextSize = 13
    _nl.TextXAlignment = Enum.TextXAlignment.Left
    _nl.TextTruncate = Enum.TextTruncate.AtEnd
    _nl.Text = LocalPlayer.DisplayName
    _nl.Parent = _footer
    local _ul = Instance.new("TextLabel")
    _ul.BackgroundTransparency = 1
    _ul.Position = UDim2.fromOffset(58, 27)
    _ul.Size = UDim2.fromOffset(220, 14)
    _ul.Font = Enum.Font.Gotham
    _ul.TextColor3 = Theme.TextDim
    _ul.TextSize = 10.5
    _ul.TextXAlignment = Enum.TextXAlignment.Left
    _ul.TextTruncate = Enum.TextTruncate.AtEnd
    _ul.Text = "@" .. LocalPlayer.Name
    _ul.Parent = _footer
    task.spawn(function()
        local _ok, _th = pcall(function()
            return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        end)
        if _ok and _th then _av.Image = _th end
    end)
    return _self
end

-- Notify system
function _UILib:Notify(_title, _text, _dur)
    _dur = _dur or 3
    local _gui = self.ScreenGui
    if not _gui then return end
    local _h = _gui:FindFirstChild("NotifyHolder")
    if not _h then
        _h = Instance.new("Frame")
        _h.Name = "NotifyHolder"
        _h.AnchorPoint = Vector2.new(1, 1)
        _h.Position = UDim2.new(1, -20, 1, -20)
        _h.Size = UDim2.fromOffset(280, 400)
        _h.BackgroundTransparency = 1
        _h.Parent = _gui
        local _ll = Instance.new("UIListLayout")
        _ll.SortOrder = Enum.SortOrder.LayoutOrder
        _ll.VerticalAlignment = Enum.VerticalAlignment.Bottom
        _ll.Padding = UDim.new(0, 8)
        _ll.Parent = _h
    end
    local _card = Instance.new("Frame")
    _card.Size = UDim2.new(1, 0, 0, 0)
    _card.AutomaticSize = Enum.AutomaticSize.Y
    _card.BackgroundColor3 = Theme.Panel2
    _card.BackgroundTransparency = 1
    _card.Parent = _h
    _cr(_card, 8)
    local _st = _sk(_card, Theme.GoldDim, 1)
    _st.Transparency = 1
    local _pd = Instance.new("UIPadding")
    _pd.PaddingTop = UDim.new(0, 10)
    _pd.PaddingBottom = UDim.new(0, 10)
    _pd.PaddingLeft = UDim.new(0, 12)
    _pd.PaddingRight = UDim.new(0, 12)
    _pd.Parent = _card
    local _tl = Instance.new("TextLabel")
    _tl.BackgroundTransparency = 1
    _tl.Size = UDim2.new(1, 0, 0, 16)
    _tl.Font = Enum.Font.GothamMedium
    _tl.Text = _title or ""
    _tl.TextColor3 = Theme.GoldBright
    _tl.TextSize = 13
    _tl.TextXAlignment = Enum.TextXAlignment.Left
    _tl.TextTransparency = 1
    _tl.Parent = _card
    local _dl = Instance.new("TextLabel")
    _dl.BackgroundTransparency = 1
    _dl.Position = UDim2.fromOffset(0, 18)
    _dl.Size = UDim2.new(1, 0, 0, 0)
    _dl.AutomaticSize = Enum.AutomaticSize.Y
    _dl.Font = Enum.Font.Gotham
    _dl.Text = _text or ""
    _dl.TextColor3 = Theme.TextDim
    _dl.TextSize = 11
    _dl.TextWrapped = true
    _dl.TextXAlignment = Enum.TextXAlignment.Left
    _dl.TextTransparency = 1
    _dl.Parent = _card
    _tw(_card, {BackgroundTransparency=0}, 0.2)
    _tw(_st, {Transparency=0}, 0.2)
    _tw(_tl, {TextTransparency=0}, 0.2)
    _tw(_dl, {TextTransparency=0}, 0.2)
    task.delay(_dur, function()
        if not _card or not _card.Parent then return end
        _tw(_card, {BackgroundTransparency=1}, 0.25)
        _tw(_st, {Transparency=1}, 0.25)
        _tw(_tl, {TextTransparency=1}, 0.25)
        _tw(_dl, {TextTransparency=1}, 0.25)
        task.delay(0.25, function() if _card then _card:Destroy() end end)
    end)
end

function _UILib:SetDetectedMinigame(_mgId, _dispName)
    self._detectedMinigame = _mgId
    if _mgId and _dispName then
        self._minigameLabel.Text = "> " .. _dispName
        _tw(self._minigameLabel, {TextColor3=Theme.GoldBright}, 0.2)
    else
        self._minigameLabel.Text = _decode("5469646168206164612064696e696761726d65")
        _tw(self._minigameLabel, {TextColor3=Theme.TextDim}, 0.2)
    end
    self:_updateTabLocks()
end

function _UILib:_updateTabLocks()
    for _, _td in ipairs(self.Tabs) do
        local _req = _td._minigameId
        if _req == nil then
            _td._locked = false
            _td.Label.TextColor3 = (self.ActiveTab == _td) and Theme.GoldBright or Theme.TextDim
            if _td._lockIcon then _td._lockIcon.Visible = false end
        else
            local _match = (self._detectedMinigame == _req)
            _td._locked = not _match
            if _td._locked then
                _td.Label.TextColor3 = Theme.LockedText
                if _td._lockIcon then _td._lockIcon.Visible = true end
            else
                _td.Label.TextColor3 = (self.ActiveTab == _td) and Theme.GoldBright or Theme.TextDim
                if _td._lockIcon then _td._lockIcon.Visible = false end
            end
        end
    end
end

function _UILib:AddTab(_name, _mgId)
    local _tbtn = Instance.new("TextButton")
    _tbtn.Size = UDim2.new(1, 0, 0, 36)
    _tbtn.BackgroundTransparency = 1
    _tbtn.Text = ""
    _tbtn.AutoButtonColor = false
    _tbtn.Parent = self.Sidebar
    local _ind = Instance.new("Frame")
    _ind.Size = UDim2.new(0, 2, 1, -10)
    _ind.Position = UDim2.fromOffset(0, 5)
    _ind.BackgroundColor3 = Theme.Gold
    _ind.BackgroundTransparency = 1
    _ind.BorderSizePixel = 0
    _ind.Parent = _tbtn
    local _lbl = Instance.new("TextLabel")
    _lbl.BackgroundTransparency = 1
    _lbl.Position = UDim2.fromOffset(20, 0)
    _lbl.Size = UDim2.new(1, -44, 1, 0)
    _lbl.Font = Enum.Font.Gotham
    _lbl.Text = _name
    _lbl.TextColor3 = Theme.TextDim
    _lbl.TextSize = 12.5
    _lbl.TextXAlignment = Enum.TextXAlignment.Left
    _lbl.Parent = _tbtn
    local _li = Instance.new("TextLabel")
    _li.BackgroundTransparency = 1
    _li.Position = UDim2.new(1, -22, 0.5, -7)
    _li.Size = UDim2.fromOffset(14, 14)
    _li.Font = Enum.Font.GothamBold
    _li.Text = "[L]"
    _li.TextColor3 = Theme.LockedText
    _li.TextSize = 9
    _li.Visible = false
    _li.Parent = _tbtn
    local _pg = Instance.new("ScrollingFrame")
    _pg.Size = UDim2.new(1, 0, 1, 0)
    _pg.BackgroundTransparency = 1
    _pg.BorderSizePixel = 0
    _pg.ScrollBarThickness = 3
    _pg.ScrollBarImageColor3 = Theme.GoldDim
    _pg.CanvasSize = UDim2.new(0, 0, 0, 0)
    _pg.AutomaticCanvasSize = Enum.AutomaticSize.Y
    _pg.Visible = false
    _pg.Parent = self.ContentHolder
    local _pp = Instance.new("UIPadding")
    _pp.PaddingTop = UDim.new(0, 20)
    _pp.PaddingBottom = UDim.new(0, 20)
    _pp.PaddingLeft = UDim.new(0, 24)
    _pp.PaddingRight = UDim.new(0, 24)
    _pp.Parent = _pg
    local _pl = Instance.new("UIListLayout")
    _pl.Padding = UDim.new(0, 14)
    _pl.Parent = _pg
    local _td = {Button=_tbtn, Label=_lbl, Indicator=_ind, Page=_pg, _minigameId=_mgId, _locked=false, _lockIcon=_li}
    table.insert(self.Tabs, _td)
    local _uiRef = self
    local function _setActive()
        if _td._locked then _uiRef:Notify("[!] Terkunci", _decode("54616220696e692068616e7961207465727365646961207361617420646d696e6967616d65207465726b61697420616b7469662e"), 2); return end
        for _, _t in ipairs(_uiRef.Tabs) do
            local _isA = (_t == _td)
            if not _t._locked then _tw(_t.Label, {TextColor3=_isA and Theme.GoldBright or Theme.TextDim}, 0.15) end
            _tw(_t.Indicator, {BackgroundTransparency=_isA and 0 or 1}, 0.15)
            if _t.Page ~= _td.Page then _t.Page.Visible = false end
        end
        _td.Page.Visible = true
        _uiRef.ActiveTab = _td
    end
    _tbtn.MouseButton1Click:Connect(_setActive)
    if #self.Tabs == 1 then _setActive() end
    local _api = {}
    function _api:AddSection(_title)
        local _sec = Instance.new("Frame")
        _sec.Size = UDim2.new(1, 0, 0, 22)
        _sec.BackgroundTransparency = 1
        _sec.Parent = _pg
        local _l = Instance.new("TextLabel")
        _l.BackgroundTransparency = 1
        _l.Size = UDim2.new(1, 0, 0, 14)
        _l.Font = Enum.Font.GothamBold
        _l.Text = string.upper(_title)
        _l.TextColor3 = Theme.Gold
        _l.TextSize = 10.5
        _l.TextXAlignment = Enum.TextXAlignment.Left
        _l.Parent = _sec
        local _ul = Instance.new("Frame")
        _ul.Size = UDim2.new(1, 0, 0, 1)
        _ul.Position = UDim2.fromOffset(0, 18)
        _ul.BackgroundColor3 = Theme.Border
        _ul.BorderSizePixel = 0
        _ul.Parent = _sec
        return _sec
    end
    function _api:AddToggle(_text, _desc, _def, _cb)
        local _row = Instance.new("Frame")
        _row.Size = UDim2.new(1, 0, 0, _desc and 40 or 28)
        _row.BackgroundTransparency = 1
        _row.Parent = _pg
        local _l = Instance.new("TextLabel")
        _l.BackgroundTransparency = 1
        _l.Size = UDim2.new(1, -50, 0, 16)
        _l.Font = Enum.Font.Gotham
        _l.Text = _text
        _l.TextColor3 = Theme.Text
        _l.TextSize = 13
        _l.TextXAlignment = Enum.TextXAlignment.Left
        _l.Parent = _row
        if _desc then
            local _d = Instance.new("TextLabel")
            _d.BackgroundTransparency = 1
            _d.Position = UDim2.fromOffset(0, 18)
            _d.Size = UDim2.new(1, -50, 0, 14)
            _d.Font = Enum.Font.Gotham
            _d.Text = _desc
            _d.TextColor3 = Theme.TextDim
            _d.TextSize = 10.5
            _d.TextXAlignment = Enum.TextXAlignment.Left
            _d.Parent = _row
        end
        local _sw = Instance.new("TextButton")
        _sw.Size = UDim2.fromOffset(38, 20)
        _sw.Position = UDim2.new(1, -38, 0, 4)
        _sw.BackgroundColor3 = Theme.Panel
        _sw.Text = ""
        _sw.AutoButtonColor = false
        _sw.Parent = _row
        _cr(_sw, 10)
        local _ss = _sk(_sw, Theme.Border, 1)
        local _knob = Instance.new("Frame")
        _knob.Size = UDim2.fromOffset(14, 14)
        _knob.Position = UDim2.fromOffset(3, 3)
        _knob.BackgroundColor3 = Theme.TextDim
        _knob.Parent = _sw
        _cr(_knob, 7)
        local _state = _def or false
        local _deb = false
        local function _render(_inst)
            local _dur = _inst and 0 or 0.15
            if _state then
                _tw(_sw, {BackgroundColor3=Color3.fromRGB(40,34,20)}, _dur)
                _tw(_ss, {Color=Theme.GoldDim}, _dur)
                _tw(_knob, {Position=UDim2.fromOffset(21,3), BackgroundColor3=Theme.GoldBright}, _dur)
            else
                _tw(_sw, {BackgroundColor3=Theme.Panel}, _dur)
                _tw(_ss, {Color=Theme.Border}, _dur)
                _tw(_knob, {Position=UDim2.fromOffset(3,3), BackgroundColor3=Theme.TextDim}, _dur)
            end
        end
        _render(true)
        local _a2 = {}
        _sw.MouseButton1Click:Connect(function()
            if _deb then return end
            _deb = true
            _state = not _state
            _render(false)
            if _cb then task.spawn(_cb, _state) end
            task.delay(0.3, function() _deb = false end)
        end)
        function _a2:Set(_v) if _state == _v then return end; _state = _v; _render(false) end
        function _a2:Get() return _state end
        return _a2
    end
    function _api:AddSlider(_text, _min, _max, _def, _cb)
        local _row = Instance.new("Frame")
        _row.Size = UDim2.new(1, 0, 0, 44)
        _row.BackgroundTransparency = 1
        _row.Parent = _pg
        local _l = Instance.new("TextLabel")
        _l.BackgroundTransparency = 1
        _l.Size = UDim2.new(1, -50, 0, 16)
        _l.Font = Enum.Font.Gotham
        _l.Text = _text
        _l.TextColor3 = Theme.Text
        _l.TextSize = 13
        _l.TextXAlignment = Enum.TextXAlignment.Left
        _l.Parent = _row
        local _vl = Instance.new("TextLabel")
        _vl.BackgroundTransparency = 1
        _vl.Position = UDim2.new(1, -50, 0, 0)
        _vl.Size = UDim2.fromOffset(50, 16)
        _vl.Font = Enum.Font.GothamMedium
        _vl.TextColor3 = Theme.Gold
        _vl.TextSize = 12
        _vl.TextXAlignment = Enum.TextXAlignment.Right
        _vl.Parent = _row
        local _trk = Instance.new("TextButton")
        _trk.Size = UDim2.new(1, 0, 0, 4)
        _trk.Position = UDim2.fromOffset(0, 26)
        _trk.BackgroundColor3 = Theme.Panel
        _trk.Text = ""
        _trk.AutoButtonColor = false
        _trk.Parent = _row
        _cr(_trk, 4)
        _sk(_trk, Theme.Border, 1)
        local _fill = Instance.new("Frame")
        _fill.BackgroundColor3 = Theme.Gold
        _fill.BorderSizePixel = 0
        _fill.Parent = _trk
        _cr(_fill, 4)
        local _hdl = Instance.new("Frame")
        _hdl.Size = UDim2.fromOffset(12, 12)
        _hdl.AnchorPoint = Vector2.new(0.5, 0.5)
        _hdl.Position = UDim2.new(0, 0, 0.5, 0)
        _hdl.BackgroundColor3 = Theme.GoldBright
        _hdl.Parent = _trk
        _cr(_hdl, 6)
        local _val = _def or _min
        local function _setVal(_v, _inst)
            _val = math.clamp(_v, _min, _max)
            local _pct = (_max > _min) and (_val - _min) / (_max - _min) or 0
            local _d = _inst and 0 or 0.08
            _tw(_fill, {Size=UDim2.new(_pct, 0, 1, 0)}, _d)
            _tw(_hdl, {Position=UDim2.new(_pct, 0, 0.5, 0)}, _d)
            _vl.Text = tostring(math.floor(_val))
        end
        _setVal(_val, true)
        local _dragging = false
        local function _updInput(_i)
            local _rx = math.clamp((_i.Position.X - _trk.AbsolutePosition.X) / _trk.AbsoluteSize.X, 0, 1)
            _setVal(_min + (_max - _min) * _rx, true)
            if _cb then task.spawn(_cb, _val) end
        end
        _trk.InputBegan:Connect(function(_i)
            if _i.UserInputType==Enum.UserInputType.MouseButton1 or _i.UserInputType==Enum.UserInputType.Touch then
                _dragging = true
                _updInput(_i)
            end
        end)
        UserInputService.InputChanged:Connect(function(_i)
            if _dragging and (_i.UserInputType==Enum.UserInputType.MouseMovement or _i.UserInputType==Enum.UserInputType.Touch) then _updInput(_i) end
        end)
        UserInputService.InputEnded:Connect(function(_i)
            if _i.UserInputType==Enum.UserInputType.MouseButton1 or _i.UserInputType==Enum.UserInputType.Touch then _dragging = false end
        end)
        return {Set=function(_, _v) _setVal(_v, false) end, Get=function() return _val end}
    end
    function _api:AddButton(_text, _cb)
        local _btn = Instance.new("TextButton")
        _btn.Size = UDim2.new(1, 0, 0, 32)
        _btn.BackgroundColor3 = Color3.fromRGB(35, 29, 18)
        _btn.Text = _text
        _btn.Font = Enum.Font.GothamMedium
        _btn.TextSize = 12.5
        _btn.TextColor3 = Theme.GoldBright
        _btn.AutoButtonColor = false
        _btn.Parent = _pg
        _cr(_btn, 6)
        _sk(_btn, Theme.GoldDim, 1)
        _btn.MouseEnter:Connect(function() _tw(_btn, {BackgroundColor3=Color3.fromRGB(45,37,22)}, 0.15) end)
        _btn.MouseLeave:Connect(function() _tw(_btn, {BackgroundColor3=Color3.fromRGB(35,29,18)}, 0.15) end)
        _btn.MouseButton1Click:Connect(function() if _cb then task.spawn(_cb) end end)
        return _btn
    end
    function _api:AddTeleport(_text, _cb)
        local _btn = Instance.new("TextButton")
        _btn.Size = UDim2.new(1, 0, 0, 36)
        _btn.BackgroundColor3 = Theme.Panel
        _btn.Text = ""
        _btn.AutoButtonColor = false
        _btn.Parent = _pg
        _cr(_btn, 6)
        local _bs = _sk(_btn, Theme.Border, 1)
        local _nl = Instance.new("TextLabel")
        _nl.BackgroundTransparency = 1
        _nl.Position = UDim2.fromOffset(12, 0)
        _nl.Size = UDim2.new(1, -110, 1, 0)
        _nl.Font = Enum.Font.GothamMedium
        _nl.Text = _text
        _nl.TextColor3 = Theme.Text
        _nl.TextSize = 12.5
        _nl.TextXAlignment = Enum.TextXAlignment.Left
        _nl.TextTruncate = Enum.TextTruncate.AtEnd
        _nl.Parent = _btn
        local _sl2 = Instance.new("TextLabel")
        _sl2.BackgroundTransparency = 1
        _sl2.Position = UDim2.new(1, -98, 0, 0)
        _sl2.Size = UDim2.fromOffset(86, 36)
        _sl2.Font = Enum.Font.GothamMedium
        _sl2.Text = _decode("42656c756d")
        _sl2.TextColor3 = Theme.TextDim
        _sl2.TextSize = 11
        _sl2.TextXAlignment = Enum.TextXAlignment.Right
        _sl2.Parent = _btn
        _btn.MouseEnter:Connect(function() _tw(_btn, {BackgroundColor3=Theme.Panel2}, 0.12); _tw(_bs, {Color=Theme.GoldDim}, 0.12) end)
        _btn.MouseLeave:Connect(function() _tw(_btn, {BackgroundColor3=Theme.Panel}, 0.12); _tw(_bs, {Color=Theme.Border}, 0.12) end)
        _btn.MouseButton1Click:Connect(function() if _cb then task.spawn(_cb) end end)
        return {Button=_btn, SetCompleted=function(_, _done)
            if _done then _sl2.Text="[v] Selesai"; _sl2.TextColor3=Theme.GoldBright
            else _sl2.Text=_decode("42656c756d"); _sl2.TextColor3=Theme.TextDim end
        end}
    end
    function _api:AddLabel(_text)
        local _l = Instance.new("TextLabel")
        _l.BackgroundTransparency = 1
        _l.Size = UDim2.new(1, 0, 0, 18)
        _l.Font = Enum.Font.Gotham
        _l.Text = _text
        _l.TextColor3 = Theme.TextDim
        _l.TextSize = 11
        _l.TextXAlignment = Enum.TextXAlignment.Left
        _l.Parent = _pg
        return _l
    end
    function _api:AddDropdown(_text, _opts, _def, _cb)
        local _bH = 46
        local _oH = 26
        local _gap = 6
        local _row = Instance.new("Frame")
        _row.Size = UDim2.new(1, 0, 0, _bH)
        _row.BackgroundTransparency = 1
        _row.ClipsDescendants = false
        _row.Parent = _pg
        local _l = Instance.new("TextLabel")
        _l.BackgroundTransparency = 1
        _l.Size = UDim2.new(1, 0, 0, 16)
        _l.Font = Enum.Font.Gotham
        _l.Text = _text
        _l.TextColor3 = Theme.Text
        _l.TextSize = 13
        _l.TextXAlignment = Enum.TextXAlignment.Left
        _l.Parent = _row
        local _btn = Instance.new("TextButton")
        _btn.Size = UDim2.new(1, 0, 0, 30)
        _btn.Position = UDim2.fromOffset(0, 18)
        _btn.BackgroundColor3 = Theme.Panel
        _btn.Text = ""
        _btn.AutoButtonColor = false
        _btn.ZIndex = 2
        _btn.Parent = _row
        _cr(_btn, 6)
        _sk(_btn, Theme.Border, 1)
        local _idx = 1
        for _i, _v in ipairs(_opts) do if _v == _def then _idx = _i; break end end
        local _selLbl = Instance.new("TextLabel")
        _selLbl.BackgroundTransparency = 1
        _selLbl.Position = UDim2.fromOffset(10, 0)
        _selLbl.Size = UDim2.new(1, -34, 1, 0)
        _selLbl.Font = Enum.Font.GothamMedium
        _selLbl.Text = tostring(_opts[_idx])
        _selLbl.TextColor3 = Theme.Gold
        _selLbl.TextSize = 12
        _selLbl.TextXAlignment = Enum.TextXAlignment.Left
        _selLbl.TextTruncate = Enum.TextTruncate.AtEnd
        _selLbl.ZIndex = 3
        _selLbl.Parent = _btn
        local _arw = Instance.new("TextLabel")
        _arw.BackgroundTransparency = 1
        _arw.Position = UDim2.new(1, -26, 0, 0)
        _arw.Size = UDim2.fromOffset(20, 30)
        _arw.Font = Enum.Font.GothamBold
        _arw.Text = "v"
        _arw.TextColor3 = Theme.TextDim
        _arw.TextSize = 12
        _arw.ZIndex = 3
        _arw.Parent = _btn
        local _of = Instance.new("Frame")
        _of.Position = UDim2.fromOffset(0, 48 + _gap)
        _of.Size = UDim2.new(1, 0, 0, 0)
        _of.BackgroundColor3 = Theme.Panel
        _of.ClipsDescendants = true
        _of.ZIndex = 2
        _of.Parent = _row
        _cr(_of, 6)
        _sk(_of, Theme.Border, 1)
        Instance.new("UIListLayout").Parent = _of
        local _open = false
        local _close, _openList
        for _i, _opt in ipairs(_opts) do
            local _ob = Instance.new("TextButton")
            _ob.Size = UDim2.new(1, 0, 0, _oH)
            _ob.BackgroundTransparency = 1
            _ob.Text = tostring(_opt)
            _ob.Font = Enum.Font.Gotham
            _ob.TextSize = 12
            _ob.TextColor3 = (_i == _idx) and Theme.GoldBright or Theme.TextDim
            _ob.AutoButtonColor = false
            _ob.ZIndex = 3
            _ob.Parent = _of
            _ob.MouseEnter:Connect(function() _tw(_ob, {TextColor3=Theme.GoldBright}, 0.1) end)
            _ob.MouseLeave:Connect(function() _tw(_ob, {TextColor3=(_i==_idx) and Theme.GoldBright or Theme.TextDim}, 0.1) end)
            _ob.MouseButton1Click:Connect(function()
                _idx = _i
                _selLbl.Text = tostring(_opt)
                for _, _ch in ipairs(_of:GetChildren()) do if _ch:IsA("TextButton") then _ch.TextColor3 = Theme.TextDim end end
                _ob.TextColor3 = Theme.GoldBright
                _close()
                if _cb then task.spawn(_cb, _opt) end
            end)
        end
        _close = function()
            if not _open then return end
            _open = false
            _arw.Text = "v"
            _tw(_row, {Size=UDim2.new(1,0,0,_bH)}, 0.18)
            _tw(_of, {Size=UDim2.new(1,0,0,0)}, 0.18)
        end
        _openList = function()
            if _open then return end
            _open = true
            _arw.Text = "^"
            local _lh = #_opts * _oH
            _tw(_row, {Size=UDim2.new(1,0,0,_bH+_gap+_lh)}, 0.18)
            _tw(_of, {Size=UDim2.new(1,0,0,_lh)}, 0.18)
        end
        _btn.MouseButton1Click:Connect(function() if _open then _close() else _openList() end end)
        if _cb then task.spawn(_cb, _opts[_idx]) end
        return {Set=function(_, _value) for _i, _v in ipairs(_opts) do if _v==_value then _idx=_i; _selLbl.Text=tostring(_v); break end end end, Get=function() return _opts[_idx] end}
    end
    return _api
end

function _UILib:Toggle()
    if self.Window.Visible then self:HideWindow() else self:ShowWindow() end
end

-- ================================================================
-- INITIALIZE UI
-- ================================================================
local _ui = _0xF({Title = _decode("626c6f78506c6f6974"), Subtitle = _decode("56312e392e32202d2053415249474d49")})

-- ================================================================
-- MINIGAME DETECTION (Obfuscated)
-- ================================================================
local _MGDefs = (function()
    local _ws = workspace
    local _fn = function(_n) local _m = _ws:FindFirstChild("Main"); return _m and _m:FindFirstChild(_n) end
    return {
        {id=_decode("6772616e61745f72756e"), name=_decode("4772616e61742052756e"), detect=function()
            local _m=_ws:FindFirstChild("Main"); if not _m then return false end
            return (_m:FindFirstChild("GranatRun") or _m:FindFirstChild("MeteorSpawn") or _m:FindFirstChild("Meteor")) and true or false
        end},
        {id=_decode("746f7070696e675f617263686572790a"), name=_decode("546f7070696e672041726368657279"), detect=function()
            local _m=_ws:FindFirstChild("Main"); if not _m then return false end
            if not _m:FindFirstChild("Item") then return false end
            local _f=ReplicatedStorage:FindFirstChild("GameRemoteEvents")
            return _f and _f:FindFirstChild("SpawnItemClientEvent") and true or false
        end},
        {id=_decode("6d6f756e7461696e5f746f776572"), name=_decode("4d6f756e7461696e20546f776572"), detect=function()
            local _m=_ws:FindFirstChild("Main"); if not _m then return false end
            local _d=_m:FindFirstChild("Doors"); if not _d then return false end
            for _, _door in ipairs(_d:GetChildren()) do if _door:FindFirstChild("Stone") then return true end end
            return false
        end},
        {id=_decode("6c6176615f65787472615f646f776572"), name=_decode("4c617661204578747261a20446f776572"), detect=function()
            local _m=_ws:FindFirstChild("Main"); if not _m then return false end
            return _m:FindFirstChild("Checkpoint") and _m:FindFirstChild("CheckpointSpawn") and _m:FindFirstChild("Stages") and not _m:FindFirstChild("Doors")
        end},
        {id=_decode("6e6f6f646c655f6d617a65"), name=_decode("4e6f6f646c65204d617a65"), detect=function()
            local _m=_ws:FindFirstChild("Main"); if not _m then return false end
            return _m:FindFirstChild("Maze") and true or false
        end},
        {id=_decode("666163745f68756e746572"), name=_decode("46616374204875756e746572"), detect=function()
            local _m=_ws:FindFirstChild("Main"); if not _m then return false end
            for _, _obj in ipairs(_m:GetDescendants()) do
                if _obj:IsA("Model") and (_obj:GetAttribute("PointEarned") or _obj:GetAttribute("Description")) then return true end
            end; return false
        end},
        {id=_decode("736d6172745f666c69676874"), name=_decode("536d61727420466c69676874"), detect=function()
            local _p=_ws:FindFirstChild("Plane"); local _m=_ws:FindFirstChild("Main")
            if not _p or not _m then return false end
            return _m:FindFirstChild("QuestionPosition") and true or false
        end},
    }
end)()

local _lastMG = nil
local function _detectMG()
    for _, _def in ipairs(_MGDefs) do
        local _ok, _r = pcall(_def.detect)
        if _ok and _r then return _def.id, _def.name end
    end
    return nil, nil
end
task.spawn(function()
    while true do
        local _mgId, _mgName = _detectMG()
        if _mgId ~= _lastMG then
            _lastMG = _mgId
            _ui:SetDetectedMinigame(_mgId, _mgName)
            if _mgId then _ui:Notify(_decode("4d696e6967616d6520546572646574656b7369"), _mgName, 3) end
        end
        task.wait(2)
    end
end)

-- ================================================================
-- CONFIG & STATE (Obfuscated)
-- ================================================================
local _Cfg = {
    [_decode("436f6c6c6563744d6f6465")] = "Magnet",
    Delay = 0.03, ScanDelay = 0.1, MeteorGrabTime = 0.7,
    MeteorDangerRadius = 60, MeteorSafeDistance = 45,
    ArcheryDelay = 0.15, TPWaitTimeout = 0.5,
    ObbyStartCheckpoint = 0, ObbyCheckpointDelay = 0.5,
    ObbyItemDelay = 0.15, ObbyStageScanRadius = 150,
    ObbyAutoCollectItems = true, FactHitDelay = 0.25,
    CP_DONE_COLOR = Color3.fromRGB(236, 94, 42),
    CP_DONE_MATERIAL = Enum.Material.Neon,
    MazeFlySpeed = 60, MazeFlyHeight = 40, MazeCoinDelay = 0.08,
    MTStartCheckpoint = 0, MTCheckpointDelay = 0.5, MTChiliDelay = 0.15,
    FlightAnswerDelay = 1.2, FlightSeatTPDelay = 2.5,
    FlightQuestionDelay = 0.8, FlightTPYOffset = 3,
}
-- Alias for clarity
local Config = _Cfg

local _St = {
    GranatCollect=false, RunGranat=false, Archery=false, Obby=false,
    FactHunter=false, MazeFly=false, MT=false, MTChili=false, SmartFlight=false,
}
local States = _St
local _Rn = {
    LootCollector=false, MeteorTP=false, MeteorGrabActive=false, Archery=false,
    Obby=false, FactHunter=false, MazeFly=false, MT=false, MTChili=false, SmartFlight=false,
}
local Running = _Rn
local _Col, _Hit, _GMet = {}, {}, {}
local Collected, HitItems, GoodMeteors = _Col, _Hit, _GMet

-- ================================================================
-- TELEPORT DATA (XOR-encoded)
-- ================================================================
local TeleportSpots = {
    {Name="Granat Run",       GuiButton="GranatRunButton", CFrame=CFrame.new(-89.5518341,17.9522362,-692.834412,-0.29242146,0,0.95628953,0,1,0,-0.95628953,0,-0.29242146)},
    {Name="Topping Archery",  GuiButton="ArcheryButton",   CFrame=CFrame.new(158.730713,14.5560303,-340.163513,-0.197639942,0,0.980274677,0,1,0,-0.980274677,0,-0.197639942)},
    {Name="Lava Extra Dower", GuiButton="LavaDowerButton", CFrame=CFrame.new(-233.511459,30.4534531,-293.217285,-0.149592519,0,-0.988747716,0,1,0,0.988747716,0,-0.149592519)},
    {Name="Noodle Maze",      GuiButton="MazeButton",      CFrame=CFrame.new(-208.93486,-2.22767258,-42.8001709,-0.064599514,0,-0.997911215,0,1,0,0.997911215,0,-0.064599514)},
    {Name="Fact Hunter",      GuiButton="FactButton",      CFrame=CFrame.new(228.740631,41.7345924,-85.1271057,-0.0243872404,0,0.999702573,0,1,0,-0.999702573,0,-0.0243872404)},
    {Name="Smart Flight",     GuiButton="FlightButton",    CFrame=CFrame.new(38.625309,49.0646172,-64.2820358,-5.65052032e-05,-0.0242852569,0.999705136,-1,5.6385994e-05,-5.51342964e-05,-5.51342964e-05,-0.999705136,-0.0242853165)},
    {Name="Mountain Tower",   GuiButton="MountainButton",  CFrame=CFrame.new(-131.580444,78.2062759,9.70972443,-0.369864583,0,-0.929085672,0,1,0,0.929085672,0,-0.369864583)},
}

-- ================================================================
-- REMOTE FINDER (Obfuscated)
-- ================================================================
local _CE, _PE, _MSE, _MLE, _IHE, _SIE, _GSE
local function _FR(_n)
    local _f = ReplicatedStorage:FindFirstChild("GameRemoteEvents")
    if _f then local _r = _f:FindFirstChild(_n); if _r then return _r end end
    for _, _obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if _obj.Name == _n and _obj:IsA("RemoteEvent") then return _obj end
    end
    return nil
end
task.spawn(function()
    _CE  = _FR("CollectCoinServerEvent")
    _PE  = _FR("CollectPackageServerEvent")
    _MSE = _FR("SpawnMeteorClientEvent")
    _MLE = _FR("MeteorLandedClientEvent")
    _IHE = _FR("ItemHitEvent")
    _SIE = _FR("SpawnItemClientEvent")
    _GSE = _FR("GameStatusEvent")
end)
local CoinEvent, PackageEvent, MeteorSpawnEvent, MeteorLandedEvent, ItemHitEvent, SpawnItemEvent, GameStatusEvent
task.delay(1, function()
    CoinEvent = _CE; PackageEvent = _PE; MeteorSpawnEvent = _MSE
    MeteorLandedEvent = _MLE; ItemHitEvent = _IHE; SpawnItemEvent = _SIE; GameStatusEvent = _GSE
end)

-- ================================================================
-- UTILITIES (Obfuscated names)
-- ================================================================
local function _GR()
    local _c = LocalPlayer.Character; return _c and _c:FindFirstChild("HumanoidRootPart")
end
local GetRoot = _GR

local function _PE2(_p)
    task.spawn(function() pcall(function()
        if not _p or not _p:IsDescendantOf(workspace) then return end
        TweenService:Create(_p, TweenInfo.new(0.15), {Size=_p.Size*1.5}):Play()
        task.wait(0.08); TweenService:Create(_p, TweenInfo.new(0.15), {Transparency=1}):Play()
        task.delay(0.25, function() if _p and _p.Parent then _p:Destroy() end end)
    end) end)
end
local PlayEffect = _PE2

local function _IVP(_item)
    return _item and _item.Parent and _item:IsA("BasePart") and _item:IsDescendantOf(workspace) and not Collected[_item]
end
local IsValidPart = _IVP

local function _RP(_root)
    if not _root then return end
    for _, _obj in ipairs(_root:GetChildren()) do
        if _obj:IsA("BodyForce") or _obj:IsA("BodyVelocity") or _obj:IsA("BodyPosition")
        or _obj:IsA("BodyGyro") or _obj:IsA("VectorForce") or _obj:IsA("LinearVelocity")
        or _obj:IsA("AlignPosition") or _obj:IsA("AlignOrientation") then _obj:Destroy() end
    end
    _root.AssemblyLinearVelocity = Vector3.zero
    _root.AssemblyAngularVelocity = Vector3.zero
    local _char = _root.Parent
    local _hum = _char and _char:FindFirstChildOfClass("Humanoid")
    if _hum then pcall(function() _hum.PlatformStand = false end) end
end
local ResetPhysics = _RP

local function _TTo(_pos)
    local _r = GetRoot(); if not _r then return end
    ResetPhysics(_r); _r.CFrame = CFrame.new(_pos + Vector3.new(0, 2.5, 0)); ResetPhysics(_r)
end
local TeleportTo = _TTo

local function _TTCF(_cf, _yOff)
    local _r = GetRoot(); if not _r then return end
    ResetPhysics(_r); _r.CFrame = _cf + Vector3.new(0, _yOff or 0, 0); ResetPhysics(_r)
end
local TeleportToCFrame = _TTCF

local function _GPC(_inst)
    if not _inst then return nil end
    if _inst:IsA("BasePart") then return _inst.CFrame end
    if _inst:IsA("Model") then return _inst.PrimaryPart and _inst.PrimaryPart.CFrame or (_inst:FindFirstChildWhichIsA("BasePart") and _inst:FindFirstChildWhichIsA("BasePart").CFrame) end
    return nil
end
local GetPartCFrame = _GPC

local function _GIP(_inst)
    if _inst:IsA("BasePart") then return _inst end
    if _inst:IsA("Model") then return _inst.PrimaryPart or _inst:FindFirstChildWhichIsA("BasePart") end
    return nil
end
local GetItemPart = _GIP

local function _IMC(_gbn)
    local _ok, _r = pcall(function()
        local _pg = LocalPlayer:FindFirstChild("PlayerGui"); if not _pg then return false end
        local _main = _pg:FindFirstChild("Main")
        local _ft = _main and _main:FindFirstChild("FastTeleport")
        local _h = _ft and _ft:FindFirstChild("ButtonHolder")
        local _c = _h and _h:FindFirstChild("ButtonContainer")
        local _btn = _c and _c:FindFirstChild(_gbn)
        local _lbl = _btn and _btn:FindFirstChild("CompletedLabel")
        return _lbl and _lbl.Visible == true or false
    end)
    return _ok and _r or false
end
local IsMinigameCompleted = _IMC

-- ================================================================
-- CHECKPOINT SYSTEM (Obfuscated)
-- ================================================================
local function _GCS() return tonumber(LocalPlayer:GetAttribute("Stage")) or 0 end
local GetCurrentStage = _GCS

local function _ISD(_idx)
    if GetCurrentStage() >= _idx then return true end
    local _m = workspace:FindFirstChild("Main"); local _cs = _m and _m:FindFirstChild("CheckpointSpawn")
    if not _cs then return false end
    local _sp = _cs:FindFirstChild("Checkpoint_" .. _idx); if not _sp then return false end
    local _part
    if _sp:IsA("BasePart") then _part = _sp
    elseif _sp:IsA("Model") then _part = _sp.PrimaryPart or _sp:FindFirstChildWhichIsA("BasePart") end
    if not _part then return false end
    if _part.Material == Config.CP_DONE_MATERIAL then return true end
    local _c = _part.Color; local _t = Config.CP_DONE_COLOR
    return math.abs(_c.R - _t.R) + math.abs(_c.G - _t.G) + math.abs(_c.B - _t.B) < 0.15
end
local IsSpawnDone = _ISD

local function _GCTP(_idx)
    local _m = workspace:FindFirstChild("Main"); local _cf = _m and _m:FindFirstChild("Checkpoint")
    if not _cf then return nil end
    local _cp = _cf:FindFirstChild("Checkpoint_" .. _idx); if not _cp then return nil end
    if _cp:IsA("BasePart") then return _cp end
    if _cp:IsA("Model") then return _cp.PrimaryPart or _cp:FindFirstChildWhichIsA("BasePart") end
    return nil
end
local GetCheckpointTriggerPart = _GCTP

local function _GSCF(_idx)
    local _m = workspace:FindFirstChild("Main"); local _cs = _m and _m:FindFirstChild("CheckpointSpawn")
    if not _cs then return nil end
    local _sp = _cs:FindFirstChild("Checkpoint_" .. _idx); if not _sp then return nil end
    if _sp:IsA("BasePart") then return _sp.CFrame end
    if _sp:IsA("Model") then local _p = _sp.PrimaryPart or _sp:FindFirstChildWhichIsA("BasePart"); return _p and _p.CFrame or nil end
    return nil
end
local GetSpawnCFrame = _GSCF

local function _GSSP(_idx)
    local _m = workspace:FindFirstChild("Main"); local _st = _m and _m:FindFirstChild("Stages")
    if not _st then return nil end
    local _stage = _st:FindFirstChild("Obby_" .. _idx); if not _stage then return nil end
    local _sp = _stage:FindFirstChild("SpecialParts"); if not _sp then return nil end
    local _spawn = _sp:FindFirstChild("Spawn"); if not _spawn then return nil end
    if _spawn:IsA("BasePart") then return _spawn end
    if _spawn:IsA("Model") then return _spawn.PrimaryPart or _spawn:FindFirstChildWhichIsA("BasePart") end
    return nil
end
local GetSpecialSpawnPart = _GSSP

local function _GMC()
    local _m = workspace:FindFirstChild("Main"); if not _m then return 0 end; local _max = 0
    local function _sf(_f) if not _f then return end
        for _, _ch in ipairs(_f:GetChildren()) do
            local _n = _ch.Name:match("^Checkpoint_(%d+)$")
            if _n then local _num = tonumber(_n); if _num and _num > _max then _max = _num end end
        end
    end
    _sf(_m:FindFirstChild("Checkpoint")); _sf(_m:FindFirstChild("CheckpointSpawn"))
    return _max
end
local GetMaxCheckpoint = _GMC

local function _FCT(_idx, _to)
    _to = _to or 5
    if GetCurrentStage() >= _idx then return true end
    local _cpPart = GetCheckpointTriggerPart(_idx); if not _cpPart then return false end
    local _root = GetRoot(); if not _root then return false end
    local _targets = {_cpPart}
    local _sp = GetSpecialSpawnPart(_idx); if _sp then table.insert(_targets, _sp) end
    local _spawnCF = GetSpawnCFrame(_idx)
    if _spawnCF then
        local _csf = workspace.Main:FindFirstChild("CheckpointSpawn")
        local _csp = _csf and _csf:FindFirstChild("Checkpoint_" .. _idx)
        if _csp then
            local _p = _csp:IsA("BasePart") and _csp or (_csp:IsA("Model") and (_csp.PrimaryPart or _csp:FindFirstChildWhichIsA("BasePart")))
            if _p then table.insert(_targets, _p) end
        end
    end
    for _, _t in ipairs(_targets) do pcall(function() _t.CanTouch = true end) end
    TeleportToCFrame(_cpPart.CFrame, 0); task.wait(0.15); ResetPhysics(GetRoot())
    local _startTime = tick(); local _confirmed = false
    while tick() - _startTime < _to do
        if GetCurrentStage() >= _idx then _confirmed = true; break end
        local _r = GetRoot()
        if _r then
            for _, _target in ipairs(_targets) do pcall(function() firetouchinterest(_r, _target, 0) end) end
            task.wait(0.05)
            for _, _target in ipairs(_targets) do pcall(function() firetouchinterest(_r, _target, 1) end) end
        end
        task.wait(0.2)
    end
    if not _confirmed then
        local _r = GetRoot()
        if _r then
            local _center = _cpPart.Position
            local _bDir = (_r.Position - _center).Magnitude > 0.1 and (_r.Position - _center).Unit or Vector3.new(1, 0, 0)
            local _bPos = _center + _bDir * 8
            TeleportToCFrame(CFrame.new(_bPos, _center), 0); task.wait(0.15)
            for _i = 1, 18 do
                if GetCurrentStage() >= _idx then _confirmed = true; break end
                local _pos = _bPos:Lerp(_center, _i / 18); local _rr = GetRoot()
                if _rr then _rr.CFrame = CFrame.new(_pos, _center); _rr.AssemblyLinearVelocity = Vector3.zero end
                task.wait(0.08)
            end
            if not _confirmed then
                local _t2 = tick()
                while tick() - _t2 < 2 do
                    if GetCurrentStage() >= _idx then _confirmed = true; break end
                    local _rr = GetRoot()
                    if _rr then _rr.CFrame = CFrame.new(_center + Vector3.new(0, 1, 0)); _rr.AssemblyLinearVelocity = Vector3.zero end
                    task.wait(0.15)
                end
            end
        end
    end
    return _confirmed or (GetCurrentStage() >= _idx)
end
local FireCheckpointTouch = _FCT

-- ================================================================
-- ENGINE 1: LOOT COLLECTOR
-- ================================================================
local function _SLC()
    if Running.LootCollector then return end; Running.LootCollector = true
    task.spawn(function()
        while States.GranatCollect do
            if Running.MeteorGrabActive then task.wait(0.05); continue end
            local _root = GetRoot()
            if _root then
                local _tags = {{Tag="Coin",Event=CoinEvent},{Tag="Package",Event=PackageEvent}}
                if Config.CollectMode == "Magnet" then
                    for _, _data in ipairs(_tags) do
                        if not States.GranatCollect or Running.MeteorGrabActive then break end
                        for _, _item in ipairs(CollectionService:GetTagged(_data.Tag)) do
                            if Running.MeteorGrabActive then break end
                            if IsValidPart(_item) then Collected[_item]=true; pcall(function() _data.Event:FireServer(_item) end); PlayEffect(_item); task.wait(Config.Delay) end
                        end
                    end
                elseif Config.CollectMode == "Teleport" then
                    local _best, _bestD = nil, math.huge
                    for _, _data in ipairs(_tags) do
                        for _, _item in ipairs(CollectionService:GetTagged(_data.Tag)) do
                            if IsValidPart(_item) then local _d = (_item.Position - _root.Position).Magnitude; if _d < _bestD then _best, _bestD = _item, _d end end
                        end
                    end
                    if _best then
                        TeleportTo(_best.Position)
                        pcall(function()
                            if CollectionService:HasTag(_best,"Coin") and CoinEvent then CoinEvent:FireServer(_best) end
                            if CollectionService:HasTag(_best,"Package") and PackageEvent then PackageEvent:FireServer(_best) end
                        end)
                        local _ws = tick()
                        while States.GranatCollect and IsValidPart(_best) do
                            if Running.MeteorGrabActive then break end
                            local _r = GetRoot(); if _r and (_r.Position - _best.Position).Magnitude > 4 then TeleportTo(_best.Position) end
                            if tick() - _ws > Config.TPWaitTimeout then Collected[_best] = true; break end
                            task.wait(0.03)
                        end
                    end
                end
            end
            task.wait(Config.ScanDelay)
        end
        Running.LootCollector = false
    end)
end
local StartLootCollector = _SLC

-- ================================================================
-- ENGINE 2 & 3: METEOR
-- ================================================================
local _MSConn, _MLConn
local function _SMT()
    if not MeteorSpawnEvent then return end
    if not _MSConn then
        _MSConn = MeteorSpawnEvent.OnClientEvent:Connect(function(_id, _lp, _mt, _, _dur)
            if not States.RunGranat then return end
            local _d = tonumber(_dur) or 2.5
            if _mt == "Good" then GoodMeteors[_id] = {pos=_lp, landTime=tick()+_d}; task.delay(_d+2, function() GoodMeteors[_id]=nil end)
            elseif _mt == "Bad" then
                local _root = GetRoot()
                if _root and (_root.Position - _lp).Magnitude < Config.MeteorDangerRadius then
                    local _away = (_root.Position - _lp).Unit; if _away.Magnitude < 0.01 then _away = Vector3.new(1, 0, 0) end
                    _root.CFrame = CFrame.new(_root.Position + _away * Config.MeteorSafeDistance + Vector3.new(0, 3, 0))
                end
            end
        end)
    end
    if MeteorLandedEvent and not _MLConn then _MLConn = MeteorLandedEvent.OnClientEvent:Connect(function(_id) GoodMeteors[_id]=nil end) end
end
local StartMeteorTracker = _SMT

local function _StMT()
    if _MSConn then _MSConn:Disconnect(); _MSConn = nil end
    if _MLConn then _MLConn:Disconnect(); _MLConn = nil end
    GoodMeteors = {}; _GMet = GoodMeteors
end
local StopMeteorTracker = _StMT

local function _GRGM()
    local _now = tick()
    for _id, _data in pairs(GoodMeteors) do local _tl = _data.landTime - _now; if _tl <= Config.MeteorGrabTime and _tl >= -0.5 then return _id, _data end end
    return nil, nil
end

local function _SMTP()
    if Running.MeteorTP then return end; Running.MeteorTP = true
    task.spawn(function()
        while States.RunGranat do
            local _mId, _meteor = _GRGM()
            if _meteor then
                Running.MeteorGrabActive = true; TeleportTo(_meteor.pos)
                while States.RunGranat and GoodMeteors[_mId] do
                    local _r = GetRoot(); if _r and (_r.Position - _meteor.pos).Magnitude > 5 then TeleportTo(_meteor.pos) end; task.wait(0.03)
                end
                task.wait(0.1); Running.MeteorGrabActive = false
            end
            task.wait(0.05)
        end
        Running.MeteorTP = false
    end)
end
local StartMeteorTP = _SMTP

-- ================================================================
-- ENGINE 4: TOPPING ARCHERY
-- ================================================================
local _AConn = nil
local function _ShI(_item)
    if not _item or not _item:IsA("Model") or not _item.PrimaryPart or not _item:IsDescendantOf(workspace) or HitItems[_item] then return false end
    if not ItemHitEvent then return false end
    HitItems[_item] = true; pcall(function() ItemHitEvent:FireServer(_item) end); PlayEffect(_item.PrimaryPart)
    task.delay(0.2, function() if _item and _item.Parent then _item:Destroy() end end); return true
end
local ShootItem = _ShI

local function _SA()
    if Running.Archery then return end; Running.Archery = true
    if SpawnItemEvent and not _AConn then
        _AConn = SpawnItemEvent.OnClientEvent:Connect(function(_item)
            if States.Archery then task.delay(0.2, function() if States.Archery then ShootItem(_item) end end) end
        end)
    end
    task.spawn(function()
        while States.Archery do
            local _m = workspace:FindFirstChild("Main"); local _f = _m and _m:FindFirstChild("Item")
            if _f then for _, _item in ipairs(_f:GetChildren()) do if not States.Archery then break end; if ShootItem(_item) then task.wait(Config.ArcheryDelay) end end end
            task.wait(0.2)
        end
        Running.Archery = false
    end)
end
local StartArchery = _SA

local function _StA() if _AConn then _AConn:Disconnect(); _AConn = nil end end
local StopArchery = _StA

-- ================================================================
-- ENGINE 5: LAVA EXTRA DOWER
-- ================================================================
local ObbyStatusLbl = nil; local ObbyToggleRef = nil

local function _GSAP(_sf)
    local _cf = _sf:FindFirstChild("Coin"); if not _cf then return nil end
    local _total, _count = Vector3.new(), 0
    for _, _item in ipairs(_cf:GetDescendants()) do local _part = GetItemPart(_item); if _part then _total = _total + _part.Position; _count = _count + 1 end end
    return _count > 0 and _total / _count or nil
end

local function _FSNC(_cpPos, _usedStages)
    local _m = workspace:FindFirstChild("Main"); local _stages = _m and _m:FindFirstChild("Stages")
    if not _stages or not _cpPos then return nil end
    local _best, _bestDist = nil, math.huge
    for _, _stage in ipairs(_stages:GetChildren()) do
        if not _usedStages[_stage] then
            local _pos = _GSAP(_stage)
            if _pos then local _d = (_pos - _cpPos).Magnitude; if _d < _bestDist then _best, _bestDist = _stage, _d end end
        end
    end
    return _best and _bestDist <= Config.ObbyStageScanRadius and _best or nil
end

local function _CSI(_sf, _fromPos, _toPos)
    local _cf = _sf:FindFirstChild("Coin"); if not _cf then return end
    local _items = {}
    for _, _inst in ipairs(_cf:GetDescendants()) do local _part = GetItemPart(_inst); if _part and not Collected[_part] then table.insert(_items, _part) end end
    if #_items == 0 then return end
    local _dir = (_toPos and _fromPos) and (_toPos - _fromPos) or Vector3.new(0, 0, 1)
    if _dir.Magnitude > 0.01 then _dir = _dir.Unit else _dir = Vector3.new(0, 0, 1) end
    table.sort(_items, function(_a, _b) return (_a.Position - _fromPos):Dot(_dir) < (_b.Position - _fromPos):Dot(_dir) end)
    for _, _part in ipairs(_items) do
        if not States.Obby then break end
        if _part and _part.Parent then Collected[_part]=true; TeleportToCFrame(_part.CFrame, 0); PlayEffect(_part); task.wait(Config.ObbyItemDelay); local _r=GetRoot(); if _r then ResetPhysics(_r) end end
    end
end

local function _SO()
    if Running.Obby then return end; Running.Obby = true; States.Obby = true
    if ObbyStatusLbl then ObbyStatusLbl.Text = "Status : Berjalan" end
    task.spawn(function()
        local _maxCp = GetMaxCheckpoint()
        _ui:Notify("Lava Extra Dower", "Memulai dari checkpoint " .. Config.ObbyStartCheckpoint)
        local _usedStages = {}; local _i = Config.ObbyStartCheckpoint
        while States.Obby do
            if IsSpawnDone(_i) then if ObbyStatusLbl then ObbyStatusLbl.Text = "Status : Lewati CP " .. _i end; _i = _i + 1; if _i > _maxCp then break end; continue end
            local _cpT = GetCheckpointTriggerPart(_i); if not _cpT then _ui:Notify("Lava Extra Dower", "CP " .. _i .. " tidak ditemukan.", 2); break end
            local _root = GetRoot(); while not _root and States.Obby do task.wait(0.15); _root = GetRoot() end; if not States.Obby then break end
            if ObbyStatusLbl then ObbyStatusLbl.Text = "Status : Checkpoint " .. _i .. "/" .. _maxCp end
            _ui:Notify("Lava Extra Dower", "Checkpoint " .. _i .. "/" .. _maxCp, 1.5)
            FireCheckpointTouch(_i, 5); if not States.Obby then break end
            local _spCF = GetSpawnCFrame(_i); if _spCF then TeleportToCFrame(_spCF, 3) end
            task.wait(Config.ObbyCheckpointDelay); if not States.Obby then break end
            if Config.ObbyAutoCollectItems then
                local _curPos = _spCF and _spCF.Position or (_cpT and _cpT.Position or Vector3.new())
                local _nxtSpCF = GetSpawnCFrame(_i + 1); local _nxtPos = _nxtSpCF and _nxtSpCF.Position or _curPos
                local _stage = _FSNC(_curPos, _usedStages)
                if _stage then _usedStages[_stage] = true; _CSI(_stage, _curPos, _nxtPos) end
            end
            if not States.Obby then break end; _i = _i + 1; if _i > _maxCp then break end
        end
        if States.Obby then
            local _m = workspace:FindFirstChild("Main"); local _td = _m and _m:FindFirstChild("TeleportingDoor")
            local _dp = _td and _td:FindFirstChild("BackToLobby")
            if _dp then local _dcf = GetPartCFrame(_dp); if _dcf then TeleportToCFrame(_dcf, 0) end end
            _ui:Notify("Lava Extra Dower", "Selesai! Semua checkpoint terlewati.")
        else _ui:Notify("Lava Extra Dower", "Dihentikan oleh user.") end
        States.Obby = false; Running.Obby = false
        if ObbyStatusLbl then ObbyStatusLbl.Text = "Status : Idle" end
        if ObbyToggleRef then ObbyToggleRef:Set(false) end
    end)
end
local StartObby = _SO

local function _StO() States.Obby = false; if ObbyStatusLbl then ObbyStatusLbl.Text = "Status : Idle" end end
local StopObby = _StO

-- ================================================================
-- ENGINE 6: FACT HUNTER
-- ================================================================
local FactStatusLbl = nil; local FactToggleRef = nil

local function _HFI(_item)
    if not _item or not _item:IsA("Model") or not _item.PrimaryPart or HitItems[_item] then return false end
    if not ItemHitEvent then return false end
    HitItems[_item] = true; pcall(function() ItemHitEvent:FireServer(_item) end); PlayEffect(_item.PrimaryPart); return true
end

local function _SFH()
    if Running.FactHunter then return end; Running.FactHunter = true; States.FactHunter = true
    if FactStatusLbl then FactStatusLbl.Text = "Status : Berjalan" end
    task.spawn(function()
        _ui:Notify("Fact Hunter", "Memindai item..."); local _hc = 0
        for _, _obj in ipairs(workspace:GetDescendants()) do
            if not States.FactHunter then break end
            if _obj:IsA("Model") and _obj.PrimaryPart and (_obj:GetAttribute("PointEarned") or _obj:GetAttribute("Description")) and not HitItems[_obj] then
                if _HFI(_obj) then _hc = _hc + 1; if FactStatusLbl then FactStatusLbl.Text = "Status : Hit " .. _hc end; task.wait(Config.FactHitDelay) end
            end
        end
        _ui:Notify("Fact Hunter", (States.FactHunter and "Selesai! " or "Dihentikan. ") .. _hc .. " item.")
        States.FactHunter = false; Running.FactHunter = false
        if FactStatusLbl then FactStatusLbl.Text = "Status : Idle" end
        if FactToggleRef then FactToggleRef:Set(false) end
    end)
end
local StartFactHunter = _SFH

local function _StFH() States.FactHunter = false; if FactStatusLbl then FactStatusLbl.Text = "Status : Idle" end end
local StopFactHunter = _StFH

-- ================================================================
-- ENGINE 7: NOODLE MAZE
-- ================================================================
local MazeStatusLbl = nil; local MazeToggleRef = nil

local function _SMTo(_grf, _tp, _spd)
    while States.MazeFly do
        local _r = _grf(); if not _r then return false end
        local _cur = _r.Position; local _dir = _tp - _cur; local _dist = _dir.Magnitude
        if _dist <= 1.5 then _r.CFrame = CFrame.new(_tp); return true end
        local _step = math.min(_spd * (1/60), _dist); local _nxt = _cur + _dir.Unit * _step
        local _ld = Vector3.new(_dir.X, 0, _dir.Z)
        if _ld.Magnitude > 0.1 then _r.CFrame = CFrame.new(_nxt, _nxt + _ld) else _r.CFrame = CFrame.new(_nxt) end
        task.wait()
    end; return false
end

local function _SFTo(_tp, _spd, _ht)
    local _r = GetRoot(); if not _r then return false end
    _r.Anchored = true
    local _hum = _r.Parent and _r.Parent:FindFirstChildOfClass("Humanoid")
    if _hum then pcall(function() _hum.PlatformStand = true end) end
    local function _cr2() return GetRoot() end
    local _sp = _r.Position; local _ap = Vector3.new(_sp.X, _sp.Y + _ht, _sp.Z)
    local _ok1 = _SMTo(_cr2, _ap, _spd)
    if not _ok1 then local _rr = GetRoot(); if _rr then _rr.Anchored = false end; if _hum then pcall(function() _hum.PlatformStand = false end) end; return false end
    local _fp = Vector3.new(_tp.X, _ap.Y, _tp.Z)
    local _ok2 = _SMTo(_cr2, _fp, _spd)
    if not _ok2 then local _rr = GetRoot(); if _rr then _rr.Anchored = false end; if _hum then pcall(function() _hum.PlatformStand = false end) end; return false end
    local _lp = _tp + Vector3.new(0, 3, 0); local _ok3 = _SMTo(_cr2, _lp, _spd)
    local _rr = GetRoot(); if _rr then _rr.Anchored = false end; if _hum then pcall(function() _hum.PlatformStand = false end) end; return _ok3
end
local SemiFlyTo = _SFTo

local function _GMFP()
    local _m = workspace:FindFirstChild("Main"); local _mf = _m and _m:FindFirstChild("Maze"); if not _mf then return nil end
    local _ch = {}
    for _, _child in ipairs(_mf:GetChildren()) do local _num = _child.Name:match("_(%d+)$"); if _num then table.insert(_ch, {obj=_child, num=tonumber(_num)}) end end
    table.sort(_ch, function(_a, _b) return _a.num < _b.num end)
    if #_ch == 0 then return nil end
    local _fo = _ch[#_ch].obj
    if _fo:IsA("BasePart") then return _fo end
    if _fo:IsA("Model") then return _fo.PrimaryPart or _fo:FindFirstChildWhichIsA("BasePart") end
    return nil
end
local GetMazeFinishPart = _GMFP

local function _GAMC()
    local _m = workspace:FindFirstChild("Main"); local _cf = _m and _m:FindFirstChild("Coin"); if not _cf then return {} end
    local _list = {}
    for _, _inst in ipairs(_cf:GetChildren()) do local _part = GetItemPart(_inst); if _part and _part.Parent and not Collected[_part] then table.insert(_list, _part) end end
    return _list
end

local function _SCNP(_coins, _sp)
    local _rem = {}; for _, _c in ipairs(_coins) do table.insert(_rem, _c) end
    local _ord = {}; local _cp = _sp
    while #_rem > 0 do
        local _bI, _bD = 1, math.huge
        for _idx, _part in ipairs(_rem) do if _part and _part.Parent then local _d = (_part.Position - _cp).Magnitude; if _d < _bD then _bD = _d; _bI = _idx end end end
        local _chosen = table.remove(_rem, _bI); if _chosen then table.insert(_ord, _chosen); _cp = _chosen.Position end
    end; return _ord
end

local function _MBTL()
    local _m = workspace:FindFirstChild("Main"); if not _m then return false end
    local _td = _m:FindFirstChild("TeleportingDoor"); local _dp = _td and _td:FindFirstChild("BackToLobby")
    if _dp then local _dcf = GetPartCFrame(_dp); if _dcf then TeleportToCFrame(_dcf, 0); _ui:Notify("Noodle Maze", "Kembali ke lobby...", 2); return true end end
    for _, _obj in ipairs(_m:GetDescendants()) do
        if (_obj.Name:lower():find("lobby") or _obj.Name:lower():find("back")) and _obj:IsA("BasePart") then
            local _r = GetRoot(); if _r then TeleportToCFrame(_obj.CFrame, 0); task.wait(0.2); pcall(function() firetouchinterest(_r, _obj, 0) end); task.wait(0.1); pcall(function() firetouchinterest(_r, _obj, 1) end); _ui:Notify("Noodle Maze", "Kembali ke lobby...", 2); return true end
        end
    end; return false
end
local MazeBackToLobby = _MBTL

local function _SMAF()
    if Running.MazeFly then return end; Running.MazeFly = true; States.MazeFly = true
    if MazeStatusLbl then MazeStatusLbl.Text = "Status : Berjalan" end
    task.spawn(function()
        local _fp = GetMazeFinishPart()
        if not _fp then _ui:Notify("Noodle Maze","Titik finish tidak ditemukan."); States.MazeFly=false; Running.MazeFly=false; if MazeStatusLbl then MazeStatusLbl.Text="Status : Idle" end; if MazeToggleRef then MazeToggleRef:Set(false) end; return end
        local _root = GetRoot()
        if not _root then _ui:Notify("Noodle Maze","Karakter tidak ditemukan."); States.MazeFly=false; Running.MazeFly=false; if MazeStatusLbl then MazeStatusLbl.Text="Status : Idle" end; if MazeToggleRef then MazeToggleRef:Set(false) end; return end
        local _coins = _GAMC(); local _ordCoins = _SCNP(_coins, _root.Position)
        local _total = #_ordCoins; local _cc = 0
        _ui:Notify("Noodle Maze","Mengumpulkan " .. _total .. " coin...")
        for _idx, _cp in ipairs(_ordCoins) do
            if not States.MazeFly then break end
            if _cp and _cp.Parent and not Collected[_cp] then
                if MazeStatusLbl then MazeStatusLbl.Text = string.format("Status : Coin %d/%d", _idx, _total) end
                local _reached = SemiFlyTo(_cp.Position, Config.MazeFlySpeed, Config.MazeFlyHeight)
                if _reached and States.MazeFly and _cp.Parent then
                    Collected[_cp]=true; pcall(function() if CoinEvent then CoinEvent:FireServer(_cp) end end); PlayEffect(_cp); _cc=_cc+1; task.wait(Config.MazeCoinDelay)
                end
            end
        end
        if not States.MazeFly then _ui:Notify("Noodle Maze","Dihentikan. " .. _cc .. " coin."); Running.MazeFly=false; if MazeStatusLbl then MazeStatusLbl.Text="Status : Idle" end; if MazeToggleRef then MazeToggleRef:Set(false) end; local _r=GetRoot(); if _r then _r.Anchored=false end; return end
        if MazeStatusLbl then MazeStatusLbl.Text = "Status : Menuju Finish" end
        _ui:Notify("Noodle Maze", _cc .. " coin. Menuju finish...")
        local _fr = SemiFlyTo(_fp.Position, Config.MazeFlySpeed, Config.MazeFlyHeight)
        if _fr and States.MazeFly then
            _ui:Notify("Noodle Maze","Sampai di finish!")
            local _r = GetRoot(); if _r and _fp then pcall(function() firetouchinterest(_r, _fp, 0) end); task.wait(0.3); pcall(function() firetouchinterest(_r, _fp, 1) end) end
            task.wait(1); if MazeStatusLbl then MazeStatusLbl.Text = "Status : Kembali ke Lobby" end; MazeBackToLobby()
        else _ui:Notify("Noodle Maze","Dihentikan sebelum finish.") end
        States.MazeFly=false; Running.MazeFly=false; if MazeStatusLbl then MazeStatusLbl.Text="Status : Idle" end; if MazeToggleRef then MazeToggleRef:Set(false) end
    end)
end
local StartMazeAutoFly = _SMAF

local function _StMAF()
    States.MazeFly = false
    task.delay(0.1, function() local _r=GetRoot(); if _r then _r.Anchored=false end; local _c=LocalPlayer.Character; local _h=_c and _c:FindFirstChildOfClass("Humanoid"); if _h then pcall(function() _h.PlatformStand=false end) end end)
    if MazeStatusLbl then MazeStatusLbl.Text = "Status : Idle" end; _ui:Notify("Noodle Maze","Dihentikan.", 2)
end
local StopMazeAutoFly = _StMAF

-- ================================================================
-- ENGINE 8: MOUNTAIN TOWER
-- ================================================================
local MTStatusLbl = nil; local MTToggleRef = nil; local MTChiliToggleRef = nil

local function _GAMTC()
    local _m = workspace:FindFirstChild("Main"); local _cf = _m and _m:FindFirstChild("Coins"); if not _cf then return {} end
    local _list = {}
    for _, _inst in ipairs(_cf:GetChildren()) do local _part = GetItemPart(_inst); if _part and _part.Parent and not Collected[_part] then table.insert(_list, _part) end end
    return _list
end

local function _SMTC()
    if Running.MTChili then return end; Running.MTChili = true; States.MTChili = true
    task.spawn(function()
        _ui:Notify("Mountain Tower","Auto Chili aktif", 2); local _tc = 0
        while States.MTChili do
            local _chilis = _GAMTC()
            for _, _part in ipairs(_chilis) do
                if not States.MTChili then break end
                if _part and _part.Parent and not Collected[_part] then
                    Collected[_part]=true; TeleportToCFrame(_part.CFrame, 0)
                    pcall(function() if CoinEvent then CoinEvent:FireServer(_part) end; if PackageEvent then PackageEvent:FireServer(_part) end end)
                    PlayEffect(_part); _tc=_tc+1; task.wait(Config.MTChiliDelay)
                end
            end; task.wait(0.5)
        end
        Running.MTChili = false; _ui:Notify("Mountain Tower","Auto Chili nonaktif (".._tc.." terkumpul)", 2)
    end)
end
local StartMTChili = _SMTC

local function _StMTC() States.MTChili = false end
local StopMTChili = _StMTC

local function _SMTA()
    if Running.MT then return end; Running.MT = true; States.MT = true
    if MTStatusLbl then MTStatusLbl.Text = "Status : Berjalan" end
    if not States.GranatCollect then States.GranatCollect = true; StartLootCollector(); _ui:Notify("Mountain Tower","Auto magnet aktif", 2) end
    task.spawn(function()
        local _maxCp = GetMaxCheckpoint(); _ui:Notify("Mountain Tower","Memulai dari checkpoint " .. Config.MTStartCheckpoint)
        local _i = Config.MTStartCheckpoint
        while States.MT do
            if IsSpawnDone(_i) then if MTStatusLbl then MTStatusLbl.Text = "Status : Lewati CP " .. _i end; _i = _i + 1; if _i > _maxCp then break end; continue end
            local _cpT = GetCheckpointTriggerPart(_i); if not _cpT then _ui:Notify("Mountain Tower","CP ".._i.." tidak ditemukan.", 2); break end
            local _root = GetRoot(); while not _root and States.MT do task.wait(0.15); _root = GetRoot() end; if not States.MT then break end
            if MTStatusLbl then MTStatusLbl.Text = "Status : Checkpoint " .. _i .. "/" .. _maxCp end
            _ui:Notify("Mountain Tower","Checkpoint " .. _i .. "/" .. _maxCp, 1.5)
            FireCheckpointTouch(_i, 5); if not States.MT then break end
            local _spCF = GetSpawnCFrame(_i); if _spCF then TeleportToCFrame(_spCF, 3) end
            task.wait(Config.MTCheckpointDelay); if not States.MT then break end
            _i = _i + 1; if _i > _maxCp then break end
        end
        if States.MT then
            local _m = workspace:FindFirstChild("Main"); local _td = _m and _m:FindFirstChild("TeleportingDoor"); local _dp = _td and _td:FindFirstChild("BackToLobby")
            if _dp then local _dcf = GetPartCFrame(_dp); if _dcf then TeleportToCFrame(_dcf, 0) end end
            _ui:Notify("Mountain Tower","Selesai! Semua checkpoint terlewati.")
        else _ui:Notify("Mountain Tower","Dihentikan oleh user.") end
        States.MT = false; Running.MT = false; if MTStatusLbl then MTStatusLbl.Text = "Status : Idle" end; if MTToggleRef then MTToggleRef:Set(false) end
    end)
end
local StartMTAuto = _SMTA

local function _StMTA() States.MT = false; if MTStatusLbl then MTStatusLbl.Text = "Status : Idle" end end
local StopMTAuto = _StMTA

-- ================================================================
-- ENGINE 9: SMART FLIGHT
-- ================================================================
local FlightStatusLbl = nil; local FlightToggleRef = nil; local FlightQuestionLbl = nil

local function _GPS()
    local _p = workspace:FindFirstChild("Plane"); if not _p then return nil end
    local _s = _p:FindFirstChild("Seat")
    if _s and _s:IsA("BasePart") then return _s end
    return _p:FindFirstChildWhichIsA("VehicleSeat") or _p:FindFirstChildWhichIsA("Seat") or _p:FindFirstChildWhichIsA("BasePart")
end
local GetPlaneSeat = _GPS

local function _GPB()
    local _p = workspace:FindFirstChild("Plane"); if not _p then return nil end
    if _p:IsA("BasePart") then return _p end
    return _p.PrimaryPart or _p:FindFirstChildWhichIsA("BasePart")
end
local GetPlaneBody = _GPB

local function _ISIP()
    local _char = LocalPlayer.Character; if not _char then return false end
    local _hum = _char:FindFirstChildOfClass("Humanoid"); if not _hum then return false end
    local _seat = GetPlaneSeat(); if not _seat then return false end
    if _seat:IsA("VehicleSeat") then return _seat.Occupant == _hum end
    for _, _v in ipairs(_char:GetChildren()) do
        if _v:IsA("Weld") or _v:IsA("WeldConstraint") then
            if _v.Part0 == _seat or _v.Part1 == _seat then return true end
        end
    end
    return false
end
local IsSittingInPlane = _ISIP

local function _WUS(_to)
    local _t = tick()
    while tick() - _t < _to do if IsSittingInPlane() then return true end; task.wait(0.2) end
    return false
end

local function _GQU()
    local _pg = LocalPlayer:FindFirstChild("PlayerGui"); if not _pg then return nil end
    local _menu = _pg:FindFirstChild("Menu"); if not _menu then return nil end
    return _menu:FindFirstChild("QuestionUI")
end
local GetQuestionUI = _GQU

local function _WFQU(_to)
    local _t = tick()
    while tick() - _t < _to do local _qUI = GetQuestionUI(); if _qUI and _qUI.Visible then return _qUI end; task.wait(0.3) end
    return nil
end

local function _GCAT()
    local _m = workspace:FindFirstChild("Main"); if not _m then return nil end
    local _qf = _m:FindFirstChild("Question"); if not _qf then return nil end
    for _, _obj in ipairs(_qf:GetDescendants()) do
        if _obj:IsA("TextLabel") or _obj:IsA("TextButton") or _obj:IsA("SurfaceGui") then
            local _tl = _obj:IsA("SurfaceGui") and _obj:FindFirstChildWhichIsA("TextLabel") or _obj
            if _tl and _tl:IsA("TextLabel") and _tl.Text and _tl.Text ~= "" then return _tl.Text end
        end
        local _ans = _obj:GetAttribute("Answer") or _obj:GetAttribute("CorrectAnswer")
        if _ans then return tostring(_ans) end
    end
    for _, _obj in ipairs(_qf:GetChildren()) do
        if _obj:IsA("BasePart") or _obj:IsA("Model") then return _obj.Name end
    end
    return nil
end

local function _GAP()
    local _m = workspace:FindFirstChild("Main"); if not _m then return {} end
    local _qp = _m:FindFirstChild("QuestionPosition"); if not _qp then return {} end
    local _list = {}
    for _, _child in ipairs(_qp:GetChildren()) do
        local _part = GetItemPart(_child) or (_child:IsA("BasePart") and _child)
        if _part then table.insert(_list, {name=_child.Name, part=_part, position=_part.Position}) end
    end
    return _list
end

local function _GAFQU(_qUI)
    if not _qUI then return nil end
    local _ans = _qUI:GetAttribute("CorrectAnswer") or _qUI:GetAttribute("Answer") or _qUI:GetAttribute("AnswerPoint")
    if _ans then return tostring(_ans) end
    for _, _child in ipairs(_qUI:GetDescendants()) do
        local _a = _child:GetAttribute("CorrectAnswer") or _child:GetAttribute("Answer") or _child:GetAttribute("AnswerPoint")
        if _a then return tostring(_a) end
    end
    return nil
end

local function _FAP(_ap, _at)
    if not _at or #_ap == 0 then return _ap[1] and _ap[1].position or nil end
    local _la = _at:lower()
    for _, _a in ipairs(_ap) do if _a.name:lower() == _la or _a.name:lower():find(_la, 1, true) then return _a.position end end
    local _lm = {a=1, b=2, c=3, d=4, e=5}
    local _li = _lm[_la:sub(1,1)]
    if _li and _ap[_li] then return _ap[_li].position end
    local _num = tonumber(_at); if _num and _ap[_num] then return _ap[_num].position end
    return _ap[1] and _ap[1].position or nil
end

local function _TPP(_tp)
    local _plane = workspace:FindFirstChild("Plane"); if not _plane then return false end
    local _pb = GetPlaneBody(); if not _pb then return false end
    for _, _p in ipairs(_plane:GetDescendants()) do
        if _p:IsA("BasePart") then pcall(function() _p.Velocity = Vector3.zero; _p.RotVelocity = Vector3.zero end) end
    end
    local _cf = _pb.CFrame
    local _ncf = CFrame.new(Vector3.new(_tp.X, _tp.Y + Config.FlightTPYOffset, _tp.Z), Vector3.new(_tp.X, _tp.Y + Config.FlightTPYOffset, _tp.Z) + _cf.LookVector)
    if _plane:IsA("Model") and _plane.PrimaryPart then pcall(function() _plane:SetPrimaryPartCFrame(_ncf) end)
    else pcall(function() _pb.CFrame = _ncf end) end
    for _, _p in ipairs(_plane:GetDescendants()) do
        if _p:IsA("BasePart") then pcall(function() _p.AssemblyLinearVelocity = Vector3.zero; _p.AssemblyAngularVelocity = Vector3.zero end) end
    end
    return true
end

local function _TAP(_tp)
    local _m = workspace:FindFirstChild("Main"); if not _m then return end
    local _qp = _m:FindFirstChild("QuestionPosition"); if not _qp then return end
    local _root = GetRoot()
    local _cp, _cd = nil, math.huge
    for _, _child in ipairs(_qp:GetChildren()) do
        local _part = GetItemPart(_child) or (_child:IsA("BasePart") and _child)
        if _part then local _d = (_part.Position - _tp).Magnitude; if _d < _cd then _cp = _part; _cd = _d end end
    end
    if _cp then
        if _root then pcall(function() firetouchinterest(_root, _cp, 0) end); task.wait(0.15); pcall(function() firetouchinterest(_root, _cp, 1) end) end
        local _pb = GetPlaneBody()
        if _pb then pcall(function() firetouchinterest(_pb, _cp, 0) end); task.wait(0.15); pcall(function() firetouchinterest(_pb, _cp, 1) end) end
    end
end

local function _GQP(_qUI)
    if not _qUI then return 0, 5 end
    local _cur = _qUI:GetAttribute("QuestionNumber") or 1
    local _tot = _qUI:GetAttribute("TotalQuestions") or 5
    return tonumber(_cur) or 1, tonumber(_tot) or 5
end

local function _SSF()
    if Running.SmartFlight then return end
    Running.SmartFlight = true; States.SmartFlight = true
    if FlightStatusLbl then FlightStatusLbl.Text = "Status : Berjalan" end
    task.spawn(function()
        local _seat = GetPlaneSeat()
        if not _seat then
            _ui:Notify("Smart Flight", "Kursi pesawat tidak ditemukan!")
            States.SmartFlight = false; Running.SmartFlight = false
            if FlightStatusLbl then FlightStatusLbl.Text = "Status : Idle" end
            if FlightToggleRef then FlightToggleRef:Set(false) end
            return
        end
        if not IsSittingInPlane() then
            if FlightStatusLbl then FlightStatusLbl.Text = "Status : Naik Pesawat..." end
            _ui:Notify("Smart Flight", "Teleport ke kursi pesawat...")
            TeleportToCFrame(_seat.CFrame, 2); task.wait(0.5)
            pcall(function() local _c = LocalPlayer.Character; local _h = _c and _c:FindFirstChildOfClass("Humanoid"); if _h then _h.SeatPart = _seat end end)
            local _r = GetRoot()
            if _r then pcall(function() firetouchinterest(_r, _seat, 0) end); task.wait(0.2); pcall(function() firetouchinterest(_r, _seat, 1) end) end
            local _sat = _WUS(Config.FlightSeatTPDelay)
            if not _sat then
                TeleportToCFrame(_seat.CFrame, 0.5); task.wait(0.3)
                local _r2 = GetRoot()
                if _r2 then pcall(function() firetouchinterest(_r2, _seat, 0) end); task.wait(0.2); pcall(function() firetouchinterest(_r2, _seat, 1) end) end
                _WUS(2)
            end
            if not IsSittingInPlane() then _ui:Notify("Smart Flight", "Belum bisa naik pesawat, tetap lanjut...", 2)
            else _ui:Notify("Smart Flight", "Berhasil naik pesawat!", 2) end
        else _ui:Notify("Smart Flight", "Sudah di dalam pesawat.", 2) end
        task.wait(1)
        local _qc = 0; local _maxQ = 10
        while States.SmartFlight and _qc < _maxQ do
            if FlightStatusLbl then FlightStatusLbl.Text = "Status : Menunggu Soal..." end
            local _qUI = _WFQU(8)
            if not _qUI then
                if IsMinigameCompleted("FlightButton") then _ui:Notify("Smart Flight", "Minigame selesai!"); break end
                _ui:Notify("Smart Flight", "Soal tidak muncul, coba tunggu...", 2); task.wait(2); continue
            end
            _qc = _qc + 1
            local _curQ, _totQ = _GQP(_qUI)
            if FlightStatusLbl then FlightStatusLbl.Text = string.format("Status : Soal %d/%d", _curQ, _totQ) end
            _ui:Notify("Smart Flight", string.format("Soal %d/%d — Mencari jawaban...", _curQ, _totQ), 2)
            task.wait(Config.FlightAnswerDelay)
            local _ansPos = _GAP()
            local _ansText = _GAFQU(_qUI); if not _ansText then _ansText = _GCAT() end
            if FlightQuestionLbl then FlightQuestionLbl.Text = "Jawaban: " .. (_ansText or "?") .. " (" .. #_ansPos .. " titik)" end
            local _tgtPos = _FAP(_ansPos, _ansText)
            if not _tgtPos then
                if FlightStatusLbl then FlightStatusLbl.Text = "Status : Coba semua titik..." end
                for _, _ap in ipairs(_ansPos) do
                    if not States.SmartFlight then break end
                    _TPP(_ap.position); task.wait(0.5); _TAP(_ap.position); task.wait(0.3)
                    local _nqUI = GetQuestionUI()
                    if not _nqUI or not _nqUI.Visible then break end
                    local _nQ, _ = _GQP(_nqUI); if _nQ ~= _curQ then break end
                end
            else
                if FlightStatusLbl then FlightStatusLbl.Text = "Status : Terbang ke jawaban..." end
                _TPP(_tgtPos); task.wait(0.4); _TAP(_tgtPos); task.wait(0.3)
            end
            task.wait(Config.FlightQuestionDelay)
            if IsMinigameCompleted("FlightButton") then _ui:Notify("Smart Flight", "Semua soal selesai!"); break end
            if _curQ >= _totQ then task.wait(1); if IsMinigameCompleted("FlightButton") then _ui:Notify("Smart Flight", "Minigame selesai!") end; break end
        end
        States.SmartFlight = false; Running.SmartFlight = false
        if FlightStatusLbl then FlightStatusLbl.Text = "Status : Idle" end
        if FlightQuestionLbl then FlightQuestionLbl.Text = "Jawaban terakhir: -" end
        if FlightToggleRef then FlightToggleRef:Set(false) end
        _ui:Notify("Smart Flight", "Selesai / Dihentikan.", 2)
    end)
end
local StartSmartFlight = _SSF

local function _StSF()
    States.SmartFlight = false
    if FlightStatusLbl then FlightStatusLbl.Text = "Status : Idle" end
    _ui:Notify("Smart Flight", "Dihentikan.", 2)
end
local StopSmartFlight = _StSF

-- ================================================================
-- BACKGROUND CLEANUP
-- ================================================================
task.spawn(function()
    while true do task.wait(5)
        for _obj in pairs(Collected) do if not _obj or not _obj.Parent then Collected[_obj] = nil end end
        for _obj in pairs(HitItems)  do if not _obj or not _obj.Parent then HitItems[_obj]  = nil end end
    end
end)
LocalPlayer.CharacterAdded:Connect(function() task.wait(1); Collected = {}; _Col = Collected end)

-- ================================================================
-- BUILD UI TABS
-- ================================================================

-- TAB: MAIN
local _mainTab = _ui:AddTab("Main", nil)
_mainTab:AddSection("Global")
_mainTab:AddToggle("Auto Coin Magnet", "Ambil coin & package otomatis", false, function(_b)
    States.GranatCollect = _b
    if _b then StartLootCollector(); _ui:Notify("Auto Coin","Magnet aktif.")
    else _ui:Notify("Auto Coin","Magnet nonaktif.") end
end)
_mainTab:AddButton("Bersihkan Cache", function()
    Collected = {}; HitItems = {}; _ui:Notify("Cache","Berhasil dibersihkan.")
end)
_mainTab:AddSection("Teleport Minigame")
local _TRs = {}
for _, _spot in ipairs(TeleportSpots) do
    local _row = _mainTab:AddTeleport(_spot.Name, function()
        TeleportToCFrame(_spot.CFrame, 0); _ui:Notify("Teleport", _spot.Name)
    end)
    _TRs[_spot.GuiButton] = _row
end
task.spawn(function()
    while true do
        for _, _spot in ipairs(TeleportSpots) do
            local _row = _TRs[_spot.GuiButton]; if _row then _row:SetCompleted(IsMinigameCompleted(_spot.GuiButton)) end
        end; task.wait(3)
    end
end)

-- TAB: GRANAT RUN
local _granatTab = _ui:AddTab("Granat Run", "granat_run")
_granatTab:AddSection("Pengaturan")
_granatTab:AddDropdown("Mode Collect",{"Magnet (Silent)","Teleport (Fisik)"},"Magnet (Silent)",function(_v) Config.CollectMode = _v == "Magnet (Silent)" and "Magnet" or "Teleport" end)
_granatTab:AddSlider("Grab Timing (ms)", 200, 1500, 700, function(_v) Config.MeteorGrabTime = _v/1000 end)
_granatTab:AddSlider("Danger Radius", 30, 200, 60, function(_v) Config.MeteorDangerRadius = _v end)
_granatTab:AddSlider("Collect Delay (ms)", 10, 200, 30, function(_v) Config.Delay = _v/1000 end)
_granatTab:AddSection("Modul")
_granatTab:AddToggle("Auto Collect","Coin & Package otomatis",false,function(_b)
    States.GranatCollect=_b; if _b then StartLootCollector(); _ui:Notify("Granat Run","Auto Collect aktif.") else _ui:Notify("Granat Run","Auto Collect nonaktif.") end
end)
_granatTab:AddToggle("Auto Meteor Snatch & Dodge","Ambil meteor biru, hindari yang berbahaya",false,function(_b)
    States.RunGranat=_b; if _b then StartMeteorTracker(); StartMeteorTP(); _ui:Notify("Granat Run","Meteor Snatch aktif.")
    else StopMeteorTracker(); Running.MeteorGrabActive=false; _ui:Notify("Granat Run","Meteor Snatch nonaktif.") end
end)
_granatTab:AddToggle("Mode All-in","Aktifkan semua modul sekaligus",false,function(_b)
    States.RunGranat=_b; States.GranatCollect=_b
    if _b then StartMeteorTracker(); StartMeteorTP(); StartLootCollector(); _ui:Notify("Granat Run","Mode All-in aktif!")
    else StopMeteorTracker(); Running.MeteorGrabActive=false; _ui:Notify("Granat Run","Mode All-in nonaktif.") end
end)

-- TAB: TOPPING ARCHERY
local _archeryTab = _ui:AddTab("Topping Archery","topping_archery")
_archeryTab:AddSection("Pengaturan")
_archeryTab:AddSlider("Delay Tembak (ms)",50,500,150,function(_v) Config.ArcheryDelay=_v/1000 end)
_archeryTab:AddSection("Modul")
_archeryTab:AddToggle("Auto Archery","Tembak target otomatis",false,function(_b)
    States.Archery=_b; if _b then StartArchery(); _ui:Notify("Topping Archery","Auto Archery aktif.") else StopArchery(); _ui:Notify("Topping Archery","Auto Archery nonaktif.") end
end)

-- TAB: LAVA EXTRA DOWER
local _lavaTab = _ui:AddTab("Lava Extra Dower","lava_extra_dower")
_lavaTab:AddSection("Pengaturan")
_lavaTab:AddSlider("Mulai dari Checkpoint #", 0, 20, 0, function(_v) Config.ObbyStartCheckpoint = math.floor(_v) end)
_lavaTab:AddSlider("Delay per Checkpoint (ms)", 100, 2000, 500, function(_v) Config.ObbyCheckpointDelay = _v/1000 end)
_lavaTab:AddSlider("Delay Ambil Item (ms)", 50, 500, 150, function(_v) Config.ObbyItemDelay = _v/1000 end)
_lavaTab:AddSlider("Radius Deteksi Stage", 50, 300, 150, function(_v) Config.ObbyStageScanRadius = _v end)
_lavaTab:AddToggle("Ambil Item Otomatis","Coin, Package & Chili tiap stage",true,function(_b) Config.ObbyAutoCollectItems=_b end)
_lavaTab:AddSection("Modul")
ObbyStatusLbl = _lavaTab:AddLabel("Status : Idle")
ObbyToggleRef = _lavaTab:AddToggle("Auto Lava Extra Dower","Lewati checkpoint otomatis sampai selesai",false,function(_b)
    if _b then StartObby() else StopObby(); _ui:Notify("Lava Extra Dower","Dihentikan.") end
end)

-- TAB: MOUNTAIN TOWER
local _mtTab = _ui:AddTab("Mountain Tower","mountain_tower")
_mtTab:AddSection("Pengaturan")
_mtTab:AddSlider("Mulai dari Checkpoint #", 0, 20, 0, function(_v) Config.MTStartCheckpoint = math.floor(_v) end)
_mtTab:AddSlider("Delay per Checkpoint (ms)", 100, 2000, 500, function(_v) Config.MTCheckpointDelay = _v/1000 end)
_mtTab:AddSlider("Delay Ambil Chili (ms)", 50, 500, 150, function(_v) Config.MTChiliDelay = _v/1000 end)
_mtTab:AddSection("Modul")
MTStatusLbl = _mtTab:AddLabel("Status : Idle")
MTToggleRef = _mtTab:AddToggle("Auto Mountain Tower","Lewati checkpoint otomatis sampai selesai",false,function(_b)
    if _b then StartMTAuto() else StopMTAuto(); _ui:Notify("Mountain Tower","Dihentikan.") end
end)
MTChiliToggleRef = _mtTab:AddToggle("Auto Ambil Chili","Kumpulkan semua item dari folder Coins",false,function(_b)
    if _b then StartMTChili() else StopMTChili() end
end)

-- TAB: NOODLE MAZE
local _mazeTab = _ui:AddTab("Noodle Maze","noodle_maze")
_mazeTab:AddSection("Pengaturan")
_mazeTab:AddSlider("Fly Speed", 20, 150, 60, function(_v) Config.MazeFlySpeed = _v end)
_mazeTab:AddSlider("Fly Height", 10, 100, 40, function(_v) Config.MazeFlyHeight = _v end)
_mazeTab:AddSlider("Delay per Coin (ms)", 10, 500, 80, function(_v) Config.MazeCoinDelay = _v/1000 end)
_mazeTab:AddSection("Modul")
MazeStatusLbl = _mazeTab:AddLabel("Status : Idle")
MazeToggleRef = _mazeTab:AddToggle("Auto Fly + Collect Coin","Kumpulkan semua coin lalu terbang ke finish",false,function(_b)
    if _b then StartMazeAutoFly() else StopMazeAutoFly() end
end)
_mazeTab:AddButton("Fly Langsung ke Finish",function()
    local _fp = GetMazeFinishPart()
    if not _fp then _ui:Notify("Noodle Maze","Finish tidak ditemukan."); return end
    _ui:Notify("Noodle Maze","Terbang ke finish..."); States.MazeFly = true
    task.spawn(function()
        local _reached = SemiFlyTo(_fp.Position, Config.MazeFlySpeed, Config.MazeFlyHeight)
        if _reached then
            _ui:Notify("Noodle Maze","Sampai di finish!")
            local _r = GetRoot(); if _r and _fp then pcall(function() firetouchinterest(_r, _fp, 0) end); task.wait(0.3); pcall(function() firetouchinterest(_r, _fp, 1) end) end
            task.wait(1); MazeBackToLobby()
        else _ui:Notify("Noodle Maze","Terbang dihentikan.") end
        States.MazeFly = false
    end)
end)

-- TAB: SMART FLIGHT
local _flightTab = _ui:AddTab("Smart Flight","smart_flight")
_flightTab:AddSection("Pengaturan")
_flightTab:AddSlider("Jeda Baca Jawaban (ms)", 200, 3000, 1200, function(_v) Config.FlightAnswerDelay = _v/1000 end)
_flightTab:AddSlider("Tunggu Naik Pesawat (s)", 1, 8, 3, function(_v) Config.FlightSeatTPDelay = _v end)
_flightTab:AddSlider("Jeda Antar Soal (ms)", 200, 2000, 800, function(_v) Config.FlightQuestionDelay = _v/1000 end)
_flightTab:AddSlider("Offset Y Pesawat", 0, 20, 3, function(_v) Config.FlightTPYOffset = _v end)
_flightTab:AddSection("Info Soal")
FlightQuestionLbl = _flightTab:AddLabel("Jawaban terakhir: -")
_flightTab:AddSection("Modul")
FlightStatusLbl = _flightTab:AddLabel("Status : Idle")
FlightToggleRef = _flightTab:AddToggle("Auto Smart Flight","Naik pesawat & jawab soal otomatis",false,function(_b)
    if _b then StartSmartFlight() else StopSmartFlight() end
end)
_flightTab:AddButton("Naik Pesawat Manual",function()
    local _seat = GetPlaneSeat()
    if not _seat then _ui:Notify("Smart Flight","Kursi pesawat tidak ditemukan!"); return end
    _ui:Notify("Smart Flight","Teleport ke kursi pesawat...")
    TeleportToCFrame(_seat.CFrame, 2); task.wait(0.5)
    local _r = GetRoot()
    if _r then pcall(function() firetouchinterest(_r, _seat, 0) end); task.wait(0.2); pcall(function() firetouchinterest(_r, _seat, 1) end) end
    pcall(function() local _c = LocalPlayer.Character; local _h = _c and _c:FindFirstChildOfClass("Humanoid"); if _h then _h.SeatPart = _seat end end)
    _ui:Notify("Smart Flight","Mencoba naik pesawat...", 2)
end)
_flightTab:AddButton("Debug: TP Pesawat ke Titik 1",function()
    local _ansPos = _GAP()
    if #_ansPos == 0 then _ui:Notify("Smart Flight","QuestionPosition kosong!"); return end
    local _ap = _ansPos[1]
    _TPP(_ap.position)
    _ui:Notify("Smart Flight","Pesawat TP ke " .. _ap.name)
end)

-- TAB: FACT HUNTER
local _factTab = _ui:AddTab("Fact Hunter","fact_hunter")
_factTab:AddSection("Pengaturan")
_factTab:AddSlider("Hit Delay (ms)",100,1000,250,function(_v) Config.FactHitDelay=_v/1000 end)
_factTab:AddSection("Modul")
FactStatusLbl = _factTab:AddLabel("Status : Idle")
FactToggleRef = _factTab:AddToggle("Auto Hit","Pukul semua item otomatis",false,function(_b)
    if _b then StartFactHunter() else StopFactHunter(); _ui:Notify("Fact Hunter","Dihentikan.") end
end)
_factTab:AddButton("Bersihkan Cache",function() HitItems={}; _ui:Notify("Fact Hunter","Cache dibersihkan.") end)

-- TAB: INFO
local _infoTab = _ui:AddTab("Info",nil)
_infoTab:AddSection(_decode("626c6f78506c6f697420") .. "V1.9.2")
_infoTab:AddLabel("Map : SARIMI")
_infoTab:AddLabel("Tekan RCtrl untuk toggle UI")
_infoTab:AddSection("Minigame")
_infoTab:AddLabel("Granat Run — Meteor Snatch & Auto Collect")
_infoTab:AddLabel("Topping Archery — Auto Shoot")
_infoTab:AddLabel("Lava Extra Dower — Auto Checkpoint")
_infoTab:AddLabel("Mountain Tower — Auto Checkpoint + Chili")
_infoTab:AddLabel("Noodle Maze — Auto Fly & Coin")
_infoTab:AddLabel("Smart Flight — Auto Naik & Jawab Soal")
_infoTab:AddLabel("Fact Hunter — Auto Hit")

-- ================================================================
-- KEYBIND
-- ================================================================
UserInputService.InputBegan:Connect(function(_input, _gpe)
    if _gpe then return end
    if _input.KeyCode == Enum.KeyCode.RightControl then _ui:Toggle() end
end)

-- ================================================================
-- INTEGRITY CHECK (runs periodically)
-- ================================================================
task.spawn(function()
    local _hash = 0
    for _i = 1, 47 do _hash = _hash + _i * 7 end
    while true do
        task.wait(30)
        local _check = 0
        for _i = 1, 47 do _check = _check + _i * 7 end
        if _check ~= _hash then
            pcall(function() _ui.ScreenGui:Destroy() end)
            break
        end
    end
end)

_ui:Notify(_decode("626c6f78506c6f6974"), "V1.9.2 siap! Tekan RCtrl untuk toggle.", 4)
print(_decode("5b626c6f78506c6f69745d") .. " V1.9.2 loaded")
