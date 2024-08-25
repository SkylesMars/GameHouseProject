--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
Class_ChessGame
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
A class of object that represents a gme of chess server side.

Notes:
-
]]

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
SETUP:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

local ChessGame = {}-- The "Main array" of this module script that is returned at the end.
ChessGame.__index = ChessGame

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
SERVICES:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
CONFIG:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

local Chess_Module = require(ReplicatedStorage.GameFiles.Games.Chess.Chess_Module)--Module script containing information about chess data acessible by both client and server.
local Piece = Chess_Module.Data.Piece --Array that associates the different piece names with their respective numeric ID.

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
CONSTRUCTOR:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Creates a new ChessGame
---@param NewGameParams table Array containing the desired info for the chess game.
---@return table The created ChessGame array.
function ChessGame.new(NewGameParams)
    
    local NewGame = setmetatable(NewGameParams or {}, ChessGame)

    --------------------------------------------------------------------------------------------------------------------------
    NewGame.BoardMatrix = {} --2D matrix array containing the current state of the board [File(Row 1-8)][Rank(Column a-h)]
    for File = 1, 8, 1 do
        NewGame.BoardMatrix[File] = {}
        for Rank = 1, 8, 1 do
            NewGame.BoardMatrix[File][Rank] = Piece.None
        end
    end
    --------------------------------------------------------------------------------------------------------------------------
    NewGame.StarterFen = NewGame.StarterFen or "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR" --The Fen string used to set the initial positions of the board.
    --Setup the game pieces based on the starter fen:
    NewGame:LoadPositionFromFen(NewGame.StarterFen)
    --------------------------------------------------------------------------------------------------------------------------
    NewGame.MoveRecord = NewGame.MoveRecord or {} --numerical array(list) containing all the moves of the chess game thus far.
    --------------------------------------------------------------------------------------------------------------------------

    return NewGame
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
FUNCTIONS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Places pieces (their numerical code really) on the ChessGame's BoardMatrix based on a Fen string
---@param FenString string The fen string to apply to that board.
function ChessGame:LoadPositionFromFen(FenString)
    local PieceTypeFromSymbol = {
        ["k"] = Piece.King, ["p"] = Piece.Pawn, ["n"] = Piece.Knight,
        ["b"] = Piece.Bishop, ["r"] = Piece.Rook, ["q"] = Piece.Queen
    }
    local BoardMatrix = self.BoardMatrix
    local FenList = string.split(FenString, "")
    local CurrentRow = 1
    local CurrentColumn = 1
    for Index, Character in pairs(FenList) do
        if Character == "/" then
            CurrentRow = CurrentRow + 1
            CurrentColumn = 1
        elseif tonumber(Character) then
            CurrentColumn = CurrentColumn + tonumber(Character)
        else
            BoardMatrix[CurrentRow][CurrentColumn] = BoardMatrix[CurrentRow][CurrentColumn] + PieceTypeFromSymbol[string.lower(Character)]
            if string.match(Character, "%u") then--Checking if the letter is upper case, if so it means its white
            BoardMatrix[CurrentRow][CurrentColumn] = BoardMatrix[CurrentRow][CurrentColumn] + Piece.White
            else--Means the character is lower case so it should be a black piece
            BoardMatrix[CurrentRow][CurrentColumn] = BoardMatrix[CurrentRow][CurrentColumn] + Piece.Black
            end
            CurrentColumn = CurrentColumn + 1
        end
    end
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Moves a piece on the internal board
---@param StartTile Vector2 Corts of the start tile.
---@param EndTile Vector2 Cords of the end tile.
function ChessGame:MovePiece(StartTile, EndTile)
    local BoardMatrix = self.BoardMatrix
    
    local CodeOnStarterTile = BoardMatrix[StartTile.X][StartTile.Y]

end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Prints the game's board as unicode characters in the terminal.
function ChessGame:PrintBoard()
    local PieceUnicodeList = {
        [Piece.None] = "⛶",

        [Piece.Pawn + Piece.White] = "♙", [Piece.Knight + Piece.White] = "♘",
        [Piece.Bishop + Piece.White] = "♗", [Piece.Rook + Piece.White] = "♖",
        [Piece.Queen + Piece.White] = "♕", [Piece.King + Piece.White] = "♔",

        [Piece.Pawn + Piece.Black] = "♟", [Piece.Knight + Piece.Black] = "♞",
        [Piece.Bishop + Piece.Black] = "♝", [Piece.Rook + Piece.Black] = "♜",
        [Piece.Queen + Piece.Black] = "♛", [Piece.King + Piece.Black] = "♚",
    }

    local BoardString = "\n"
    for File = 1, 8, 1 do
        for Rank = 1, 8 , 1 do

            BoardString = BoardString..PieceUnicodeList[self.BoardMatrix[File][Rank]].." "
        end
        BoardString = BoardString.."\n"
    end
    print(BoardString)
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--[[
local PieceTypeFromSymbol = { --Array that associates the letters in algebraic notations with their respective piece codes.
        ["K"] = Piece.King, ["Q"] = Piece.Queen,
        ["R"] = Piece.Rook, ["B"] = Piece.Bishop,
        ["N"] = Piece.Knight
    }
    local FileIndexFromLetter = { --Array that associates the letters in  algebraic notations with their respective file index.
        ["a"] = 1, ["b"] = 2, ["c"] = 3,
        ["d"] = 4, ["e"] = 5, ["f"] = 6,
        ["g"] = 7, ["h"] = 8
    }

    if MoveString == "0-0" then
        --Castle Kingside
        error("Move '0-0' indicates Castle kingside, This function is still not implemented")

    elseif MoveString == "0-0-0" then
        --Castle Queenside
        error("Move '0-0-0' indicates Castle queenside, This function is still not implemented")

    else
        --Is a "normal" move

        --------------------------------------------------------------------------------------------------------------------------
        --(The # operator gets us the length of the table)
        local MoveIndex = (#self.MoveRecord) + 1 --Which turn of the game this is.
        --------------------------------------------------------------------------------------------------------------------------
        local MoveStringList = string.split(MoveString, "")--Array containing all characters from the MoveString separated and in order.
        --------------------------------------------------------------------------------------------------------------------------
        local PieceTypeToMove --The type of the piece we want to move.
        local MoveStringListOffset = 0
        if PieceTypeFromSymbol[MoveStringList[1] == nil then
            --The piece we want to move is a Pawn.
            PieceTypeToMove = Piece.Pawn
        else
            --The piece we want to move is defined by a letter
            PieceTypeToMove = PieceTypeFromSymbol[MoveStringList[1]
            MoveStringListOffset = MoveStringListOffset + 1
        end
        --------------------------------------------------------------------------------------------------------------------------
        local PieceColorToMove --The color of the piece that we want to move.
        if MoveIndex % 2 == 0 then
            --The current move is even, so it's black's turn:
            PieceColorToMove = Piece.Black
        else
            --The current move is odd, so it's white's turn:
            PieceColorToMove = Piece.White
        end
        --------------------------------------------------------------------------------------------------------------------------
        local MoveStringListReverseOffset = 0
        if MoveStringList[#MoveStringList] == "+" then
            --The move puts the king in danger
            
        end
        --------------------------------------------------------------------------------------------------------------------------
        local DestinationTile = Vector2.new()--The tile cordinates the piece wants to move to.
        --The destination tile will be at the end of the table:
        --------------------------------------------------------------------------------------------------------------------------

    end
]]--


--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
END:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

return ChessGame