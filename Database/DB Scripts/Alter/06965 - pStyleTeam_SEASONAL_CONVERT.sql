INSERT INTO pStyleTeam(
	StyleTeamID, ManagerID, TeamID, StyleDevelopmentId, StyleID, TradePartner, 
	RequestStatus, RequestMessage, RequestGrantedBy, RequestDate, 
	TradePartnerRelationshipLevelID, SeasonYearID)
SELECT NEWID(), st.ManagerID, st.TeamID, st.StyleDevelopmentId, st.StyleID, st.TradePartner, 
	st.RequestStatus, st.RequestMessage, st.RequestGrantedBy, st.RequestDate, 
	st.TradePartnerRelationshipLevelID, ssy.SeasonYearID
FROM pStyleTeam st
INNER JOIN pStyleSeasonYear ssy ON st.StyleID = ssy.StyleID

DELETE FROM pStyleTeam WHERE SeasonYearID IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06965', GetDate())
GO
