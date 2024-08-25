local Chess_ServerModule = {}
--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
Chess_ServerModule
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
Module script housing functions used by the chess server script.

Notes:
-
]]

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
SERVICES AND IMPORTANT PATHS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

--------------------------------------------------------------------------------------------------------------------------

local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

--------------------------------------------------------------------------------------------------------------------------

local GameAssets = ServerStorage.GameAssets --Folder containing meshes and other well, assets used by this and other scripts.



--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
BOARD FUNCTIONS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]






--------------------------------------------------------------------------------------------------------------------------

local BoardInfo_Default = { --Default parameters for a chess board.
    Rows = 8,
    Columns = 8,

    BoardWidth = 20, -- Physical sizeX of the board

    BoardCFrame = CFrame.new(0,-10,0), --CFrame telling the position and orientation of the new board.

    BoardHeight = 1, -- How thick the bord will be

    BorderThickness = 1, -- How thick the border of the board is
    BorderColor = Color3.fromRGB(129, 79, 58),
    BorderMaterial = "Wood",


    TileModel = GameAssets.BoardParts.BoardTile_1,
    DarktTileColor = Color3.fromRGB(27, 42, 53), --The primary color of the tiles (aka Tile[1,1])
    DarkTileMaterial = "Granite",
    LightTileColor = Color3.fromRGB(237, 234, 234),
    LightTileMaterial = "Marble",

    EdgeModel = GameAssets.BoardParts.BoardEdge_1,
    LeftCornerModel = GameAssets.BoardParts.BoardCorner_1A,
    RightCornerModel = GameAssets.BoardParts.BoardCorner_1B,
    --BorderColor = Color3.fromRGB
}

--------------------------------------------------------------------------------------------------------------------------

