/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_SeasonYear_ByWorkflowMasterID_SELECT]    Script Date: 03/18/2014 13:30:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_SeasonYear_ByWorkflowMasterID_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_SeasonYear_ByWorkflowMasterID_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_SeasonYear_ByWorkflowMasterID_SELECT]    Script Date: 03/18/2014 13:30:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleBOM_SeasonYear_ByWorkflowMasterID_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@WorkflowItemMasterID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT bom.StyleBOMDimensionID, sy.Season, sy.[Year] FROM pWorkFlowItem wfi
    INNER JOIN pStyleSeasonYear ssy ON wfi.StyleSeasonYearID = ssy.StyleSeasonYearID
    INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
    INNER JOIN pStyleBOMDimension bom ON wfi.WorkFlowItemID = bom.WorkFlowItemID
    WHERE wfi.WorkflowItemMasterID = @WorkflowItemMasterID AND bom.StyleID = @StyleID
	ORDER BY sy.SeasonOrder, ssy.Sort, wfi.Sort
    
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07269', GetDate())
GO
