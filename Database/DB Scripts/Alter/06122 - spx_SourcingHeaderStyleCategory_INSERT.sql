IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingHeaderStyleCategory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingHeaderStyleCategory_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SourcingHeaderStyleCategory_INSERT]
	@SourcingHeaderID UNIQUEIDENTIFIER, 
	@StyleCategories VARCHAR(MAX) 
AS
BEGIN

	DELETE FROM pSourcingHeaderToStyleCategory WHERE SourcingHeaderID = @SourcingHeaderID
	
	INSERT INTO pSourcingHeaderToStyleCategory (SourcingHeaderID, StyleCategoryID)
	SELECT @SourcingHeaderID, ltrim(rtrim(value))
	FROM dbo.fnx_Split(@StyleCategories,',')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06122', GetDate())
GO
