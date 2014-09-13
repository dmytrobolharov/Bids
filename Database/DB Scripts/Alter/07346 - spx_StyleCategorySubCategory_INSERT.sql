IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCategorySubCategory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCategorySubCategory_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleCategorySubCategory_INSERT](
	@StyleCategoryId UNIQUEIDENTIFIER,
	@SubCategoryId UNIQUEIDENTIFIER
	)
AS
BEGIN
	INSERT INTO pStyleCategorySubCategory (StyleCategorySubCategoryID, StyleCategoryId, SubCategoryId)
    VALUES (newID(), @StyleCategoryId, @SubCategoryId)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07346', GetDate())
GO
