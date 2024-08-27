--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
Chess_Client
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔


Notes:
- 
]]

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
SERVICES AND IMPORTANT PATHS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

--------------------------------------------------------------------------------------------------------------------------
--[[SERVICES:]]--

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
--------------------------------------------------------------------------------------------------------------------------

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

--------------------------------------------------------------------------------------------------------------------------

local Chess_Module = require(script.Parent.Chess_Module)
local Piece = Chess_Module.Data.Piece
--print(Piece)

--------------------------------------------------------------------------------------------------------------------------

local Debug_BoardGui = PlayerGui:WaitForChild("DebugBoardGui")
local Debug_BoardMainFrame = Debug_BoardGui.BoardMainFrame

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
CONFIG:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]


local TileImageConfig = {
    
}
--------------------------------------------------------------------------------------------------------------------------

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
ChessGame_Client CLASS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

---@class ChessGame_Client
---Class which represents the chess game on the client side.
local ChessGame_Client = {}
ChessGame_Client.__index = ChessGame_Client

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Creates a new ChessGame array/object
---@param NewBoardParams table Array containing the desired info and properties for the chess game.
---@return table NewChessGui The newlly created GuiBoard.
function ChessGame_Client.new(NewBoardParams)
    local NewGame = setmetatable(NewBoardParams or {}, ChessGame_Client)

    --------------------------------------------------------------------------------------------------------------------------
    --[[CONFIG HANDLING:]]--
    
    --[[ BoardFrame config: ]]--

    ---@type number
    ---The value used for the UIStroke of the BoardFrame to give it it's border.
    NewGame.BoardFrame_StrokeThickness = NewGame.BoardFrame_StrokeThickness or 5

    ---@type Color3
    ---The "background" color of the gui chess game.
    NewGame.BoardFrame_Color = NewGame.BoardFrame_Color or Color3.new(0.137254, 0.137254, 0.254901)

    ---@type number
    ---The value to apply to the Transparency property of the background of the gui board (aka.: BoardFrame).
    NewGame.BoardFrame_Transparency = NewGame.BoardFrame_Transparency or 0

    --[[ TileFrame config: ]]--

    ---@type UDim
    ---Value used for the CornerRadius property of the UICorner for each of the Gui tiles (TileFrame(s)) of the board.
    NewGame.TileFrame_CornerRadius = NewGame.TileFrameCornerRadius or UDim.new(0.1, 0)

    ---@type number
    --[[Represents for much of the alocated space for each Gui tile will be used for the Tileframe it self.
    A value of 1 alocates the maximum amount of space for the tile leaving no space in between tiles,
    while a value of 0.5 (for the sake of example) would alocate half of the avalible space for the tile, leaving quite a large space in between tiles.]]
    NewGame.TileFrame_Size = NewGame.TileFrameSize or 0.9

    ---@type Color3
    ---The Color to apply to white/light gui tiles.
    NewGame.TileFrame_LightColor = NewGame.TileFrame_LightColor or Color3.new(1, 1, 1)

    ---@type Color3
    ---The Color to apply to white/light gui tiles.
    NewGame.TileFrame_DarkColor = NewGame.TileFrame_DarkColor or Color3.new(0.5, 0.5, 0.5)

    ---@type number
    ---The transparency value to apply to the gui tiles (TileFrames(s)) of the board.
    NewGame.TileFrame_Transparency = NewGame.TileFrame_Transparency or 0.7

    ---@type Color3
    ---The color of the text that displays each tile's coordinates (example A1, C5, H8... etc)
    NewGame.TileFrame_TextColor = NewGame.TileFrame_TextColor or Color3.new(1, 1, 1)

    --[[ HighLightFrame config: ]]--

    ---@type string
    ---The rbxassetid of the image to apply to the HilightFrame (Used when displaying an obstructed move)
    NewGame.HighLightFrame_ImageId = NewGame.HighLightFrame_ImageId or "rbxassetid://123813851949107"

    ---@type number
    ---The Transparency value to use for the Gui tile highlights
    NewGame.HighlightFrame_Transparency = NewGame.HighlightFrame_Transparency or 0.5

    ---@type number
    ---The Thickness value to apply to the HighLightFrame UIStroke when required.
    NewGame.HighlightFrame_StrokeThickness = NewGame.HighlightFrame_StrokeThickness or 3

    ---@type table
    ---Array containing the colors to apply to the gui tile highlight for each highlight type.
    NewGame.HighlightFrame_Colors = NewGame.HighlightFrame_Colors or {}
    NewGame.HighlightFrame_Colors.Default = NewGame.HighlightFrame_Colors.Debug or Color3.new(1, 1, 1)
    NewGame.HighlightFrame_Colors.Hover = NewGame.HighlightFrame_Colors.Hover or Color3.new(1,1,1)
    NewGame.HighlightFrame_Colors.Move_Possible = NewGame.HighlightFrame_Colors.Move_Possible or Color3.new(0.9, 0.75, 0.5)
    NewGame.HighlightFrame_Colors.Move_Obstructed = NewGame.HighlightFrame_Colors.Move_Obstructed or NewGame.HighlightFrame_Colors.Move_Possible
    NewGame.HighlightFrame_Colors.Move_Capture = NewGame.HighlightFrame_Colors.Move_Capture or Color3.new(1, 0.6, 0.4)


    --------------------------------------------------------------------------------------------------------------------------
    --[[OBJECT(s) AND INSTANCE(s) HANDLING:]]--

    ---@type Piece
    ---Which piece color the LocalPlayer is playing as.
    NewGame.PlayerColor = NewGame.PlayerColor or Piece.White
    
    ---@type ScreenGui
    ---The ScreenGui where the 2D board is placed.
    NewGame.ScreenGui = NewGame.ScreenGui or NewGame:CreateScreenGui()
    
    ---@type Frame
    ---The MainFrame used to position the 2D board.
    NewGame.MainFrame = NewGame.MainFrame or NewGame:CreateMainFrame()

    NewGame.BoardFrame = NewGame.BoardFrame or NewGame:CreateBoardFrame()

    ---@type number
    ---How many files/ranks the board has, only square board supported.
    NewGame.BoardSize = NewGame.BoardSize or 8
   
    ---@type table
    ---Array that stores the matrix of the board.
    NewGame.BoardMatrix = NewGame.BoardMatrix or {}
    local BoardMatrix = NewGame.BoardMatrix

    for File = 1, NewGame.BoardSize, 1 do
        
        ---@type table
        ---Array(s) that store each files(a-h) of the board.
        BoardMatrix[File] = BoardMatrix[File] or {}

        for Rank = 1, NewGame.BoardSize, 1 do
            
            ---@type table
            ---Array(s) that store the Tiles of the board.
            BoardMatrix[File][Rank] = BoardMatrix[File][Rank] or {}
            local GameTile = BoardMatrix[File][Rank]
            
            ---@type Piece
            ---What piece is curentlly stored in that tile.
            GameTile.Piece = GameTile.Piece or Piece.None

            ---@type ImageButton
            ---The Gui Frame(s) of the tile(s).
            GameTile.TileFrame = GameTile.Frame or NewGame:CreateTileFrame(File, Rank)

            GameTile.TileFrame.MouseEnter:Connect(function()
                NewGame:MouseEnterTile(File, Rank)
            end)

        end
    end

    return NewGame
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
function ChessGame_Client:Create(Object)
    
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Creates a new ScreenGui for the Chess game.
---@return ScreenGui ScreenGui The newlly created Screengui.
function ChessGame_Client:CreateScreenGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ChessGui"
    ScreenGui.Parent = Player.PlayerGui
    return ScreenGui
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---creates a new Mainframe inside the board's ScreenGui.
---@return Frame MainFrame The frame used to place the BoardGui
function ChessGame_Client:CreateMainFrame()
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(1, 0, 0.8, 0)
    MainFrame.BackgroundTransparency = 1
    MainFrame.Parent = self.ScreenGui
    return MainFrame
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Creates the BoardFrame of the 2d board aka: The background frame.
---@return Frame Boardframe The "background" frame of the 2D chessboard.
function ChessGame_Client:CreateBoardFrame()
    local BoardFrame = Instance.new("Frame")
    BoardFrame.Name = "BoardFrame"
    BoardFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    BoardFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    BoardFrame.Size = UDim2.new(1, 0, 1, 0)
    BoardFrame.BackgroundColor3 = self.BoardFrame_Color
    BoardFrame.BackgroundTransparency = self.BoardFrame_Transparency

    local BoardFrameARConstraint = Instance.new("UIAspectRatioConstraint")
    BoardFrameARConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    BoardFrameARConstraint.Parent = BoardFrame

    local BoardUICorner = Instance.new("UICorner")
    BoardUICorner.CornerRadius = UDim.new(0, 10)
    BoardUICorner.Parent = BoardFrame

    local BoardUIStroke = Instance.new("UIStroke")
    BoardUIStroke.Thickness = self.BoardFrame_StrokeThickness
    BoardUIStroke.Color = self.BoardFrame_Color
    BoardUIStroke.Transparency = self.BoardFrame_Transparency
    BoardUIStroke.Parent = BoardFrame
    
    BoardFrame.Parent = self.MainFrame
    return BoardFrame
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Creates a new GuiTile at the specified board cordinates.
---@param File any
---@param Rank any
---@return any
function ChessGame_Client:CreateTileFrame(File, Rank)

    local TileFrame = Instance.new("ImageButton")
    TileFrame.Name = "TileFrame"
    TileFrame.AnchorPoint = Vector2.new(0.5,0.5)
    TileFrame.Size = UDim2.new(1/self.BoardSize*self.TileFrame_Size, 0, 1/self.BoardSize*self.TileFrame_Size, 0)

    local NewTileXPosition
    local NewTileYPosition
    if self.PlayerColor == Piece.White then 
        NewTileXPosition = 1/self.BoardSize*File-1/self.BoardSize/2
        NewTileYPosition = 1-(1/self.BoardSize*Rank-1/self.BoardSize/2)
    elseif self.PlayerColor == Piece.Black then
        NewTileXPosition = 1-(1/self.BoardSize*File-1/self.BoardSize/2)
        NewTileYPosition = 1/self.BoardSize*Rank-1/self.BoardSize/2
    end
    TileFrame.Position = UDim2.new(NewTileXPosition, 0, NewTileYPosition, 0)

    if (File + Rank) % 2 == 0 then
        TileFrame.BackgroundColor3 = self.TileFrame_DarkColor
    else
        TileFrame.BackgroundColor3 = self.TileFrame_LightColor
    end
    TileFrame.BackgroundTransparency = self.TileFrame_Transparency
    TileFrame:SetAttribute("Coordinate", Vector2.new(File,Rank))

    TileFrame.ImageTransparency = 1

    local TileLabel = Instance.new("TextLabel")
    TileLabel.Text = string.upper(Chess_Module.Data.Alphabet[File])..tostring(Rank)
    TileLabel.TextColor3 = self.TileFrame_TextColor
    TileLabel.TextTransparency = 0.7
    TileLabel.TextXAlignment = Enum.TextXAlignment.Left
    TileLabel.TextYAlignment = Enum.TextYAlignment.Top
    TileLabel.TextScaled = true
    TileLabel.Size = UDim2.new(1, 0, 0.2, 0)
    TileLabel.AnchorPoint = Vector2.new(0, 0)
    TileLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
    TileLabel.BackgroundTransparency = 1
    TileLabel.Parent = TileFrame

    local HighlightFrame = Instance.new("ImageLabel")
    HighlightFrame.Name = "HighlightFrame"
    HighlightFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    HighlightFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    HighlightFrame.Size = UDim2.new(1, 0, 1, 0)
    HighlightFrame.ZIndex = 100
    HighlightFrame.BackgroundTransparency = 1
    HighlightFrame.Image = self.HighLightFrame_ImageId
    HighlightFrame.ImageTransparency = 1
    HighlightFrame.Parent = TileFrame

    local NewTileUICorner = Instance.new("UICorner")
    NewTileUICorner.CornerRadius = self.TileFrame_CornerRadius
    NewTileUICorner.Parent = TileFrame

    local HighlightframeUICorner = Instance.new("UICorner")
    HighlightframeUICorner.CornerRadius = self.TileFrame_CornerRadius
    HighlightframeUICorner.Parent = HighlightFrame

    local NewTileUIStroke = Instance.new("UIStroke")
    NewTileUIStroke.Thickness = 0
    NewTileUIStroke.Transparency = 1
    NewTileUIStroke.Parent = HighlightFrame

    TileFrame.Parent = self.BoardFrame

    return TileFrame
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
function ChessGame_Client:MouseEnterTile(File, Rank)
    self.CurrentHover2dTile = self.BoardMatrix[File][Rank].TileFrame
    local GameTile = self.BoardMatrix[File][Rank]
    local TileFrame = GameTile.TileFrame

    local GeneralTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

    self:Highlight2dTile(File, Rank, true, "Hover")

    if GameTile.PieceImage then
        local PieceImage = GameTile.PieceImage
        local PieceImageTween = TweenService:Create(PieceImage, GeneralTweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
        PieceImageTween:Play()
    end
    
    local PieceMoves
    if GameTile.Piece ~= Piece.None then
        PieceMoves = Chess_Module.GetPieceMoves(File, Rank, self.BoardMatrix)
        for MoveFile, MoveFileValue in pairs(PieceMoves) do
            for MoveRank, MoveType in pairs(MoveFileValue) do
                self:Highlight2dTile(MoveFile, MoveRank, true, MoveType)
            end
        end
    end
    --------------------------------------------------------------------------------------------------------------------------
    
    TileFrame.MouseLeave:Connect(function()
        self:Highlight2dTile(File, Rank, false)

        if PieceMoves then
            for MoveFile, MoveFileValue in pairs(PieceMoves) do
                for MoveRank, MoveType in pairs(MoveFileValue) do
                    self:Highlight2dTile(MoveFile, MoveRank, false)
                end
            end
        end
        if GameTile.PieceImage then
            local PieceImage = GameTile.PieceImage
            local PieceImageTween = TweenService:Create(PieceImage, GeneralTweenInfo, {Size = UDim2.new(0.9, 0, 0.9, 0)})
            PieceImageTween:Play()
        end

    end)

end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Highlights the gui tile using the HighLightFrame
---@param File number
---@param Rank number
---@param Value boolean Determines if the highlight should be turned on or off
---@param Type string The key used to identify what type of highlight to apply (Not required if Value = false)
function ChessGame_Client:Highlight2dTile(File, Rank, Value, Type)
    local GameTile = self.BoardMatrix[File][Rank]
    local HighlightFrame = GameTile.TileFrame.HighlightFrame
    local GeneralTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    local FrameTween, StrokeTween
    if Value == false then
        FrameTween = TweenService:Create(HighlightFrame, GeneralTweenInfo, {BackgroundTransparency = 1, ImageTransparency = 1})
        StrokeTween = TweenService:Create(HighlightFrame.UIStroke, GeneralTweenInfo, {Thickness = 0, Transparency = 1})
    elseif Type == "Hover" then
        HighlightFrame.UIStroke.Color = self.HighlightFrame_Colors.Hover
        StrokeTween = TweenService:Create(HighlightFrame.UIStroke, GeneralTweenInfo, {Transparency = 0, Thickness = self.HighlightFrame_StrokeThickness})
    elseif Type == "Move_Possible" then
        HighlightFrame.BackgroundColor3 = self.HighlightFrame_Colors.Move_Possible
        FrameTween = TweenService:Create(HighlightFrame, GeneralTweenInfo, {BackgroundTransparency = self.HighlightFrame_Transparency})
    elseif Type == "Move_Obstructed" then
        HighlightFrame.ImageColor3 = self.HighlightFrame_Colors.Move_Obstructed
        FrameTween = TweenService:Create(HighlightFrame, GeneralTweenInfo, {ImageTransparency = self.HighlightFrame_Transparency})
    elseif Type == "Move_Capture" then
        HighlightFrame.BackgroundColor3 = self.HighlightFrame_Colors.Move_Capture
        HighlightFrame.UIStroke.Color = self.HighlightFrame_Colors.Move_Capture
        FrameTween = TweenService:Create(HighlightFrame, GeneralTweenInfo, {BackgroundTransparency = self.HighlightFrame_Transparency})
        StrokeTween = TweenService:Create(HighlightFrame.UIStroke, GeneralTweenInfo, {Transparency = self.HighlightFrame_Transparency, Thickness = self.HighlightFrame_StrokeThickness})
    end
    if FrameTween then
        FrameTween:Play()
    end
    if StrokeTween then
        StrokeTween:Play()
    end
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
function ChessGame_Client:UpdateBoard(NewBoardMatrix)
    for File = 1, self.BoardSize, 1 do
        for Rank = 1, self.BoardSize do
            if NewBoardMatrix[File][Rank] == Piece.None then
                self:DeletePiece(File, Rank)
            else
                self:CreatePiece(File, Rank, NewBoardMatrix[File][Rank])
            end
        end
    end
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Removes a piece from the local chess board.
---@param File number
---@param Rank number
function ChessGame_Client:DeletePiece(File, Rank)
    local GameTile = self.BoardMatrix[File][Rank]
    GameTile.Piece = Piece.None
    if GameTile.PieceImage then 
        GameTile.PieceImage:Destroy()
        GameTile.PieceImage = nil
    end
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Creates a new piece at the provided tile (for now it only supports 2d pieces)
---@param File number
---@param Rank number
---@param NewPiece Piece The piece to create
function ChessGame_Client:CreatePiece(File, Rank, NewPiece)
    local GameTile = self.BoardMatrix[File][Rank]
    GameTile["Piece"] = NewPiece

    self:Create2dPiece(File, Rank, NewPiece)
    --TODO: self:Create3dPiece(File, Rank, NewPiece)
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
function ChessGame_Client:Create2dPiece(File, Rank, NewPiece)
    local GameTile = self.BoardMatrix[File][Rank]
    GameTile["Piece"] = NewPiece

    local PieceImageList = {
        [ Piece.White + Piece.King ] = "rbxassetid://131158620290995",
        [ Piece.White + Piece.Pawn ] = "rbxassetid://138241308799606",
        [ Piece.White + Piece.Knight ] = "rbxassetid://87502654853841",
        [ Piece.White + Piece.Bishop ] = "rbxassetid://124200432163916",
        [ Piece.White + Piece.Rook ] = "rbxassetid://131889736443318",
        [ Piece.White + Piece.Queen ] = "rbxassetid://121994979957080",
        
        [ Piece.Black + Piece.King ] = "rbxassetid://138277852159029",
        [ Piece.Black + Piece.Pawn ] = "rbxassetid://79703474237153",
        [ Piece.Black + Piece.Knight ] = "rbxassetid://81040715472662",
        [ Piece.Black + Piece.Bishop ] = "rbxassetid://120857166062773",
        [ Piece.Black + Piece.Rook ] = "rbxassetid://138921760605947",
        [ Piece.Black + Piece.Queen ] = "rbxassetid://92861639866902"
        }

    local PieceImage = Instance.new("ImageLabel")
    PieceImage.Name = "PieceImage"
    PieceImage.AnchorPoint = Vector2.new(0.5, 0.5)
    PieceImage.Position = UDim2.new(0.5, 0, 0.5, 0)
    PieceImage.Size = UDim2.new(0.9, 0, 0.9, 0)
    PieceImage.BackgroundTransparency = 1
    PieceImage.Image = PieceImageList[NewPiece]
    PieceImage.ZIndex = 200
    PieceImage.Parent = GameTile.TileFrame

    GameTile.PieceImage = PieceImage
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
--[[function ChessGui:CreatePiece(File, Rank, PieceCode)
    local NewPieceLabel = Instance.new("ImageLabel")
    NewPieceLabel.Name = "PieceLabel"
    NewPieceLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    NewPieceLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    NewPieceLabel.Size = UDim2.new(1, 0, 1, 0)
    NewPieceLabel.BackgroundTransparency = 1
    NewPieceLabel.Image = PieceImageList[PieceCode]
    NewPieceLabel.Parent = self.TileMatrix[File][Rank]
end]]
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
TILEFUNCTIONS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]


