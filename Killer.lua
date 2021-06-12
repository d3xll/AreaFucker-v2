local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AreaFucker | Killer", "Synapse")
----PLAYERMENU
local Player = Window:NewTab("Player")
--States
local StatesSection = Player:NewSection("States")
StatesSection:NewSlider("WalkSpeed", "Change WalkSpeed", 500, 16, function(s) -- 500 (MaxValue) | 16 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

StatesSection:NewSlider("JumpPower", "Change JumpPower", 500, 50, function(s) -- 500 (MaxValue) | 50 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

StatesSection:NewSlider("FOV", "Field Of View", 120, 70, function(s) -- 120 (MaxValue) | 70 (MinValue)
    game:GetService'Workspace'.Camera.FieldOfView = s
end)



--Mods
local ModsSection = Player:NewSection("Mods")

ModsSection:NewButton("Fly [C]", "Fly all over the map!", function()
repeat wait() 
until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
local mouse = game.Players.LocalPlayer:GetMouse() 
repeat wait() until mouse
local plr = game.Players.LocalPlayer 
local torso = plr.Character.Head 
local flying = false
local deb = true 
local ctrl = {f = 0, b = 0, l = 0, r = 0} 
local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
local maxspeed = 50 
local speed = 0 

function Fly() 
local bg = Instance.new("BodyGyro", torso) 
bg.P = 9e4 
bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
bg.cframe = torso.CFrame 
local bv = Instance.new("BodyVelocity", torso) 
bv.velocity = Vector3.new(0,0.1,0) 
bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
repeat wait() 
plr.Character.Humanoid.PlatformStand = true 
if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then 
speed = speed+.5+(speed/maxspeed) 
if speed > maxspeed then 
speed = maxspeed 
end 
elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then 
speed = speed-1 
if speed < 0 then 
speed = 0 
end 
end 
if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then 
bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then 
bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
else 
bv.velocity = Vector3.new(0,0.1,0) 
end 
bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
until not flying 
ctrl = {f = 0, b = 0, l = 0, r = 0} 
lastctrl = {f = 0, b = 0, l = 0, r = 0} 
speed = 0 
bg:Destroy() 
bv:Destroy() 
plr.Character.Humanoid.PlatformStand = false 
end 
mouse.KeyDown:connect(function(key) 
if key:lower() == "c" then 
if flying then flying = false 
else 
flying = true 
Fly() 
end 
elseif key:lower() == "w" then 
ctrl.f = 1 
elseif key:lower() == "s" then 
ctrl.b = -1 
elseif key:lower() == "a" then 
ctrl.l = -1 
elseif key:lower() == "d" then 
ctrl.r = 1 
end 
end) 
mouse.KeyUp:connect(function(key) 
if key:lower() == "w" then 
ctrl.f = 0 
elseif key:lower() == "s" then 
ctrl.b = 0 
elseif key:lower() == "a" then 
ctrl.l = 0 
elseif key:lower() == "d" then 
ctrl.r = 0 
end 
end)
Fly()
end)

ModsSection:NewToggle("Noclip", "Pass through objects!", function(state)
    if state then
        noclip = true
        game:GetService('RunService').Stepped:connect(function()
        if noclip == true then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
            end
        end)
    else
        noclip = false
    end
end)



ModsSection:NewToggle("InfJump", "Jump as much as you want!", function(state)
    if state then
        InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
            if InfiniteJumpEnabled == true then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState(3)
                wait()
            end
    end)
    else
        InfiniteJumpEnabled = false
    end
end)

ModsSection:NewToggle("GodMode", "Return to the same place where you died!", function(state)
    if state then
        local stationaryrespawn = false
        local needsrespawning = false
        local haspos = false
        local pos = CFrame.new()
        local Respawning = Instance.new("ScreenGui")
        local RespawningButton = Instance.new("TextButton")
        respawngodmode = true
         
        Respawning.Name = "Respawning"
        Respawning.Parent = game.CoreGui
         
         
         
         
        function StatRespawn(inputObject, gameProcessedEvent)
            if respawngodmode == true and gameProcessedEvent == false then        
        stationaryrespawn = not stationaryrespawn
            end
        end
         
         
         
         
         
         
        game:GetService("UserInputService").InputBegan:connect(StatRespawn)
         
         
         
        game:GetService('RunService').Stepped:connect(function()
         
         
        if stationaryrespawn == false and game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
        if haspos == false then
        pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        haspos = true
        end
         
        needsrespawning = true
        end
         
         
        if needsrespawning == true then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
        end
         
         
        if stationaryrespawn == false then 
        RespawningButton.Text = "Returning"
        else
        RespawningButton.Text = "Not Returning"
        end
         
         
        end)
         
        game.Players.LocalPlayer.CharacterAdded:connect(function()
        wait(0.6)
        needsrespawning = false
        haspos = false
        end)
         
        game.Players.LocalPlayer.CharacterAdded:connect(function()
        wait(0.6)
        needsrespawning = false
        haspos = false
        end)
         
        game.Players.LocalPlayer.CharacterAdded:connect(function()
        wait(0.6)
        needsrespawning = false
        haspos = false
        end)
    else
        respawngodmode = false
    end
end)

--ESP [Players/Killers]
local ESPSection = Player:NewSection("ESP")
ESPSection:NewToggle("Players ESP", "The ability to see players through walls!", function(state)
    if state then
    players = true
    while players == true do
    local function esp(player)
        local b = Instance.new("BoxHandleAdornment", player)
        b.AlwaysOnTop = true
        b.ZIndex = 5
        b.Size = player.Size
        b.Adornee = player
        b.Transparency = 0.6
        b.Color3 = Color3.fromRGB(0, 155, 255)
    end

    function Main(Esp)
        for i, v in pairs(Esp:GetChildren()) do
            if v:IsA("BasePart") and not v:FindFirstChild("BoxHandleAdornment") then
                esp(v)
            end
        end
    end
for i, v in pairs(game.Workspace:GetDescendants()) do
    pcall(
        function()
            if v:FindFirstChild("Humanoid") and v.Parent.Name == "Characters to kill" and v.Name ~= game.Players.LocalPlayer.Name then
            Main(v)
            end
        end)
    end
    wait(1)
end
    else
        players = false
        for i, v in pairs(game:GetService("Workspace")["Characters to kill"]:GetDescendants()) do
            if v:IsA("BoxHandleAdornment") then
                v:Destroy()
            end
        end
    end
end)

ESPSection:NewToggle("Killers ESP", "The ability to see killers through walls!", function(state)
    if state then
    killeresp = true
    while killeresp == true do
    local function esp(player)
        local b = Instance.new("BoxHandleAdornment", player)
        b.AlwaysOnTop = true
        b.ZIndex = 5
        b.Size = player.Size
        b.Adornee = player
        b.Transparency = 0.6
        b.Color3 = Color3.fromRGB(200, 0, 0)
    end

    function Main(Esp)
        for i, v in pairs(Esp:GetChildren()) do
            if v:IsA("BasePart") and not v:FindFirstChild("BoxHandleAdornment") then
                esp(v)
            end
        end
    end
for i, v in pairs(game.Workspace:GetDescendants()) do
    pcall(
        function()
            if v:FindFirstChild("Humanoid") and v.Parent.Name == "Killers" and v.Name ~= game.Players.LocalPlayer.Name then
            Main(v)
            end
        end)
    end
    wait(1)
end
    else
        killeresp = false
        for i, v in pairs(game:GetService("Workspace")["Killers"]:GetDescendants()) do
            if v:IsA("BoxHandleAdornment") then
                v:Destroy()
            end
        end
    end
end)
--Other[Player]
local OtherPlayerSection = Player:NewSection("Other")
OtherPlayerSection:NewButton("Morph zombie", "Zombie morph, boo!", function()
    oldpositionzombiemorh = game:GetService("Workspace").AREA51.Outside.Hangar.Right["Zombie Morph"].TheButton.CFrame
    game:GetService("Workspace").AREA51.Outside.Hangar.Right["Zombie Morph"].TheButton.CanCollide = false
    game:GetService("Workspace").AREA51.Outside.Hangar.Right["Zombie Morph"].TheButton.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
    wait(0.1)
    game:GetService("Workspace").AREA51.Outside.Hangar.Right["Zombie Morph"].TheButton.CanCollide = true
    game:GetService("Workspace").AREA51.Outside.Hangar.Right["Zombie Morph"].TheButton.CFrame = oldpositionzombiemorh
end)

OtherPlayerSection:NewButton("Delete tool", "An item that can remove anything!", function()
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local backpack = localPlayer:WaitForChild("Backpack")
local tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.CanBeDropped = false
tool.Parent = backpack
tool.Name = "Delete"
tool.Equipped:Connect(function(mouse)
mouse.Button1Down:Connect(function()
if mouse.Target and mouse.Target.Parent then
mouse.Target.Transparency = 1
mouse.Target.CanCollide = false
mouse.Target.Anchored = false
mouse.Target.Size  = Vector3.new(0,0,0)
end
end)
end)
end)

OtherPlayerSection:NewButton("Get papers", "Get all 3 papers!", function()
    --papers
    local Paper1 = game:GetService("Workspace").AREA51.RadioactiveArea.Floor1.Paper
    local Paper2 = game:GetService("Workspace").AREA51.YellowBedRoom.Buro.Paper
    local Paper3 = game:GetService("Workspace").AREA51.MeetingRoom.DeadGuy.Paper
    --OldPos
    local pos1paper = Paper1.CFrame
    local pos2paper = Paper2.CFrame
    local pos3paper = Paper3.CFrame
    --DisableCollision
    Paper1.CanCollide = false
    Paper2.CanCollide = false
    Paper3.CanCollide = false
    --TPPlayer
    Paper1.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame --Paper1
    Paper2.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame -- Paper2
    Paper3.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame -- Paper3
    --Wait and old position
    wait(0.1)
    Paper1.CFrame = pos1paper
    Paper2.CFrame = pos2paper
    Paper3.CFrame = pos3paper
end)

----GUNS
local Guns = Window:NewTab("Guns")
local AssaultRifle = Guns:NewSection("Assault rifle")
--[AssaultRifle]
AssaultRifle:NewButton("AK-47", "Give AK-47", function()
    local gun = game:GetService("Workspace").AREA51["AK-47"]["AK-47 Giver"]["PUT THE WEAPON IN THIS BRICK"]
	local oldpos = gun.CFrame
	gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	gun.CanCollide = false
	wait()
	gun.CFrame = oldpos
	gun.CanCollide = true
end)

AssaultRifle:NewButton("G36C", "Give G36C", function()
	local gun = game:GetService("Workspace").AREA51["G36C"]["G36C Giver"]["PUT THE WEAPON IN THIS BRICK"]
	local oldpos = gun.CFrame
	gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	gun.CanCollide = false
	wait()
	gun.CFrame = oldpos
	gun.CanCollide = true
end)

AssaultRifle:NewButton("M16A2", "Give M16A2", function()
	local gun = game:GetService("Workspace").AREA51["M16A2/M203"]["M16A2/M203 Giver"]["PUT THE WEAPON IN THIS BRICK"]
	local oldpos = gun.CFrame
	gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	gun.CanCollide = false
	wait()
	gun.CFrame = oldpos
	gun.CanCollide = true
end)

AssaultRifle:NewButton("M4A1", "Give M4A1", function()
	local gun = game:GetService("Workspace").AREA51["M4A1"]["M4A1 Giver"]["PUT THE WEAPON IN THIS BRICK"]
	local oldpos = gun.CFrame
	gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	gun.CanCollide = false
	wait()
	gun.CFrame = oldpos
	gun.CanCollide = true
end)
--End[AssaultRifle]



--SniperRifles
local SniperRifles = Guns:NewSection("Sniper Rifles")
SniperRifles:NewButton("AWP", "Give AWP", function()
    local gun = game:GetService("Workspace").AREA51["AWP"]["AWP Giver"]["PUT THE WEAPON IN THIS BRICK"]
    local oldpos = gun.CFrame
    gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    gun.CanCollide = false
    wait()
    gun.CFrame = oldpos
    gun.CanCollide = true
end)

SniperRifles:NewButton("SVD", "Give SVD", function()
	local gun = game:GetService("Workspace").AREA51["SVD"]["SVDGiver"]["PUT THE WEAPON IN THIS BRICK"]
	local oldpos = gun.CFrame
	gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	gun.CanCollide = false
	wait()
	gun.CFrame = oldpos
	gun.CanCollide = true
end)
--End[SniperRifles]



--SMG
local SMG = Guns:NewSection("SMG")
SMG:NewButton("MP5k", "Give MP5k", function()
	local gun = game:GetService("Workspace").AREA51["MP5k"]["MP5k Giver"]["PUT THE WEAPON IN THIS BRICK"]
	local oldpos = gun.CFrame
	gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	gun.CanCollide = false
	wait()
	gun.CFrame = oldpos
	gun.CanCollide = true
end)
--End[SMG]



--Shotguns
local Shotguns = Guns:NewSection("Shotguns")
Shotguns:NewButton("M1014", "Give M1014", function()
	local gun = game:GetService("Workspace").AREA51["M1014"]["M1014 Giver"]["PUT THE WEAPON IN THIS BRICK"]
	local oldpos = gun.CFrame
	gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	gun.CanCollide = false
    wait()
	gun.CFrame = oldpos
	gun.CanCollide = true
end)

Shotguns:NewButton("R870", "Give R870", function()
	local gun = game:GetService("Workspace").AREA51["R870"]["R870 Giver"]["PUT THE WEAPON IN THIS BRICK"]
	local oldpos = gun.CFrame
	gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	gun.CanCollide = false
	wait()
	gun.CFrame = oldpos
	gun.CanCollide = true
end)
--End[Shotguns]



--Pistols
local Pistols = Guns:NewSection("Pistols")
Pistols:NewButton("Desert Eagle", "Give Desert Eagle", function()
	local gun = game:GetService("Workspace").AREA51["Desert Eagle"]["Desert Eagle Giver"]["PUT THE WEAPON IN THIS BRICK"]
	local oldpos = gun.CFrame
	gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	gun.CanCollide = false
	wait()
	gun.CFrame = oldpos
	gun.CanCollide = true
end)

Pistols:NewButton("M1911", "Give M1911", function()
	local gun = game:GetService("Workspace").AREA51["M1911"]["M1911 Giver"]["PUT THE WEAPON IN THIS BRICK"]
	local oldpos = gun.CFrame
	gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	gun.CanCollide = false
	wait()
	gun.CFrame = oldpos
	gun.CanCollide = true
end)

local OtherGuns = Guns:NewSection("Other")
OtherGuns:NewButton("RayGun", "Give RayGun", function()
	local gun = game:GetService("Workspace").AREA51["RayGun"]["RayGun Giver"]["PUT THE WEAPON IN THIS BRICK"]
	local oldpos = gun.CFrame
	gun.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	gun.CanCollide = false
	wait()
	gun.CFrame = oldpos
	gun.CanCollide = true
end)

OtherGuns:NewButton("Get all guns", "Get all the guns that are on the map!", function()
	local descendants = workspace:GetDescendants()
	for i, descendant in pairs(descendants) do
		if string.find(descendant.Name, "PUT THE WEAPON IN") then
			local oldpos = descendant.CFrame
			descendant.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			descendant.CanCollide = false
			wait()
			descendant.CFrame = oldpos
			descendant.CanCollide = true
		end
	end
end)
--End[Guns]



----TELEPORTS
local TeleportTab = Window:NewTab("Teleport")
--TeleportsMain
local TPMain = TeleportTab:NewSection("Teleports")
TPMain:NewButton("Ammo", "Instant teleport to the specified location!", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(184,311,437))
end)

