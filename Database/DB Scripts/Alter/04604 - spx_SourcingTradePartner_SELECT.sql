IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingTradePartner_SELECT]
GO

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
		AgentID UNIQUEIDENTIFIER
		, VendorID UNIQUEIDENTIFIER
		, FactoryID UNIQUEIDENTIFIER
		, Lvl INT
		, CountryCode VARCHAR(5)
	)

	-- select root level of partners
	INSERT INTO @Partners(SourcingTradePartnerID, AgentID, VendorID, FactoryID, Lvl, CountryCode)
	SELECT 
		stp.SourcingTradePartnerID,
		CASE tpr.TradePartnerLevel WHEN 1 THEN stp.TradePartnerID ELSE NULL END as AgentID,
		CASE tpr.TradePartnerLevel WHEN 2 THEN stp.TradePartnerID ELSE NULL END as VendorID,
		CASE tpr.TradePartnerLevel WHEN 3 THEN stp.TradePartnerID ELSE NULL END as FactoryID,
		0,
		tp.Country
	FROM pSourcingTradePartner stp 
	LEFT JOIN uTradePartner tp ON stp.TradePartnerID = tp.TradePartnerID
	LEFT JOIN uTradePartnerRelationshipType tpr ON tpr.TradePartnerRelationshipTypeID = tp.TradePartnerRelationshipType
	WHERE stp.TradePartnerLevelID IS NULL AND stp.SourcingHeaderID = @SourcingHeaderID

	-- select vendors and factories for agents
	INSERT INTO @Partners(SourcingTradePartnerID, AgentID, VendorID, FactoryID, Lvl, CountryCode)
	SELECT stp.SourcingTradePartnerID, p.AgentID,		
		CASE tprt.TradePartnerLevel WHEN 2 THEN stp.TradePartnerID ELSE NULL END as VendorID,
		CASE tprt.TradePartnerLevel WHEN 3 THEN stp.TradePartnerID ELSE NULL END as FactoryID,
		p.Lvl + 1,
		tp.Country
	FROM @Partners p
	LEFT JOIN uTradePartnerRelationship tpr ON tpr.TradePartnerMasterID = p.AgentID
	INNER JOIN pSourcingTradePartner stp ON stp.TradePartnerLevelID = tpr.TradePartnerRelationshipID AND stp.SourcingHeaderID = @SourcingHeaderID
	LEFT JOIN uTradePartner tp ON tp.TradePartnerID = stp.TradePartnerID
	LEFT JOIN uTradePartnerRelationshipType tprt ON tprt.TradePartnerRelationshipTypeID = tp.TradePartnerRelationshipType
	
	-- select factories for vendors
	INSERT INTO @Partners(SourcingTradePartnerID, AgentID, VendorID, FactoryID, Lvl, CountryCode)
	SELECT stp.SourcingTradePartnerID, p.AgentID, p.VendorID,		
		CASE tprt.TradePartnerLevel WHEN 3 THEN stp.TradePartnerID ELSE NULL END as FactoryID,
		p.Lvl + 1,
		tp.Country
	FROM @Partners p
	LEFT JOIN uTradePartnerRelationship tpr ON tpr.TradePartnerMasterID = p.VendorID
	INNER JOIN pSourcingTradePartner stp ON stp.TradePartnerLevelID = tpr.TradePartnerRelationshipID AND stp.SourcingHeaderID = @SourcingHeaderID
	LEFT JOIN uTradePartner tp ON tp.TradePartnerID = stp.TradePartnerID
	LEFT JOIN uTradePartnerRelationshipType tprt ON tprt.TradePartnerRelationshipTypeID = tp.TradePartnerRelationshipType
	
	SELECT
		COALESCE(p.FactoryID, p.VendorID, p.AgentID) as TradePartnerID
		, p.*
		, tpa.TradePartnerName as AgentName
		, tpv.TradePartnerName as VendorName
		, tpf.TradePartnerName as FactoryName
		, ac.CountryName as AgentCountry
		, vc.CountryName as VendorCountry
		, fc.CountryName as FactoryCountry
		, ( SELECT
				StatusDesc
			FROM
				uTradePartnerComplianceStatus
			WHERE
				StatusId = (
							CASE
								WHEN vci.StatusCount IS NULL THEN '00000000-0000-0000-0000-000000000000'
								WHEN vci.StatusCount = 0 THEN '00000000-0000-0000-0000-000000000002'
								ELSE '00000000-0000-0000-0000-000000000001'
							END)
			) AS VendorCStatus
		, ( SELECT
				StatusDesc
			FROM
				uTradePartnerComplianceStatus
			WHERE
				StatusId = (
							CASE
								WHEN fci.StatusCount IS NULL THEN '00000000-0000-0000-0000-000000000000'
								WHEN fci.StatusCount = 0 THEN '00000000-0000-0000-0000-000000000002'
								ELSE '00000000-0000-0000-0000-000000000001'
							END)
			) AS FactoryCStatus
	INTO #tmpPartners
	FROM @Partners p
	LEFT JOIN uTradePartner tpa ON p.AgentID = tpa.TradePartnerID
	LEFT JOIN uTradePartner tpv ON p.VendorID = tpv.TradePartnerID
	LEFT JOIN uTradePartner tpf ON p.FactoryID = tpf.TradePartnerID
	LEFT JOIN uCountry ac ON ac.CountryCode = tpa.Country
	LEFT JOIN uCountry vc ON vc.CountryCode = tpv.Country
	LEFT JOIN uCountry fc ON fc.CountryCode = tpf.Country
	LEFT JOIN (select TradePartnerId, sum(case When StatusId='00000000-0000-0000-0000-000000000001' Then 1 else 0 end) as StatusCount from uTradePartnerCompliance GROUP BY TradePartnerId) vci ON vci.TRadePartnerID = p.VendorID
	LEFT JOIN (select TradePartnerId, sum(case When StatusId='00000000-0000-0000-0000-000000000001' Then 1 else 0 end) as StatusCount from uTradePartnerCompliance GROUP BY TradePartnerId) fci ON fci.TRadePartnerID = p.FactoryID
	ORDER BY AgentID DESC, VendorID, Lvl
	
	EXEC('SELECT * FROM #tmpPartners')

	DROP TABLE #tmpPartners
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04604', GetDate())
GO
