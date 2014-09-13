IF EXISTS (select * from sysobjects where id = object_id('spx_Body_Model_DELETE') and sysstat & 0xf = 4)
    drop procedure spx_Body_Model_DELETE
GO

CREATE PROCEDURE [dbo].[spx_Body_Model_DELETE]
(
@BodyID uniqueidentifier,
@StyleSet int,
@ID uniqueidentifier
)
AS 
Begin
DELETE FROM pBodyPatternSheetPiece WHERE BodyID = @BodyID AND StyleSet = @StyleSet AND Model_Code in (Select Model_Code from pBodyPatternSheetModel WHERE ID = @ID)
DELETE FROM dbo.pBodyPatternSheetModel WHERE (BodyId = @BodyID and ID = @ID)

End
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01284', GetDate())
GO