TPMain:NewButton("Armory", "Instant teleport to the specified location!", function()
	local x = -133
	local y = 313
	local z = 281
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z)) --armory
end)

TPMain:NewButton("Armory 2", "Instant teleport to the specified location!", function()
    local x = -161
	local y = 294
	local z = 316
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z)) --armory2
end)

TPMain:NewButton("Camera", "Instant teleport to the specified location!", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(91.2,314,172.4))
end)

TPMain:NewButton("Military car", "Instant teleport to the specified location!", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(380.048,517.5,296.642))
end)

TPMain:NewButton("First door", "Instant teleport to the specified location!", function()
	local x = 334.87
	local y = 313.5
	local z = 370.47
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z)) --firstdoor
end)

TPMain:NewButton("Jail cells", "Instant teleport to the specified location!", function()
	local x = 97.7
	local y = 291.5
	local z = 241.4
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z))
end)

TPMain:NewButton("Kitchen", "Instant teleport to the specified location!", function()
	local x = 295.2
	local y = 314.3
	local z = 285.6
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z))
end)

TPMain:NewButton("Lock room", "Instant teleport to the specified location!", function()
    local x = 21.4
	local y = 313.5
	local z = 202.5
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z))
end)

TPMain:NewButton("Office", "Instant teleport to the specified location!", function()
	local x = -7
	local y = 293
	local z = 291
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z)) --office
end)

