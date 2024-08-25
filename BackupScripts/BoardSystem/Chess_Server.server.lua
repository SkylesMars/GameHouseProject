--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
Chess_Server
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
ServerScript that handles games of chess.

Notes:
- For now, all functions will be stored here in order to create a working game, however once the game is complete and more games are added to the house,
some functions will be moved to other module scripts and stuff depending on what goes.
]]

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
SERVICES AND IMPORTANT PATHS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

--------------------------------------------------------------------------------------------------------------------------
--[[SERVICES:]]--

local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

--------------------------------------------------------------------------------------------------------------------------

--local Chess_ServerModule = require(ServerScriptService.GameFiles.Games.Chess.Chess_ServerModule)

--------------------------------------------------------------------------------------------------------------------------

local GameAssets = ServerStorage.GameAssets --Folder containing meshes and other well, assets used by this and other scripts.

local BoardSetsFolder = GameAssets.Chess.BoardSets --Folder containing the avalible bord sets.
local PieceSetsFolder = GameAssets.Chess.PieceSets --Folder containing the avalible piece sets.

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
CHESS CONFIG.:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

--------------------------------------------------------------------------------------------------------------------------
--[[PIECES INFO:]]--

local Piece = {
    None = 0,

    King = 1,
    Pawn = 2,
    Knight = 3,
    Bishop = 4,
    Rook = 5,
    Queen = 6,

    White = 8,
    Black = 16,
}
--------------------------------------------------------------------------------------------------------------------------
--[[DEFAULT GAME PARAMETERS:]]--
--Dictionary containing the default information used by the CreateNewGame() function
local DefaultGameParameters = {

    BoardSet = "Default",--Which piece set to use when generating the board.
    --BoardShape = Vector2.new(8,8),--(Columns, Rows)
    BoardSize = Vector2.new(16,1),--The physical width and height of the board (Does not include the border, only the tiles)
    BoardCFrame = CFrame.new(0,0,0),--The CFrame containing the position and orientation of where to generate the board.

    LightTileColor = Color3.fromRGB(255,255,255),--What color the generated board will use for light tiles.
    DarkTileColor = Color3.fromRGB(0,0,0),--What color the generated board will use for dark tiles.
    LightTileMaterial = "Plastic",--What material the generated board will use for light tiles.
    DarkTileMaterial = "Plastic",--What material the generated board will use for dark tiles.


    --PlayerWhite = nil,--The player who is playing as white.
    --PlayerBlack = nil,--The player who is playing as black.

    WhitePieceSet = "Default",--Which piece set to use for the white pieces.
    BlackPieceSet = "Default",--Which piece set to use for the black pieces.

    StarterGameState = {
        {"Pawn_White", Vector2.new(1,2)},
        {"Pawn_White", Vector2.new(2,2)},
        {"Pawn_White", Vector2.new(3,2)},
        {"Pawn_White", Vector2.new(4,2)},
        {"Pawn_White", Vector2.new(5,2)},
        {"Pawn_White", Vector2.new(6,2)},
        {"Pawn_White", Vector2.new(7,2)},
        {"Pawn_White", Vector2.new(8,2)},
        {"Rook_White", Vector2.new(1,1)},
    },

}

--------------------------------------------------------------------------------------------------------------------------


--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
CHESS CONFIG.:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

--------------------------------------------------------------------------------------------------------------------------
local function CreatePiece(BoardMatrix,BoardModel,PieceName,PiecePosition)

end
--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
local function CreateNewGame(GameParameters)
    
    --Verify the provided Gameparameters:
    if GameParameters == nil then
        GameParameters = {}
    end
    for Index, Value in pairs(DefaultGameParameters) do
        if GameParameters[Index] == nil then
            GameParameters[Index] = Value
        end
    end

    local ScaleParameter = GameParameters.BoardSize.X / 8

    local BoardModel = Instance.new("Model")

    local BoardMatrix = {} --A 2D matrix countaining all the information of the current game's bord.

    --Create the BoardMatrix and generate the tiles:
    for ColumnIndex = 1, 8, 1 do
        BoardMatrix[ColumnIndex] = {}

        for RowIndex = 1, 8, 1 do
            BoardMatrix[ColumnIndex][RowIndex] = {}

            local NewTileModel = BoardSetsFolder:FindFirstChild(GameParameters.BoardSet).Tile:Clone()

            --Color the tile apropreatelly:
            if (ColumnIndex + RowIndex) % 2 == 0 then
                for ModelPartIndex, ModelPart in pairs(NewTileModel:GetChildren()) do
                    ModelPart.Material = GameParameters.LightTileMaterial
                    ModelPart.Color = GameParameters.LightTileColor
                end
            else
                for ModelPartIndex, ModelPart in pairs(NewTileModel:GetChildren()) do
                    ModelPart.Material = GameParameters.DarkTileMaterial
                    ModelPart.Color = GameParameters.DarkTileColor
                end
            end

            --TODO: remove this from the loop and instead do only once when the game starts, by changing the attribute in the template itself.
            local NewTileScaleOffset = NewTileModel:GetAttribute("ScaleOffset")
            if NewTileScaleOffset == nil then
                NewTileScaleOffset = 1
            end

            NewTileModel:ScaleTo(ScaleParameter * NewTileScaleOffset)--
            NewTileModel:PivotTo((GameParameters.BoardCFrame * CFrame.new(ColumnIndex*ScaleParameter, 0, RowIndex*ScaleParameter)) * CFrame.new(-(GameParameters.BoardSize.X+ScaleParameter)/2, 0, -(GameParameters.BoardSize.X+ScaleParameter)/2))
            NewTileModel.Parent = BoardModel

            BoardMatrix[ColumnIndex][RowIndex].TileModel = NewTileModel
        end 
    end

    --Place the game pieces:
    for Index, PieceInfo in pairs(GameParameters.StarterGameState) do
        -- PieceInfo is organised as: { PieceName(string) , PiecePosition(vector2) }

        BoardMatrix[PieceInfo[2].X][PieceInfo[2].Y].PieceName = PieceInfo[1]

        if PieceInfo[1]:split("_")[2] == "White" then
            
        else

        end
    end


    BoardModel.Parent = game.Workspace
    print(BoardMatrix)
end
--------------------------------------------------------------------------------------------------------------------------



CreateNewGame()