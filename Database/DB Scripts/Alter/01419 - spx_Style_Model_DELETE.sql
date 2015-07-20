
GO
/****** Object:  StoredProcedure [dbo].[spx_Style_Model_DELETE]    Script Date: 04/12/2011 15:16:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


ALTER PROCEDURE [dbo].[spx_Style_Model_DELETE]
(
@ID uniqueidentifier
)
AS 
BEGIN

DECLARE 
	@BodyID UNIQUEIDENTIFIER,
	@IsLinkedBF INT
	
	
SELECT @BodyID = BodyID, @IsLinkedBF =IsLinkedBF  FROM pBodyPatternSheetModel 
WITH(NOLOCK) WHERE ID = @ID  

if @BodyID IS  NULL 
	BEGIN 
		DELETE FROM pBodyPatternSheetPiece WHERE ModelID = @ID
		DELETE FROM pBodyPatternSheetModel WHERE ID = @ID
	END  
else
	BEGIN 
		UPDATE pBodyPatternSheetModel SET IsLinkedBF = 0, StyleID= NULL WHERE ID = @ID
	END  
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01419', GetDate())
GO