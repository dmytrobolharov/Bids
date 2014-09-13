IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostSheet_Copy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostSheet_Copy_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleCostSheet_Copy_INSERT]
	@StyleCostingId UNIQUEIDENTIFIER
	,@StyleSeasonYearID UNIQUEIDENTIFIER 
	,@StyleId UNIQUEIDENTIFIER
	,@CreatedBy NVARCHAR(200)
	,@CreatedDate DATETIME
AS
BEGIN

DECLARE @NewStyleCostingId UNIQUEIDENTIFIER = NEWID()
DECLARE @StyleCostingHeaderId UNIQUEIDENTIFIER

IF @StyleSeasonYearID IS NOT NULL
	SELECT @StyleCostingHeaderId = StyleCostingHeaderID FROM pStyleCostingHeader WHERE StyleSeasonYearID = @StyleSeasonYearID
ELSE
	SELECT TOP 1 @StyleCostingHeaderId = StyleCostingHeaderID FROM pStyleCostingHeader WHERE StyleID = @StyleID

INSERT INTO pStyleCosting
	(StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingFreightTypeID, 
	StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, StyleCostingCustomField1, 
	StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
	StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, 
	StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, 
	StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, 
	StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, 
	StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
	StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, 
	StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, 
	StyleCostingCustomField34, StyleCostingCustomField35, 
	CUser, CDate, MUser, MDate, Active, StyleSeasonYearID, StyleColorwayID, BOMCost, BOLCost, BOLCurr, 
	StyleBOMDimensionID, StyleSourcingID, StyleNBOLHeaderID, StyleCostingHeaderId, StyleCostingName, StyleCostingCurrency, 
	StyleCostingConvertedCurr, StyleCostingHTS, AdditionalCost, StyleCostingComments, StyleCostingScenarioItemsId, 
	StyleCostingScenarioNo, StyleCostingCustomField36, StyleCostingCustomField37, StyleCostingCustomField38, 
	StyleCostingCustomField39, StyleCostingCustomField40, StyleCostingCustomField41, StyleCostingCustomField42, 
	StyleCostingCustomField43, StyleCostingCustomField44, StyleCostingCustomField45)
SELECT
	@NewStyleCostingId, @StyleId, StyleCostingTypeID, StyleCostingFreightTypeID, 
	StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, StyleCostingCustomField1, 
	StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
	StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, 
	StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, 
	StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, 
	StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, 
	StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
	StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, 
	StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, 
	StyleCostingCustomField34, StyleCostingCustomField35, 
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, Active, 
	@StyleSeasonYearID, 
	StyleColorwayID, BOMCost, BOLCost, BOLCurr, 
	StyleBOMDimensionID, StyleSourcingID, StyleNBOLHeaderID, 
	@StyleCostingHeaderId, 
	StyleCostingName, StyleCostingCurrency, 
	StyleCostingConvertedCurr, StyleCostingHTS, AdditionalCost, StyleCostingComments, StyleCostingScenarioItemsId, 
	StyleCostingScenarioNo, StyleCostingCustomField36, StyleCostingCustomField37, StyleCostingCustomField38, 
	StyleCostingCustomField39, StyleCostingCustomField40, StyleCostingCustomField41, StyleCostingCustomField42, 
	StyleCostingCustomField43, StyleCostingCustomField44, StyleCostingCustomField45
FROM pStyleCosting
WHERE StyleCostingID = @StyleCostingId



/************ Copying Costing Scenarios **********/
DECLARE @OldStyleCostingScenarioItemID UNIQUEIDENTIFIER
DECLARE @NewStyleCostingScenarioItemID UNIQUEIDENTIFIER
DECLARE @ScenariosCursor CURSOR

SET @ScenariosCursor = CURSOR SCROLL
FOR SELECT StytleCostingScenarioItemsID FROM pStyleCostingScenarioItems
WHERE StyleCostingID = @StyleCostingID