TPMain:NewButton("Pick a punch", "Instant teleport to the specified location!", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(281,325.5,784))
end)

TPMain:NewButton("Spawn", "Instant teleport to the specified location!", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(320,511,392))
end)

TPMain:NewButton("Spawn 2", "Instant teleport to the specified location!", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(259, 511.5, 331.488922))
end)

TPMain:NewButton("Spawn 3", "Instant teleport to the specified location!", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(181.23,511.5,419.228))
end)

TPMain:NewButton("Hangar", "Instant teleport to the specified location!", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(441.19,512.5,425.27))
end)

TPMain:NewButton("Hangar 2", "Instant teleport to the specified location!", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(447.19,512.5,334.106))
end)

TPMain:NewButton("UFO", "Instant teleport to the specified location!", function()
	local x = 15
	local y = 313.4
	local z = 451.7
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z)) --UFO
end)

TPMain:NewButton("Big boy", "Instant teleport to the specified location!", function()
	local x = 178
	local y = 314
	local z = 562
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z))
end)

TPMain:NewButton("Teleport room", "Instant teleport to the specified location!", function()
	local x = 111.7
	local y = 313.5
	local z = 26.5
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z))
end)

TPMain:NewButton("Command area", "Instant teleport to the specified location!", function()
	local x = 138.42
	local y = 333.5
	local z = 535.41
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z)) --commandarea)
end)

