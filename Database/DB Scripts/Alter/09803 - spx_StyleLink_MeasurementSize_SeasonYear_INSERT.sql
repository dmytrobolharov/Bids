IF OBJECT_ID(N'[dbo].[spx_StyleLink_MeasurementSize_SeasonYear_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleLink_MeasurementSize_SeasonYear_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleLink_MeasurementSize_SeasonYear_INSERT] (
	@StyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@SeasonYearID UNIQUEIDENTIFIER,
	@AMLMeasHdrID UNIQUEIDENTIFIER,
	@PomTempId NVARCHAR(50),
	@StyleMeasConversion NVARCHAR(10),
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS
BEGIN

DECLARE @SizeRange NVARCHAR(200)
DECLARE @SizeClass NVARCHAR(400)
DECLARE @WorkflowItemID UNIQUEIDENTIFIER, @WorkflowID UNIQUEIDENTIFIER
 
SELECT @SizeClass = SizeClass, @SizeRange = SizeRange FROM pGRMeasurementsPOMTemplate WHERE POMTempId = @POMTempId

DECLARE @WorkflowItemStyleSet INT
SELECT @WorkflowItemStyleSet = StyleSet, @WorkflowItemID = WorkFlowItemId, @WorkflowID = Workflowid FROM pAMLMeasHdr WHERE AMLMeasHdrId = @AMLMeasHdrID

IF @StyleSet = 1 
BEGIN 
	--***
	--** INSERT pStyleHeader, pStyleAttribute, pStyleImage, pStyleWorkflow, pStyleDevelopmentItem, pStyleDetail,
	--** pStyleWorkflowSchedule
	--***
	EXEC spx_StyleHeaderLink_INSERT @StyleID = @StyleID, @NewStyleID = @NewStyleID, 
	@SizeClass = @SizeClass, @SizeRange = @SizeRange, @CreatedBy = @CUser, @CreatedDate = @CDate, @SeasonYearID = @SeasonYearID

	--***
	--** Define Style / SeasonYear
	--***
	EXEC spx_StyleSeasonYear_INSERT @StyleID = @NewStyleID, @SeasonYearID = @SeasonYearID, 
	@CUser = @CUser, @CDate = @CDate

	-- Update SeasonYear of pStyleWorkflow for Seasonal bubbles
	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @NewStyleID AND SeasonYearID = @SeasonYearID)
	UPDATE pStyleWorkflow SET StyleSeasonYearID = @StyleSeasonYearID
	WHERE StyleID = @NewStyleID AND WorkflowID IN (SELECT Map FROM Mapping WHERE IsSeasonal = 1)
	
	--***
	--** INSERT pStyleMaterials, StyleColorway, StyleColorwaySeasonYear, StyleColorwayItem
	--***
	EXEC spx_StyleMaterialLink_SeasonYear_INSERT @StyleID = @StyleID, @NewStyleID = @NewStyleID, 
	@SeasonYearID = @SeasonYearID, @CUser = @CUser , @CDate = @CDate 	

	--***
	--** INSERT pStyleImageItem
	--***
	EXEC spx_StyleImageItemLink_INSERT  @StyleID = @StyleID, @NewStyleID = @NewStyleID, @CreatedBy = @CUser, @CreatedDate = @CDate 
	
	--***
	--** INSERT pStyleCare
	--***
	EXEC spx_StyleCareCopy_INSERT @StyleID  = @StyleID, @NewStyleID = @NewStyleID, @CreatedBy = @CUser, @CreatedDate = @CDate
	
	--***
	--** INSERT pStyleCostingHeader, pStyleCosting
	--***	
	EXEC spx_StyleCostingCopy_SeasonYear_INSERT @StyleID = @StyleID, @NewStyleID = @NewStyleID, @SeasonYearID = @SeasonYearID, 
	@CreatedBy = @CUser, @CreatedDate = @CDate

END 
	-- Copying the measurement item and swapping template
	DECLARE @NewWorkflowItemID UNIQUEIDENTIFIER
	DECLARE @NewAMLMeasHdrID UNIQUEIDENTIFIER
	SELECT @NewWorkflowItemID = NEWID()
	
	EXEC spx_WorkflowItem_COPY @WorkflowID, 
								@WorkflowItemID, 
								@NewStyleID, 
								@StyleID, 
								@StyleSet, 
								@WorkflowItemStyleSet, 
								@CUser, 
								@CDate, 
								@NewWorkflowItemID
	
	SELECT @NewAMLMeasHdrID = AmlMeasHdrID FROM pAMLMeasHdr WHERE WorkFlowItemId = @NewWorkflowItemID
	
	EXEC spx_StyleMeas_TemplateDelete @NewAmlMeasHdrID, @CUser, @CDate
	EXEC spx_StyleMeasGRMeasurements_INSERT @POMTempID, @NewStyleID, @WorkflowID, @NewWorkflowItemID, @StyleSet, '1', @NewAmlMeasHdrID, @CDate, @CUser, @AMLMeasHdrID
	
	IF (UPPER(@StyleMeasConversion) = 'TRUE')
		EXEC spx_StyleLink_MeasurementSize_SampleSizeConversion @AMLMeasHdrID, @NewAMLMeasHdrID
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09803', GetDate())
GO
