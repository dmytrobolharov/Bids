-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestStyleBOMFIX_INSERT]    Script Date: 12/18/2011 18:08:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestStyleBOMFIX_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestStyleBOMFIX_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestStyleBOMFIX_INSERT]    Script Date: 12/18/2011 18:08:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestStyleBOMFIX_INSERT]
(@ItemDim1Id nvarchar(50) = null,
@ItemDim2Id nvarchar(50) = null,
@ItemDim3Id nvarchar(50) = null,
@StyleSet nvarchar(50),
@CreatedDate nvarchar(50),
@SampleRequestTradeID nvarchar(50),
@StyleID uniqueidentifier,
@TeamID uniqueidentifier,
@CreatedBy nvarchar(50))
AS 

--DECLARE @StyleColorName nvarchar(50)

--SELECT @StyleColorName = MainColor FROM pStyleColorway WITH (NOLOCK) WHERE StyleColorID = @StyleColorID 


--DELETE FROM pSampleRequestStyle WHERE  (StyleID = @StyleID) AND (@StyleSet = @StyleSet) AND (SampleRequestGroupID = @SampleRequestGroupID)


	INSERT INTO dbo.pSampleRequestStyleBOM
	(SampleRequestTradeID, TradePartnerVendorID, ItemDim1Id, ItemDim2Id,ItemDim3Id, StyleSet, StyleID, StyleType, WorkflowType, RefNo, StyleNo, TempID, TempNo, CustomerNo, 
	ConceptID, ConceptNo, SpecNo, Description, SizeRange, DueDate, RecDate, Customer, Buyer, Designer, SampleMaker, PatternMaker, 
	ProductionManager, TechnicalDesigner, StyleStatus, StyleLocation, Pitch, MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, 
	MaterialName, StyleMaterialID, DesignSketchID, DesignSketchVersion, Markup, TargetPrice, SellingPrice, CustomField1, CustomField2, CustomField3, 
	CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, CustomField11, CustomField12, 
	CustomField13, CustomField14, CustomField15, 
--	Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, 
--	Sel0, Sel1, Sel2,  Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, 
	Pc1, Pc2, Pc3, Pc4, CUser, CDate, MUser, MDate, Active, Change, Action, NoColorCombo,

	CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
	CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30 
	)
	SELECT     @SampleRequestTradeID AS SampleRequestGroupID, @TeamID AS TradePartnerVendorID, @ItemDim1Id AS ItemDim1Id, @ItemDim2Id AS ItemDim2Id,@ItemDim3Id AS ItemDim3Id, @StyleSet AS StyleSet, 
	StyleID, StyleType, WorkflowType, RefNo, StyleNo, TempID, TempNo, CustomerNo, ConceptID, ConceptNo, SpecNo, Description, SizeRange, DueDate, 
	RecDate, Customer, Buyer, Designer, SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleStatus, StyleLocation, Pitch, 
	MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, MaterialName, StyleMaterialID, DesignSketchID, DesignSketchVersion, Markup, 
	TargetPrice, SellingPrice, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, 
	CustomField9, CustomField10, CustomField11, CustomField12, CustomField13, CustomField14, CustomField15, 
--	Size0, Size1, Size2, Size3, Size4,  Size5, Size6, Size7, Size8, Size9, Size10, Size11, 
--	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, 
	Pc1, Pc2, Pc3, Pc4, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate, Active, Change, Action, NoColorCombo,

	CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
	CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30 
	FROM         dbo.pStyleHeader WITH (NOLOCK)
	WHERE    (StyleID = @StyleID)

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02379'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02379', GetDate())

END

GO