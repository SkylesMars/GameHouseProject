--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
Chess_Server
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
The script that handles the server-side operations in regards to any on going game of chess.

Notes:
- This script is heavily inspired by the "Coding Adventure: Chess" youtube video by Sebastian Lague.
]]

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
SERVICES AND IMPORTANT PATHS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

--------------------------------------------------------------------------------------------------------------------------
--[[SERVICES:]]--

local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--------------------------------------------------------------------------------------------------------------------------

local Chess_Module = require(game.ReplicatedStorage.GameFiles.Games.Chess.Chess_Module)
local Piece = Chess_Module.Data.Piece

--local ChessGame = require(ServerScriptService.GameFiles.Games.Chess.Class_ChessGame)

--------------------------------------------------------------------------------------------------------------------------

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
CHESS GAME CLASS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

---@class ChessGame_Server
---Internal server-side representation of an entire game of chess
local ChessGame_Server = {}
ChessGame_Server.__index = ChessGame_Server

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Creates a new ChessGame array/object
---@param NewGameParams table Array containing the desired info for the chess game.
---@return table NewChessGame The newlly created ChessGame array.
function ChessGame_Server.new(NewGameParams)
    local NewGame = setmetatable(NewGameParams or {}, ChessGame_Server)
    --------------------------------------------------------------------------------------------------------------------------
    ---Hoe many files/ranks the board will have, only square board suported.
    NewGame.BoardSize = NewGame.BoardSize or 8
    --------------------------------------------------------------------------------------------------------------------------
    ---2D matrix array containing the current state of the board [File(Row 1-8)][Rank(Column a-h)]
    NewGame.BoardMatrix = {}--2D matrix array containing the current state of the board [File(Row 1-8)][Rank(Column a-h)]
    for File = 1, NewGame.BoardSize, 1 do
        NewGame.BoardMatrix[File] = {}
        for Rank = 1, NewGame.BoardSize, 1 do
            NewGame.BoardMatrix[File][Rank] = Piece.None
        end
    end
    
    --------------------------------------------------------------------------------------------------------------------------
    ---The Fen string used to set the initial positions of the board.
    NewGame.StarterFen = NewGame.StarterFen or "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"
    NewGame:LoadPositionFromFen(NewGame.StarterFen)
    --------------------------------------------------------------------------------------------------------------------------
    ---numerical array(list) containing all the moves of the chess game thus far.
    NewGame.MoveRecord = NewGame.MoveRecord or {}
    --------------------------------------------------------------------------------------------------------------------------

    return NewGame
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Places pieces (their numerical code really) on the ChessGame's BoardMatrix based on a Fen string
---@param FenString string The fen string to apply to that board.
function ChessGame_Server:LoadPositionFromFen(FenString)
    local PieceTypeFromSymbol = {
        ["k"] = Piece.King, ["p"] = Piece.Pawn, ["n"] = Piece.Knight,
        ["b"] = Piece.Bishop, ["r"] = Piece.Rook, ["q"] = Piece.Queen
    }
    local BoardMatrix = self.BoardMatrix
    local FenList = string.split(FenString, "")

    local FileAmount = #BoardMatrix
    local RankAmount = #BoardMatrix[1]
    local CurrentRank = RankAmount
    local CurrentFile = 1
    for Index, Character in pairs (FenList) do
        if Character == "/" then
            CurrentRank = CurrentRank-1
            CurrentFile = 1
        elseif tonumber(Character) then
            CurrentFile = CurrentFile + 1
        else
            BoardMatrix[CurrentFile][CurrentRank] = BoardMatrix[CurrentFile][CurrentRank] + PieceTypeFromSymbol[string.lower(Character)]
            if string.match(Character, "%u") then--Checking if the letter is upper case, if so it means its white
                BoardMatrix[CurrentFile][CurrentRank] = BoardMatrix[CurrentFile][CurrentRank] + Piece.White
            else--Means the character is lower case so it should be a black piece
                BoardMatrix[CurrentFile][CurrentRank] = BoardMatrix[CurrentFile][CurrentRank] + Piece.Black
            end
            CurrentFile = CurrentFile + 1
        end
    end

end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Moves a piece on the internal board
---@param StartTile Vector2 Corts of the start tile.
---@param EndTile Vector2 Cords of the end tile.
function ChessGame_Server:MovePiece(StartTile, EndTile)
    local BoardMatrix = self.BoardMatrix
    
    local CodeOnStarterTile = BoardMatrix[StartTile.X][StartTile.Y]

end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
---Prints the game's board as unicode characters in the terminal.
function ChessGame_Server:PrintBoard()
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
    for File = 1, self.BoardSize, 1 do
        for Rank = 1, self.BoardSize , 1 do

            BoardString = BoardString..PieceUnicodeList[self.BoardMatrix[File][Rank]].." "
        end
        BoardString = BoardString.."\n"
    end
    print(BoardString)
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
END:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]



--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
FUNCTIONS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]


local FunnyGame = ChessGame_Server.new({StarterFen = "rnbqkbnr/pppppppp/8/8/1R2K2Q2B/8/PPPPPPPP/RNBQKBNR"})

print(FunnyGame)
task.wait(1)
ReplicatedStorage.GameFiles.Games.Chess.Events.RE_UpdateBoard:FireAllClients(FunnyGame.BoardMatrix)
FunnyGame:PrintBoard()




