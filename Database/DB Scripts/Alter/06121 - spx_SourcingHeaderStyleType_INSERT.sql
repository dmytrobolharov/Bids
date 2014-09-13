IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingHeaderStyleType_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingHeaderStyleType_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SourcingHeaderStyleType_INSERT]
	@SourcingHeaderID UNIQUEIDENTIFIER, 
	@StyleTypes VARCHAR(MAX) 
AS
BEGIN

	DELETE FROM pSourcingHeaderToStyleType WHERE SourcingHeaderID = @SourcingHeaderID
	
	INSERT INTO pSourcingHeaderToStyleType (SourcingHeaderID, StyleTypeID)
	SELECT @SourcingHeaderID, ltrim(rtrim(value))
	FROM dbo.fnx_Split(@StyleTypes,',')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06121', GetDate())
GO
