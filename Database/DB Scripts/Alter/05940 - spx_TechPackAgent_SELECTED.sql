IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackAgent_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackAgent_SELECTED]
GO

CREATE PROCEDURE [dbo].[spx_TechPackAgent_SELECTED](@TechPackId uniqueidentifier)
AS
-- techpacks shared by old agent functionality
SELECT     dbo.uTradePartner.TradePartnerID, dbo.uTradePartner.TradePartnerCode, dbo.uTradePartner.TradePartnerName, dbo.uTradePartner.Country, 
                      dbo.pTechPackTeam.TechPackDownload, dbo.pTechPackTeam.TradePartner, dbo.pTechPackTeam.TechPackID, 
                      dbo.uTradePartner.TradePartnerID as AgentID, dbo.uTradePartner.TradePartnerName as AgentName, NULL as VendorID, NULL as VendorName, NULL as FactoryID, NULL as FactoryName
FROM         dbo.uTradePartner WITH (NOLOCK) INNER JOIN
                      dbo.pTechPackTeam WITH (NOLOCK) ON dbo.uTradePartner.TradePartnerID = dbo.pTechPackTeam.TeamID
WHERE     (dbo.pTechPackTeam.TechPackID = @TechPackId) AND dbo.pTechPackTeam.TradePartnerRelationshipLevelID IS NULL
UNION
-- techpacks shared by new partner functionality (agent/vendor/factory)
SELECT     dbo.uTradePartner.TradePartnerID, dbo.uTradePartner.TradePartnerCode, dbo.uTradePartner.TradePartnerName, dbo.uTradePartner.Country, 
                      dbo.pTechPackTeam.TechPackDownload, dbo.pTechPackTeam.TradePartner, dbo.pTechPackTeam.TechPackID,
                      tprl.AgentID, tprl.AgentName, tprl.VendorID, tprl.VendorName, tprl.FactoryID, tprl.FactoryName
FROM         dbo.uTradePartner WITH (NOLOCK) INNER JOIN
                      dbo.pTechPackTeam WITH (NOLOCK) ON dbo.uTradePartner.TradePartnerID = dbo.pTechPackTeam.TeamID INNER JOIN
                      dbo.vwx_TradePartnerRelationshipLevels_SEL tprl WITH (NOLOCK) ON dbo.pTechPackTeam.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
WHERE     (dbo.pTechPackTeam.TechPackID = @TechPackId)
ORDER BY dbo.pTechPackTeam.TradePartner, AgentName, VendorName, FactoryName

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05940', GetDate())
GO
