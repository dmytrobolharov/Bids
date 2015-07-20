-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 27 November 2012                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_StyleSampleRequest_Search_SEL')
	DROP VIEW vwx_StyleSampleRequest_Search_SEL
GO


CREATE VIEW vwx_StyleSampleRequest_Search_SEL
AS

SELECT b.StyleID, b.StyleMasterID, b.StyleWorkflowID, b.StyleType, b.WorkflowType, b.RefNo, b.StyleNo, b.TempID, b.TempNo, b.CustomerNo, b.DevelopmentID,
	b.DevelopmentNo, b.ConceptID, b.ConceptNo, b.SpecNo, b.Description, b.StyleCategory, b.SizeClass, b.SizeRange, b.StyleSet, b.TechPackId, b.TechPackDate,
	b.DueDate, b.RecDate, b.Customer, b.Buyer, b.Designer, b.SampleMaker, b.PatternMaker, b.ProductionManager, b.TechnicalDesigner, b.StyleStatus, b.StyleLocation,
	b.WashType, b.Pitch, b.MaterialID, b.MaterialImageID, b.MaterialImageVersion, b.MaterialNo, b.MaterialName, b.POMTempGroupID1, b.POMTempGroupID2,
	b.POMTempGroupID3, b.POMTempGroupID4, b.POMTempID1, b.POMTempVersion1, b.POMTempSizeClass1, b.POMTempID2, b.POMTempVersion2,
	b.POMTempSizeClass2, b.POMTempID3, b.POMTempVersion3, b.POMTempSizeClass3, b.POMTempID4, b.POMTempVersion4, b.POMTempSizeClass4,
	b.StyleMaterialID, b.DesignSketchID, b.TechSketchID, b.ConceptSketchID, b.ColorSketchID, b.DesignSketchVersion, b.TechSketchVersion, b.ConceptSketchVersion,
	b.ColorSketchVersion, b.DetailSketchID1, b.DetailSketchID2, b.DetailSketchID3, b.DetailSketchID4, b.DetailSketchVersion1, b.DetailSketchVersion2,
	b.DetailSketchVersion3, b.DetailSketchVersion4, b.SpecSketchID1, b.SpecSketchID2, b.SpecSketchID3, b.SpecSketchID4, b.SpecSketchVersion1,
	b.SpecSketchVersion2, b.SpecSketchVersion3, b.SpecSketchVersion4, b.Markup, b.TargetPrice, b.SellingPrice, b.CustomField1, b.CustomField2, b.CustomField3,
	b.CustomField4, b.CustomField5, b.CustomField6, b.CustomField7, b.CustomField8, b.CustomField9, b.CustomField10, b.CustomField11, b.CustomField12,
	b.CustomField13, b.CustomField14, b.CustomField15, b.Pc1, b.Pc2, b.Pc3, b.Pc4, b.CUser, b.CDate, b.MUser, b.MDate, b.Active, b.Change, b.Action, b.NoColorCombo,
	b.StyleVersion, b.StyleDetail, b.StyleDetail1, b.StyleAttribute, b.StyleDetail2, b.LinePlanSketchID, b.LinePlanSketchVersion, b.LinePlanID, b.LinePlanNo,
	b.CustomField16, b.CustomField17, b.CustomField18, b.CustomField19, b.CustomField20, b.CustomField21, b.CustomField22, b.CustomField23, b.CustomField24,
	b.CustomField25, b.CustomField26, b.CustomField27, b.CustomField28, b.CustomField29, b.CustomField30, b.PackagingNo, b.StyleCopyID, b.LinePlanItemID,
	b.StyleStatusID, b.BodyID, b.TradePartnerID, b.TradePartnerVendorID, b.StyleLinkID, b.MaterialCoreID, b.ProdDev, b.HeaderLocked,
	a.StyleSeasonYearID, a.SeasonYearID,c.Season,c.Year,ISNULL(dbo.pStyleDevelopmentItem.StyleDevelopmentName,
	dbo.pStyleDevelopmentItem.Variation) AS Variation, b.UserCID, b.UserMID

FROM dbo.pStyleSeasonYear AS a 
	RIGHT OUTER JOIN dbo.pStyleHeader AS b ON a.StyleID = b.StyleID 
	INNER JOIN dbo.pSeasonYear AS c ON c.SeasonYearID = a.SeasonYearID 
	INNER JOIN dbo.pStyleDevelopmentItem ON a.StyleID = dbo.pStyleDevelopmentItem.StyleID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04468', GetDate())
GO

SET NOCOUNT Off
GO
