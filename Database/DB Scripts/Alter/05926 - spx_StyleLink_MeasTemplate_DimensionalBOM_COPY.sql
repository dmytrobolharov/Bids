/****** Object:  StoredProcedure [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOM_COPY]    Script Date: 06/26/2013 15:51:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleLink_MeasTemplate_DimensionalBOM_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOM_COPY]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOM_COPY]    Script Date: 06/26/2013 15:51:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOM_COPY]
	@CopyStyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@POMTemplateID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @WorkflowItemID UNIQUEIDENTIFIER
    DECLARE @OldStyleSet INT
    DECLARE @WorkflowID UNIQUEIDENTIFIER
    DECLARE @NewWorkflowItemID UNIQUEIDENTIFIER

    
    SET @WorkflowID = '40000000-0000-0000-0000-000000000080'
    SELECT @NewWorkflowItemID = NEWID()
    
    SELECT @WorkflowItemID = WorkflowItemID, @OldStyleSet = StyleSet FROM pStyleBOMDimension 
    WHERE StyleBOMDimensionID = @StyleBOMDimensionID
    
    EXEC spx_WorkflowItem_COPY @WorkflowID, 
								@WorkflowItemID,
								@NewStyleID, 
								@CopyStyleID, 
								@StyleSet, 
								@OldStyleSet, 
								@CUSer, 
								@CDate,
								@NewWorkflowItemID
								
	-- Deleting old size range and inserting new, if there is a size
	DECLARE @NewBOMDimensionID UNIQUEIDENTIFIER
	DECLARE @AMLMeasHdrID UNIQUEIDENTIFIER
    DECLARE @SizeDimTypeID UNIQUEIDENTIFIER
    DECLARE @SizeRangeID UNIQUEIDENTIFIER
    DECLARE @DimLevel INT
	    
    SELECT @AMLMeasHdrID = AMLMeasHdrId FROM pAMLMeasHdr 
    WHERE StyleId=@NewStyleID AND StyleSet = @StyleSet AND CompanyId = @POMTemplateID
    
    SELECT @NewBOMDimensionID = StyleBOMDimensionID FROM pStyleBOMDimension WHERE WorkFlowItemID = @NewWorkflowItemID
    
    SELECT @SizeDimTypeID = DimTypeID FROM pStyleBOMDimType WHERE DimTypeName = 'Size'
    
    SELECT @SizeRangeID = SizeRangeID FROM pGRMeasurementsPOMTemplate WHERE POMTempID = @POMTemplateID
    
    -- Deleting the old size info
    IF EXISTS (SELECT * FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @NewBOMDimensionID AND ItemDim1TypeId = @SizeDimTypeID)
    BEGIN
		SET @DimLevel = 1
		DELETE FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @NewBOMDimensionID AND ItemDim1TypeId = @SizeDimTypeID
		AND ItemDim1Id IS NOT NULL AND ItemDim2Id IS NULL AND ItemDim3Id IS NULL
		
		DELETE FROM pStyleBOMDimensionItems WHERE StyleBOMDimensionID = @NewBOMDimensionID AND ItemDim1TypeId = @SizeDimTypeID
	END
	ELSE IF EXISTS (SELECT * FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @NewBOMDimensionID AND ItemDim2TypeId = @SizeDimTypeID)
	BEGIN
		SET @DimLevel = 2
		DELETE FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @NewBOMDimensionID AND ItemDim2TypeId = @SizeDimTypeID
		AND ItemDim1Id IS NULL AND ItemDim2Id IS NOT NULL AND ItemDim3Id IS NULL
		
		DELETE FROM pStyleBOMDimensionItems WHERE StyleBOMDimensionID = @NewBOMDimensionID AND ItemDim2TypeId = @SizeDimTypeID
	END
	ELSE IF EXISTS (SELECT * FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @NewBOMDimensionID AND ItemDim3TypeId = @SizeDimTypeID)
	BEGIN
		SET @DimLevel = 3
		DELETE FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @NewBOMDimensionID AND ItemDim3TypeId = @SizeDimTypeID
		AND ItemDim1Id IS NULL AND ItemDim2Id IS NULL AND ItemDim3Id IS NOT NULL
		
		DELETE FROM pStyleBOMDimensionItems WHERE StyleBOMDimensionID = @NewBOMDimensionID AND ItemDim3TypeId = @SizeDimTypeID
	END
	ELSE
		SET @DimLevel = 0
	
	-- Inserting new size range into BOM
	EXEC spx_StyleBOMSizeRange_Update @AMLMeasHdrID, 
										@SizeDimTypeID, 
										@SizeRangeID, 
										@NewBOMDimensionID, 
										@NewStyleID, 
										@StyleSet, 
										@WorkflowID, 
										@NewWorkflowItemID, 
										@DimLevel
	
	-- Temporary (but probably eternal) solution for seasonality issue with multi-bubble.
	-- At the time being, only one season/year can be carried over into extended size, so we can just update seasonal workflows
	-- for this season/year.
	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
	SELECT TOP 1 @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @NewStyleID
	UPDATE pWorkflowItem SET StyleSeasonYearID = @StyleSeasonYearID, WorkflowItemMasterID = @NewWorkflowItemID 
	WHERE WorkFlowItemID = @NewWorkflowItemID
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05926', GetDate())
GO
