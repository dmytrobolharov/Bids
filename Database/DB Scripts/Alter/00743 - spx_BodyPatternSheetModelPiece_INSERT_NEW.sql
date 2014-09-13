
/****** Object:  StoredProcedure [dbo].[spx_BodyPatternSheetModelPiece_INSERT_NEW]    Script Date: 11/18/2010 17:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_BodyPatternSheetModelPiece_INSERT_NEW') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_BodyPatternSheetModelPiece_INSERT_NEW
GO
CREATE PROC [dbo].[spx_BodyPatternSheetModelPiece_INSERT_NEW] (
@ID UNIQUEIDENTIFIER ,
@Model_Code int,
@Piece_Code int,
@Piece_Name varchar(32)

)
AS

DECLARE @NumPieces int
            
IF not exists  (select * from dbo.pBodyPatternSheetPiece where ID = @ID)
BEGIN
INSERT INTO dbo.pBodyPatternSheetPiece
                (ID,Piece_Code,Piece_Name,Model_Code, IsLinked)
                VALUES 
              (@ID,@Piece_Code,@Piece_Name,@Model_Code,0)
END
SET @NumPieces =( SELECT Model_nPieces FROM dbo.pBodyPatternSheetModel WHERE Model_Code = @Model_Code)
IF @NumPieces = NULL 
BEGIN
SET @NumPieces = 0
END
UPDATE pBodyPatternSheetModel 
   SET Model_nPieces  = @NumPieces+1 
WHERE Model_Code = @Model_Code

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '743', GetDate())
GO
