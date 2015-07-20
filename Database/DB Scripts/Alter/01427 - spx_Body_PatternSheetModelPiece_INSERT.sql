
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Body_PatternSheetModelPiece_INSERT') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Body_PatternSheetModelPiece_INSERT
GO
CREATE PROC [dbo].[spx_Body_PatternSheetModelPiece_INSERT] (
@ID UNIQUEIDENTIFIER,
@BodyID UNIQUEIDENTIFIER,
@StyleSet int,
@Model_Code int,
@Piece_Code int,
@Piece_Name varchar(32),
@ModelID UNIQUEIDENTIFIER
)
AS

DECLARE @NumPieces int
            
IF not exists  (select * from dbo.pBodyPatternSheetPiece where ID = @ID)
BEGIN
INSERT INTO dbo.pBodyPatternSheetPiece
                (ID, BodyID, StyleSet, Piece_Code,Piece_Name,Model_Code, IsLinked, ModelID)
                VALUES 
              (@ID,@BodyID,@StyleSet,@Piece_Code,@Piece_Name,@Model_Code,0, @ModelID)
END
SET @NumPieces =( SELECT Model_nPieces FROM dbo.pBodyPatternSheetModel WHERE 
ID = @ModelID)
IF @NumPieces = NULL 
BEGIN
SET @NumPieces = 0
END
UPDATE pBodyPatternSheetModel 
   SET Model_nPieces  = @NumPieces+1 
WHERE ID = @ModelID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01427', GetDate())
GO
