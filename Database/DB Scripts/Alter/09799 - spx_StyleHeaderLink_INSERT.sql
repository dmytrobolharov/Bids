IF OBJECT_ID(N'[dbo].[spx_StyleHeaderLink_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleHeaderLink_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleHeaderLink_INSERT]
(
@StyleID uniqueidentifier,
@NewStyleID uniqueidentifier,
@SizeClass nvarchar(400),
@SizeRange nvarchar(200),
@CreatedBy nvarchar(200),
@CreatedDate datetime,
@SeasonYearID uniqueidentifier = NULL
)
AS

SET NOCOUNT ON

DECLARE @StyleMasterID uniqueidentifier
DECLARE @NewStyleMasterID uniqueidentifier

SET @NewStyleMasterID = newid()

BEGIN
		
	SELECT @StyleMasterID = StyleMasterID FROM pStyleHeader WHERE StyleID = @StyleID
		
		IF @StyleMasterID IS NULL
		BEGIN			
			UPDATE pStyleHeader SET StyleMasterID = @NewStyleMasterID WHERE StyleID = @StyleID
		END	
			
END

BEGIN
	INSERT INTO pStyleHeader
		(StyleWorkflowID, StyleID, StyleCategory, StyleMasterID, StyleType, WorkflowType, StyleNo, TempID, TempNo, CustomerNo, DevelopmentID, DevelopmentNo, SpecNo, 
		Description, SizeClassId, SizeClass, SizeRangeId, SizeRange, StyleSet, DueDate, RecDate, Designer, StyleStatus, StyleLocation, WashType, Pitch, MaterialID, MaterialImageID, 
		MaterialImageVersion, MaterialNo, MaterialName, POMTempID1, POMTempVersion1, POMTempID2, POMTempVersion2, POMTempID3, 
		POMTempVersion3, POMTempID4, POMTempVersion4, POMTempSizeClass1, POMTempSizeClass2, POMTempSizeClass3, POMTempSizeClass4, 
		StyleMaterialID, DesignSketchID, TechSketchID, ConceptSketchID, ColorSketchID, DesignSketchVersion, TechSketchVersion, ConceptSketchVersion, 
		ColorSketchVersion, DetailSketchID1, DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchVersion1, DetailSketchVersion2, 
		DetailSketchVersion3, DetailSketchVersion4, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, SpecSketchVersion1, 
		SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, 
		CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, CustomField11, CustomField12, CustomField13, CustomField14, 
		CustomField15, Pc1, Pc2, Pc3, Pc4, CUser, CDate, MUser, MDate, Active, Change, Action, Customer, Buyer, SampleMaker, PatternMaker, 
		ProductionManager, TechnicalDesigner, StyleDetail, StyleDetail1, StyleAttribute, StyleDetail2,
		CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
		CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30, 
		IntroSeasonYearID, DivisionID, StyleThemeID
		 )
	SELECT StyleWorkflowID, @NewStyleID AS NewStyleId, StyleCategory, StyleMasterID, StyleType, WorkflowType, StyleNo, TempID, TempNo, 
	       CustomerNo, DevelopmentID, DevelopmentNo, SpecNo, Description, (SELECT TOP 1 CustomId FROM pSizeClass WHERE Custom = @SizeClass), @SizeClass, 
		   (SELECT TOP 1 CustomId FROM pSizeRange WHERE SizeRangeCode = @SizeRange), @SizeRange, StyleSet, DueDate, RecDate, Designer, StyleStatus, 
		   StyleLocation, WashType, Pitch, MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, MaterialName, POMTempID1, POMTempVersion1, 
		   POMTempID2, POMTempVersion2, POMTempID3, POMTempVersion3, POMTempID4, POMTempVersion4, POMTempSizeClass1, POMTempSizeClass2, 
		POMTempSizeClass3, POMTempSizeClass4, StyleMaterialID, DesignSketchID, TechSketchID, ConceptSketchID, ColorSketchID, DesignSketchVersion, 
		TechSketchVersion, ConceptSketchVersion, ColorSketchVersion, DetailSketchID1, DetailSketchID2, DetailSketchID3, DetailSketchID4, 
		DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, DetailSketchVersion4, SpecSketchID1, SpecSketchID2, SpecSketchID3, 
		SpecSketchID4, SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, CustomField1, CustomField2, CustomField3, 
		CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, CustomField11, CustomField12, 
		CustomField13, CustomField14, CustomField15, Pc1, Pc2, Pc3, Pc4, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, 
		@CreatedDate AS MDate, 1, Change, Action, Customer, Buyer, SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleDetail, 
		StyleDetail1, StyleAttribute, StyleDetail2,
		CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
		CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30, 
		@SeasonYearID, DivisionID, StyleThemeID
	FROM  pStyleHeader
	WHERE StyleID = @StyleID
END

BEGIN
	
	INSERT INTO pStyleAttribute
         (StyleAttributeTableId, StyleId, StyleAttributeText, StyleAttributeValue, CUser, CDate, MUser, MDate)
	SELECT StyleAttributeTableId, @NewStyleId, StyleAttributeText, StyleAttributeValue, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pStyleAttribute
	WHERE StyleID = @StyleID
	
END


BEGIN
		
	SELECT @StyleMasterID = StyleMasterID FROM pStyleImage WHERE StyleID = @StyleID
		
		IF @StyleMasterID IS NULL
		BEGIN
			UPDATE pStyleImage SET StyleMasterID = @NewStyleMasterID WHERE StyleID = @StyleID
		END	
			
END

BEGIN

	INSERT INTO pStyleImage
	(StyleID, StyleMasterID, StyleType, MaterialID, MaterialImageID, DesignSketchID, TechSketchID, SalesSketchID, ColorSketchID, MaterialImageVersion, 
	DesignSketchVersion, TechSketchVersion, SalesSketchVersion, ColorSketchVersion, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, 
	SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, DetailSketchNo, DetailSketchData, DetailSketchID1, 
	DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchID11, DetailSketchID12, DetailSketchID21, DetailSketchID22, DetailSketchID31, 
	DetailSketchID32, DetailSketchID41, DetailSketchID42, DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, DetailSketchVersion4, 
	DetailSketchVersion11, DetailSketchVersion12, DetailSketchVersion21, DetailSketchVersion22, DetailSketchVersion31, DetailSketchVersion32, 
	DetailSketchVersion41, DetailSketchVersion42)
	SELECT @NewStyleID, StyleMasterID, StyleType, MaterialID, MaterialImageID, DesignSketchID, TechSketchID, SalesSketchID, ColorSketchID, MaterialImageVersion, 
	DesignSketchVersion, TechSketchVersion, SalesSketchVersion, ColorSketchVersion, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, 
	SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, DetailSketchNo, DetailSketchData, DetailSketchID1, 
	DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchID11, DetailSketchID12, DetailSketchID21, DetailSketchID22, DetailSketchID31, 
	DetailSketchID32, DetailSketchID41, DetailSketchID42, DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, DetailSketchVersion4, 
	DetailSketchVersion11, DetailSketchVersion12, DetailSketchVersion21, DetailSketchVersion22, DetailSketchVersion31, DetailSketchVersion32, 
	DetailSketchVersion41, DetailSketchVersion42
	FROM dbo.pStyleImage
	WHERE StyleID = @StyleID
	
END

BEGIN
CREATE TABLE [dbo].[#tempStyleWorkflow] (
	[RecID] int IDENTITY(1,1)  NOT NULL,
	[StyleWorkflowID]  uniqueidentifier ROWGUIDCOL  NOT NULL ,
	[StyleWorkflowMasterID] [uniqueidentifier],
	[StyleID] [uniqueidentifier],
	[StyleSet] [int],
	[WorkflowID] [uniqueidentifier],
	[WorkflowType] [int],
	[WorkflowOrder] [int],
	[WorkDate] [datetime],
	[WorkStart] [datetime],
	[WorkDue] [datetime],
	[WorkAssignedTo] [int],
	[WorkComplete] [nvarchar] (50),
	[WorkStatus] [int],
	[WorkStatusDate] [datetime],
	[WorkStatusBy] [nvarchar] (50),
	[WorkVersion] [int],
	[WorkComments] [nvarchar] (4000),
	[WorkSort] [nvarchar] (2),
	[CUser] [nvarchar] (100),
	[CDate] [datetime],
	[MUser] [nvarchar] (100),
	[MDate] [datetime]
)
END

/*Get the ID for the "In Progress" status so that the newly added size class has all it's Style Workflow pages
set to "In Progress" as the default.*/
DECLARE @DefaultWorkStatus int

BEGIN
	IF @SeasonYearID IS NOT NULL 
	BEGIN
		INSERT INTO dbo.#tempStyleWorkflow
		(StyleWorkflowID, StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
		WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate)
		SELECT StyleWorkflowID, @NewStyleID AS StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
		WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate
		FROM  dbo.pStyleWorkflow
		WHERE StyleID = @StyleID
		AND ((StyleSeasonYearID = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID) AND StyleSeasonYearID IS NOT NULL) 
		OR StyleSeasonYearID IS NULL)
	END
	ELSE
	BEGIN
		INSERT INTO dbo.#tempStyleWorkflow
		(StyleWorkflowID, StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
		WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate)
		SELECT StyleWorkflowID, @NewStyleID AS StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
		WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate
		FROM  dbo.pStyleWorkflow
		WHERE StyleID = @StyleID
	END
