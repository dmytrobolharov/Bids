IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TechPack_SEL]'))
DROP VIEW [dbo].[vwx_TechPack_SEL]
GO

CREATE VIEW [dbo].[vwx_TechPack_SEL]
AS
SELECT     CASE WHEN dbo.pTechPack.TechPackID = dbo.pStyleHeader.TechPackId THEN CASE WHEN dbo.pTechPack.StyleVersion = dbo.pStyleHeader.Change THEN '<img  src=''../System/Icons/icon_packageok.gif'' >'
                       ELSE '<img  src=''../System/Icons/icon_packagefail.gif'' >' END ELSE CASE WHEN dbo.pTechPack.StyleVersion = dbo.pStyleHeader.Change THEN '<img  src=''../System/Icons/icon_packageok.gif'' >'
                       ELSE '<img  src=''../System/Icons/icon_packagefail.gif'' >' END END AS ImagePath, dbo.pTechPack.TechPackID, dbo.pTechPack.TechPackNo, 
                      dbo.pTechPack.TechPackStatus, dbo.pTechPack.TechPackName, dbo.pTechPack.StyleID, dbo.pTechPack.CDate, dbo.pTechPack.CUser, 
                      dbo.pStyleHeader.TechPackId AS FinalTechPackId, dbo.pTechPack.Notes, dbo.pStyleHeader.TechPackDate AS FinalTechPackDate, 
                      dbo.pTechPack.StyleVersion AS TechPackStyleVersion, dbo.pStyleHeader.Change AS StyleVersion, dbo.pTechPack.TechPackRelease, dbo.pSeasonYear.Season, 
                      dbo.pSeasonYear.Year, dbo.sSystemCulture.CultureName, dbo.sSystemCulture.CultureLanguage + ' (' + dbo.sSystemCulture.CultureCountry + ')' AS CultureDesc, 
                      dbo.pTechPack.Active, dbo.pSeasonYear.SeasonYearID,
	STUFF
	((SELECT ', ' + wfi.WorkFlowItemName
	  FROM pTechPackWorkflowItem tpw
	  INNER JOIN pWorkFlowItem wfi ON wfi.WorkFlowItemID = tpw.WorkflowItemID AND wfi.WorkFlowID = '40000000-0000-0000-0000-000000000050' 
	  WHERE tpw.TechPackID = dbo.pTechPack.TechPackID FOR XML PATH('')), 1, 2, '') 
	  AS TechPackMeas,
	  STUFF
	((SELECT ', ' + wfi.WorkFlowItemName
	  FROM pTechPackWorkflowItem tpw
	  INNER JOIN pWorkFlowItem wfi ON wfi.WorkFlowItemID = tpw.WorkflowItemID AND wfi.WorkFlowID = '40000000-0000-0000-0000-000000000080' 
	  WHERE tpw.TechPackID = dbo.pTechPack.TechPackID FOR XML PATH('')), 1, 2, '') 
	  AS TechPackBom
FROM         dbo.pTechPack WITH (NOLOCK) INNER JOIN
                      dbo.pStyleHeader WITH (NOLOCK) ON dbo.pTechPack.StyleID = dbo.pStyleHeader.StyleID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear ON dbo.pTechPack.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID LEFT OUTER JOIN
                      dbo.pSeasonYear ON dbo.pStyleSeasonYear.SeasonYearID = dbo.pSeasonYear.SeasonYearID LEFT OUTER JOIN
                      dbo.sSystemCulture ON dbo.pTechPack.SystemCultureId = dbo.sSystemCulture.SystemCultureId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06783', GetDate())
GO
