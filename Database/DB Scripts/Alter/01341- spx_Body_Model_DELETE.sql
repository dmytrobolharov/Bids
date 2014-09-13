IF EXISTS (select * from sysobjects where id = object_id('spx_Body_Model_DELETE') and sysstat & 0xf = 4)
    drop procedure spx_Body_Model_DELETE
GO

CREATE PROCEDURE [dbo].[spx_Body_Model_DELETE]
(
@ID uniqueidentifier
)
AS 
Begin
DELETE FROM pBodyPatternSheetPiece WHERE ModelID = @ID
DELETE FROM dbo.pBodyPatternSheetModel WHERE  ID = @ID

End
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01341', GetDate())
GO