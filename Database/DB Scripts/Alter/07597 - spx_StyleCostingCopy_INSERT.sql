IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingCopy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingCopy_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleCostingCopy_INSERT]
(
@StyleID uniqueidentifier,
@NewStyleID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime,
@SeasonYearID uniqueidentifier = null
)
AS 
-- Copy Costing Header
BEGIN

DECLARE @OldStyleCostingHeaderID UNIQUEIDENTIFIER
DECLARE @NewStyleCostingHeaderID UNIQUEIDENTIFIER
DECLARE @CostingHeaderCursor CURSOR

DECLARE @OldStyleSeasonYearID UNIQUEIDENTIFIER
DECLARE @NewStyleSeasonYearID UNIQUEIDENTIFIER

SET @CostingHeaderCursor = CURSOR SCROLL
FOR 
	SELECT StyleCostingHeaderID FROM pStyleCostingHeader
		INNER JOIN pStyleSeasonYear ON pStyleCostingHeader.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
WHERE pStyleCostingHeader.StyleID = @StyleID AND (pStyleSeasonYear.SeasonYearID = @SeasonYearID OR @SeasonYearID IS NULL)
OPEN @CostingHeaderCursor

FETCH NEXT FROM @CostingHeaderCursor INTO @OldStyleCostingHeaderID
WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT @NewStyleCostingHeaderID = NEWID()
	
	SELECT @OldStyleSeasonYearID = StyleSeasonYearID
	FROM pStyleCostingHeader WHERE StyleCostingHeaderID = @OldStyleCostingHeaderID
	
	/* copy costing only for the same SeasonYear as copied Style */
	--SELECT @NewStyleSeasonYearID = nssy.StyleSeasonYearID
	--FROM pStyleSeasonYear ossy INNER JOIN pStyleSeasonYear nssy
	--ON ossy.SeasonYearID = nssy.SeasonYearID
	--WHERE ossy.StyleSeasonYearID = @OldStyleSeasonYearID 
	--AND nssy.StyleID = @NewStyleID
	
	SELECT TOP 1 @NewStyleSeasonYearID = StyleSeasonYearID
	FROM pStyleSeasonYear 
	WHERE StyleID = @NewStyleID

	INSERT INTO dbo.pStyleCostingHeader
						  (StyleID, StyleCostingHeaderID, StyleCostingTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, StyleCostingCustomField1, StyleCostingCustomField2, 
						  StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, 
						  StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, 
						  StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, 
						  StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, 
						  StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, 
						  StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32,
						  StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, StyleSeasonYearID, CUser, CDate, MUser, MDate, Active)
	SELECT     @NewStyleID AS StyleId, @NewStyleCostingHeaderID, StyleCostingTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, StyleCostingCustomField1, 
						  StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, 
						  StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, 
						  StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, 
						  StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, 
						  StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, 
						  StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32,
						  StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, @NewStyleSeasonYearID, @CreatedBy AS CreatedBy, 
						  @CreatedDate AS CreatedDate, @CreatedBy AS CreatedBy, @CreatedDate AS CreatedDate, Active
	FROM         dbo.pStyleCostingHeader WITH (NOLOCK)
	WHERE StyleCostingHeaderID = @OldStyleCostingHeaderID

	-- Copy Costings
	DECLARE @OldStyleCostingID UNIQUEIDENTIFIER
	DECLARE @NewStyleCostingID UNIQUEIDENTIFIER
	DECLARE @CostingCursor CURSOR

	SET @CostingCursor = CURSOR SCROLL
	FOR SELECT StyleCostingID FROM pStyleCosting WHERE StyleCostingHeaderID = @OldStyleCostingHeaderID
	OPEN @CostingCursor
	FETCH NEXT FROM @CostingCursor INTO @OldStyleCostingID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SELECT @NewStyleCostingID = NEWID()
		
		INSERT INTO dbo.pStyleCosting
						  (StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingFreightTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, StyleCostingCustomField1, 
						  StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, 
						  StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, 
						  StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, 
						  StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, 
						  StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, 
						  StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, 
						  StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, CUser, CDate, MUser, MDate, 
						  Active, StyleSeasonYearID, StyleColorwayID, BOMCost, BOLCost, BOLCurr, StyleBOMDimensionID, StyleSourcingID, StyleNBOLHeaderID, StyleCostingHeaderId, 
						  StyleCostingName, StyleCostingCurrency, StyleCostingConvertedCurr, StyleCostingHTS, AdditionalCost, StyleCostingComments, StyleCostingScenarioItemsId, 
						  StyleCostingScenarioNo, StyleCostingCustomField36, StyleCostingCustomField37, StyleCostingCustomField38, StyleCostingCustomField39, StyleCostingCustomField40, 
						  StyleCostingCustomField41, StyleCostingCustomField42, StyleCostingCustomField43, StyleCostingCustomField44, StyleCostingCustomField45)
		SELECT     @NewStyleCostingID AS StyleCostingID, @NewStyleID AS StyleId, StyleCostingTypeID, StyleCostingFreightTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, 
						  StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
						  StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, 
						  StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
						  StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, 
						  StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
						  StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
						  StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, 
						  @CreatedBy AS Cuser, @CreatedDate AS Cdate, @CreatedBy AS Muser, @CreatedDate AS Mdate, 1,
						  @NewStyleSeasonYearID, StyleColorwayID, BOMCost, BOLCost, BOLCurr, StyleBOMDimensionID, StyleSourcingID, StyleNBOLHeaderID, @NewStyleCostingHeaderID, StyleCostingName, 
						  StyleCostingCurrency, StyleCostingConvertedCurr, StyleCostingHTS, AdditionalCost, StyleCostingComments, StyleCostingScenarioItemsId, StyleCostingScenarioNo, 
						  StyleCostingCustomField36, StyleCostingCustomField37, StyleCostingCustomField38, StyleCostingCustomField39, StyleCostingCustomField40, StyleCostingCustomField41, 
						  StyleCostingCustomField42, StyleCostingCustomField43, StyleCostingCustomField44, StyleCostingCustomField45
		FROM         dbo.pStyleCosting WITH (NOLOCK)
		WHERE StyleCostingID = @OldStyleCostingID
		
		UPDATE pStyleCosting SET StyleNBOLHeaderID = snh.StyleNBOLHeaderID
		FROM pStyleCosting sc LEFT JOIN pStyleNBOLHeader snh
		ON sc.StyleNBOLHeaderID = snh.StyleNBOLHeaderCopyMasterID
		AND snh.StyleID = @NewStyleID
		WHERE sc.StyleCostingID = @NewStyleCostingID
		
		UPDATE pStyleCosting SET StyleBOMDimensionID = sbd.StyleBOMDimensionID
		FROM pStyleCosting sc LEFT JOIN pStyleBOMDimension sbd
		ON sc.StyleBOMDimensionID = sbd.StyleBOMDimensionCopyMasterID
		AND sbd.StyleID = @NewStyleID
		WHERE sc.StyleCostingID = @NewStyleCostingID
		
		-- Copying Costing Scenarios
		DECLARE @OldStyleCostingScenarioItemID UNIQUEIDENTIFIER
		DECLARE @NewStyleCostingScenarioItemID UNIQUEIDENTIFIER
		DECLARE @ScenariosCursor CURSOR
		
		SET @ScenariosCursor = CURSOR SCROLL
		FOR SELECT StytleCostingScenarioItemsID FROM pStyleCostingScenarioItems
		WHERE StyleCostingID = @OldStyleCostingID
		
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
			SELECT     @NewStyleCostingScenarioItemID AS StytleCostingScenarioItemsID, @NewStyleCostingID AS StyleCostingID, @NewStyleID AS StyleId, StyleCostingTypeID, StyleCostingFreightTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, 
						  StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
						  StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, 
						  StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
						  StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, 
						  StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
						  StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
						  StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, 
						  @CreatedBy AS Cuser, @CreatedDate AS Cdate, @CreatedBy AS Muser, @CreatedDate AS Mdate, 1, @NewStyleSeasonYearID, StyleColorwayID, BOMCost, BOLCost, BOLCurr, StyleBOMDimensionID, StyleNBOLHeaderId, StyleSourcingID, @NewStyleCostingHeaderID,
						  StyleCostingName, StyleCostingCurrency, StyleCostingConvertedCurr, StyleCostingHTS, AdditionalCost, StyleCostingComments, StyleCostingCustomField36, 
						  StyleCostingCustomField37,  StyleCostingCustomField38,  StyleCostingCustomField39,  StyleCostingCustomField40,  StyleCostingCustomField41,  StyleCostingCustomField42, 
						  StyleCostingCustomField43,  StyleCostingCustomField44,  StyleCostingCustomField45, StyleCostingScenarioNo 
			FROM         dbo.pStyleCostingScenarioItems WITH (NOLOCK)
			WHERE StytleCostingScenarioItemsID = @OldStyleCostingScenarioItemID
			
			UPDATE pStyleCosting SET StyleCostingScenarioItemsId = @NewStyleCostingScenarioItemID
			WHERE StyleCostingID = @NewStyleCostingID AND StyleCostingScenarioItemsId = @OldStyleCostingScenarioItemID
			
			UPDATE pStyleCostingScenarioItems
			SET StyleBOMDimensionID = sbd.StyleBOMDimensionID
			FROM pStyleCostingScenarioItems csi LEFT JOIN pStyleBOMDimension sbd
			ON csi.StyleBOMDimensionID = sbd.StyleBOMDimensionCopyMasterID
			AND sbd.StyleID = @NewStyleID
			WHERE csi.StytleCostingScenarioItemsID = @NewStyleCostingScenarioItemID
			
			-- Copy costing BOL
			
			INSERT INTO pStyleCostingBOL (styleCostingBOLID, StytleCostingScenarioItemsID, StyleID, StyleNBOLHeaderID,
			StyleNBOLItemId, OperationCode, OperationName, OperationTypeID, OperationCost,
			CDate, CUser, MDate, MUser)
			SELECT NEWID(), @NewStyleCostingScenarioItemID, @NewStyleID, StyleNBOLHeaderID,
			StyleNBOLItemId, OperationCode, OperationName, OperationTypeID, OperationCost,
			@CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy
			FROM pStyleCostingBOL WHERE StytleCostingScenarioItemsID = @OldStyleCostingScenarioItemID
			
			UPDATE pStyleCostingBOL
			SET StyleNBOLItemId = nbi.StyleNBOLItemID, 
				StyleNBOLHeaderID = nbh.StyleNBOLHeaderID
			FROM pStyleCostingBOL scb 
			LEFT JOIN pStyleNBOLItems nbi
			ON scb.StyleNBOLItemId = nbi.StyleNBOLItemCopyMasterID
			AND nbi.StyleID = @NewStyleID
			LEFT JOIN pStyleNBOLHeader nbh 
			ON nbh.WorkFlowItemID = nbi.WorkFlowItemID
			WHERE scb.StytleCostingScenarioItemsID = @NewStyleCostingScenarioItemID
			
			-- Costing BOL
			
			INSERT INTO pStyleCostingBOM (styleCostingBOMID, StytleCostingScenarioItemsID, StyleID, StyleBOMDimensionID,
				StyleMaterialId, MaterialName, MaterialNo, MaterialType, MaterialTypeDesc, 
				MaterialCost, CDate, CUser, MDate, MUser)
			SELECT NEWID(), @NewStyleCostingScenarioItemID, @NewStyleID, StyleBOMDimensionID,
				StyleMaterialId, MaterialName, MaterialNo, MaterialType, MaterialTypeDesc, 
				MaterialCost, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy
			FROM pStyleCostingBOM WHERE StytleCostingScenarioItemsID = @OldStyleCostingScenarioItemID
			
			UPDATE pStyleCostingBOM
			SET StyleMaterialId = sbom.StyleMaterialID,
				StyleBOMDimensionID = sdb.StyleBOMDimensionID
			FROM pStyleCostingBOM scb 
			LEFT JOIN pStyleBOM sbom
			ON scb.StyleMaterialId = sbom.CopyStyleMaterialID
			AND sbom.StyleID = @NewStyleID
			LEFT JOIN pStyleBOMDimension sdb 
			ON sbom.StyleBOMDimensionID = sdb.StyleBOMDimensionID
			WHERE scb.StytleCostingScenarioItemsID = @NewStyleCostingScenarioItemID
			
			-- Copying additional items
			
			INSERT INTO pstyleCostingAdditionalItems (styleCostingAdditionalItemsID, StytleCostingScenarioItemsID, 
			StyleID, AdditionalItemNo, AdditionalItemName, AdditionalItemCost, StyleAdditionalItemID,
			CDate, CUser, MDate, MUser)
			SELECT NEWID(), @NewStyleCostingScenarioItemID, 
			@NewStyleID, AdditionalItemNo, AdditionalItemName, AdditionalItemCost, StyleAdditionalItemID,
			@CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy
			FROM pstyleCostingAdditionalItems
			WHERE StytleCostingScenarioItemsID = @OldStyleCostingScenarioItemID
			
			FETCH NEXT FROM @ScenariosCursor INTO @OldStyleCostingScenarioItemID
		END
		
		CLOSE @ScenariosCursor
		DEALLOCATE @ScenariosCursor
		

		FETCH NEXT FROM @CostingCursor INTO @OldStyleCostingID
	END

	CLOSE @CostingCursor
	DEALLOCATE @CostingCursor

END

CLOSE @CostingHeaderCursor
DEALLOCATE @CostingHeaderCursor

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07597', GetDate())
GO
