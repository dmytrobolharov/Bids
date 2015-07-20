  
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTechPackAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTechPackAgent_SELECT]
GO
  
CREATE PROCEDURE [dbo].[spx_StyleTechPackAgent_SELECT] (@StyleId uniqueidentifier,  
@TeamId uniqueidentifier)  
AS   
  
  
SELECT     dbo.pTechPack.TechPackID, dbo.pTechPack.TechPackNo, dbo.pTechPack.TechPackStatus, dbo.pTechPack.TechPackName, dbo.pTechPack.StyleID,   
                      dbo.pTechPack.CDate, dbo.pTechPack.CUser, dbo.pStyleHeader.TechPackId AS FinalTechPackId,   
                      dbo.pStyleHeader.TechPackDate AS FinalTechPackDate, dbo.pTechPackTeam.TechPackDownload, dbo.pTechPackTeam.TeamID, b.Season AS Season, b.Year AS [Year]  
FROM         dbo.pTechPack WITH (NOLOCK) INNER JOIN  
                      dbo.pStyleHeader WITH (NOLOCK) ON dbo.pTechPack.StyleID = dbo.pStyleHeader.StyleID INNER JOIN  
                      dbo.pTechPackTeam WITH (NOLOCK) ON dbo.pTechPack.TechPackID = dbo.pTechPackTeam.TechPackID  LEFT OUTER JOIN
                       pSeasonYear b ON pTechPack.StyleSeasonYearID  = b.SeasonYearID
WHERE     (pTechPack.StyleID = @StyleId) AND (pTechPackTeam.TeamID = @TeamId)  
ORDER By TechPackNo DESC  

 GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '646', GetDate())

GO


