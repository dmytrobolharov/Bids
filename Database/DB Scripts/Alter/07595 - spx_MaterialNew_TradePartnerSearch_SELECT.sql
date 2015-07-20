IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialNew_TradePartnerSearch_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialNew_TradePartnerSearch_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialNew_TradePartnerSearch_SELECT]
	@SearchCondition NVARCHAR(MAX),
	@TeamID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER
AS
BEGIN
	
	SET @SearchCondition = '%' + @SearchCondition + '%'
	
	SELECT TradePartnerIDChain as Value, STUFF(
        ISNULL(' -> ' + AgentName, '') +
        ISNULL(' -> ' + VendorName, '') +
        ISNULL(' -> ' + FactoryName, ''), 1, 4, '') AS 'Text' 
    FROM vwx_TradePartnerMgmt_SEL
	WHERE (AgentName LIKE @SearchCondition
		OR VendorName LIKE @SearchCondition
		OR FactoryName LIKE @SearchCondition)
		AND RelationshipLevelID NOT IN (
			SELECT TradePartnerRelationshipLevelID FROM tmpMaterialTradePartner WHERE MaterialID = @MaterialID)	
	ORDER BY LEN(TradePartnerIDChain), COALESCE(AgentName, VendorName, FactoryName), AgentName, VendorName, FactoryName
			--FactoryActive ASC, VendorActive ASC, AgentActive DESC, AgentName, VendorName, FactoryName
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07595', GetDate())
GO
