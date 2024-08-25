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

--------------------------------------------------------------------------------------------------------------------------

local Player = game.Players.LocalPlayer
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

--------------------------------------------------------------------------------------------------------------------------
---Image IDs to use for the pieces
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

local TileImageConfig = {
    
}
--------------------------------------------------------------------------------------------------------------------------

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
ChessGame_Client CLASS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

---@class GuiBoard
---Gui of the chess game.
local ChessGame_Client = {}
ChessGame_Client.__index = ChessGame_Client

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Creates a new ChessGame array/object
---@param NewBoardParams table Array containing the desired info for the chess game.
---@return table NewChessGui The newlly created GuiBoard.
function ChessGame_Client.new(NewBoardParams)
    local NewChessGame = setmetatable(NewBoardParams or {}, ChessGame_Client)
    
    --------------------------------------------------------------------------------------------------------------------------
    NewChessGame.Gui = NewChessGame.Gui or {}
    --------------------------------------------------------------------------------------------------------------------------
    --The MainFrame where the Gui is placed
    if NewBoardParams.MainFrame then
        NewChessGui.MainFrame = NewBoardParams.MainFrame
    else
        error("A MainFrame must be provided to create a new ChessGui.")
    end
    --------------------------------------------------------------------------------------------------------------------------
    --The "background" frame of the ChessGui.
    NewChessGui.BoardFrame = Instance.new("Frame")
    local BoardFrame = NewChessGui.BoardFrame
    BoardFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    BoardFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    BoardFrame.Size = UDim2.new(1, 0, 1, 0)
    BoardFrame.BackgroundColor3 = Color3.fromHex("35374B")

    local BoardFrameARConstraint = Instance.new("UIAspectRatioConstraint")
    BoardFrameARConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    BoardFrameARConstraint.Parent = BoardFrame

    local BoardUICorner = Instance.new("UICorner")
    BoardUICorner.CornerRadius = UDim.new(0, 10)
    BoardUICorner.Parent = BoardFrame

    local BoardUIStroke = Instance.new("UIStroke")
    BoardUIStroke.Thickness = 5
    BoardUIStroke.Color = Color3.fromHex("35374B")
    BoardUIStroke.Parent = BoardFrame
    
    BoardFrame.Parent = NewChessGui.MainFrame
    --------------------------------------------------------------------------------------------------------------------------
    ---How many files/ranks the board has, only square board supported.
    NewChessGui.BoardSize = NewChessGui.BoardSize or 8
    ---which color the localplayer is using
    NewChessGui.PlayerColor = NewChessGui.PlayerColor or Piece.White
    --------------------------------------------------------------------------------------------------------------------------
    NewChessGui.TileMatrix = {}
    for File = 1, NewChessGui.BoardSize, 1 do
        NewChessGui.TileMatrix[File] = {}
        for Rank = 1, NewChessGui.BoardSize, 1 do
            local NewTile = Instance.new("ImageButton")
            NewTile.AnchorPoint = Vector2.new(0.5,0.5)
            NewTile.Size = UDim2.new(1/NewChessGui.BoardSize, -5, 1/NewChessGui.BoardSize, -5)

            local NewTileXPosition
            local NewTileYPosition
            if NewChessGui.PlayerColor == Piece.White then 
                NewTileXPosition = 1/NewChessGui.BoardSize*File-1/NewChessGui.BoardSize/2
                NewTileYPosition = 1-(1/NewChessGui.BoardSize*Rank-1/NewChessGui.BoardSize/2)
            elseif NewChessGui.PlayerColor == Piece.Black then
                NewTileXPosition = 1-(1/NewChessGui.BoardSize*File-1/NewChessGui.BoardSize/2)
                NewTileYPosition = 1/NewChessGui.BoardSize*Rank-1/NewChessGui.BoardSize/2
            end
            NewTile.Position = UDim2.new(NewTileXPosition, 0, NewTileYPosition, 0)

            if (File + Rank) % 2 == 0 then
                NewTile.BackgroundColor3 = Color3.fromRGB(100,100,100)
            else
                NewTile.BackgroundColor3 = Color3.fromRGB(255,255,255)
            end
            NewTile.BackgroundTransparency = 0.7
            NewTile:SetAttribute("Coordinate", Vector2.new(File,Rank))

            NewTile.ImageTransparency = 1

            local TileLabel = Instance.new("TextLabel")
            TileLabel.Text = " "..Chess_Module.Data.FileString[File]..tostring(Rank)
            TileLabel.TextColor3 = Color3.fromRGB(226,226,226)
            TileLabel.TextTransparency = 0.5
            TileLabel.TextXAlignment = Enum.TextXAlignment.Left
            TileLabel.TextYAlignment = Enum.TextYAlignment.Top
            TileLabel.Size = UDim2.new(1, 0, 1, 0)
            TileLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            TileLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
            TileLabel.BackgroundTransparency = 1
            TileLabel.Parent = NewTile

            local NewTileUICorner = Instance.new("UICorner")
            NewTileUICorner.CornerRadius = UDim.new(0.1, 0)
            NewTileUICorner.Parent = NewTile

            local NewTileUIStroke = Instance.new("UIStroke")
            NewTileUIStroke.Thickness = 0
            NewTileUIStroke.Parent = NewTile

            NewTile.Parent = BoardFrame

            NewChessGui.TileMatrix[File][Rank] = NewTile

            --------------------------------------------------------------------------------------------------------------------------
            NewTile.MouseEnter:Connect(function()
                local GeneralTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                local HighlightTween = TweenService:Create(NewTile.UIStroke, GeneralTweenInfo, {Thickness = 2, Transparency = 0})
                NewTile.UIStroke.Color = Color3.fromRGB(255,255,255)
                NewTile.UIStroke.Transparency = 1
                HighlightTween:Play()

                local PieceLabel = NewTile:FindFirstChild("PieceLabel")
                if PieceLabel then
                    local PieceLabelTween = TweenService:Create(PieceLabel, GeneralTweenInfo, {Position = UDim2.new(0.5, 0, 0.4, 0)})
                    PieceLabelTween:Play()
                end

                NewTile.MouseLeave:Connect(function()
                    HighlightTween = TweenService:Create(NewTile.UIStroke, GeneralTweenInfo, {Thickness = 0, Transparency = 1})
                    HighlightTween:Play()

                    if PieceLabel then
                        local PieceLabelTween = TweenService:Create(PieceLabel, GeneralTweenInfo, {Position = UDim2.new(0.5, 0, 0.5, 0)})
                        PieceLabelTween:Play()
                    end

                end)
            end)
            --------------------------------------------------------------------------------------------------------------------------
            

        end
    end
    --------------------------------------------------------------------------------------------------------------------------
    
    BoardFrame.Parent = NewChessGui.MainFrame

    return NewChessGui
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
function ChessGui:UpdateBoard(BoardMatrix)
    for FileIndex, FileValue in pairs(BoardMatrix) do
        for RankIndex, RankValue in pairs(BoardMatrix[FileIndex]) do
            if BoardMatrix[FileIndex][RankIndex] == Piece.None then
                if self.TileMatrix[FileIndex][RankIndex]:FindFirstChild("PieceLabel") then
                    self.TileMatrix[FileIndex][RankIndex].PieceLabel:Destroy()
                end
            else
                self:CreatePiece(FileIndex, RankIndex, BoardMatrix[FileIndex][RankIndex])
            end
        end
    end
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
function ChessGui:CreatePiece(File, Rank, PieceCode)
    local NewPieceLabel = Instance.new("ImageLabel")
    NewPieceLabel.Name = "PieceLabel"
    NewPieceLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    NewPieceLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    NewPieceLabel.Size = UDim2.new(1, 0, 1, 0)
    NewPieceLabel.BackgroundTransparency = 1
    NewPieceLabel.Image = PieceImageList[PieceCode]
    NewPieceLabel.Parent = self.TileMatrix[File][Rank]
end
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
---Creates a Gui piece at the provided coordinate
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

end
--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
local function UpdateGuiBoard(BoardMatrix, TileMatrix)

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
end
--------------------------------------------------------------------------------------------------------------------------

local FunnyChessBoard = ChessGui.new({MainFrame = Debug_BoardMainFrame})
--local TileMatrix = CreateGuiBoardTiles(Debug_BoardFrame)
local RE_UpdateBoard = script.Parent.Events.RE_UpdateBoard
RE_UpdateBoard.OnClientEvent:Connect(function(BoardMatrix)
    FunnyChessBoard:UpdateBoard(BoardMatrix)
end)