OPEN @ScenariosCursor
FETCH NEXT FROM @ScenariosCursor INTO @OldStyleCostingScenarioItemID
WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT @NewStyleCostingScenarioItemID = NEWID()

	INSERT INTO dbo.pStyleCostingScenarioItems
				  (StytleCostingScenarioItemsID, StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingFreightTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, StyleCostingCustomField1, 
				  StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, 
				  StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, 
				  StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, 
				  StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, 
				  StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, 
				  StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, 
				  StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, CUser, CDate, MUser, MDate, 
				  Active, StyleSeasonYearID, StyleColorwayID, BOMCost, BOLCost, BOLCurr, StyleBOMDimensionID, StyleNBOLHeaderId, StyleSourcingID, StyleCostingHeaderId,
				  StyleCostingName, StyleCostingCurrency, StyleCostingConvertedCurr, StyleCostingHTS, AdditionalCost, StyleCostingComments, StyleCostingCustomField36, 
				  StyleCostingCustomField37,  StyleCostingCustomField38,  StyleCostingCustomField39,  StyleCostingCustomField40,  StyleCostingCustomField41,  StyleCostingCustomField42, 
				  StyleCostingCustomField43,  StyleCostingCustomField44,  StyleCostingCustomField45, StyleCostingScenarioNo )
	SELECT     @NewStyleCostingScenarioItemID AS StytleCostingScenarioItemsID, @NewStyleCostingId AS StyleCostingID, @StyleID AS StyleId, StyleCostingTypeID, StyleCostingFreightTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, 
				  StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
				  StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, 
				  StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
				  StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, 
				  StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
				  StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
				  StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, 
				  @CreatedBy AS Cuser, @CreatedDate AS Cdate, @CreatedBy AS Muser, @CreatedDate AS Mdate, 1, @StyleSeasonYearID, StyleColorwayID, BOMCost, BOLCost, BOLCurr, StyleBOMDimensionID, StyleNBOLHeaderId, StyleSourcingID, @StyleCostingHeaderID,
				  StyleCostingName, StyleCostingCurrency, StyleCostingConvertedCurr, StyleCostingHTS, AdditionalCost, StyleCostingComments, StyleCostingCustomField36, 
				  StyleCostingCustomField37,  StyleCostingCustomField38,  StyleCostingCustomField39,  StyleCostingCustomField40,  StyleCostingCustomField41,  StyleCostingCustomField42, 
				  StyleCostingCustomField43,  StyleCostingCustomField44,  StyleCostingCustomField45, StyleCostingScenarioNo 
	FROM         dbo.pStyleCostingScenarioItems WITH (NOLOCK)
	WHERE StytleCostingScenarioItemsID = @OldStyleCostingScenarioItemID
	
	-- set one of scerio items as system cost sheet
	UPDATE pStyleCosting SET StyleCostingScenarioItemsId = @NewStyleCostingScenarioItemID
	WHERE StyleCostingID = @NewStyleCostingID AND StyleCostingScenarioItemsId = @OldStyleCostingScenarioItemID
	
	-- Copy costing BOL
	INSERT INTO pStyleCostingBOL (styleCostingBOLID, StytleCostingScenarioItemsID, StyleID, StyleNBOLHeaderID,
	StyleNBOLItemId, OperationCode, OperationName, OperationTypeID, OperationCost,
	CDate, CUser, MDate, MUser)
	SELECT NEWID(), @NewStyleCostingScenarioItemID, @StyleId, StyleNBOLHeaderID,
	StyleNBOLItemId, OperationCode, OperationName, OperationTypeID, OperationCost,
	@CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy
	FROM pStyleCostingBOL WHERE StytleCostingScenarioItemsID = @OldStyleCostingScenarioItemID
	

	-- Copy costing BOM
	INSERT INTO pStyleCostingBOM (styleCostingBOMID, StytleCostingScenarioItemsID, StyleID, StyleBOMDimensionID,
		StyleMaterialId, MaterialName, MaterialNo, MaterialType, MaterialTypeDesc, 
		MaterialCost, CDate, CUser, MDate, MUser)
	SELECT NEWID(), @NewStyleCostingScenarioItemID, @StyleId, StyleBOMDimensionID,
		StyleMaterialId, MaterialName, MaterialNo, MaterialType, MaterialTypeDesc, 
		MaterialCost, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy
	FROM pStyleCostingBOM WHERE StytleCostingScenarioItemsID = @OldStyleCostingScenarioItemID
	
	
	-- Copying additional items
	INSERT INTO pstyleCostingAdditionalItems (styleCostingAdditionalItemsID, StytleCostingScenarioItemsID, 
	StyleID, AdditionalItemNo, AdditionalItemName, AdditionalItemCost, StyleAdditionalItemID,
	CDate, CUser, MDate, MUser)
	SELECT styleCostingAdditionalItemsID, StytleCostingScenarioItemsID, 
	StyleID, AdditionalItemNo, AdditionalItemName, AdditionalItemCost, StyleAdditionalItemID,
	CDate, CUser, MDate, MUser
	FROM pstyleCostingAdditionalItems
	WHERE StytleCostingScenarioItemsID = @OldStyleCostingScenarioItemID
	
	FETCH NEXT FROM @ScenariosCursor INTO @OldStyleCostingScenarioItemID
END
/************ End Copying Costing Scenarios **********/

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05359', GetDate())
GO