TPMain:NewButton("Control door", "Instant teleport to the specified location!", function()
    local x = -48
    local y = 314
    local z = 290
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z))
end)
--TeleportsOther
local TPOther = TeleportTab:NewSection("Teleports other")
TPOther:NewButton("Teleport tool", "Create teleport tool!", function()
    mouse = game.Players.LocalPlayer:GetMouse()
    tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Click Teleport"
    tool.Activated:connect(function()
    local pos = mouse.Hit+Vector3.new(0,2.5,0)
    pos = CFrame.new(pos.X,pos.Y,pos.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
end)

TPOther:NewTextBox("Teleport to player", "Instant teleportation to the player you specified!", function(txt)
local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart
local p2 = txt
local pos = p1.CFrame

p1.CFrame = game.Players[p2].Character.HumanoidRootPart.CFrame
end)
--End[Teleports]


----MISC
local MiscTab = Window:NewTab("Misc")
--MiscAmmo
local MiscAmmo = MiscTab:NewSection("Guns")
--[MiscAmmo]
MiscAmmo:NewToggle("InfAmmo", "These bullets will never run out!", function(state)
    if state then
        oldpos = workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].CFrame
        infammo = true
        while infammo == true do
            workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].CanCollide = false
            workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].Transparency = 1
            game:GetService("Workspace").AREA51.PlantRoom["Box of Shells"].Box.Texture.Transparency = 1
            wait()
        end
    else
        infammo = false
        workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].Transparency = 0
        game:GetService("Workspace").AREA51.PlantRoom["Box of Shells"].Box.Texture.Transparency = 0
        workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].CFrame = oldpos
        workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].CanCollide = true
    end
