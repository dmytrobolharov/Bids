IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleHeader_SELECT]'))
DROP VIEW [dbo].[vwx_StyleHeader_SELECT]
GO

/*
select   * from (

 (
SELECT     pStyleHeader.* , NULL  as AgentVendor
FROM         dbo.pStyleHeader
WHERE  pStyleHeader.StyleId NOT IN (
	SELECT  a.StyleID
	FROM pStyleTeam a , uTradePartner  b
	WHERE  a.TeamID  = b.TradePartnerID
	AND b.Custom1 = 'Agent-Vendor'  
	GROUP BY  a.StyleID
	HAVING COUNT(*) >= 1
	)
)
UNION ALL
(
SELECT  c.* ,   b.TradePartnerName     as AgentVendor
FROM pStyleTeam a , uTradePartner  b, pStyleHeader c
WHERE  a.TeamID  = b.TradePartnerID
AND a.StyleID = c.StyleID
AND b.Custom1 = 'Agent-Vendor'  
) 




UNION 
(
	SELECT  pStyleHeader.* ,  NULL AS AgentVendor
	FROM  pStyleHeader 	
	WHERE StyleID  IN ( 
		SELECT  a.StyleID 
		FROM pStyleTeam a , uTradePartner  b 
		WHERE  a.TeamID  = b.TradePartnerID
		AND ( b.Custom1 not LIKE  '%Agent-Vendor%'   OR b.Custom1 IS NULL  )
		GROUP BY  a.StyleID
	)

)


)as foo */
CREATE VIEW [dbo].[vwx_StyleHeader_SELECT]
AS
SELECT     dbo.pStyleHeader.StyleID, dbo.pStyleHeader.StyleMasterID, dbo.pStyleHeader.StyleWorkflowID, dbo.pStyleHeader.StyleType, dbo.pStyleHeader.WorkflowType, 
                      dbo.pStyleHeader.RefNo, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.TempID, dbo.pStyleHeader.TempNo, dbo.pStyleHeader.CustomerNo, 
                      dbo.pStyleHeader.DevelopmentID, dbo.pStyleHeader.DevelopmentNo, dbo.pStyleHeader.ConceptID, dbo.pStyleHeader.ConceptNo, dbo.pStyleHeader.SpecNo, 
                      dbo.pStyleHeader.Description, dbo.pStyleHeader.StyleCategory, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.StyleSet, 
                      dbo.pStyleHeader.TechPackId, dbo.pStyleHeader.TechPackDate, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, dbo.pStyleHeader.Customer, 
                      dbo.pStyleHeader.Buyer, dbo.pStyleHeader.Designer, dbo.pStyleHeader.SampleMaker, dbo.pStyleHeader.PatternMaker, dbo.pStyleHeader.ProductionManager, 
                      dbo.pStyleHeader.TechnicalDesigner, dbo.pStyleHeader.StyleStatus, dbo.pStyleHeader.StyleLocation, dbo.pStyleHeader.WashType, dbo.pStyleHeader.Pitch, 
                      dbo.pStyleHeader.MaterialID, dbo.pStyleHeader.MaterialImageID, dbo.pStyleHeader.MaterialImageVersion, dbo.pStyleHeader.MaterialNo, 
                      dbo.pStyleHeader.MaterialName, dbo.pStyleHeader.POMTempGroupID1, dbo.pStyleHeader.POMTempGroupID2, dbo.pStyleHeader.POMTempGroupID3, 
                      dbo.pStyleHeader.POMTempGroupID4, dbo.pStyleHeader.POMTempID1, dbo.pStyleHeader.POMTempVersion1, dbo.pStyleHeader.POMTempSizeClass1, 
                      dbo.pStyleHeader.POMTempID2, dbo.pStyleHeader.POMTempVersion2, dbo.pStyleHeader.POMTempSizeClass2, dbo.pStyleHeader.POMTempID3, 
                      dbo.pStyleHeader.POMTempVersion3, dbo.pStyleHeader.POMTempSizeClass3, dbo.pStyleHeader.POMTempID4, dbo.pStyleHeader.POMTempVersion4, 
                      dbo.pStyleHeader.POMTempSizeClass4, dbo.pStyleHeader.StyleMaterialID, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.TechSketchID, 
                      dbo.pStyleHeader.ConceptSketchID, dbo.pStyleHeader.ColorSketchID, dbo.pStyleHeader.DesignSketchVersion, dbo.pStyleHeader.TechSketchVersion, 
                      dbo.pStyleHeader.ConceptSketchVersion, dbo.pStyleHeader.ColorSketchVersion, dbo.pStyleHeader.DetailSketchID1, dbo.pStyleHeader.DetailSketchID2, 
                      dbo.pStyleHeader.DetailSketchID3, dbo.pStyleHeader.DetailSketchID4, dbo.pStyleHeader.DetailSketchVersion1, dbo.pStyleHeader.DetailSketchVersion2, 
                      dbo.pStyleHeader.DetailSketchVersion3, dbo.pStyleHeader.DetailSketchVersion4, dbo.pStyleHeader.SpecSketchID1, dbo.pStyleHeader.SpecSketchID2, 
                      dbo.pStyleHeader.SpecSketchID3, dbo.pStyleHeader.SpecSketchID4, dbo.pStyleHeader.SpecSketchVersion1, dbo.pStyleHeader.SpecSketchVersion2, 
                      dbo.pStyleHeader.SpecSketchVersion3, dbo.pStyleHeader.SpecSketchVersion4, dbo.pStyleHeader.Markup, dbo.pStyleHeader.TargetPrice, 
                      dbo.pStyleHeader.SellingPrice, dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField2, dbo.pStyleHeader.CustomField3, dbo.pStyleHeader.CustomField4, 
                      dbo.pStyleHeader.CustomField5, dbo.pStyleHeader.CustomField6, dbo.pStyleHeader.CustomField7, dbo.pStyleHeader.CustomField8, dbo.pStyleHeader.CustomField9,
                       dbo.pStyleHeader.CustomField10, dbo.pStyleHeader.CustomField11, dbo.pStyleHeader.CustomField12, dbo.pStyleHeader.CustomField13, 
                      dbo.pStyleHeader.CustomField14, dbo.pStyleHeader.CustomField15, dbo.pStyleHeader.Pc1, dbo.pStyleHeader.Pc2, dbo.pStyleHeader.Pc3, dbo.pStyleHeader.Pc4, 
                      dbo.pStyleHeader.CUser, dbo.pStyleHeader.CDate, dbo.pStyleHeader.MUser, dbo.pStyleHeader.MDate, dbo.pStyleHeader.Active, dbo.pStyleHeader.Change, 
                      dbo.pStyleHeader.Action, dbo.pStyleHeader.NoColorCombo, dbo.pStyleHeader.StyleVersion, dbo.pStyleHeader.StyleDetail, dbo.pStyleHeader.StyleDetail1, 
                      dbo.pStyleHeader.StyleDetail2, dbo.pStyleHeader.StyleAttribute, dbo.pStyleHeader.LinePlanID, dbo.pStyleHeader.LinePlanNo, dbo.pStyleHeader.LinePlanSketchID, 
                      dbo.pStyleHeader.LinePlanSketchVersion, dbo.pStyleHeader.CustomField16, dbo.pStyleHeader.CustomField17, dbo.pStyleHeader.CustomField18, 
                      dbo.pStyleHeader.CustomField19, dbo.pStyleHeader.CustomField20, dbo.pStyleHeader.CustomField21, dbo.pStyleHeader.CustomField22, 
                      dbo.pStyleHeader.CustomField23, dbo.pStyleHeader.CustomField24, dbo.pStyleHeader.CustomField25, dbo.pStyleHeader.CustomField26, 
                      dbo.pStyleHeader.CustomField27, dbo.pStyleHeader.CustomField28, dbo.pStyleHeader.CustomField29, dbo.pStyleHeader.CustomField30, 
                      dbo.pStyleHeader.PackagingNo, dbo.pStyleHeader.StyleCopyID, dbo.pStyleHeader.LinePlanItemID, dbo.pStyleHeader.StyleStatusID, dbo.pStyleHeader.BodyID, 
                      dbo.pStyleHeader.TradePartnerID, dbo.pStyleHeader.TradePartnerVendorID, dbo.pStyleSeasonYear.StyleSeason, dbo.pStyleSeasonYear.StyleYear, 
                      dbo.pStyleHeader.StyleLinkID, dbo.pStyleTypeTemplate.IsSilhouette, dbo.pStyleHeader.DesignSketchBackID, dbo.pStyleHeader.DesignSketchBackVersion
FROM         dbo.pStyleHeader LEFT OUTER JOIN
                      dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID LEFT OUTER JOIN
                      dbo.pStyleType ON dbo.pStyleHeader.StyleType = dbo.pStyleType.StyleTypeID LEFT OUTER JOIN
                      dbo.pStyleTypeTemplate ON dbo.pStyleType.StyleTypeTemplateID = dbo.pStyleTypeTemplate.StyleTypeTemplateID
                      


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08261', GetDate())
GO        
