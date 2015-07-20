/****** Object:  StoredProcedure [dbo].[spx_SourcingTradePartners_SELECT]    Script Date: 01/10/2013 11:12:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingTradePartners_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingTradePartners_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingTradePartners_SELECT]    Script Date: 01/10/2013 11:12:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SourcingTradePartners_SELECT]
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = N''
AS
BEGIN
	
	SELECT 
		stp.SourcingTradePartnerID, stp.SourcingHeaderID, stp.TradePartnerLevelID,
		stp.TradePartnerTypeID, stp.Custom1, stp.Custom2, stp.Custom3, stp.Custom4, stp.Custom5,
		stp.CUser, stp.CDate, stp.MUser, stp.MDate, stp.Active,	rl.* 
	INTO #tmpPartners
	FROM pSourcingTradePartner stp
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL rl ON rl.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
	WHERE stp.SourcingHeaderID = @SourcingHeaderID
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
VALUES ('DB_Version', '5.0.0000', '04747', GetDate())
GO
