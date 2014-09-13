/****** Object:  StoredProcedure [dbo].[spx_SourcingTradePartnerAvailable_SELECT]    Script Date: 01/10/2013 11:23:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingTradePartnerAvailable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingTradePartnerAvailable_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingTradePartnerAvailable_SELECT]    Script Date: 01/10/2013 11:23:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SourcingTradePartnerAvailable_SELECT]
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * INTO #tmpPartners 
    FROM vwx_TradePartnerMgmt_SEL ptm
    WHERE NOT EXISTS (
		SELECT * FROM pSourcingTradePartner stp 
		WHERE SourcingHeaderID = @SourcingHeaderID AND stp.TradePartnerLevelID = ptm.RelationshipLevelID) 
    ORDER BY 
		CASE WHEN AgentName IS NULL THEN 1 ELSE 0 END,
		AgentName,
		VendorName,
		FactoryName
		
	EXEC('SELECT * FROM #tmpPartners ' + @SearchCond)
		
	DROP TABLE #tmpPartners
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04748', GetDate())
GO