end)

MiscAmmo:NewButton("+Ammo", "Refill your ammo!", function()
    oldpos1 = workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].CFrame
	workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].CanCollide = false
	wait()
	workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].CFrame = oldpos1
	workspace["AREA51"]["PlantRoom"]["Box of Shells"]["Box"].CanCollide = true
end)

MiscAmmo:NewButton("Guns mod", "ButtonInfo", function()
    local Weapon = game:GetService("ReplicatedStorage").Weapon
    Old = hookfunction(require(Weapon).fire, function(p89, p90)
        p89.is_pap = true
        p89.ammo = math.huge
        p89.equip_time = 0
        p89.stored_ammo = math.huge
        p89.max_ammo = math.huge
        p89.max_stored = math.huge
        p89.is_auto = true
        p89.shoot_wait = 0.000000000000000000000000000000000000000001
        p89.inaccuracy = 0
        return Old(p89, p90)
    end)
    Old2 = hookfunction(require(Weapon).play_animation, function(self, AnimName)
        if AnimName == "Fire" then
            local AnimFunc = self.animations[AnimName]
            hookfunction(AnimFunc, function() end)
        end
        return Old2(self, AnimName)
    end)
    function update()
        if require(Weapon).instance == game.Players.LocalPlayer.Character:FindFirstChild("M16A2/M203") then
            local A = require(Weapon["M16A2/M203"].Animations.Fire)
            hookfunction(A[true], function() end)
            hookfunction(A[false], function() end)
        end
    end
    game:GetService("RunService").Stepped:Connect(update)
end)

