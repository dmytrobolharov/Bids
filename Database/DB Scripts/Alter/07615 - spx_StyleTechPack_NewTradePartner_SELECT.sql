IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTechPack_NewTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTechPack_NewTradePartner_SELECT]
GO



CREATE PROCEDURE [dbo].[spx_StyleTechPack_NewTradePartner_SELECT] (
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
			END AS ImagePath,
			STUFF
			((SELECT ', ' + wfi.WorkFlowItemName
			  FROM pTechPackWorkflowItem tpw
			  INNER JOIN pWorkFlowItem wfi ON wfi.WorkFlowItemID = tpw.WorkflowItemID AND wfi.WorkFlowID = '40000000-0000-0000-0000-000000000050' 
			  WHERE tpw.TechPackID = a.TechPackID FOR XML PATH('')), 1, 2, '') 
			  AS TechPackMeas,
			  STUFF
			((SELECT ', ' + wfi.WorkFlowItemName
			  FROM pTechPackWorkflowItem tpw
			  INNER JOIN pWorkFlowItem wfi ON wfi.WorkFlowItemID = tpw.WorkflowItemID AND wfi.WorkFlowID = '40000000-0000-0000-0000-000000000080' 
			  WHERE tpw.TechPackID = a.TechPackID FOR XML PATH('')), 1, 2, '') 
			  AS TechPackBom
	FROM dbo.pTechPack a WITH (NOLOCK) 
		INNER JOIN  dbo.pStyleHeader d WITH (NOLOCK) ON a.StyleID = d.StyleID 
		INNER JOIN  dbo.pTechPackTeam e WITH (NOLOCK) ON a.TechPackID = e.TechPackID  
		LEFT OUTER JOIN pStyleSeasonYear c WITH (NOLOCK) ON a.StyleSeasonYearID = c.StyleSeasonYearID
		LEFT OUTER JOIN pSeasonYear b WITH (NOLOCK) ON c.SeasonYearID  = b.SeasonYearID
		LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON e.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID
	WHERE a.StyleID = @StyleId
		AND @TeamId IN (e.TeamID, tpm.AgentID, tpm.VendorID, tpm.FactoryID)
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
			END AS ImagePath,
			STUFF
			((SELECT ', ' + wfi.WorkFlowItemName
			  FROM pTechPackWorkflowItem tpw
			  INNER JOIN pWorkFlowItem wfi ON wfi.WorkFlowItemID = tpw.WorkflowItemID AND wfi.WorkFlowID = '40000000-0000-0000-0000-000000000050' 
			  WHERE tpw.TechPackID = a.TechPackID FOR XML PATH('')), 1, 2, '') 
			  AS TechPackMeas,
			  STUFF
			((SELECT ', ' + wfi.WorkFlowItemName
			  FROM pTechPackWorkflowItem tpw
			  INNER JOIN pWorkFlowItem wfi ON wfi.WorkFlowItemID = tpw.WorkflowItemID AND wfi.WorkFlowID = '40000000-0000-0000-0000-000000000080' 
			  WHERE tpw.TechPackID = a.TechPackID FOR XML PATH('')), 1, 2, '') 
			  AS TechPackBom
	FROM dbo.pTechPack a WITH (NOLOCK) 
		INNER JOIN  dbo.pStyleHeader d WITH (NOLOCK) ON a.StyleID = d.StyleID 
		INNER JOIN  dbo.pTechPackTeam e WITH (NOLOCK) ON a.TechPackID = e.TechPackID  
		LEFT OUTER JOIN pStyleSeasonYear c WITH (NOLOCK) ON a.StyleSeasonYearID = c.StyleSeasonYearID
		LEFT OUTER JOIN pSeasonYear b WITH (NOLOCK) ON c.SeasonYearID  = b.SeasonYearID
		LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON e.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID
	WHERE a.StyleID = @StyleId AND b.SeasonYearID = @SeasonYearId
		AND @TeamId IN (e.TeamID, tpm.AgentID, tpm.VendorID, tpm.FactoryID)
	ORDER By TechPackNo DESC  

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07615', GetDate())
GO
