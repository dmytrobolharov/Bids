IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TechPackDownloads_Shared_SELECT]'))
DROP VIEW [dbo].[vwx_TechPackDownloads_Shared_SELECT]
GO

CREATE VIEW [dbo].[vwx_TechPackDownloads_Shared_SELECT]
AS
SELECT tp.TechPackID, tp.TechPackNo, tp.TechPackName, tp.CDate, tpm.AgentID, tpm.VendorID, tpm.FactoryID, tpm.AgentName, tpm.
	VendorName, tpm.FactoryName, TechPackDownload = CASE tpt.TechPackDownload
		WHEN 0
			THEN 'No'
		ELSE 'Yes'
		END, sy.Season, sy.Year, sh.SizeClass, sh.SizeRange, sh.StyleNo, sh.Description, HasAttachments = CASE (
			SELECT COUNT(*)
			FROM pStyleDocument
			WHERE StyleDocumentShared = 1
				AND StyleId = sh.StyleID
			)
		WHEN 0
			THEN 'No'
		ELSE 'Yes'
		END, sh.CustomField3 AS Delivery, sh.Active, sh.ProductionManager, CustomField1 AS Division, sy.SeasonYearID, sh.StyleType
	, sh.StyleID, sh.CustomField1, sh.CustomField2, sh.CustomField3, sh.CustomField4, sh.CustomField5, sh.CustomField6, sh.
	CustomField7, sh.CustomField8, sh.CustomField9, sh.CustomField10, sh.CustomField11, sh.CustomField12, sh.CustomField13, sh.
	CustomField14, sh.CustomField15, sh.CustomField16, sh.CustomField17, sh.CustomField18, sh.CustomField19, sh.CustomField20, 
	sh.CustomField21, sh.CustomField22, sh.CustomField23, sh.CustomField24, sh.CustomField25, sh.CustomField26, sh.
	CustomField27, sh.CustomField28, sh.CustomField29, sh.CustomField30, sh.CustomField31, sh.CustomField32, sh.CustomField33, 
	sh.CustomField34, sh.CustomField35, sh.CustomField36, sh.CustomField37, sh.CustomField38, sh.CustomField39, sh.
	CustomField40, sh.CUser AS StyleCUser, sh.MUser AS StyleMUser, sh.IntroSeasonYearID
FROM pTechPack tp
INNER JOIN pTechPackTeam tpt ON tpt.TechPackID = tp.TechPackID
INNER JOIN pStyleHeader sh ON sh.StyleID = tp.StyleID
LEFT JOIN pStyleSeasonYear ssy ON ssy.StyleSeasonYearID = tp.StyleSeasonYearID
LEFT JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationshipLevelID = tpt.
	TradePartnerRelationshipLevelID




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06040', GetDate())
GO