--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
local function MixColors(Color1, Color2)
	local r = (Color1.R + Color2.R)* 127.5

	local g = (Color1.G + Color2.G) * 127.5

	local b = (Color1.B + Color2.B) * 127.5

	return Color3.fromRGB(r,g,b)

end

local function HighlightGuiTile(TileGui, HighlightType, State)
    print("egg")
    local HighlightTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    local HighlightTween
    if State == true then
        HighlightTween = TweenService:Create(TileGui, HighlightTweenInfo, {
            BackgroundColor3 = Color3.fromRGB(TileGui.BackgroundColor3.R + 30, TileGui.BackgroundColor3.G + 20, TileGui.BackgroundColor3.B)
        })
    elseif State == false then
        HighlightTween = TweenService:Create(TileGui, HighlightTweenInfo, {
            BackgroundColor3 = Color3.fromRGB(TileGui.BackgroundColor3.R - 30, TileGui.BackgroundColor3.G - 20, TileGui.BackgroundColor3.B)
        })
    else
        error("State must be boolean")
    end
    HighlightTween:Play()
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
--------------------------------------------------------------------------------------------------------------------------
--[[local function CreateGuiBoardTiles(BoardFrame)
    local TileMatrix = {}
    local TileOffset = BoardFrame.Size.X.Offset/8
    print(TileOffset)
    for Row = 1, 8, 1 do
        TileMatrix[Row] = {}
        for Column = 1, 8, 1 do
            TileMatrix[Row][Column] = {}
            local NewFrame = Instance.new("Frame")
            NewFrame.AnchorPoint = Vector2.new(1,1)
            NewFrame.Position = UDim2.new(0,Column*TileOffset,0,Row*TileOffset)
            NewFrame.Size = UDim2.new(0,TileOffset-4,0,TileOffset-4)
            if (Column + Row) % 2 == 0 then
                NewFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
            else
                NewFrame.BackgroundColor3 = Color3.fromRGB(100,100,100)
            end
            NewFrame.BackgroundTransparency = 0.7
            NewFrame:SetAttribute("Coordinate", Vector2.new(Row,Column))

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0.1,0)
            UICorner.Parent = NewFrame

            NewFrame.Parent = BoardFrame
            TileMatrix[Row][Column] = NewFrame
        end
    end
    return(TileMatrix)
end]]
--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
--[[-Creates a Gui piece at the provided coordinate
---@param TileMatrix table 2D matrix array countaining all the Gui tiles that make the visual board
---@param PieceCode number The code of the piece to create
---@param Coordinate Vector2 Where to place the piece
local function CreateGuiPiece(TileMatrix, PieceCode, Coordinate)

    local NewPiece = Instance.new("ImageButton")
    NewPiece.AnchorPoint = Vector2.new(0.5,0.5)
    NewPiece.Position = UDim2.new(0.5,0,0.5,0)
    NewPiece.Size = UDim2.new(1,0,1,0)
    NewPiece.Image = PieceImageList[PieceCode]
    NewPiece.Name = "PieceLabel"
    NewPiece.BackgroundTransparency = 1
    NewPiece.Parent = TileMatrix[Coordinate.X][Coordinate.Y]

end]]
--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
--[[local function UpdateGuiBoard(BoardMatrix, TileMatrix)

    for RowIndex, RowValue in pairs(BoardMatrix) do
        for ColumnIndex, ColumnValue in pairs(BoardMatrix[RowIndex]) do
            if BoardMatrix[RowIndex][ColumnIndex] == 0 then
                if TileMatrix[RowIndex][ColumnIndex]:FindFirstChild("PieceLabel") then
                    TileMatrix[RowIndex][ColumnIndex].PieceLabel:Destroy()
                end
            else
                CreateGuiPiece(TileMatrix, BoardMatrix[RowIndex][ColumnIndex], Vector2.new(RowIndex, ColumnIndex))
            end
        end
    end
end]]
--------------------------------------------------------------------------------------------------------------------------

local FunnyChessGameClient= ChessGame_Client.new()
print(FunnyChessGameClient)

local RE_UpdateBoard = script.Parent.Events.RE_UpdateBoard
RE_UpdateBoard.OnClientEvent:Connect(function(NewBoardMatrix)
    --print("hi")
    FunnyChessGameClient:UpdateBoard(NewBoardMatrix)
end)