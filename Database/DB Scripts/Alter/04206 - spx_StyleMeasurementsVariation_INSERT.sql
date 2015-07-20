/****** Object:  StoredProcedure [dbo].[spx_StyleMeasurementsVariation_INSERT]    Script Date: 09/06/2012 10:02:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasurementsVariation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeasurementsVariation_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMeasurementsVariation_INSERT]    Script Date: 09/06/2012 10:02:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleMeasurementsVariation_INSERT]
	(@StyleID uniqueidentifier,
	@NewStyleID uniqueidentifier)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Measurements Workflow ID
	DECLARE @WorkflowID UNIQUEIDENTIFIER
	SET @WorkflowID = '40000000-0000-0000-0000-000000000050'
	-- Data for inserting measurements from old style to new
	DECLARE @WorkflowItemCursor CURSOR
	DECLARE @CurrentWorkflowItemID UNIQUEIDENTIFIER
	DECLARE @CurrentAmlMeasHdrID UNIQUEIDENTIFIER
	DECLARE @NewWorkflowItemID UNIQUEIDENTIFIER
	DECLARE @NewAmlMeasHeaderID UNIQUEIDENTIFIER
	DECLARE @AMLMeasPOMCursor CURSOR
	DECLARE @CurrentPOMID UNIQUEIDENTIFIER
	DECLARE @NewPOMID UNIQUEIDENTIFIER
	-- For each Measurement Workflow Item in current variation
	SET @WorkflowItemCursor = CURSOR SCROLL
	FOR SELECT WorkFlowItemID FROM pWorkFlowItem WHERE StyleID = @StyleID AND WorkflowID = @WorkflowID
	OPEN @WorkflowItemCursor
	-- Selecting the current workflow item ID
	FETCH NEXT FROM @WorkflowItemCursor INTO @CurrentWorkflowItemID
	WHILE (@@FETCH_STATUS = 0) -- For each workflow item from old style
	BEGIN 
		SELECT @NewWorkflowItemID = NEWID()
		-- Inserting the data from current workflow item into new workflow item
		INSERT INTO pWorkFlowItem (WorkFlowItemID, WorkflowID, WorkflowItemTypeId, StyleID, WorkFlowItemName,
									Sort, CUser, CDate, MUser, MDate, StyleSet, RepRowGuidColID, StatusID, 
									WorkStart, WorkDue, WorkAssignedTo, WorkStatus, WorkEscalateTo)
		SELECT @NewWorkflowItemID, WorkflowID, WorkflowItemTypeId, @NewStyleID, WorkFlowItemName,
									Sort, CUser, CDate, MUser, MDate, StyleSet, RepRowGuidColID, StatusID, 
									WorkStart, WorkDue, WorkAssignedTo, WorkStatus, WorkEscalateTo
		FROM pWorkFlowItem WHERE WorkFlowItemID = @CurrentWorkflowItemID
		-- Inserting the data from current item's AMLMeasHeader into new AMLMeasHeader
		SELECT @NewAmlMeasHeaderID = NEWID()
		SELECT @CurrentAmlMeasHdrID = AmlMeasHdrID FROM pAMLMeasHdr WHERE WorkFlowItemId = @CurrentWorkflowItemID
		INSERT INTO pAMLMeasHdr (AMLMeasHdrId, Workflowid, StyleId, CompanyId, PDMPageId, CompanyName,
								PDMCompanyId, IsRelative, IsNegative, IsMetric, SizeClass, SizeClassId, SizeClassCode,
								SizeRange, SizeRangeId, SizeRangeCode, ProductType, ProductTypeId, ProductTypeCode, BaseSizeGrdCol,
								SelectedRange, MeasRowCnt, HaveHistory, HistoryMsg, CUser, CDate, MUser, MDate, WorkFlowItemId, StyleSet)
		SELECT @NewAmlMeasHeaderID, Workflowid, StyleId, CompanyId, PDMPageId, CompanyName,
								PDMCompanyId, IsRelative, IsNegative, IsMetric, SizeClass, SizeClassId, SizeClassCode,
								SizeRange, SizeRangeId, SizeRangeCode, ProductType, ProductTypeId, ProductTypeCode, BaseSizeGrdCol,
								SelectedRange, MeasRowCnt, HaveHistory, HistoryMsg, CUser, CDate, MUser, MDate, @NewWorkflowItemID, StyleSet
		FROM pAMLMeasHdr WHERE AMLMeasHdrId = @CurrentAmlMeasHdrID
		-- Inserting the AML Measurement Labels from current AMLMeasHdr to new AMLMeasHdr
		INSERT INTO pAMLMeasLbl (AMLMeasHdrId, PDMPageId, SizeRangeId, SizeRangeDetailId, SizeCol, MeasLbl, IsVisible, IsSample, MeasDesc, CUser, CDate, 
		MUser, MDate)
		SELECT @NewAmlMeasHeaderID, PDMPageId, SizeRangeId, SizeRangeDetailId, SizeCol, MeasLbl, IsVisible, IsSample, MeasDesc, CUser, CDate, 
		MUser, MDate
		FROM pAMLMeasLbl WHERE AMLMeasHdrId = @CurrentAmlMeasHdrID
		-- Inserting the POMs from current header to new header and adding IGC to each if them
		SET @AMLMeasPOMCursor = CURSOR SCROLL
		FOR SELECT AmlMeasPOMId FROM pAmlMeasPOM WHERE AMLMeasHdrId = @CurrentAmlMeasHdrId
		OPEN @AmlMeasPOMCursor
		FETCH NEXT FROM @AmlMeasPOMCursor INTO @CurrentPOMID
		WHILE (@@FETCH_STATUS = 0) -- For each POM from old header
		BEGIN
			SELECT @NewPOMID = NEWID()
			-- Inserting the POM data from old header to new
			INSERT INTO pAMLMeasPOM (AMLMeasPOMId, AMLMeasHdrId, PDMPageId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, RefCode,
								Description, TolPlus, TolMinus, TolPlusConv, TolMinusConv, Flag4QA, WSRowId, SortId,
								VideoSerialnumber, ImageSerialnumber, ImageId, How2MeasText, CUser, CDate, MUser, MDate,
								IsLinked, Critical, How2MeasName, FabricType, IsLength, IsWidth, ShrinkX, ShrinkY, CADModelId,
								BeforeTreat)
			SELECT @NewPOMID, @NewAmlMeasHeaderID, PDMPageId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, RefCode,
								Description, TolPlus, TolMinus, TolPlusConv, TolMinusConv, Flag4QA, WSRowId, SortId,
								VideoSerialnumber, ImageSerialnumber, ImageId, How2MeasText, CUser, CDate, MUser, MDate,
								IsLinked, Critical, How2MeasName, FabricType, IsLength, IsWidth, ShrinkX, ShrinkY, CADModelId,
								BeforeTreat
			FROM pAMLMeasPOM WHERE AMLMeasPomID = @CurrentPOMID
			-- Inserting the IGC data from old POM to new
			INSERT INTO pAMLMeasIGC (AMLMeasHdrId, AMLMeasPOMId, PDMPageId, POM_Row, WSRowId, SizeCol, Incr, Grade, ConvGrade, 
										CUser, CDate, MUser, MDate)
			SELECT @NewAmlMeasHeaderID, @NewPOMID, PDMPageId, POM_Row, WSRowId, SizeCol, Incr, Grade, ConvGrade, 
										CUser, CDate, MUser, MDate
			FROM pAMLMeasIGC WHERE AMLMeasPOMId = @CurrentPOMID
			
			FETCH NEXT FROM @AmlMeasPOMCursor INTO @CurrentPOMID
		END
		CLOSE @AmlMeasPOMCursor
		DEALLOCATE @AmlMeasPOMCursor
		
		FETCH NEXT FROM @WorkflowItemCursor INTO @CurrentWorkflowItemID
	END

CLOSE @WorkflowItemCursor
DEALLOCATE @WorkflowItemCursor

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04206', GetDate())
GO
