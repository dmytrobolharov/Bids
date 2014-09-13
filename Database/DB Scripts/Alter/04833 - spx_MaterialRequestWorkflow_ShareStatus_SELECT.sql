/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestWorkflow_ShareStatus_SELECT]    Script Date: 01/22/2013 16:14:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflow_ShareStatus_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflow_ShareStatus_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestWorkflow_ShareStatus_SELECT]    Script Date: 01/22/2013 16:14:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflow_ShareStatus_SELECT]
	@TradePartnerID UNIQUEIDENTIFIER,
	@MaterialRequestSubmitWorkflowID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT COUNT(*)
    FROM pMaterialRequestSubmitWorkflowShare
    WHERE TradePartnerID = @TradePartnerID
    AND MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID
    
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04833', GetDate())
GO
