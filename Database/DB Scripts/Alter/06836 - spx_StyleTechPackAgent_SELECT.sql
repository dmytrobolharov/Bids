IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTechPackAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTechPackAgent_SELECT]
GO

  
CREATE PROCEDURE [dbo].[spx_StyleTechPackAgent_SELECT] (
@StyleId uniqueidentifier,  
@TeamId uniqueidentifier,
@SeasonYearId uniqueidentifier = NULL
)  
AS   
  
IF @SeasonYearId IS NULL
BEGIN

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
	WHERE a.StyleID = @StyleId
		AND e.TeamID = @TeamId
	ORDER By TechPackNo DESC

END
ELSE
BEGIN

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
	WHERE a.StyleID = @StyleId AND b.SeasonYearID = @SeasonYearId
		AND e.TeamID = @TeamId
	ORDER By TechPackNo DESC

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06836', GetDate())
GO
