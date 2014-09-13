/****** Object:  View [dbo].[vwx_TradePartnerMgmt_SEL]    Script Date: 12/25/2012 18:22:59 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TradePartnerMgmt_SEL]'))
DROP VIEW [dbo].[vwx_TradePartnerMgmt_SEL]
GO

/****** Object:  View [dbo].[vwx_TradePartnerMgmt_SEL]    Script Date: 12/25/2012 18:22:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_TradePartnerMgmt_SEL]
AS

WITH ComplianceCount as (
	select TradePartnerId, sum(case When StatusId='00000000-0000-0000-0000-000000000001' Then 1 else 0 end) as StatusCount 
	from uTradePartnerCompliance GROUP BY TradePartnerId
),
c as (
	SELECT tp.TradePartnerID,
	CASE WHEN tpr.TradePartnerLevel = 1 THEN tp.TradePartnerID ELSE NULL END as AgentID,
	CASE WHEN tpr.TradePartnerLevel = 2 THEN tp.TradePartnerID ELSE NULL END as VendorID,
	CASE WHEN tpr.TradePartnerLevel = 3 THEN tp.TradePartnerID ELSE NULL END as FactoryID,
	CAST(NULL as UNIQUEIDENTIFIER) as TradePartnerRelationshipID,
	tpr.TradePartnerLevel as Lvl
	FROM uTradePartner tp
	LEFT JOIN uTradePartnerRelationshipType tpr ON tpr.TradePartnerRelationshipTypeID = tp.TradePartnerRelationshipType	
	WHERE tp.Direct = 1	
	
	UNION ALL
	
	SELECT tpr.TradePartnerID, 
	CASE WHEN tprt.TradePartnerLevel = 1 THEN tpr.TradePartnerID ELSE c.AgentID END as AgentID,
	CASE WHEN tprt.TradePartnerLevel = 2 THEN tpr.TradePartnerID ELSE c.VendorID END as VendorID,
	CASE WHEN tprt.TradePartnerLevel = 3 THEN tpr.TradePartnerID ELSE c.FactoryID END as FactoryID,
	tpr.TradePartnerRelationshipID,
	(c.Lvl + 1) as lvl FROM c	
	INNER JOIN uTradePartnerRelationship tpr ON c.TradePartnerID = tpr.TradePartnerMasterID
	INNER JOIN uTradePartner tp ON tp.TradePartnerID = tpr.TradePartnerID
	INNER JOIN uTradePartnerRelationshipType tprt ON tprt.TradePartnerRelationshipTypeID = tp.TradePartnerRelationshipType
	WHERE Lvl < 3
)
SELECT	COALESCE(FactoryID, VendorID, AgentID) as TradePartnerID,
		tpa.TradePartnerID as AgentID,		tpv.TradePartnerID as VendorID,		tpf.TradePartnerID as FactoryID,
		tpa.TradePartnerName as AgentName,	tpv.TradePartnerName as VendorName, tpf.TradePartnerName as FactoryName,
		tpa.TradePartnerCode as AgentCode,  tpv.TradePartnerCode as VendorCode, tpf.TradePartnerCode as FactoryCode,
		tpa.Active as AgentActive,			tpv.Active as VendorActive,			tpf.Active as FactoryActive,	
		ac.CountryName as AgentCountry,		vc.CountryName as VendorCountry,	fc.CountryName as FactoryCountry,
		(SELECT	StatusDesc FROM	uTradePartnerComplianceStatus
		 WHERE StatusId = (CASE
								WHEN ccv.StatusCount IS NULL THEN '00000000-0000-0000-0000-000000000000'
								WHEN ccv.StatusCount = 0 THEN '00000000-0000-0000-0000-000000000002'
								ELSE '00000000-0000-0000-0000-000000000001'
							END)
		) AS VendorCStatus,
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
		), 1, 2, '') as ProductType,
		c.TradePartnerRelationshipID FROM c 
LEFT JOIN uTradePartner tpa ON tpa.TradePartnerID = c.AgentID
LEFT JOIN uTradePartner tpv ON tpv.TradePartnerID = c.VendorID
LEFT JOIN uTradePartner tpf ON tpf.TradePartnerID = c.FactoryID
LEFT JOIN uCountry ac ON ac.CountryCode = tpa.Country
LEFT JOIN uCountry vc ON vc.CountryCode = tpv.Country
LEFT JOIN uCountry fc ON fc.CountryCode = tpf.Country
LEFT JOIN ComplianceCount cca ON cca.TradePartnerId = c.AgentID 
LEFT JOIN ComplianceCount ccv ON ccv.TradePartnerId = c.VendorID
LEFT JOIN ComplianceCount ccf ON ccf.TradePartnerId = c.FactoryID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04686', GetDate())
GO