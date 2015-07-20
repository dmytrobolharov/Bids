/****** Object:  StoredProcedure [dbo].[spx_StyleTechPack_NewTradePartner_SELECT]    Script Date: 02/04/2013 17:25:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTechPack_NewTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTechPack_NewTradePartner_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleTechPack_NewTradePartner_SELECT]    Script Date: 02/04/2013 17:25:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleTechPack_NewTradePartner_SELECT] (@StyleId uniqueidentifier,  
@TeamId uniqueidentifier)  
AS   
  
  
SELECT	a.TechPackID, a.TechPackNo, a.TechPackStatus, a.TechPackName, a.StyleID,   
		a.CDate, a.CUser, d.TechPackId AS FinalTechPackId,   
		d.TechPackDate AS FinalTechPackDate, 
		e.TechPackDownload, e.TeamID, 
		b.Season AS Season, b.Year AS [Year],
		CASE 
			WHEN e.TechPackDownload = 1 THEN  'Yes'
			ELSE 'No' 
		END AS Downloaded,
		CASE 
			WHEN a.TechPackID = d.TechPackId 
			THEN 
				CASE 
					WHEN a.StyleVersion = d.Change 
						THEN '<img  src=''../System/Icons/icon_packageok.gif'' >' 
						ELSE '<img  src=''../System/Icons/icon_packagefail.gif'' >' 
				END 
			ELSE 
				CASE WHEN a.StyleVersion = d.Change 
					THEN '<img  src=''../System/Icons/icon_packageok.gif'' >' 
					ELSE '<img  src=''../System/Icons/icon_packagefail.gif'' >' 
				END 
		END AS ImagePath		
FROM dbo.pTechPack a WITH (NOLOCK) 
	INNER JOIN  dbo.pStyleHeader d WITH (NOLOCK) ON a.StyleID = d.StyleID 
	INNER JOIN  dbo.pTechPackTeam e WITH (NOLOCK) ON a.TechPackID = e.TechPackID  
	LEFT OUTER JOIN pStyleSeasonYear c WITH (NOLOCK) ON a.StyleSeasonYearID = c.StyleSeasonYearID
	LEFT OUTER JOIN pSeasonYear b WITH (NOLOCK) ON c.SeasonYearID  = b.SeasonYearID
	LEFT OUTER JOIN vwx_TradePartnerMgmt_SEL tpm ON e.TradePartnerRelationshipLevelID = tpm.RelationshipLevelID
WHERE a.StyleID = @StyleId
	AND @TeamId IN (e.TeamID, tpm.AgentID, tpm.VendorID, tpm.FactoryID)
ORDER By TechPackNo DESC  


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04965', GetDate())
GO
