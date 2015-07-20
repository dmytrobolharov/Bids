IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_FlashEdit_StyleHeader_NonApparel_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_FlashEdit_StyleHeader_NonApparel_SEL]
GO


CREATE VIEW [dbo].[vwx_FlashEdit_StyleHeader_NonApparel_SEL]
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
                      dbo.pStyleHeader.PackagingNo, dbo.pStyleHeader.StyleCopyID, dbo.pStyleHeader.StyleStatusID, dbo.pStyleHeader.BodyID, dbo.pSeasonYear.Year, 
                      dbo.pSeasonYear.Season, dbo.pStyleHeader.HeaderLocked, dbo.pStyleSeasonYear.StyleSeasonYearID, dbo.pStyleSeasonYear.SeasonYearID, 
                      dbo.pStyleHeader.StyleLinkID, dbo.pStyleHeader.Distribution, dbo.pLinePlan.Description AS Expr1, dbo.pStyleHeader.MaterialCoreID, 
                      dbo.pLinePlanStyleAttributeItem.AttributeName, dbo.pStyleCostingHeader.StyleCostingCustomField1, dbo.pStyleHeader.CustomField31, 
                      dbo.pStyleHeader.CustomField32, dbo.pStyleHeader.CustomField33, dbo.pStyleHeader.CustomField34, dbo.pStyleHeader.CustomField35, 
                      dbo.pStyleHeader.CustomField36, dbo.pStyleHeader.CustomField37, dbo.pStyleHeader.CustomField38, dbo.pStyleHeader.CustomField39, 
                      dbo.pStyleHeader.CustomField40,
							(SELECT     dbo.pActive.Custom
                          FROM          dbo.pStyleHeader pSH(NOLOCK) INNER JOIN
                                                 dbo.pActive(NOLOCK) ON pSH.HeaderLocked = dbo.pActive.CustomKey
                          WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) LOCKSTATUS,
                          (SELECT     dbo.uTradePartner.TradePartnerName + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleSourcing ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartner ON dbo.pStyleSourcing.TradePartnerID = dbo.uTradePartner.TradePartnerID
                            WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) TradePartnerName,
                          (SELECT     dbo.uTradePartnerVendor.VendorName + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleSourcing ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartnerVendor ON dbo.pStyleSourcing.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID
                            WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) VendorName,
                          (SELECT     dbo.pStyleColorway.SAPCODE + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleColorway ON pSH.StyleID = dbo.pStyleColorway.StyleID
                            WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) 
                      SAPCODE
/*dbo.pStyleSourcing.TradePartnerVendorID, dbo.pStyleColorway.SAPCode*/ FROM /* dbo.pStyleHeader ON dbo.pStyleColorway.StyleID =*/ dbo.pStyleHeader LEFT OUTER JOIN
                      /* dbo.pStyleHeader.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN*/ dbo.pStyleSeasonYear ON 
                      dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID LEFT OUTER JOIN
                      dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID LEFT OUTER JOIN
                      dbo.pLinePlan ON dbo.pLinePlan.LinePlanID = dbo.pStyleSeasonYear.LinePlanID LEFT OUTER JOIN
                      dbo.pLinePlanItem ON dbo.pLinePlanItem.LinePlanItemID = pStyleSeasonYear.LinePlanITEMID LEFT OUTER JOIN
                      dbo.pLinePlanStyleAttributeItem ON dbo.pLinePlanStyleAttributeItem.LinePlanStyleAttributeItemID = pLinePlanItem.LinePlanStyleAttributeItemID LEFT OUTER JOIN
                      dbo.pStyleCostingHeader ON dbo.pStyleCostingHeader.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
WHERE     dbo.pStyleHeader.StyleType IN (18, 22, 23)
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01584'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01584', GetDate())
END	

GO
