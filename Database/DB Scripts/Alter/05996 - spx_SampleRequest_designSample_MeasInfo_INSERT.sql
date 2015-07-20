/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasInfo_INSERT]    Script Date: 07/03/2013 15:59:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_MeasInfo_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasInfo_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasInfo_INSERT]    Script Date: 07/03/2013 15:59:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE   PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasInfo_INSERT] (
@SampleRequestAMLHdrID UNIQUEIDENTIFIER,
@workflowItemID UNIQUEIDENTIFIER,
@workflowID UNIQUEIDENTIFIER  
)
AS

DECLARE @amlheader uniqueidentifier

set @amlheader = NEWID()

INSERT INTO pAMLMeasHdr(AMLMeasHdrId, Workflowid, StyleId, CompanyId, PDMPageId, CompanyName, PDMCompanyId, IsRelative, IsNegative, IsMetric, SizeClass, SizeClassId, 
                      SizeClassCode, SizeRange, SizeRangeId, SizeRangeCode, ProductType, ProductTypeId, ProductTypeCode, BaseSizeGrdCol, SelectedRange, MeasRowCnt, 
                      HaveHistory, HistoryMsg, CUser, CDate, MUser, MDate, WorkFlowItemId, StyleSet)
                      select @amlheader, @workflowID, StyleId, CompanyId, PDMPageId, CompanyName, PDMCompanyId, IsRelative, IsNegative, IsMetric, SizeClass, SizeClassId, 
                      SizeClassCode, SizeRange, SizeRangeId, SizeRangeCode, ProductType, ProductTypeId, ProductTypeCode, BaseSizeGrdCol, SelectedRange, MeasRowCnt, 
                      HaveHistory, HistoryMsg, CUser, CDate, MUser, MDate, @workflowItemID, StyleSet from pSampleRequestAMLMeasHdr where SampleRequestAMLMeasHdrId = @SampleRequestAMLHdrID


INSERT INTO pAMLMeasLbl (AMLMeasHdrId, PDMPageId, SizeRangeId, SizeRangeDetailId, SizeCol, MeasLbl, IsVisible, IsSample, MeasDesc, CUser, CDate, 
		MUser, MDate)
		SELECT @amlheader, PDMPageId, SizeRangeId, SizeRangeDetailId, SizeCol, MeasLbl, IsVisible, IsSample, MeasDesc, CUser, CDate, 
		MUser, MDate
		FROM pSampleRequestAMLMeasLbl WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLHdrID
			
	
	DECLARE @AMLMeasPOMCursor CURSOR
	DECLARE @CurrentPOMID UNIQUEIDENTIFIER
	DECLARE @NewPOMID UNIQUEIDENTIFIER
	
	
		
		
		
		
		
		-- Inserting the POMs from current header to new header and adding IGC to each if them
		SET @AMLMeasPOMCursor = CURSOR SCROLL
		FOR SELECT SampleRequestAmlMeasPOMId FROM pSampleRequestAMLMeasPOM WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLHdrID
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
			SELECT @NewPOMID, @amlheader, PDMPageId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, RefCode,
								Description, TolPlus, TolMinus, TolPlusConv, TolMinusConv, Flag4QA, WSRowId, SortId,
								VideoSerialnumber, ImageSerialnumber, ImageId, How2MeasText, CUser, CDate, MUser, MDate,
								IsLinked, Critical, How2MeasName, FabricType, IsLength, IsWidth, ShrinkX, ShrinkY, CADModelId,
								BeforeTreat
			FROM pSampleRequestAMLMeasPOM WHERE SampleRequestAMLMeasPOMId = @CurrentPOMID
			-- Inserting the IGC data from old POM to new
			INSERT INTO pAMLMeasIGC (AMLMeasHdrId, AMLMeasPOMId, PDMPageId, POM_Row, WSRowId, SizeCol, Incr, Grade, ConvGrade, 
										CUser, CDate, MUser, MDate)
			SELECT @amlheader, @NewPOMID, PDMPageId, POM_Row, WSRowId, SizeCol, Incr, Grade, ConvGrade, 
										CUser, CDate, MUser, MDate
			FROM pSampleRequestAMLMeasIGC WHERE SampleRequestAMLMeasPOMId = @CurrentPOMID
			
			FETCH NEXT FROM @AmlMeasPOMCursor INTO @CurrentPOMID
		END
		CLOSE @AmlMeasPOMCursor
		DEALLOCATE @AmlMeasPOMCursor
 
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05996', GetDate())
GO