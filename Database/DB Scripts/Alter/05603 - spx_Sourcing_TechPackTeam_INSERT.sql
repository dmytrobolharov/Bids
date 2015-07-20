IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_TechPackTeam_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_TechPackTeam_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_Sourcing_TechPackTeam_INSERT]
@TechPackId uniqueidentifier,
@StyleDevelopmentId uniqueidentifier,
@StyleId uniqueidentifier,
@SourcingTradePartnerID uniqueidentifier
AS 

DECLARE @TradePartnerID UNIQUEIDENTIFIER, 
		@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER

SELECT @TradePartnerID = TradePartnerID, @TradePartnerRelationshipLevelID = TradePartnerLevelID 
FROM pSourcingTradePartner
WHERE SourcingTradePartnerID = @SourcingTradePartnerID


IF (SELECT COUNT(*) FROM pTechPackTeam WITH (NOLOCK) WHERE TechPackID = @TechpackId AND TeamID = @TradePartnerID AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID) = 0
BEGIN
	INSERT INTO pTechPackTeam
		(TechPackID, StyleDevelopmentId, StyleId, TeamID, TradePartner, CDate, TradePartnerRelationshipLevelID)
	VALUES(@TechPackId, @StyleDevelopmentId, @StyleId, @TradePartnerID, 1, GETDATE(), @TradePartnerRelationshipLevelID)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05603', GetDate())
GO
