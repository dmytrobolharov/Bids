IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BodyPatternSheetModelPiece_INSERT_NEW]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BodyPatternSheetModelPiece_INSERT_NEW]
GO
/****** Object:  StoredProcedure [dbo].[spx_BodyPatternSheetModelPiece_INSERT_NEW]    Script Date: 11/30/2011 13:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
Create PROC [dbo].[spx_BodyPatternSheetModelPiece_INSERT_NEW] (
@ID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@StyleSet int,
@Model_Code int,
@Piece_Code int,
@Piece_Name nvarchar(32),
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
SET @NumPieces =( SELECT Model_nPieces FROM dbo.pBodyPatternSheetModel WHERE ID = @ModelID)
IF @NumPieces = NULL 
BEGIN
SET @NumPieces = 0
END
UPDATE pBodyPatternSheetModel 
   SET Model_nPieces  = @NumPieces+1 
WHERE ID= @ModelID 
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02256'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02256', GetDate())
END	
GO