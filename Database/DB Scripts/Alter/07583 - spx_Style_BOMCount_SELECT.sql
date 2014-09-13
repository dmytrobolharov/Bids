IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_BOMCount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_BOMCount_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Style_BOMCount_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT COUNT(wfi.WorkFlowItemID) as BomCnt
	FROM pWorkFlowItem wfi
	INNER JOIN pStyleSeasonYear ssy ON wfi.StyleSeasonYearID = ssy.StyleSeasonYearID
	WHERE wfi.WorkflowID = '40000000-0000-0000-0000-000000000080' 
		AND wfi.StyleID = @StyleID AND ssy.SeasonYearID = @SeasonYearID
	
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07583', GetDate())
GO
