/****** Object:  StoredProcedure [dbo].[spx_LineFolder_TechPackTeam_INSERT]    Script Date: 07/11/2013 10:49:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_TechPackTeam_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_TechPackTeam_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_TechPackTeam_INSERT]    Script Date: 07/11/2013 10:49:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_TechPackTeam_INSERT]
@TechPackId UNIQUEIDENTIFIER,
@StyleDevelopmentId UNIQUEIDENTIFIER,
@StyleId UNIQUEIDENTIFIER,
@TradePartnerID UNIQUEIDENTIFIER,
@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL,
@TradePartnerIDChain VARCHAR(MAX)
AS 

IF @TradePartnerRelationshipLevelID IS NULL
BEGIN
	EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, @TradePartnerRelationshipLevelID OUT
END

IF (SELECT COUNT(*) FROM pTechPackTeam WITH (NOLOCK) WHERE TechPackID = @TechpackId AND TeamID = @TradePartnerID 
	AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID) = 0
BEGIN
	INSERT INTO pTechPackTeam
		(TechPackID, StyleDevelopmentId, StyleId, TeamID, TradePartner, CDate, TradePartnerRelationshipLevelID)
	VALUES(@TechPackId, @StyleDevelopmentId, @StyleId, @TradePartnerID, 1, GETDATE(), @TradePartnerRelationshipLevelID)
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06033', GetDate())
GO
