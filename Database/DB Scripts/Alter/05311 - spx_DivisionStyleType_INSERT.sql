IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DivisionStyleType_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DivisionStyleType_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_DivisionStyleType_INSERT]
	@DivisionId UNIQUEIDENTIFIER, 
	@StyleTypes VARCHAR(MAX) 
AS
BEGIN

	DELETE FROM pDivisionStyleType WHERE DivisionID = @DivisionId
	
	INSERT INTO pDivisionStyleType (DivisionID, StyleTypeID)
	SELECT @DivisionId, ltrim(rtrim(value))
	FROM dbo.fnx_Split(@StyleTypes,',')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05311', GetDate())
GO
