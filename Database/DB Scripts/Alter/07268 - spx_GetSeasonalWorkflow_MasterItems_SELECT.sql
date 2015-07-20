/****** Object:  StoredProcedure [dbo].[spx_GetSeasonalWorkflow_MasterItems_SELECT]    Script Date: 03/18/2014 13:29:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GetSeasonalWorkflow_MasterItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GetSeasonalWorkflow_MasterItems_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_GetSeasonalWorkflow_MasterItems_SELECT]    Script Date: 03/18/2014 13:29:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_GetSeasonalWorkflow_MasterItems_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@WorkflowID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT DISTINCT WorkflowItemMasterID, WorkFlowItemName 
    FROM pWorkFlowItem 
    WHERE StyleID=@StyleID
    AND WorkflowID=@WorkflowID
    ORDER BY WorkFlowItemName
    
END


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07268', GetDate())
GO
