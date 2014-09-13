IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pBodyPatternSheetModel' and COLUMN_NAME = N'ModelID')
BEGIN
     ALTER TABLE pBodyPatternSheetModel DROP COLUMN ModelID
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pBodyPatternSheetPiece' and COLUMN_NAME = N'ModelID')
BEGIN
     TRUNCATE TABLE pBodyPatternSheetPiece
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pBodyPatternSheetPiece' and COLUMN_NAME = N'ModelID')
BEGIN
     ALTER TABLE pBodyPatternSheetPiece ADD ModelID uniqueidentifier NOT NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pBodyPatternSheetModel' and COLUMN_NAME = N'ModelID')
BEGIN
     ALTER TABLE pBodyPatternSheetModel ADD ModelID uniqueidentifier NOT NULL
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_BodyPatternSheetModelPiece_INSERT_NEW') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_BodyPatternSheetModelPiece_INSERT_NEW
GO
CREATE PROC [dbo].[spx_BodyPatternSheetModelPiece_INSERT_NEW] (
@ID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
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
                (ID, StyleID, StyleSet, Piece_Code,Piece_Name,Model_Code, IsLinked, ModelID)
                VALUES 
              (@ID,@StyleID,@StyleSet,@Piece_Code,@Piece_Name,@Model_Code,0, @ModelID)
END
SET @NumPieces =( SELECT Model_nPieces FROM dbo.pBodyPatternSheetModel WHERE Model_Code = @Model_Code AND StyleID = @StyleID AND StyleSet = @StyleSet)
IF @NumPieces = NULL 
BEGIN
SET @NumPieces = 0
END
UPDATE pBodyPatternSheetModel 
   SET Model_nPieces  = @NumPieces+1 
WHERE Model_Code = @Model_Code AND StyleID = @StyleID AND StyleSet = @StyleSet
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01335', GetDate())
GO
