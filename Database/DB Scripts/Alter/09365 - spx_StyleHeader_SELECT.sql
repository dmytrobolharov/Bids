/****** Object:  StoredProcedure [dbo].[spx_StyleHeader_SELECT]    Script Date: 16.02.2015 15:39:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleHeader_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleHeader_SELECT]    Script Date: 16.02.2015 15:39:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleHeader_SELECT]
(@StyleID uniqueidentifier)
AS SELECT     StyleID, StyleType, WorkflowType, RefNo, StyleNo, TempID, TempNo, CustomerNo, ConceptID, ConceptNo, SpecNo, Description, SizeRange, 
        StyleCategory, StyleSet, DueDate, RecDate, Customer, Buyer, Designer, SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, 
        StyleStatus, StyleLocation, WashType, Pitch, MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, MaterialName, CustomField1, 
        CustomField2, CustomField3, CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, 
        CustomField11, CustomField12, CustomField13, CustomField14, CustomField15, Pc1, Pc2, Pc3, Pc4, CUser, CDate, MUser, MDate, Active, 
        Change, Action, StyleMaterialID, DesignSketchID, DesignSketchVersion, POMTempID1, POMTempVersion1, POMTempSizeClass1, POMTempID2, 
        POMTempVersion2, POMTempSizeClass2, POMTempID3, POMTempVersion3, POMTempSizeClass3, POMTempID4, POMTempVersion4, 
        POMTempSizeClass4, StyleDetail, StyleDetail1, SizeClass, DevelopmentID, DevelopmentNo, TechPackId, TechPackDate, StyleWorkflowID, StyleDetail2 ,
		CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
		CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30, StyleStatusId, ISNULL (HeaderLocked,0) AS HeaderLocked,
		DivisionID
FROM    pStyleHeader
WHERE     (StyleID = @StyleID)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09365', GetDate())
GO