-- select * from pSourcingTradePartner where SourcingHeaderID = '5e83c647-c389-430c-9b81-2ff3cf075529'

BEGIN TRANSACTION
;WITH partners as (
	SELECT 
		SourcingHeaderID, SourcingTradePartnerID, stp.TradePartnerID, TradePartnerLevelID,
		CASE WHEN tprt.TradePartnerLevel = 1 THEN stp.TradePartnerID ELSE NULL END as AgentID,
		CASE WHEN tprt.TradePartnerLevel = 2 THEN stp.TradePartnerID ELSE NULL END as VendorID,
		CASE WHEN tprt.TradePartnerLevel = 3 THEN stp.TradePartnerID ELSE NULL END as FactoryID,
		3 as lvl -- if there are cyclic relationships do not go more than [lvl] levels
	FROM pSourcingTradePartner stp
	LEFT JOIN uTradePartner tp ON tp.TradePartnerID = stp.TradePartnerID
	LEFT JOIN uTradePartnerRelationshipType tprt ON tprt.TradePartnerRelationshipTypeID = tp.TradePartnerRelationshipType
	WHERE TradePartnerLevelID IS NULL
	
	UNION ALL
	
	SELECT 
		stp.SourcingHeaderID, stp.SourcingTradePartnerID, stp.TradePartnerID, stp.TradePartnerLevelID,
		CASE WHEN tprt.TradePartnerLevel = 1 THEN stp.TradePartnerID ELSE p.AgentID END as AgentID,
		CASE WHEN tprt.TradePartnerLevel = 2 THEN stp.TradePartnerID ELSE p.VendorID END as VendorID,
		CASE WHEN tprt.TradePartnerLevel = 3 THEN stp.TradePartnerID ELSE p.FactoryID END as FactoryID,
		p.lvl - 1 as lvl
	FROM partners p
	INNER JOIN uTradePartnerRelationship tpr ON p.TradePartnerID = tpr.TradePartnerMasterID
	INNER JOIN pSourcingTradePartner stp ON stp.TradePartnerLevelID = tpr.TradePartnerRelationshipID AND stp.SourcingHeaderID = p.SourcingHeaderID
	INNER JOIN uTradePartner tp ON tp.TradePartnerID = stp.TradePartnerID
	INNER JOIN uTradePartnerRelationshipType tprt ON tprt.TradePartnerRelationshipTypeID = tp.TradePartnerRelationshipType
	WHERE stp.TradePartnerLevelID IS NOT NULL AND lvl > 0
)
SELECT 
	IDENTITY(INT, 1, 1) as Row, SourcingTradePartnerID, TradePartnerLevelID, AgentID, VendorID, FactoryID,
	STUFF(
		ISNULL(',' + CAST(AgentID as VARCHAR(40)), '') 
		+ ISNULL(',' + CAST(VendorID as VARCHAR(40)), '') 
		+ ISNULL(',' + CAST(FactoryID as VARCHAR(40)), ''), 
	1, 1, '') as Chain,
	CAST(NULL as UNIQUEIDENTIFIER) as TradePartnerRelationshipLevelID
INTO #tmpSourcingTradePartner
FROM partners
ORDER BY 
	SourcingHeaderID,
	CASE WHEN AgentID IS NULL THEN 0 ELSE 1 END, AgentID,
	CASE WHEN VendorID IS NULL THEN 0 ELSE 1 END, VendorID,
	CASE WHEN FactoryID IS NULL THEN 0 ELSE 1 END, FactoryID
	
declare @Row INT = 1,
		@Total INT = (SELECT COUNT(*) FROM #tmpSourcingTradePartner)
		
while @Row <= @Total
begin
	declare @TradePartnerIDChain VARCHAR(MAX) = NULL,
			@SourcingTradePartnerID UNIQUEIDENTIFIER = NULL,
			@SourcingTradePartnerLevelID UNIQUEIDENTIFIER = NULL,
			@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL;
	
	SELECT 
		@TradePartnerIDChain = Chain, 
		@SourcingTradePartnerID =SourcingTradePartnerID, 
		@SourcingTradePartnerLevelID = TradePartnerLevelID
	FROM #tmpSourcingTradePartner WHERE Row = @Row
	
	-- create relationship in a tree and get it's PK
	exec spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, @TradePartnerRelationshipLevelID OUT
	
	print('UPDATE pSourcingTradePartner SET TradePartnerLevelID = ''' + CAST(@TradePartnerRelationshipLevelID as VARCHAR(40)) + '''' 
		+ ' WHERE SourcingTradePartnerID = ''' + CAST(@SourcingTradePartnerID as VARCHAR(40)) + ''''
		+ ' AND TradePartnerLevelID ' + ISNULL('= ''' + CAST(@SourcingTradePartnerLevelID as VARCHAR(40)) + '''', 'IS NULL'))	
	
	UPDATE pSourcingTradePartner SET TradePartnerLevelID = @TradePartnerRelationshipLevelID WHERE SourcingTradePartnerID = @SourcingTradePartnerID	
	
	set @Row = @Row + 1
end

DROP TABLE #tmpSourcingTradePartner
IF @@ERROR <> 0
	ROLLBACK
ELSE COMMIT
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04754', GetDate())
GO
