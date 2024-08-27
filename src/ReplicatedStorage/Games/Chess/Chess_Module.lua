local Chess_Module = {}
--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
Chess_Module
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
Contains data and functions used by both Chess_Client and Chess_Server scriupts.

Notes:
- THIS MODULE SCRIPT IS ACCESSIBLE BY THE CLIENT AND THE SERVER. Do not put things in here that the client should not be able to see!
]]

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
SERVICES:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
DATA:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]

--TODO: Create description of Chess_Module.Data.
Chess_Module.Data = {}

--------------------------------------------------------------------------------------------------------------------------
---@class Piece
---Array that associates the different piece names with their asigned numerical code.
Chess_Module.Data.Piece = {
    None = 0, --(00 000)
    King = 1, --(00 001)
    Pawn = 2, --(00 010)
    Knight = 3, --(00 011)
    Bishop = 4, --(00 100)
    Rook = 5, --(00 101)
    Queen = 6, --(00 110)

    White = 8, --(01 000)
    Black = 16, --(10 000)
}
local Piece = Chess_Module.Data.Piece
--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
---@type table
---Array that associates the PieceType(s) with their respective letter used in Algebraic and Fen notation(s) to identify this PieceType.
Chess_Module.Data.PieceLetter = {
    [Piece.King] = "K",
    [Piece.Queen] = "Q",
    [Piece.Rook] = "R",
    [Piece.Bishop] = "B",
    [Piece.Knight] = "N",
    [Piece.Pawn] = "P"
}
local PieceLetter = Chess_Module.Data.PieceLetter
--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
Chess_Module.Data.PieceSymbol = {
    [Piece.King + Piece.White] = "♔", [Piece.King + Piece.Black] = "♚",
    [Piece.Queen + Piece.White] = "♕", [Piece.Queen + Piece.Black] = "♛",
    [Piece.Rook + Piece.White] = "♖", [Piece.Rook + Piece.Black] = "♜",
    [Piece.Bishop + Piece.White] = "♗", [Piece.Bishop + Piece.Black] = "♝",
    [Piece.Knight + Piece.White] = "♘", [Piece.Knight + Piece.Black] = "♞",
    [Piece.Pawn + Piece.White] = "♙", [Piece.Pawn + Piece.Black] = "♟",
}
local PieceSymbol = Chess_Module.Data.PieceSymbol
--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
---@type table
---table of the alphabet, to be used when converting file numbers into their respective letter symbol.
Chess_Module.Data.Alphabet = {
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
}
--------------------------------------------------------------------------------------------------------------------------


--[[
▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃
FUNCTIONS:
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔]]


--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
function Chess_Module.GetPieceColor(PieceCode)
    if PieceCode ~= Piece.None then
        if PieceCode > 8 then
            if PieceCode < Piece.Black then
                return(Piece.White)
            else
                return(Piece.Black)
            end
        end
    end
    return(nil)
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
local MovementFunctions = {}

--------------------------------------------------------------------------------------------------------------------------
MovementFunctions.PawnMovement = function(File, Rank, BoardMatrix, MoveArray)

end
--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
MovementFunctions.Rook = function(File, Rank, BoardMatrix, MoveArray)
    local CurrentPiece = BoardMatrix[File][Rank].Piece
    local CurrentPieceColor = Chess_Module.GetPieceColor(CurrentPiece)

    local CurrentFile = File
    local CurrentRank = Rank

    local LoopCheck = true
    
    local function GetMoves(FileOffset, RankOffset)
        while  LoopCheck == true do
            CurrentFile = CurrentFile + FileOffset
            CurrentRank = CurrentRank + RankOffset
            local AdjacentTile
            if BoardMatrix[CurrentFile] and BoardMatrix[CurrentFile][CurrentRank] then
                AdjacentTile = BoardMatrix[CurrentFile][CurrentRank]
            end
            if not AdjacentTile then
                LoopCheck = false
            elseif AdjacentTile.Piece == Piece.None then
                MoveArray[CurrentFile] = MoveArray[CurrentFile] or {}
                MoveArray[CurrentFile][CurrentRank] = MoveArray[CurrentFile][CurrentRank] or "Possible"
            elseif Chess_Module.GetPieceColor(AdjacentTile.Piece) == CurrentPieceColor then
                MoveArray[CurrentFile] = MoveArray[CurrentFile] or {}
                MoveArray[CurrentFile][CurrentRank] = MoveArray[CurrentFile][CurrentRank] or "Obstructed"
                LoopCheck = false
            else
                MoveArray[CurrentFile] = MoveArray[CurrentFile] or {}
                MoveArray[CurrentFile][CurrentRank] = MoveArray[CurrentFile][CurrentRank] or "Capture"
                LoopCheck = false
            end
        end
        CurrentFile = File
        CurrentRank = Rank
        return
    end

    LoopCheck = true
    GetMoves(1, 0)
    LoopCheck = true
    GetMoves(-1, 0)
    LoopCheck = true
    GetMoves(0, 1)
    LoopCheck = true
    GetMoves(0, -1)
    
end
--------------------------------------------------------------------------------------------------------------------------
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
local PieceMovementList = {
    --------------------------------------------------------------------------------------------------------------------------
    [Piece.Pawn] = {
        MovementFunctions.PawnMovement
    },
    --------------------------------------------------------------------------------------------------------------------------
    [Piece.Rook] = {
        MovementFunctions.Rook
    },
    --------------------------------------------------------------------------------------------------------------------------
}
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
function Chess_Module.GetPieceMoves(File, Rank, BoardMatrix)
    local MoveArray = {}
    local CurrentPiece = BoardMatrix[File][Rank].Piece
    local CurrentPieceColor = Chess_Module.GetPieceColor(CurrentPiece)
    local CurrentPieceType = CurrentPiece - CurrentPieceColor

    for FunctionIndex, MovementFunction in pairs(PieceMovementList[CurrentPieceType]) do
        MovementFunction(File, Rank, BoardMatrix, MoveArray)
    end

    return MoveArray
end
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


return Chess_Module