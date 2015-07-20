IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMStyleFolderUser_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMStyleFolderUser_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_NPMStyleFolderUser_INSERT](
	@StyleDevelopmentID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@TradePartnerID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TradePartnerIDChain nVARCHAR(MAX) = NULL,
	@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL
) AS 

IF @TradePartnerRelationshipLevelID IS NULL
BEGIN
	EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, 
													@TradePartnerRelationshipLevelID OUT
END

IF NOT EXISTS(SELECT * FROM pStyleTeam WITH (NOLOCK) 
				WHERE StyleID = @StyleID 
					AND TeamID = @TradePartnerID 
					AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
					AND SeasonYearID = @SeasonYearID)
BEGIN
	INSERT INTO pStyleTeam (TeamID, StyleDevelopmentID, StyleID, TradePartner, RequestStatus, TradePartnerRelationshipLevelID, SeasonYearID)
	VALUES (@TradePartnerID, @StyleDevelopmentID, @StyleID, 1, 0, @TradePartnerRelationshipLevelID, @SeasonYearID)
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06966', GetDate())
GO
