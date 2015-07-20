IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMTechPackAgent_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMTechPackAgent_SELECTED]
GO

CREATE PROCEDURE [dbo].[spx_NPMTechPackAgent_SELECTED]
	@TechPackID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT * FROM pTechPackTeam WHERE TechPackID = @TechPackID AND TradePartnerRelationshipLevelID IS NOT NULL
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06039', GetDate())
GO
