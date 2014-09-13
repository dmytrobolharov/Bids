/****** Object:  StoredProcedure [dbo].[spx_SourcingTradePartner_SELECT]    Script Date: 11/15/2012 17:26:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingTradePartner_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingTradePartner_SELECT]    Script Date: 11/15/2012 17:26:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SourcingTradePartner_SELECT]
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = N''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @Partners as TABLE(
		SourcingTradePartnerID UNIQUEIDENTIFIER, 
		AgentID UNIQUEIDENTIFIER, 
		VendorID UNIQUEIDENTIFIER, 
		FactoryID UNIQUEIDENTIFIER, Lvl INT
	)

	-- select root level of partners
	INSERT INTO @Partners(SourcingTradePartnerID, AgentID, VendorID, FactoryID, Lvl)
	SELECT 
		stp.SourcingTradePartnerID,
		CASE tpr.TradePartnerRelationshipTypeName WHEN 'AGENT' THEN stp.TradePartnerID ELSE NULL END as AgentID,
		CASE tpr.TradePartnerRelationshipTypeName WHEN 'VENDOR' THEN stp.TradePartnerID ELSE NULL END as VendorID,
		CASE tpr.TradePartnerRelationshipTypeName WHEN 'FACTORY' THEN stp.TradePartnerID ELSE NULL END as FactoryID,
		0
	FROM pSourcingTradePartner stp 
	LEFT JOIN uTradePartner tp ON stp.TradePartnerID = tp.TradePartnerID
	LEFT JOIN uTradePartnerRelationshipType tpr ON tpr.TradePartnerRelationshipTypeID = tp.TradePartnerRelationshipType
	WHERE stp.TradePartnerLevelID IS NULL AND stp.SourcingHeaderID = @SourcingHeaderID

	-- select vendors and factories for agents
	INSERT INTO @Partners(SourcingTradePartnerID, AgentID, VendorID, FactoryID, Lvl)
	SELECT stp.SourcingTradePartnerID, p.AgentID,		
		CASE tprt.TradePartnerRelationshipTypeName WHEN 'VENDOR' THEN stp.TradePartnerID ELSE NULL END as VendorID,
		CASE tprt.TradePartnerRelationshipTypeName WHEN 'FACTORY' THEN stp.TradePartnerID ELSE NULL END as FactoryID,
		p.Lvl + 1
	FROM @Partners p
	LEFT JOIN uTradePartnerRelationship tpr ON tpr.TradePartnerMasterID = p.AgentID
	INNER JOIN pSourcingTradePartner stp ON stp.TradePartnerLevelID = tpr.TradePartnerRelationshipID AND stp.SourcingHeaderID = @SourcingHeaderID
	LEFT JOIN uTradePartner tp ON tp.TradePartnerID = stp.TradePartnerID
	LEFT JOIN uTradePartnerRelationshipType tprt ON tprt.TradePartnerRelationshipTypeID = tp.TradePartnerRelationshipType

	-- select factories for vendors
	INSERT INTO @Partners(SourcingTradePartnerID, AgentID, VendorID, FactoryID, Lvl)
	SELECT stp.SourcingTradePartnerID, p.AgentID, p.VendorID,		
		CASE tprt.TradePartnerRelationshipTypeName WHEN 'FACTORY' THEN stp.TradePartnerID ELSE NULL END as FactoryID,
		p.Lvl + 1
	FROM @Partners p
	LEFT JOIN uTradePartnerRelationship tpr ON tpr.TradePartnerMasterID = p.VendorID
	INNER JOIN pSourcingTradePartner stp ON stp.TradePartnerLevelID = tpr.TradePartnerRelationshipID AND stp.SourcingHeaderID = @SourcingHeaderID
	LEFT JOIN uTradePartner tp ON tp.TradePartnerID = stp.TradePartnerID
	LEFT JOIN uTradePartnerRelationshipType tprt ON tprt.TradePartnerRelationshipTypeID = tp.TradePartnerRelationshipType

	-- result
	SELECT COALESCE(p.FactoryID, p.VendorID, p.AgentID) as TradePartnerID, p.*, tpa.TradePartnerName as AgentName, tpv.TradePartnerName as VendorName, tpf.TradePartnerName as FactoryName 
	INTO #tmpPartners
	FROM @Partners p
	LEFT JOIN uTradePartner tpa ON p.AgentID = tpa.TradePartnerID
	LEFT JOIN uTradePartner tpv ON p.VendorID = tpv.TradePartnerID
	LEFT JOIN uTradePartner tpf ON p.FactoryID = tpf.TradePartnerID
	ORDER BY AgentID DESC, VendorID, Lvl
	
	EXEC('SELECT * FROM #tmpPartners ' + @SearchCond)
	
	DROP TABLE #tmpPartners

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04358', GetDate())
GO