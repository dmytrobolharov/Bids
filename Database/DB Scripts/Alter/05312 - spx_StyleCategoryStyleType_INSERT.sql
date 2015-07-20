IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCategoryStyleType_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCategoryStyleType_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleCategoryStyleType_INSERT]
	@StyleCategoryId UNIQUEIDENTIFIER, 
	@StyleTypes VARCHAR(MAX) 
AS
BEGIN

	DELETE FROM pStyleCategoryStyleType WHERE StyleCategoryID = @StyleCategoryId
	
	INSERT INTO pStyleCategoryStyleType (StyleCategoryID, StyleTypeID)
	SELECT @StyleCategoryId, ltrim(rtrim(value))
	FROM dbo.fnx_Split(@StyleTypes,',')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05312', GetDate())
GO
