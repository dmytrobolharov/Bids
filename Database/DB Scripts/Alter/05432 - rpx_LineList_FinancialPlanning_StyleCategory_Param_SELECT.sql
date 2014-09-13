IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineList_FinancialPlanning_StyleCategory_Param_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineList_FinancialPlanning_StyleCategory_Param_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_LineList_FinancialPlanning_StyleCategory_Param_SELECT]
(
	@LineFolderID NVARCHAR(MAX)
	, @DivisionID NVARCHAR(MAX)
	, @StyleTypeID NVARCHAR(MAX)
)
AS
BEGIN

	SELECT CAST(value AS UNIQUEIDENTIFIER) AS LineFolderID INTO #tmpLineFolder FROM fnx_Split(@LineFolderID,',')
	SELECT CAST(value AS UNIQUEIDENTIFIER) AS DivisionID INTO #tmpDivision FROM fnx_Split(@DivisionID,',')
	SELECT CAST(value AS INT) AS StyleTypeID INTO #tmpStyleType FROM fnx_Split(@StyleTypeID,',')
	
	SELECT '00000000-0000-0000-0000-000000000000' AS StyleCategoryID, 'N/A' AS StyleCategory UNION
	SELECT DISTINCT vw.StyleCategoryID, vw.StyleCategory
	FROM vwx_Division_StyleType_StyleCategory_SELECT vw
		INNER JOIN pLineFolderStyleCategory lfsc ON lfsc.StyleCategoryID = vw.StyleCategoryID
		INNER JOIN #tmpDivision td ON vw.DivisionID = td.DivisionID
		INNER JOIN #tmpLineFolder tlf ON lfsc.LineFolderID = tlf.LineFolderID
		INNER JOIN #tmpStyleType tst ON vw.StyleTypeID = tst.StyleTypeID

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05432', GetDate())
GO