---cretes a board
---@param BoardInfo table
---@return table Board matrix
---@return Instance Board model created
local function CreateBoard(BoardInfo)

    --Verify BoardInfo parameters:
    if BoardInfo ~= nil then

        for PIndex, Parameter in pairs(BoardInfo_Default) do
            if BoardInfo[PIndex] == nil then
                BoardInfo[PIndex] = BoardInfo_Default[PIndex]
            end
        end
        
    else
        BoardInfo = BoardInfo_Default
    end

    --CREATE THE BOARD TILES:

    local BoardTileMatrix = {}
    local BoardModel = Instance.new("Model")

    local TileWidth = BoardInfo.BoardWidth/BoardInfo.Rows
    
    local RowCounter = 1
    local ColumnCounter = 1
    local IsdarkTile = false
    while RowCounter <= BoardInfo.Rows do

        BoardTileMatrix[RowCounter] = {}

        if RowCounter%2 == 0 then
            IsdarkTile = false
        else
            IsdarkTile = true
        end

        while ColumnCounter <= BoardInfo.Columns do

            local NewTileMesh = BoardInfo.TileModel:Clone()
            --Set the tile size:
            NewTileMesh.Size = Vector3.new(TileWidth, BoardInfo.BoardHeight, TileWidth)
            --Set the tile position:
            --[Simplificar equação depois:]
            NewTileMesh.CFrame = BoardInfo.BoardCFrame * CFrame.new(RowCounter*TileWidth-TileWidth*0.5-TileWidth*BoardInfo.Rows*0.5, BoardInfo.BoardHeight*0.5, ColumnCounter*TileWidth-TileWidth*0.5-TileWidth*BoardInfo.Columns*0.5)
            --Log the tile in the BoardTileMatrix for later return:
            BoardTileMatrix[RowCounter][ColumnCounter] = {}
            BoardTileMatrix[RowCounter][ColumnCounter].TileMesh = NewTileMesh
            --Apply material and color:
            if IsdarkTile == true then
                NewTileMesh.Color = BoardInfo.DarktTileColor
                NewTileMesh.Material = BoardInfo.DarkTileMaterial
                IsdarkTile = false
            else
                NewTileMesh.Color = BoardInfo.LightTileColor
                NewTileMesh.Material = BoardInfo.LightTileMaterial
                IsdarkTile = true
            end
            
            --Parent the TileModel:
            NewTileMesh.Parent = BoardModel

            ColumnCounter = ColumnCounter+1
        end
        ColumnCounter = 1

        RowCounter = RowCounter+1
    end
    
    --CREATE THE BOARD BORDER:

    -------------------------------------------------

    local NewBoardEdge1 = BoardInfo.EdgeModel:Clone()
    NewBoardEdge1.CFrame = BoardInfo.BoardCFrame * CFrame.new(0.5*(BoardInfo.Rows*TileWidth + BoardInfo.BorderThickness), BoardInfo.BoardHeight*0.5, 0) * CFrame.Angles(0, math.rad(-90), 0)
    NewBoardEdge1.Size = Vector3.new(BoardInfo.Columns*TileWidth, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardEdge1.Color = BoardInfo.BorderColor
    NewBoardEdge1.Material = BoardInfo.BorderMaterial
    NewBoardEdge1.Parent = BoardModel

    local NewBoardCorner1A = BoardInfo.LeftCornerModel:Clone()
    NewBoardCorner1A.CFrame = NewBoardEdge1.CFrame * CFrame.new(0.5*(BoardInfo.Columns*TileWidth + BoardInfo.BorderThickness),0,0)
    NewBoardCorner1A.Size = Vector3.new(BoardInfo.BorderThickness, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardCorner1A.Color = BoardInfo.BorderColor
    NewBoardCorner1A.Material = BoardInfo.BorderMaterial
    NewBoardCorner1A.Parent = BoardModel

    local NewBoardCorner1B = BoardInfo.RightCornerModel:Clone()
    NewBoardCorner1B.CFrame = NewBoardEdge1.CFrame * CFrame.new(-0.5*(BoardInfo.Columns*TileWidth + BoardInfo.BorderThickness),0,0)
    NewBoardCorner1B.Size = Vector3.new(BoardInfo.BorderThickness, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardCorner1B.Color = BoardInfo.BorderColor
    NewBoardCorner1B.Material = BoardInfo.BorderMaterial
    NewBoardCorner1B.Parent = BoardModel

    -------------------------------------------------

    local NewBoardEdge2 = BoardInfo.EdgeModel:Clone()
    NewBoardEdge2.CFrame = BoardInfo.BoardCFrame * CFrame.new(-0.5*(BoardInfo.Rows*TileWidth + BoardInfo.BorderThickness), BoardInfo.BoardHeight*0.5, 0) * CFrame.Angles(0, math.rad(90), 0)
    NewBoardEdge2.Size = Vector3.new(BoardInfo.Columns*TileWidth, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardEdge2.Color = BoardInfo.BorderColor
    NewBoardEdge2.Material = BoardInfo.BorderMaterial
    NewBoardEdge2.Parent = BoardModel

    local NewBoardCorner2A = BoardInfo.LeftCornerModel:Clone()
    NewBoardCorner2A.CFrame = NewBoardEdge2.CFrame * CFrame.new(0.5*(BoardInfo.Columns*TileWidth + BoardInfo.BorderThickness),0,0)
    NewBoardCorner2A.Size = Vector3.new(BoardInfo.BorderThickness, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardCorner2A.Color = BoardInfo.BorderColor
    NewBoardCorner2A.Material = BoardInfo.BorderMaterial
    NewBoardCorner2A.Parent = BoardModel

    local NewBoardCorner2B = BoardInfo.RightCornerModel:Clone()
    NewBoardCorner2B.CFrame = NewBoardEdge2.CFrame * CFrame.new(-0.5*(BoardInfo.Columns*TileWidth + BoardInfo.BorderThickness),0,0)
    NewBoardCorner2B.Size = Vector3.new(BoardInfo.BorderThickness, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardCorner2B.Color = BoardInfo.BorderColor
    NewBoardCorner2B.Material = BoardInfo.BorderMaterial
    NewBoardCorner2B.Parent = BoardModel

    -------------------------------------------------

    local NewBoardEdge3 = BoardInfo.EdgeModel:Clone()
    NewBoardEdge3.CFrame = BoardInfo.BoardCFrame * CFrame.new(0, BoardInfo.BoardHeight*0.5, 0.5*(BoardInfo.Columns*TileWidth + BoardInfo.BorderThickness)) * CFrame.Angles(0, math.rad(180), 0)
    NewBoardEdge3.Size = Vector3.new(BoardInfo.Rows*TileWidth, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardEdge3.Color = BoardInfo.BorderColor
    NewBoardEdge3.Material = BoardInfo.BorderMaterial
    NewBoardEdge3.Parent = BoardModel

    local NewBoardCorner3A = BoardInfo.LeftCornerModel:Clone()
    NewBoardCorner3A.CFrame = NewBoardEdge3.CFrame * CFrame.new(0.5*(BoardInfo.Rows*TileWidth + BoardInfo.BorderThickness),0,0)
    NewBoardCorner3A.Size = Vector3.new(BoardInfo.BorderThickness, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardCorner3A.Color = BoardInfo.BorderColor
    NewBoardCorner3A.Material = BoardInfo.BorderMaterial
    NewBoardCorner3A.Parent = BoardModel

    local NewBoardCorner3B = BoardInfo.RightCornerModel:Clone()
    NewBoardCorner3B.CFrame = NewBoardEdge3.CFrame * CFrame.new(-0.5*(BoardInfo.Rows*TileWidth + BoardInfo.BorderThickness),0,0)
    NewBoardCorner3B.Size = Vector3.new(BoardInfo.BorderThickness, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardCorner3B.Color = BoardInfo.BorderColor
    NewBoardCorner3B.Material = BoardInfo.BorderMaterial
    NewBoardCorner3B.Parent = BoardModel

    -------------------------------------------------
    
    local NewBoardEdge4 = BoardInfo.EdgeModel:Clone()
    NewBoardEdge4.CFrame = BoardInfo.BoardCFrame * CFrame.new(0, BoardInfo.BoardHeight*0.5, -0.5*(BoardInfo.Columns*TileWidth + BoardInfo.BorderThickness)) * CFrame.Angles(0, math.rad(0), 0)
    NewBoardEdge4.Size = Vector3.new(BoardInfo.Rows*TileWidth, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardEdge4.Color = BoardInfo.BorderColor
    NewBoardEdge4.Material = BoardInfo.BorderMaterial
    NewBoardEdge4.Parent = BoardModel
    
    local NewBoardCorner4A = BoardInfo.LeftCornerModel:Clone()
    NewBoardCorner4A.CFrame = NewBoardEdge4.CFrame * CFrame.new(0.5*(BoardInfo.Rows*TileWidth + BoardInfo.BorderThickness),0,0)
    NewBoardCorner4A.Size = Vector3.new(BoardInfo.BorderThickness, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardCorner4A.Color = BoardInfo.BorderColor
    NewBoardCorner4A.Material = BoardInfo.BorderMaterial
    NewBoardCorner4A.Parent = BoardModel

    local NewBoardCorner4B = BoardInfo.RightCornerModel:Clone()
    NewBoardCorner4B.CFrame = NewBoardEdge4.CFrame * CFrame.new(-0.5*(BoardInfo.Rows*TileWidth + BoardInfo.BorderThickness),0,0)
    NewBoardCorner4B.Size = Vector3.new(BoardInfo.BorderThickness, BoardInfo.BoardHeight, BoardInfo.BorderThickness)
    NewBoardCorner4B.Color = BoardInfo.BorderColor
    NewBoardCorner4B.Material = BoardInfo.BorderMaterial
    NewBoardCorner4B.Parent = BoardModel

    -------------------------------------------------
    
    BoardModel.Name = "ChessBoard"
    BoardModel.Parent = game.Workspace

    return BoardTileMatrix, BoardModel
end

--------------------------------------------------------------------------------------------------------------------------



--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
NEW GAME:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

--------------------------------------------------------------------------------------------------------------------------

local GameInfo_Default = {

}

--------------------------------------------------------------------------------------------------------------------------

function Chess_ServerModule.NewGame(GameInfo)
    --CREATE THE BOARD:
    local GameBoard = CreateBoard()
    
    --ASSIGN PIECES:

    --White Pieces:
    for TileIndex, TileTable in pairs(GameBoard[2]) do
        TileTable.GamePiece = "Pawn_White"
    end
    GameBoard[1][1].GamePiece = "Rook_White"
    GameBoard[1][2].GamePiece = "Knight_White"
    GameBoard[1][3].GamePiece = "Bishop_White"
    GameBoard[1][4].GamePiece = "Queen_White"
    GameBoard[1][5].GamePiece = "King_White"
    GameBoard[1][6].GamePiece = "Bishop_White"
    GameBoard[1][7].GamePiece = "Knight_White"
    GameBoard[1][8].GamePiece = "Rook_White"

    --Black Pieces:
    for TileIndex, TileTable in pairs(GameBoard[2]) do
        TileTable.GamePiece = "Pawn_Black"
    end
    GameBoard[8][1].GamePiece = "Rook_Black"
    GameBoard[8][2].GamePiece = "Knight_Black"
    GameBoard[8][3].GamePiece = "Bishop_Black"
    GameBoard[8][4].GamePiece = "Queen_Black"
    GameBoard[8][5].GamePiece = "King_Black"
    GameBoard[8][6].GamePiece = "Bishop_Black"
    GameBoard[8][7].GamePiece = "Knight_Black"
    GameBoard[8][8].GamePiece = "Rook_Black"

    print(GameBoard)

    GameBoard[1][1]["TileMesh"].Color = Color3.fromRGB(255,0,0)
    GameBoard[2][1]["TileMesh"].Color = Color3.fromRGB(0,255,0)
end

--------------------------------------------------------------------------------------------------------------------------


return Chess_ServerModule