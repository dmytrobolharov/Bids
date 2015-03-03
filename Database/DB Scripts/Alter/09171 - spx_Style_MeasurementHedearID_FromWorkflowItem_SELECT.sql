/****** Object:  StoredProcedure [dbo].[spx_Style_MeasurementHedearID_FromWorkflowItem_SELECT]    Script Date: 11/24/2014 14:20:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_MeasurementHedearID_FromWorkflowItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_MeasurementHedearID_FromWorkflowItem_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Style_MeasurementHedearID_FromWorkflowItem_SELECT]    Script Date: 11/24/2014 14:20:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

Create PROCEDURE [dbo].[spx_Style_MeasurementHedearID_FromWorkflowItem_SELECT]
	@WorkflowItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT AMLMeasHdrId FROM pAMLMeasHdr where WorkFlowItemId = @WorkflowItemID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09171', GetDate())
GO
