/****** Object:  StoredProcedure [dbo].[spx_TechPack_WorkflowItems_SELECT]    Script Date: 06/21/2013 10:55:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPack_WorkflowItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPack_WorkflowItems_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPack_WorkflowItems_SELECT]    Script Date: 06/21/2013 10:55:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TechPack_WorkflowItems_SELECT]
	@ReportTechPackFolderID NVARCHAR(50),
	@StyleID UNIQUEIDENTIFIER,
	@WorkflowID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT @ReportTechPackFolderID as ReportTechPackFolderID, WorkFlowItemID, WorkFlowItemName 
	FROM pWorkFlowItem wi
	INNER JOIN Mapping m ON m.Map = wi.WorkflowID
	INNER JOIN pStyleSeasonYear si ON wi.StyleID = si.StyleID AND si.StyleSeasonYearID = wi.StyleSeasonYearID
	WHERE WorkflowID = @WorkflowID AND wi.StyleID = @StyleID
	AND (IsSeasonal = 0 OR (IsSeasonal = 1 AND si.SeasonYearID = @SeasonYearID))
	ORDER BY StyleSet, wi.Sort

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05893', GetDate())
GO
