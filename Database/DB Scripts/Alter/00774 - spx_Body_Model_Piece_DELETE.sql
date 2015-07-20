
/****** Object:  StoredProcedure [dbo].[spx_Body_Model__Piece_DELETE]    Script Date: 11/23/2010 13:30:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Body_Model_Piece_DELETE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Body_Model_Piece_DELETE
GO

CREATE PROCEDURE [dbo].[spx_Body_Model_Piece_DELETE]
(

@ID uniqueidentifier
)
AS 
Begin

DELETE FROM pBodyPatternSheetPiece
WHERE  (ID = @ID)
End

---------------------------------------------
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '774', GetDate())
GO