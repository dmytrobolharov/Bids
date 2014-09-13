IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_BOMConfig_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_BOMConfig_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Control_BOMConfig_SELECT]
	@DivisionID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT
		CASE WHEN t.StyleCategoryId IS NULL THEN t.StyleTypeDescription ELSE t.StyleCategory END AS Name
		, t.StyleTypeID
		, t.StyleCategoryId
		, t.StyleTypeDescription
		, t.StyleCategory
		, ISNULL(DimBOM, 0) AS DimBOM
		, ISNULL(DefaultBOMPage, 0) AS DefaultBOMPage
		, ISNULL(FillColorway, 0) AS FillColorway
		, ISNULL(ActiveColor, 0) AS ActiveColor
		, ISNULL(DimensionOptions, 0) AS DimensionOptions
	FROM (
	SELECT st.StyleTypeID, st.StyleTypeDescription, sc.StyleCategoryId, sc.StyleCategory, st.StyleTypeOrder, sc.Sort FROM pStyleType st
		INNER JOIN pStyleCategoryStyleType scst ON st.StyleTypeID = scst.StyleTypeID
		INNER JOIN pStyleCategory sc ON scst.StyleCategoryID = sc.StyleCategoryId
		INNER JOIN pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID
	WHERE dst.DivisionID = @DivisionID
	UNION
	SELECT st.StyleTypeID, st.StyleTypeDescription, NULL AS StyleCategoryId, NULL AS StyleCategory, st.StyleTypeOrder, NULL AS Sort FROM pStyleType st
		INNER JOIN pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID
		INNER JOIN pStyleCategoryStyleType scst ON st.StyleTypeID = scst.StyleTypeID
	WHERE dst.DivisionID = @DivisionID
	) t
	LEFT JOIN pControlBOMConfig cbc ON t.StyleTypeID = cbc.StyleTypeID AND t.StyleCategoryId = cbc.StyleCategoryID AND cbc.DivisionID = @DivisionID
	ORDER BY StyleTypeOrder, StyleTypeDescription, Sort, StyleCategory


END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06477', GetDate())
GO
