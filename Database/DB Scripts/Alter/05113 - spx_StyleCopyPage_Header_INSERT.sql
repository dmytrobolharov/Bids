IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCopyPage_Header_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCopyPage_Header_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleCopyPage_Header_INSERT](
	@TransactionID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER,
	@CDate DATETIME,
	@CUser NVARCHAR(200)
)
AS


DECLARE @StyleMasterID UNIQUEIDENTIFIER
SET @StyleMasterID = @TransactionID

INSERT INTO pStyleHeader(
	StyleID, StyleMasterID, StyleType, WorkflowType, StyleNo, TempID, TempNo, CustomerNo, ConceptID, ConceptNo, SpecNo, Description, SizeRange, SizeClass, 
	StyleSet, DueDate, RecDate, Designer, StyleStatus, StyleLocation, WashType, Pitch, MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, 
	MaterialName, POMTempID1, POMTempVersion1, POMTempID2, POMTempVersion2, POMTempID3, POMTempVersion3, POMTempID4, 
	POMTempVersion4, POMTempSizeClass1, POMTempSizeClass2, POMTempSizeClass3, POMTempSizeClass4, StyleMaterialID, DesignSketchID, 
	TechSketchID, ConceptSketchID, ColorSketchID, DesignSketchVersion, TechSketchVersion, ConceptSketchVersion, ColorSketchVersion, 
	DetailSketchID1, DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, 
	DetailSketchVersion4, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, SpecSketchVersion1, SpecSketchVersion2, 
	SpecSketchVersion3, SpecSketchVersion4, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, CustomField6, CustomField7, 
	CustomField8, CustomField9, CustomField10, CustomField11, CustomField12, CustomField13, CustomField14, CustomField15, 
	Pc1, Pc2, Pc3, 
	Pc4, CUser, CDate, MUser, MDate, Active, Change, Action, SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleDetail, StyleDetail1, 
	StyleDetail2, StyleAttribute,
	CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
	CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30, StyleCopyID
)
SELECT 
	@NewStyleID AS StyleID, StyleMasterID, StyleType, WorkflowType, StyleNo, TempID, TempNo, CustomerNo, ConceptID, ConceptNo, SpecNo, Description, SizeRange, SizeClass, 
	StyleSet, DueDate, RecDate, Designer, StyleStatus, StyleLocation, WashType, Pitch, MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, 
	MaterialName, POMTempID1, POMTempVersion1, POMTempID2, POMTempVersion2, POMTempID3, POMTempVersion3, POMTempID4, 
	POMTempVersion4, POMTempSizeClass1, POMTempSizeClass2, POMTempSizeClass3, POMTempSizeClass4, StyleMaterialID, DesignSketchID, 
	TechSketchID, ConceptSketchID, ColorSketchID, DesignSketchVersion, TechSketchVersion, ConceptSketchVersion, ColorSketchVersion, 
	DetailSketchID1, DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, 
	DetailSketchVersion4, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, SpecSketchVersion1, SpecSketchVersion2, 
	SpecSketchVersion3, SpecSketchVersion4, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, CustomField6, CustomField7, 
	CustomField8, CustomField9, CustomField10, CustomField11, CustomField12, CustomField13, CustomField14, CustomField15, 
	Pc1, Pc2, Pc3, 
	Pc4, @CUser AS CUser, @CDate AS CDate, @CUser AS MUser, @CDate AS MDate, Active, Change, Action, SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleDetail, StyleDetail1, 
	StyleDetail2, StyleAttribute,
	CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
	CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30, StyleID AS StyleCopyID
FROM  pStyleHeader WITH (NOLOCK)
WHERE StyleID = @StyleID


--** Style Attributes
INSERT INTO pStyleAttribute(
	StyleAttributeTableId, StyleId, StyleAttributeText, StyleAttributeValue, CUser, CDate, MUser, MDate)
SELECT StyleAttributeTableId, @NewStyleId, StyleAttributeText, StyleAttributeValue, @CUser, @CDate, @CUser, @CDate
FROM pStyleAttribute WITH (NOLOCK)
WHERE StyleID = @StyleID



--** Insert style-images
INSERT INTO pStyleImage	(
	StyleID, StyleMasterID, StyleType, MaterialID, MaterialImageID, DesignSketchID, TechSketchID, SalesSketchID, ColorSketchID, MaterialImageVersion, 
	DesignSketchVersion, TechSketchVersion, SalesSketchVersion, ColorSketchVersion, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, 
	SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, DetailSketchNo, DetailSketchData, DetailSketchID1, 
	DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchID11, DetailSketchID12, DetailSketchID21, DetailSketchID22, DetailSketchID31, 
	DetailSketchID32, DetailSketchID41, DetailSketchID42, DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, DetailSketchVersion4, 
	DetailSketchVersion11, DetailSketchVersion12, DetailSketchVersion21, DetailSketchVersion22, DetailSketchVersion31, DetailSketchVersion32, 
	DetailSketchVersion41, DetailSketchVersion42
)
SELECT 
	@NewStyleID, @StyleMasterID, StyleType, MaterialID, MaterialImageID, DesignSketchID, TechSketchID, SalesSketchID, ColorSketchID, MaterialImageVersion, 
	DesignSketchVersion, TechSketchVersion, SalesSketchVersion, ColorSketchVersion, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, 
	SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, DetailSketchNo, DetailSketchData, DetailSketchID1, 
	DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchID11, DetailSketchID12, DetailSketchID21, DetailSketchID22, DetailSketchID31, 
	DetailSketchID32, DetailSketchID41, DetailSketchID42, DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, DetailSketchVersion4, 
	DetailSketchVersion11, DetailSketchVersion12, DetailSketchVersion21, DetailSketchVersion22, DetailSketchVersion31, DetailSketchVersion32, 
	DetailSketchVersion41, DetailSketchVersion42
FROM pStyleImage WITH (NOLOCK)
WHERE StyleID = @StyleID





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05113', GetDate())
GO