--MiscHitboxes
local MiscHitboxes= MiscTab:NewSection("Hitboxes")
--[MiscHitboxes]


MiscHitboxes:NewToggle("Killers hitbox", "Increase the hitbox of the head by 4 times!", function(state)
    if state then
    killershitbox = true
	toggle = false
	UIS = game:GetService("UserInputService")
    while killershitbox == true do
        Size = Vector3.new(3.5,3.5,3.5) --Change 2,2,2 to desired head size. Numbers represent (x,y,z).
        toggle = not toggle
        for k,v in next, game:GetService("Workspace")["Killers"]:GetDescendants() do
            if v:FindFirstChild("Head") then
                local Head = v:FindFirstChild("Head")
                Head.Size = Size
                Head.CanCollide = false
                Head.CollisionGroupId = 2
                wait()
            end
        end
    end
    else
        killershitbox = false
        toggle = false
        UIS = game:GetService("UserInputService")
        Size = Vector3.new(2,1,1) --Change 2,2,2 to desired head size. Numbers represent (x,y,z).
                toggle = not toggle
                for k,v in next, game:GetService("Workspace")["Killers"]:GetDescendants() do
                    if v:FindFirstChild("Head") then
                        local Head = v:FindFirstChild("Head")
                        Head.Size = Size
            end
        end
    end
end)

MiscHitboxes:NewToggle("Players hitbox", "Increase the hitbox of the head by 15 times!", function(state)
    if state then
        _G.HeadSize = 35
        _G.Disabled = true
        
        game:GetService('RunService').RenderStepped:connect(function()
        if _G.Disabled then
        for i,v in next, game:GetService('Players'):GetPlayers() do
        if v.Name ~= game:GetService('Players').LocalPlayer.Name then
        pcall(function()
        v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
        v.Character.HumanoidRootPart.Transparency = 0.5
        v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
        v.Character.HumanoidRootPart.Material = "Neon"
        v.Character.HumanoidRootPart.CanCollide = false
        end)
        end
        end
        end
        end)
    else
        _G.HeadSize = 2
        _G.Disabled = false
        
        game:GetService('RunService').RenderStepped:connect(function()
        if _G.Disabled == false then
        for i,v in next, game:GetService('Players'):GetPlayers() do
        if v.Name ~= game:GetService('Players').LocalPlayer.Name then
        pcall(function()
        v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
        v.Character.HumanoidRootPart.Transparency = 1
        end)
        end
        end
        end
        end)
    end
end)

--MiscGUI
local MiscGUI= MiscTab:NewSection("GUI")
--[MiscGUI]
MiscGUI:NewToggle("Pick a punch GUI", "Upgrade weapons at a distance!", function(state)
    if state then
        game:GetService("Players").LocalPlayer.PlayerGui.PAP.Frame.Visible = true
        wait()
    else
        game:GetService("Players").LocalPlayer.PlayerGui.PAP.Frame.Visible = false
        wait()
    end
end)

