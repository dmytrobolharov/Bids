/****** Object:  StoredProcedure [dbo].[spx_StyleHeaderVariation_INSERT]    Script Date: 05/22/2013 12:08:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeaderVariation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleHeaderVariation_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleHeaderVariation_INSERT]    Script Date: 05/22/2013 12:08:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



/********************************************************************************************************************/
/*NOTES:																											*/
/* 12/12/2007 - Ryan Cabanas -	For the next to last INSERT statement, into the pStyleWorkflow table, modified		*/
/*								the "WorkStatus" and "WorkStatusDate" fields so that they insert a '6' and 'NULL',	*/
/*								respectively.  Before, they just entered the values from the previous Variation.	*/
/*								The '6' sets the status to "In Progress".											*/
/********************************************************************************************************************/


CREATE PROCEDURE [dbo].[spx_StyleHeaderVariation_INSERT]
(
@StyleID uniqueidentifier,
@NewStyleID uniqueidentifier,
@DesignSketchID uniqueidentifier,
@DesignSketchVersion varchar(5),
@StyleVariation varchar(5),
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

SET NOCOUNT ON

DECLARE @StyleMasterID uniqueidentifier
DECLARE @NewStyleMasterID uniqueidentifier


SET @NewStyleMasterID = newid()

/*
BEGIN
		
	SELECT @StyleMasterID = StyleMasterID FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID
		
		IF @StyleMasterID IS NULL
		BEGIN			
			UPDATE pStyleHeader SET StyleMasterID = @NewStyleMasterID WHERE StyleID = @StyleID
		END	
			
END
*/

SET @StyleMasterID = @NewStyleMasterID

BEGIN
	INSERT INTO pStyleHeader
		(StyleID, StyleMasterID, StyleCategory, SizeClass, StyleType, WorkflowType, StyleNo, TempID, TempNo, CustomerNo, DevelopmentID, 
		DevelopmentNo, SpecNo, Description, SizeRange, StyleSet, DueDate, RecDate, Designer, StyleStatus, StyleLocation, WashType, Pitch, MaterialID, 
		MaterialImageID, MaterialImageVersion, MaterialNo, MaterialName, POMTempID1, POMTempVersion1, POMTempID2, POMTempVersion2, 
		POMTempID3, POMTempVersion3, POMTempID4, POMTempVersion4, POMTempSizeClass1, POMTempSizeClass2, POMTempSizeClass3, 
		POMTempSizeClass4, StyleMaterialID, DesignSketchID, TechSketchID, ConceptSketchID, ColorSketchID, DesignSketchVersion, TechSketchVersion, 
		ConceptSketchVersion, ColorSketchVersion, DetailSketchID1, DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchVersion1, 
		DetailSketchVersion2, DetailSketchVersion3, DetailSketchVersion4, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, 
		SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, CustomField1, CustomField2, CustomField3, CustomField4, 
		CustomField5, CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, CustomField11, CustomField12, CustomField13, 
		CustomField14, CustomField15, Pc1, Pc2, Pc3, Pc4, CUser, CDate, MUser, MDate, Active, Change, Action, StyleDetail, StyleAttribute, Customer, Buyer, 
		SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleDetail1, StyleDetail2,
		CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
		CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30, StyleWorkflowID,DivisionID, IntroSeasonYearID
		)
	SELECT @NewStyleID AS NewStyleId, @StyleMasterID AS StyleMasterId, StyleCategory, SizeClass, StyleType, WorkflowType, StyleNo, TempID, TempNo, 
		CustomerNo, DevelopmentID, DevelopmentNo, SpecNo, Description, SizeRange, StyleSet, DueDate, RecDate, Designer, StyleStatus, StyleLocation, 
		WashType, Pitch, MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, MaterialName, POMTempID1, POMTempVersion1, POMTempID2, 
		POMTempVersion2, POMTempID3, POMTempVersion3, POMTempID4, POMTempVersion4, POMTempSizeClass1, POMTempSizeClass2, 
		POMTempSizeClass3, POMTempSizeClass4, StyleMaterialID, @DesignSketchID AS Expr3, TechSketchID, ConceptSketchID, ColorSketchID, 
		@DesignSketchVersion AS Expr4, TechSketchVersion, ConceptSketchVersion, ColorSketchVersion, DetailSketchID1, DetailSketchID2, DetailSketchID3, 
		DetailSketchID4, DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, DetailSketchVersion4, SpecSketchID1, SpecSketchID2, 
		SpecSketchID3, SpecSketchID4, SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, CustomField1, CustomField2, 
		CustomField3, CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, CustomField11, 
		CustomField12, CustomField13, CustomField14, CustomField15, Pc1, Pc2, Pc3, Pc4, @CreatedBy AS CUser, @CreatedDate AS CDate, 
		@CreatedBy AS MUser, @CreatedDate AS MDate, 1, Change, Action, StyleDetail, StyleAttribute, Customer, Buyer, SampleMaker, PatternMaker, 
		ProductionManager, TechnicalDesigner, StyleDetail1, StyleDetail2,
		CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
		CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30, StyleWorkflowID , DivisionID, IntroSeasonYearID
	FROM  pStyleHeader WITH (NOLOCK)
	WHERE StyleID = @StyleID
END

BEGIN
	
	INSERT INTO pStyleAttribute
         (StyleAttributeTableId, StyleId, StyleAttributeText, StyleAttributeValue, CUser, CDate, MUser, MDate)
	SELECT StyleAttributeTableId, @NewStyleId, StyleAttributeText, StyleAttributeValue, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pStyleAttribute WITH (NOLOCK)
	WHERE StyleID = @StyleID
	
END

BEGIN
		
	SELECT @StyleMasterID = StyleMasterID FROM pStyleImage WITH (NOLOCK) WHERE StyleID = @StyleID
		
		IF @StyleMasterID IS NULL
		BEGIN
			UPDATE pStyleImage SET StyleMasterID = @NewStyleMasterID WHERE StyleID = @StyleID
		END	
			
END

BEGIN

	INSERT INTO dbo.pStyleImage
	(StyleID, StyleMasterID, StyleType, MaterialID, MaterialImageID, DesignSketchID, TechSketchID, SalesSketchID, ColorSketchID, MaterialImageVersion, 
	DesignSketchVersion, TechSketchVersion, SalesSketchVersion, ColorSketchVersion, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, 
	SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, DetailSketchNo, DetailSketchData, DetailSketchID1, 
	DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchID11, DetailSketchID12, DetailSketchID21, DetailSketchID22, DetailSketchID31, 
	DetailSketchID32, DetailSketchID41, DetailSketchID42, DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, DetailSketchVersion4, 
	DetailSketchVersion11, DetailSketchVersion12, DetailSketchVersion21, DetailSketchVersion22, DetailSketchVersion31, DetailSketchVersion32, 
	DetailSketchVersion41, DetailSketchVersion42)
	SELECT @NewStyleID, @StyleMasterID, StyleType, MaterialID, MaterialImageID, DesignSketchID, TechSketchID, SalesSketchID, ColorSketchID, MaterialImageVersion, 
	DesignSketchVersion, TechSketchVersion, SalesSketchVersion, ColorSketchVersion, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, 
	SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, DetailSketchNo, DetailSketchData, DetailSketchID1, 
	DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchID11, DetailSketchID12, DetailSketchID21, DetailSketchID22, DetailSketchID31, 
	DetailSketchID32, DetailSketchID41, DetailSketchID42, DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, DetailSketchVersion4, 
	DetailSketchVersion11, DetailSketchVersion12, DetailSketchVersion21, DetailSketchVersion22, DetailSketchVersion31, DetailSketchVersion32, 
	DetailSketchVersion41, DetailSketchVersion42
	FROM dbo.pStyleImage WITH (NOLOCK)
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

BEGIN
	INSERT INTO dbo.#tempStyleWorkflow
	(StyleWorkflowID, StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
	WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate)
	SELECT StyleWorkflowID, @NewStyleID AS StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
	WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate
	FROM  dbo.pStyleWorkflow WITH (NOLOCK)
	WHERE StyleID = @StyleID
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

	INSERT INTO dbo.pStyleWorkflow
	(StyleWorkflowID, StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
	WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate)
	SELECT  newid() AS StyleWorkflowID, @NewStyleID AS StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
	6 AS WorkStatus, NULL AS WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate
	FROM  dbo.pStyleWorkflow WITH (NOLOCK)
	WHERE StyleID = @StyleID
END

BEGIN

	DECLARE @Variation int
	DECLARE @StyleDevelopmentID varchar(50)

	SELECT @StyleDevelopmentID = StyleDevelopmentID FROM dbo.pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID
	SET @Variation = (SELECT MAX(Variation) FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleDevelopmentID = @StyleDevelopmentID) + 1

	INSERT INTO dbo.pStyleDevelopmentItem
	(StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation, CUser, CDate, MUser, MDate)
	SELECT newid() AS StyleDevelopmentItemID, StyleDevelopmentID, @NewStyleID, SizeRange, @Variation, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate
	FROM dbo.pStyleDevelopmentItem WITH (NOLOCK)
	WHERE StyleID = @StyleID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05736', GetDate())
GO

