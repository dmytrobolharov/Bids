IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineList_FinancialPlanning_StyleType_Param_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineList_FinancialPlanning_StyleType_Param_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_LineList_FinancialPlanning_StyleType_Param_SELECT]
(
	@LineFolderID NVARCHAR(MAX)
	, @DivisionID NVARCHAR(MAX)
)
AS
BEGIN

	SELECT CAST(value AS UNIQUEIDENTIFIER) AS LineFolderID INTO #tmpLineFolder FROM fnx_Split(@LineFolderID,',')
	SELECT CAST(value AS UNIQUEIDENTIFIER) AS DevisionID INTO #tmpDivision FROM fnx_Split(@DivisionID,',')
	
	SELECT -1 AS StyleTypeID, 'N/A' AS StyleTypeDescription UNION
	SELECT DISTINCT vw.StyleTypeID, vw.StyleTypeDescription
	FROM vwx_Division_StyleType_StyleCategory_SELECT vw
		INNER JOIN pLineFolderStyleType lfst ON lfst.StyleTypeID = vw.StyleTypeID
		INNER JOIN #tmpLineFolder tlf ON lfst.LineFolderID = tlf.LineFolderID
		INNER JOIN #tmpDivision td ON vw.DivisionID = td.DevisionID
	
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05431', GetDate())
GO