MiscGUI:NewButton("Camera GUI", "Check your camera without going anywhere!", function()
    OldCameraPos = game:GetService("Workspace")["Surveillance Cameras"].Triggers.Seat.CFrame
    game:GetService("Workspace")["Surveillance Cameras"].Triggers.Seat.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local uis = Game:GetService("UserInputService")
    uis.InputBegan:connect(function(inst)
        if inst.KeyCode == Enum.KeyCode.Space then
            wait(0.5)
            game:GetService("Workspace")["Surveillance Cameras"].Triggers.Seat.CFrame = OldCameraPos
        end
    end)
end)
--MiscMap
local MiscMap= MiscTab:NewSection("Map")
--[MicsMap]
MiscMap:NewToggle("No collison doors", "Disable door collision!", function(state)
    if state then
        game:GetService("Workspace").AREA51.Doors.Vertical.EntranceOfArea.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToComptersRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ComputersRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.TrainRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToRayGunElevatorRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToMultipleRooms.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToCartons.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.CartonsRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.TrapRoomRight.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.TrapRoomLeft.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToRadioactive.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToMedicAndMeet.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.TeleporterRoomRight.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.TeleporterRoomLeft.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToSurveillanceCams.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToTeleporterLeft.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToTeleporterRight.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToNewRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToJails.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToMultiDirectionRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.CleanersPower.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.EntranceFrontPipesRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.EntranceRightPipesRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.PipeEntrance.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.MiddlePipesLeft.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.MiddlePipesRight.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.FoddSupply.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.PipesRange.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToElavator.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.ToWasteFromAbove.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Vertical.PathwayPipe.Door.Door.CanCollide = false   
        --Horizontal
        --[Collision]
        game:GetService("Workspace").AREA51.Doors.Horizontal.ComputersRoomRight.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ComputersRoomLeft.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToTrainRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToAlienRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.RobotsRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.UFORoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ElectricityRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToMenageRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.AlienRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToNewRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToOtherNewRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToUndergroundRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToExperimentRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ExperimentDoor.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.SmallTrapRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToDeadOffice.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.DeadOffice.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.Armory1Room.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.Armory2Room.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToOfficeRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToComputingRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToCardOffice.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToRestRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToCoockingRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.CleanerTwo.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.EntranceBackPipesRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.PrototypRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.SewerVault.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToMainSewers.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToSewerCentreLeft.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToSewerCentreRight.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.WasteRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.AWPRoom.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToPipes.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToCostumes.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.WasteFromMenage.Door.Door.CanCollide = false
        game:GetService("Workspace").AREA51.Doors.Horizontal.ToPlantRoom.Door.Door.CanCollide = false
--[Other Doors]
game:GetService("Workspace").AREA51.ExecutionRoom.Door.Door.Door.CanCollide = false
game:GetService("Workspace").AREA51.SewerVaultRoom.VaultDoor.Door.Door.CanCollide = false
game:GetService("Workspace").AREA51.JailsRoom.RotateDoor.Door.Door.CanCollide = false
game:GetService("Workspace").AREA51.JailsRoom.RotateDoor.Door.Door.CanCollide = false
game:GetService("Workspace").AREA51.JailsRoom.RotateDoor.Door.Door.CanCollide = false
game:GetService("Workspace").AREA51.JailsRoom.RotateDoor.Door.Door.CanCollide = false
    else
--Verticals
--[Collision]
game:GetService("Workspace").AREA51.Doors.Vertical.EntranceOfArea.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToComptersRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ComputersRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.TrainRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToRayGunElevatorRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToMultipleRooms.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToCartons.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.CartonsRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.TrapRoomRight.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.TrapRoomLeft.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToRadioactive.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToMedicAndMeet.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.TeleporterRoomRight.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.TeleporterRoomLeft.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToSurveillanceCams.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToTeleporterLeft.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToTeleporterRight.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToNewRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToJails.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToMultiDirectionRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.CleanersPower.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.EntranceFrontPipesRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.EntranceRightPipesRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.PipeEntrance.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.MiddlePipesLeft.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.MiddlePipesRight.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.FoddSupply.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.PipesRange.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToElavator.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.ToWasteFromAbove.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Vertical.PathwayPipe.Door.Door.CanCollide = true
--Horizontal
--[Collision]
game:GetService("Workspace").AREA51.Doors.Horizontal.ComputersRoomRight.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ComputersRoomLeft.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToTrainRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToAlienRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.RobotsRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.UFORoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ElectricityRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToMenageRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.AlienRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToNewRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToOtherNewRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToUndergroundRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToExperimentRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ExperimentDoor.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.SmallTrapRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToDeadOffice.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.DeadOffice.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.Armory1Room.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.Armory2Room.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToOfficeRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToComputingRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToCardOffice.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToRestRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToCoockingRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.CleanerTwo.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.EntranceBackPipesRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.PrototypRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.SewerVault.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToMainSewers.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToSewerCentreLeft.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToSewerCentreRight.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.WasteRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.AWPRoom.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToPipes.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToCostumes.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.WasteFromMenage.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.Doors.Horizontal.ToPlantRoom.Door.Door.CanCollide = true
--[Other Doors]
game:GetService("Workspace").AREA51.ExecutionRoom.Door.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.SewerVaultRoom.VaultDoor.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.JailsRoom.RotateDoor.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.JailsRoom.RotateDoor.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.JailsRoom.RotateDoor.Door.Door.CanCollide = true
game:GetService("Workspace").AREA51.JailsRoom.RotateDoor.Door.Door.CanCollide = true
    end
end)

