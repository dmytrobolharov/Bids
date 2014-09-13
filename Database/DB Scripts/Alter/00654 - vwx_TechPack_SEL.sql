
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TechPack_SEL]'))
DROP VIEW [dbo].[vwx_TechPack_SEL]
GO

CREATE VIEW [dbo].[vwx_TechPack_SEL]
AS
SELECT     CASE WHEN dbo.pTechPack.TechPackID = dbo.pStyleHeader.TechPackId THEN CASE WHEN dbo.pTechPack.StyleVersion = dbo.pStyleHeader.Change THEN
                       '<img  src=''../System/Icons/icon_packageok.gif'' >' ELSE '<img  src=''../System/Icons/icon_packagefail.gif'' >' END ELSE CASE WHEN dbo.pTechPack.StyleVersion
                       = dbo.pStyleHeader.Change THEN '<img  src=''../System/Icons/icon_packageok.gif'' >' ELSE '<img  src=''../System/Icons/icon_packagefail.gif'' >' END END
                       AS ImagePath, dbo.pTechPack.TechPackID, dbo.pTechPack.TechPackNo, dbo.pTechPack.TechPackStatus, dbo.pTechPack.TechPackName, 
                      dbo.pTechPack.StyleID, dbo.pTechPack.CDate, dbo.pTechPack.CUser, dbo.pStyleHeader.TechPackId AS FinalTechPackId, dbo.pTechPack.Notes, 
                      dbo.pStyleHeader.TechPackDate AS FinalTechPackDate, dbo.pTechPack.StyleVersion AS TechPackStyleVersion, 
                      dbo.pStyleHeader.Change AS StyleVersion, dbo.pTechPack.TechPackRelease,
                      b.Season AS Season, b.Year AS [Year]                       
 FROM         dbo.pTechPack WITH (NOLOCK) 
INNER JOIN  dbo.pStyleHeader WITH (NOLOCK) ON dbo.pTechPack.StyleID = dbo.pStyleHeader.StyleID 
LEFT OUTER JOIN pStyleSeasonYear c ON pTechPack.StyleSeasonYearID = c.StyleSeasonYearID
LEFT OUTER JOIN pSeasonYear b ON c.SeasonYearID  = b.SeasonYearID 
                       
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '649', GetDate())
GO
                      
                      
                      



