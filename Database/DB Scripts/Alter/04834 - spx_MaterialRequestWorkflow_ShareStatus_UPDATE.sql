/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestWorkflow_ShareStatus_UPDATE]    Script Date: 01/22/2013 12:03:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflow_ShareStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflow_ShareStatus_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestWorkflow_ShareStatus_UPDATE]    Script Date: 01/22/2013 12:03:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflow_ShareStatus_UPDATE]
(
	@MaterialRequestSubmitWorkflowID uniqueidentifier,
	@TradePartnerID uniqueidentifier,
	@IsADD bit,
	@MUser nvarchar(200),
	@MDate datetime
)
AS 

BEGIN

IF @IsADD = 1
	BEGIN 
		IF NOT EXISTS (SELECT * FROM pMaterialRequestSubmitWorkflowShare WHERE MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID AND TradePartnerId = @TradePartnerID)
			INSERT INTO pMaterialRequestSubmitWorkflowShare (MaterialRequestSubmitWorkflowID, TradePartnerId, MUser, MDate) 
			VALUES(@MaterialRequestSubmitWorkflowID, @TradePartnerID, @MUser, @MDate)
	END
ELSE
	BEGIN
		DELETE FROM pMaterialRequestSubmitWorkflowShare WHERE MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID AND TradePartnerId = @TradePartnerID
	END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04834', GetDate())
GO