MiscMap:NewToggle("No fog", "Disabling and enabling fog!", function(state)
    if state then
        fogmodifed = true
        fogdefault1 = game:GetService("Lighting").FogEnd
        fogdefault2 = game:GetService("Lighting").ClockTime
        fogdefault3 = game:GetService("Lighting").Brightness
        while fogmodifed == true do
            game:GetService("Lighting").FogEnd = 1000000
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").Brightness = 1.25
            wait()
        end
    else
        fogmodifed = false
        game:GetService("Lighting").FogEnd = fogdefault1
        game:GetService("Lighting").ClockTime = fogdefault2
        game:GetService("Lighting").Brightnes = fogdefault3
        end
    end)

MiscMap:NewToggle("Close doors (Spam)", "Sometimes you have to keep the doors always close!", function(state)
    if state then
        closespam = true
        while closespam == true do
        wait(0.2)
        for _,t in pairs(workspace.AREA51.Doors:GetDescendants()) do 
            if t:IsA'ClickDetector' and t.Parent.Name == 'Close' then 
                fireclickdetector(t)
            end
        end
    end
    else
        closespam = false
    end
end)

MiscMap:NewToggle("Open doors (Spam)", "Sometimes you have to keep the doors always open!", function(state)
if state then
    openspam = true
    while openspam == true do
    wait(0.2)
    for _,t in pairs(workspace.AREA51.Doors:GetDescendants()) do 
        if t:IsA'ClickDetector' and t.Parent.Name == 'Open' then 
            fireclickdetector(t)
        end
    end
end
else
    openspam = false
end
end)

MiscMap:NewButton("Remove toxic parts", "Removes all toxic / killable parts!", function()
    workspace["AREA51"]["RadioactiveArea"]["Entrance"]:Destroy()
    workspace["AREA51"]["TrashGrindRoom"]["Spinner"]["Kill"]:Destroy()
    workspace["AREA51"]["CentralSewerRoom"]["Spinner"]["Kill"]:Destroy()
    workspace["AREA51"]["SewerCaptainRoom"]["Spinner"]["Kill"]:Destroy()
    workspace.AREA51.WasteRoom["Polluted Water"]:Destroy()
    workspace.AREA51.CleanerTwoRoom["Polluted Water"]["Polluted Water"]:Destroy()
end)

----INFO
local Info = Window:NewTab("Credits")
local NameUI = Info:NewSection("Use UI: KavoUI")
local Developer = Info:NewSection("Developer: d3xl#3330")
local Helper = Info:NewSection("Helper: wzxl1q#0229")
local Version = Info:NewSection("Version: 2.2")
--[Hide/Show GUI]
local Info = Info:NewSection("UI Customization")
Info:NewKeybind("Hide/Show GUI", "Hide/Show change keybind", Enum.KeyCode.X, function()
	Library:ToggleUI()
end)
--End[INFO]


----BypassWalkSpeed
local gmt = getrawmetatable(game)
local oldIndex = gmt.__index
setreadonly(gmt, false)

gmt.__index = newcclosure(function(Self,Key)
	if tostring(Self) == "Humanoid" and tostring(Key) == "WalkSpeed" then
		return
	end
	return oldIndex(Self,Key)
end)

setreadonly(gmt, true)
--End[BypassWalkSpeed]
--PrintLoad
print("AreaFucker")
print("Current version: 2.2")
print("Mode: Killer")
--EndAll