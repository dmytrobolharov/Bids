IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TradePartnerRelationshipLevels_SEL]'))
DROP VIEW [dbo].[vwx_TradePartnerRelationshipLevels_SEL]
GO

CREATE VIEW [dbo].[vwx_TradePartnerRelationshipLevels_SEL]
AS
WITH tree as (
	SELECT 
		rl.TradePartnerRelationshipLevelID, rl.TradePartnerRelationshipParentLevelID,
		rl.TradePartnerID, rl.TradePartnerMasterID,
		CASE WHEN tprt.TradePartnerLevel = 1 THEN tp.TradePartnerID ELSE NULL END as AgentID,
		CASE WHEN tprt.TradePartnerLevel = 2 THEN tp.TradePartnerID ELSE NULL END as VendorID,
		CASE WHEN tprt.TradePartnerLevel = 3 THEN tp.TradePartnerID ELSE NULL END as FactoryID
	FROM uTradePartnerRelationshipLevel rl
	LEFT JOIN uTradePartner tp ON tp.TradePartnerID = rl.TradePartnerID
	LEFT JOIN uTradePartnerRelationshipType tprt ON tp.TradePartnerRelationshipType = tprt.TradePartnerRelationshipTypeID
	
	UNION ALL 
	
	SELECT 
		tree.TradePartnerRelationshipLevelID, rl.TradePartnerRelationshipParentLevelID,
		tree.TradePartnerID, rl.TradePartnerMasterID,
		CASE WHEN tprt.TradePartnerLevel = 1 THEN tp.TradePartnerID ELSE tree.AgentID END as AgentID,
		CASE WHEN tprt.TradePartnerLevel = 2 THEN tp.TradePartnerID ELSE tree.VendorID END as VendorID,
		CASE WHEN tprt.TradePartnerLevel = 3 THEN tp.TradePartnerID ELSE tree.FactoryID END as FactoryID
	FROM uTradePartnerRelationshipLevel rl
	INNER JOIN uTradePartner tp ON tp.TradePartnerID = rl.TradePartnerID
	INNER JOIN uTradePartnerRelationshipType tprt ON tp.TradePartnerRelationshipType = tprt.TradePartnerRelationshipTypeID
	INNER JOIN tree ON tree.TradePartnerRelationshipParentLevelID = rl.TradePartnerRelationshipLevelID	
),
ComplianceCount as (
	select TradePartnerId, sum(case When StatusId='00000000-0000-0000-0000-000000000001' Then 1 else 0 end) as StatusCount 
	from uTradePartnerCompliance GROUP BY TradePartnerId
)
SELECT 
	tree.*,
	tpa.TradePartnerName as AgentName,	tpv.TradePartnerName as VendorName, tpf.TradePartnerName as FactoryName,
	tpa.TradePartnerCode as AgentCode,  tpv.TradePartnerCode as VendorCode, tpf.TradePartnerCode as FactoryCode,
	tpa.Active as AgentActive,			tpv.Active as VendorActive,			tpf.Active as FactoryActive,
	ac.CountryName as AgentCountry,		vc.CountryName as VendorCountry,	fc.CountryName as FactoryCountry,
	SUBSTRING(ISNULL('/' + tpa.TradePartnerName, '') + ISNULL('/' + tpv.TradePartnerName, '') + ISNULL('/' + tpf.TradePartnerName, ''), 2, 2000) AS TradePartnerFullName,
	CASE
		WHEN cca.StatusCount IS NULL THEN '00000000-0000-0000-0000-000000000000'
		WHEN cca.StatusCount = 0 THEN '00000000-0000-0000-0000-000000000002'
		ELSE '00000000-0000-0000-0000-000000000001'
	END as AgentCStatusID,
	(SELECT	StatusDesc FROM	uTradePartnerComplianceStatus
	 WHERE StatusId = (CASE
							WHEN cca.StatusCount IS NULL THEN '00000000-0000-0000-0000-000000000000'
							WHEN cca.StatusCount = 0 THEN '00000000-0000-0000-0000-000000000002'
							ELSE '00000000-0000-0000-0000-000000000001'
						END)
	) AS AgentCStatus,
	CASE
		WHEN ccv.StatusCount IS NULL THEN '00000000-0000-0000-0000-000000000000'
		WHEN ccv.StatusCount = 0 THEN '00000000-0000-0000-0000-000000000002'
		ELSE '00000000-0000-0000-0000-000000000001'
	END as VendorCStatusID,
	(SELECT	StatusDesc FROM	uTradePartnerComplianceStatus
	 WHERE StatusId = (CASE
							WHEN ccv.StatusCount IS NULL THEN '00000000-0000-0000-0000-000000000000'
							WHEN ccv.StatusCount = 0 THEN '00000000-0000-0000-0000-000000000002'
							ELSE '00000000-0000-0000-0000-000000000001'
						END)
	) AS VendorCStatus,
	CASE
		WHEN ccf.StatusCount IS NULL THEN '00000000-0000-0000-0000-000000000000'
		WHEN ccf.StatusCount = 0 THEN '00000000-0000-0000-0000-000000000002'
		ELSE '00000000-0000-0000-0000-000000000001'
	END AS FactoryCStatusID,
	(SELECT	StatusDesc FROM	uTradePartnerComplianceStatus
	 WHERE StatusId = (CASE
							WHEN ccf.StatusCount IS NULL THEN '00000000-0000-0000-0000-000000000000'
							WHEN ccf.StatusCount = 0 THEN '00000000-0000-0000-0000-000000000002'
							ELSE '00000000-0000-0000-0000-000000000001'
						END)
	) AS FactoryCStatus,
	STUFF((
		SELECT DISTINCT ', ' + sc.StyleCategory
		FROM uTradePartnerProductType tppt INNER JOIN pStyleCategory sc ON tppt.StyleCategoryId = sc.StyleCategoryId
		WHERE tppt.TradePartnerId = COALESCE(FactoryID, VendorID, AgentID) FOR xml path('')
	), 1, 2, '') as ProductType
FROM tree
LEFT JOIN uTradePartner tpa ON tpa.TradePartnerID = tree.AgentID
LEFT JOIN uTradePartner tpv ON tpv.TradePartnerID = tree.VendorID
LEFT JOIN uTradePartner tpf ON tpf.TradePartnerID = tree.FactoryID
LEFT JOIN uCountry ac ON ac.CountryCode = tpa.Country
LEFT JOIN uCountry vc ON vc.CountryCode = tpv.Country
LEFT JOIN uCountry fc ON fc.CountryCode = tpf.Country
LEFT JOIN ComplianceCount cca ON cca.TradePartnerId = tree.AgentID 
LEFT JOIN ComplianceCount ccv ON ccv.TradePartnerId = tree.VendorID
LEFT JOIN ComplianceCount ccf ON ccf.TradePartnerId = tree.FactoryID
WHERE tree.TradePartnerRelationshipParentLevelID IS NULL


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07049', GetDate())
GO
