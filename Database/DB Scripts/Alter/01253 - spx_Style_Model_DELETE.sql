

IF EXISTS (select * from sysobjects where id = object_id('spx_Style_Model_DELETE') and sysstat & 0xf = 4)
    drop procedure spx_Style_Model_DELETE
GO


CREATE PROCEDURE [dbo].[spx_Style_Model_DELETE]
(
@StyleID uniqueidentifier,
@StyleSet int,
@ID uniqueidentifier
)
AS 
BEGIN


DELETE FROM pBodyPatternSheetPiece WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND Model_Code in (Select Model_Code from pBodyPatternSheetModel WHERE ID = @ID)


DELETE FROM pBodyPatternSheetModel WHERE StyleID = @StyleID and ID = @ID
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01253', GetDate())
GO