END

BEGIN

DECLARE @Row_Count int
DECLARE @Row_Loop int
DECLARE @NewStyleWorkflowMasterID uniqueidentifier
DECLARE @StyleWorkflowMasterID uniqueidentifier
DECLARE @StyleWorkflowID uniqueidentifier


	SET @Row_Loop = 1
	SET @Row_Count = (SELECT COUNT(*) FROM dbo.#tempStyleWorkflow)
	
	WHILE @Row_Loop <= @Row_Count 
	
		BEGIN
		
		SELECT @StyleWorkflowMasterID = StyleWorkflowMasterID, @StyleWorkflowID = StyleWorkflowID FROM #tempStyleWorkflow WHERE RecID = @Row_Loop
			
			IF @StyleWorkflowMasterID IS NULL
			BEGIN
				SET @NewStyleWorkflowMasterID = newid()
				UPDATE pStyleWorkflow SET StyleWorkflowMasterID = @NewStyleWorkflowMasterID WHERE StyleWorkflowID = @StyleWorkflowID
			END	
		
		SET @Row_Loop = @Row_Loop + 1
			
		END
END

BEGIN

	IF @SeasonYearID IS NOT NULL 
	BEGIN
		INSERT INTO dbo.pStyleWorkflow
		(WorkDay, StyleWorkflowID, StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
		WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate)
		SELECT  WorkDay, newid() AS StyleWorkflowID, @NewStyleID AS StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
		WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate
		FROM  dbo.pStyleWorkflow
		WHERE StyleID = @StyleID
		AND ((StyleSeasonYearID = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID) AND StyleSeasonYearID IS NOT NULL) 
		OR StyleSeasonYearID IS NULL)
	END
	ELSE
	BEGIN
		INSERT INTO dbo.pStyleWorkflow
		(WorkDay, StyleWorkflowID, StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
		WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate)
		SELECT  WorkDay, newid() AS StyleWorkflowID, @NewStyleID AS StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
		WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate
		FROM  dbo.pStyleWorkflow
		WHERE StyleID = @StyleID
	END
