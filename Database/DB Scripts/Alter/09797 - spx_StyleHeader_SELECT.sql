IF OBJECT_ID(N'[dbo].[spx_StyleHeader_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleHeader_SELECT]
(@StyleID uniqueidentifier)
AS SELECT sh.StyleID, sh.StyleType, sh.WorkflowType, sh.RefNo, sh.StyleNo, sh.TempID, sh.TempNo, sh.CustomerNo, sh.ConceptID, sh.ConceptNo, 
          sh.SpecNo, sh.Description, sh.SizeRangeId, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, sh.StyleCategory, sh.StyleSet, 
		  sh.DueDate, sh.RecDate, sh.Customer, sh.Buyer, sh.Designer, sh.SampleMaker, sh.PatternMaker, sh.ProductionManager, sh.TechnicalDesigner, 
		  sh.StyleStatus, sh.StyleLocation, sh.WashType, sh.Pitch, sh.MaterialID, sh.MaterialImageID, sh.MaterialImageVersion, sh.MaterialNo, 
		  sh.MaterialName, sh.CustomField1, sh.CustomField2, sh.CustomField3, sh.CustomField4, sh.CustomField5, sh.CustomField6, sh.CustomField7, 
		  sh.CustomField8, sh.CustomField9, sh.CustomField10, sh.CustomField11, sh.CustomField12, sh.CustomField13, sh.CustomField14, sh.CustomField15, 
		  sh.Pc1, sh.Pc2, sh.Pc3, sh.Pc4, sh.CUser, sh.CDate, sh.MUser, sh.MDate, sh.Active, sh.Change, sh.Action, sh.StyleMaterialID, sh.DesignSketchID, 
		  sh.DesignSketchVersion, sh.POMTempID1, sh.POMTempVersion1, sh.POMTempSizeClass1, sh.POMTempID2, sh.POMTempVersion2, sh.POMTempSizeClass2, 
		  sh.POMTempID3, sh.POMTempVersion3, sh.POMTempSizeClass3, sh.POMTempID4, sh.POMTempVersion4, sh.POMTempSizeClass4, sh.StyleDetail, sh.StyleDetail1, 
		  sh.SizeClassId, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, sh.DevelopmentID, sh.DevelopmentNo, sh.TechPackId, sh.TechPackDate, 
		  sh.StyleWorkflowID, sh.StyleDetail2, sh.CustomField16, sh.CustomField17, sh.CustomField18, sh.CustomField19, sh.CustomField20, sh.CustomField21, 
		  sh.CustomField22,  sh.CustomField23, sh.CustomField24,  sh.CustomField25, sh.CustomField26, sh.CustomField27, sh.CustomField28, sh.CustomField29, 
		  sh.CustomField30, sh.StyleStatusId, ISNULL(sh.HeaderLocked,0) AS HeaderLocked, sh.DivisionID
FROM pStyleHeader sh
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
WHERE (sh.StyleID = @StyleID)



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09797', GetDate())
GO
