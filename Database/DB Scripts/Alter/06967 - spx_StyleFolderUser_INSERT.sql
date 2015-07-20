IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFolderUser_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFolderUser_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleFolderUser_INSERT](
	@StyleDevelopmentID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@TradePartner INT,
	@SeasonYearID UNIQUEIDENTIFIER
) AS 

IF (SELECT COUNT(*)  FROM pStyleTeam WITH (NOLOCK) WHERE  StyleID = @StyleID AND TeamID = @TeamID AND SeasonYearID = @SeasonYearID) = 0
BEGIN
	INSERT INTO pStyleTeam (TeamID, StyleDevelopmentID, StyleID, TradePartner, RequestStatus, SeasonYearID)
	VALUES (@TeamID, @StyleDevelopmentID, @StyleID, @TradePartner, 0, @SeasonYearID)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06967', GetDate())
GO
