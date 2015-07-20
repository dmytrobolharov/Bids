IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYearTeam_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYearTeam_SELECTED]
GO

CREATE PROCEDURE [dbo].[spx_StyleSeasonYearTeam_SELECTED] (
	@StyleID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
) AS 

SELECT b.SeasonYearID , b.Season + ' ' + b.Year AS SeasonYear 
FROM pStyleSeasonYear a
INNER JOIN pSeasonYear b ON a.SeasonYearID = b.SeasonYearID  
INNER JOIN pStyleTeam st ON a.SeasonYearID = st.SeasonYearID AND a.StyleID = st.StyleID
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON st.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
WHERE a.StyleID = @StyleID AND @TeamID IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID, st.TeamID)
ORDER BY a.Sort --b.CurrentSeason DESC, b.Year DESC, b.Season



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06968', GetDate())
GO
