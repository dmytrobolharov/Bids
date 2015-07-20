/****** Object:  StoredProcedure [dbo].[spx_NPMTechPackTeam_INSERT]    Script Date: 01/30/2013 17:07:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMTechPackTeam_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMTechPackTeam_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMTechPackTeam_INSERT]    Script Date: 01/30/2013 17:07:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMTechPackTeam_INSERT]
@TechPackId uniqueidentifier,
@StyleDevelopmentId uniqueidentifier,
@StyleId uniqueidentifier,
@TradePartnerID uniqueidentifier,
@TradePartnerIDChain VARCHAR(MAX) = NULL,
@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL
AS 

IF @TradePartnerRelationshipLevelID IS NULL
BEGIN
	EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, 
													@TradePartnerRelationshipLevelID OUT
END

IF (SELECT COUNT(*) FROM pTechPackTeam WITH (NOLOCK) WHERE TechPackID = @TechpackId AND TeamID = @TradePartnerID AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID) = 0
BEGIN
	INSERT INTO pTechPackTeam
		(TechPackID, StyleDevelopmentId, StyleId, TeamID, TradePartner, CDate, TradePartnerRelationshipLevelID)
	VALUES(@TechPackId, @StyleDevelopmentId, @StyleId, @TradePartnerID, 1, GETDATE(), @TradePartnerRelationshipLevelID)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04932', GetDate())
GO
