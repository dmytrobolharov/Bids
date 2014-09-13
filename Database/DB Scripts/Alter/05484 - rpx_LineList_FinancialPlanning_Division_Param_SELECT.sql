IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineList_FinancialPlanning_Division_Param_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineList_FinancialPlanning_Division_Param_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_LineList_FinancialPlanning_Division_Param_SELECT]
(
	@LineFolderID NVARCHAR(MAX)
)
AS
BEGIN

	SELECT CAST(value AS UNIQUEIDENTIFIER) AS LineFolderID INTO #tmpLineFolder FROM fnx_Split(@LineFolderID,',')
	
	SELECT DISTINCT div.CustomID, div.Custom
	FROM iCustom1 div
		INNER JOIN pLineFolder lf ON div.CustomID = lf.LineFolderDivisionID
		INNER JOIN #tmpLineFolder tlf ON lf.LineFolderID = tlf.LineFolderID
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05484', GetDate())
GO