END

BEGIN

	INSERT INTO dbo.pStyleDevelopmentItem
	(StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation, CUser, CDate, MUser, MDate, StyleDevelopmentName)
	SELECT newid() AS StyleDevelopmentItemID, StyleDevelopmentID, @NewStyleID, @SizeRange, Variation, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate, StyleDevelopmentName
	FROM pStyleDevelopmentItem
	WHERE StyleID = @StyleID

END

BEGIN


INSERT INTO pStyleDetail
    (StyleID, Sort, StyleSet, FeatureDetail, Measurement, StitchType, Comments, CUser, CDate, MUser, MDate)
SELECT @NewStyleID AS StyleID, Sort, StyleSet, FeatureDetail, Measurement, StitchType, Comments, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate
FROM  pStyleDetail
WHERE (StyleID = @StyleID)


END


BEGIN

IF (SELECT COUNT(*) FROM pStyleWorkflowSchedule WHERE StyleID = @NewStyleId) = 0
	BEGIN
		INSERT INTO pStyleWorkflowSchedule
		(StyleId, WorkflowTemplateID, StyleDueDate, CDate, CUser)
		SELECT StyleID, StyleWorkflowID AS WorkflowTemplateID, DueDate AS StyleDueDate, @CreatedDate AS CDate, CUser
		FROM pStyleHeader
		WHERE StyleID = @NewStyleID
	END

END



--SELECT * FROM dbo.pStyleHeader WHERE (StyleID = @StyleID)
--SELECT * FROM #tempCopyStyleHeader



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09799', GetDate())
GO
