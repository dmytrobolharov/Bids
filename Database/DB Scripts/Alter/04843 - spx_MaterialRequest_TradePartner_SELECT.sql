/****** Object:  StoredProcedure [dbo].[spx_MaterialRequest_TradePartner_SELECT]    Script Date: 01/22/2013 17:21:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequest_TradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequest_TradePartner_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequest_TradePartner_SELECT]    Script Date: 01/22/2013 17:21:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequest_TradePartner_SELECT]
	@MaterialTradePartnerID UNIQUEIDENTIFIER,
	@MaterialTradePartnerColorID UNIQUEIDENTIFIER,
	@MaterialRequestWorkflowID NVARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT tpm.*, sw.* FROM pMaterialTradePartner mtp
    INNER JOIN pMaterialRequestSubmitWorkflow sw ON sw.TradePartnerID = mtp.TradepartnerId
    LEFT JOIN vwx_TradePartnerMgmt_SEL tpm ON mtp.TradePartnerRelationshipLevelID = tpm.RelationshipLevelID
    WHERE mtp.MaterialTradePartnerId = @MaterialTradePartnerID
    AND sw.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
    AND sw.MaterialTradePartnerColorID = @MaterialTradePartnerColorID
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04843', GetDate())
GO
