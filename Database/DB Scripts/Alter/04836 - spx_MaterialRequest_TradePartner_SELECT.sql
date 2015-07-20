/****** Object:  StoredProcedure [dbo].[spx_MaterialRequest_TradePartner_SELECT]    Script Date: 01/21/2013 16:43:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequest_TradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequest_TradePartner_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequest_TradePartner_SELECT]    Script Date: 01/21/2013 16:43:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequest_TradePartner_SELECT]
	@MaterialTradePartnerID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT tpm.* FROM pMaterialTradePartner mtp
    LEFT JOIN vwx_TradePartnerMgmt_SEL tpm
    ON mtp.TradePartnerRelationshipLevelID = tpm.RelationshipLevelID
    WHERE mtp.MaterialTradePartnerId = @MaterialTradePartnerID
    
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04836', GetDate())
GO
