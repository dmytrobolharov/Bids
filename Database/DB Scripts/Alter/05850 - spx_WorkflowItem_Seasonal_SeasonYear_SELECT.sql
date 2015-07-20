/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_Seasonal_SeasonYear_SELECT]    Script Date: 06/13/2013 16:19:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_Seasonal_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_Seasonal_SeasonYear_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_WorkflowItem_Seasonal_SeasonYear_SELECT]
	@WorkflowItemID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT wf2.*, vsy.*, ssy.* FROM pWorkFlowItem wf1
	INNER JOIN pWorkFlowItem wf2 ON wf1.WorkflowItemMasterID = wf2.WorkflowItemMasterID
	INNER JOIN pStyleSeasonYear ssy ON wf2.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN vwx_SeasonYear_SEL vsy ON ssy.SeasonYearID = vsy.SeasonYearID
	WHERE wf1.WorkFlowItemID = @WorkflowItemID AND wf2.WorkFlowItemID <> @WorkflowItemID
	ORDER BY SeasonOrder
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05850', GetDate())
GO
