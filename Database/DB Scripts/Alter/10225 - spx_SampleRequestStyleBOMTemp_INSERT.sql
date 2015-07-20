IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestStyleBOMTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestStyleBOMTemp_INSERT]
GO



CREATE PROCEDURE [dbo].[spx_SampleRequestStyleBOMTemp_INSERT]
(@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
@StyleSet nvarchar(50),
@CreatedDate nvarchar(50),
@SampleRequestGroupID nvarchar(50),
@StyleID uniqueidentifier,
@CreatedBy nvarchar(50))
AS 
 -- ,[ItemDim1Id],[ItemDim2Id],[ItemDim3Id],[ItemDim1Name],[ItemDim2Name],[ItemDim3Name]
DECLARE @ItemDim1Name nvarchar(200)
SELECT @ItemDim1Name = ItemDim1Name FROM pStyleBOMDimensionItem WITH (NOLOCK) WHERE  (StyleID = @StyleID) AND (StyleSet = @StyleSet) AND (ItemDim1Id = @ItemDim1Id) 
DECLARE @ItemDim2Name nvarchar(200)
SELECT @ItemDim2Name = ItemDim2Name FROM pStyleBOMDimensionItem WITH (NOLOCK) WHERE  (StyleID = @StyleID) AND (StyleSet = @StyleSet) AND (ItemDim2Id = @ItemDim2Id) 
DECLARE @ItemDim3Name nvarchar(200)
SELECT @ItemDim3Name = ItemDim3Name FROM pStyleBOMDimensionItem WITH (NOLOCK) WHERE  (StyleID = @StyleID) AND (StyleSet = @StyleSet) AND (ItemDim3Id = @ItemDim3Id) 

DELETE FROM pSampleRequestStyleBOMTemp WHERE  (StyleID = @StyleID) AND (@StyleSet = @StyleSet) AND (SampleRequestGroupID = @SampleRequestGroupID)


INSERT INTO dbo.pSampleRequestStyleBOMTemp
                      (SampleRequestGroupID,ItemDim1Id,ItemDim2Id,ItemDim3Id,ItemDim1Name,ItemDim2Name,ItemDim3Name, StyleSet, StyleID, StyleType, WorkflowType, RefNo, StyleNo, TempID, TempNo, CustomerNo, 
                      ConceptID, ConceptNo, SpecNo, Description, SizeRange, DueDate, RecDate, Customer, Buyer, Designer, SampleMaker, PatternMaker, 
                      ProductionManager, TechnicalDesigner, StyleStatus, StyleLocation, Pitch, MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, 
                      MaterialName, StyleMaterialID, DesignSketchID, DesignSketchVersion, Markup, TargetPrice, SellingPrice, CustomField1, CustomField2, CustomField3, 
                      CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, CustomField11, CustomField12, 
                      CustomField13, CustomField14, CustomField15, 
--	Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, 
--	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, 
		Pc1, Pc2, Pc3, Pc4, CUser, CDate, MUser, MDate, Active, Change, Action, NoColorCombo,

		CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
		CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30 
		)
SELECT     @SampleRequestGroupID AS SampleRequestGroupID,@ItemDim1Id as 'ItemDim1Id',@ItemDim2Id as 'ItemDim2Id',@ItemDim3Id as 'ItemDim3Id',@ItemDim1Name as 'ItemDim1Name',@ItemDim2Name as 'ItemDim2Name',@ItemDim3Name as 'ItemDim3Name', @StyleSet AS StyleSet, 
                      StyleID, StyleType, WorkflowType, RefNo, StyleNo, TempID, TempNo, CustomerNo, ConceptID, ConceptNo, SpecNo, Description, SizeRange, DueDate, 
                      RecDate, Customer, Buyer, Designer, SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleStatus, StyleLocation, Pitch, 
                      MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, MaterialName, StyleMaterialID, DesignSketchID, DesignSketchVersion, Markup, 
                      TargetPrice, SellingPrice, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, 
                      CustomField9, CustomField10, CustomField11, CustomField12, CustomField13, CustomField14, CustomField15, 
--	Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, 
--	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, 
		Pc1, Pc2, Pc3, Pc4, 
                      @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate, Active, Change, Action, NoColorCombo,
		CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
		CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30 
FROM         dbo.pStyleHeader WITH (NOLOCK)
WHERE    (StyleID = @StyleID)


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10225', GetUTCDate())
GO
