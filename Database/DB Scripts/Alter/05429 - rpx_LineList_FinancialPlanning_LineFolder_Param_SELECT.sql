IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineList_FinancialPlanning_LineFolder_Param_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineList_FinancialPlanning_LineFolder_Param_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_LineList_FinancialPlanning_LineFolder_Param_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER
	, @LineListTypeID NVARCHAR(MAX)
)
AS
BEGIN

	SELECT CAST(value AS UNIQUEIDENTIFIER) AS LineListTypeID INTO #tmpLineListType FROM fnx_Split(@LineListTypeID,',')
	
	SELECT LineFolderID, LineFolderDescription
	FROM pLineFolder lf INNER JOIN #tmpLineListType tllt ON lf.LineListTypeID = tllt.LineListTypeID
	WHERE Active = 1 AND lf.SeasonYearID = @SeasonYearID
	
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05429', GetDate())
GO