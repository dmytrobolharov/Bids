/****** Object:  StoredProcedure [dbo].[spx_StyleHeaderCopy_INSERT]    Script Date: 10/25/2012 11:03:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeaderCopy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleHeaderCopy_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleHeaderCopy_INSERT]    Script Date: 10/25/2012 11:03:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleHeaderCopy_INSERT]
(
@StyleID uniqueidentifier,
@NewStyleID uniqueidentifier,
@DesignSketchID uniqueidentifier,
@DesignSketchBackID uniqueidentifier = NULL,
@DesignSketchVersion varchar(5),
@DesignSketchBackVersion varchar(5) = NULL,
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
		(StyleID, StyleMasterID, StyleType, WorkflowType, StyleNo, TempID, TempNo, CustomerNo, ConceptID, ConceptNo, SpecNo, Description, SizeRange, SizeClass, 
		StyleSet, DueDate, RecDate, Designer, StyleStatus, StyleLocation, WashType, Pitch, MaterialID, MaterialImageID, MaterialImageVersion, MaterialNo, 
		MaterialName, POMTempID1, POMTempVersion1, POMTempID2, POMTempVersion2, POMTempID3, POMTempVersion3, POMTempID4, 
		POMTempVersion4, POMTempSizeClass1, POMTempSizeClass2, POMTempSizeClass3, POMTempSizeClass4, StyleMaterialID, DesignSketchID, DesignSketchBackID,
		TechSketchID, ConceptSketchID, ColorSketchID, DesignSketchVersion, DesignSketchBackVersion, TechSketchVersion, ConceptSketchVersion, ColorSketchVersion, 
		DetailSketchID1, DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, 
		DetailSketchVersion4, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, SpecSketchVersion1, SpecSketchVersion2, 
		SpecSketchVersion3, SpecSketchVersion4, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, CustomField6, CustomField7, 
		CustomField8, CustomField9, CustomField10, CustomField11, CustomField12, CustomField13, CustomField14, CustomField15, 
--		Size0, Size1, Size2,  Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, 
--		Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, 
		Pc1, Pc2, Pc3, 
		Pc4, CUser, CDate, MUser, MDate, Active, Change, Action, SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleDetail, StyleDetail1, 
		StyleDetail2, StyleAttribute,
		CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
		CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30 , StyleCopyID
		)
	SELECT     @NewStyleID, @StyleMasterID, StyleType, WorkflowType, StyleNo, TempID, TempNo, CustomerNo, ConceptID, ConceptNo, 
		SpecNo, Description, SizeRange, SizeClass, StyleSet, DueDate, RecDate, Designer, StyleStatus, StyleLocation, WashType, Pitch, MaterialID, MaterialImageID, 
		MaterialImageVersion, MaterialNo, MaterialName, POMTempID1, POMTempVersion1, POMTempID2, POMTempVersion2, POMTempID3, 
		POMTempVersion3, POMTempID4, POMTempVersion4, POMTempSizeClass1, POMTempSizeClass2, POMTempSizeClass3, POMTempSizeClass4, 
		StyleMaterialID, @DesignSketchID, @DesignSketchBackID, TechSketchID, ConceptSketchID, ColorSketchID, @DesignSketchVersion AS Expr4, @DesignSketchBackVersion, TechSketchVersion, 
		ConceptSketchVersion, ColorSketchVersion, DetailSketchID1, DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchVersion1, 
		DetailSketchVersion2, DetailSketchVersion3, DetailSketchVersion4, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, 
		SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, CustomField1, CustomField2, CustomField3, CustomField4, 
		CustomField5, CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, CustomField11, CustomField12, CustomField13, 
		CustomField14, CustomField15, 
--		Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, 
--		Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, 
		Pc1, Pc2, Pc3, Pc4, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, 
		@CreatedDate AS MDate, Active, 1 , Action, SampleMaker, PatternMaker, ProductionManager, TechnicalDesigner, StyleDetail, StyleDetail1,
		StyleDetail2, StyleAttribute,
		CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
		CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30 , @StyleID  AS StyleCopyID 
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
	UPDATE pStyleImage SET StyleMasterID = @NewStyleMasterID WHERE StyleID = @StyleID
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
	SELECT @NewStyleID, @StyleMasterID, StyleType, MaterialID, MaterialImageID, DesignSketchID, TechSketchID, SalesSketchID, ColorSketchID, MaterialImageVersion, 
	DesignSketchVersion, TechSketchVersion, SalesSketchVersion, ColorSketchVersion, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, 
	SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, DetailSketchNo, DetailSketchData, DetailSketchID1, 
	DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchID11, DetailSketchID12, DetailSketchID21, DetailSketchID22, DetailSketchID31, 
	DetailSketchID32, DetailSketchID41, DetailSketchID42, DetailSketchVersion1, DetailSketchVersion2, DetailSketchVersion3, DetailSketchVersion4, 
	DetailSketchVersion11, DetailSketchVersion12, DetailSketchVersion21, DetailSketchVersion22, DetailSketchVersion31, DetailSketchVersion32, 
	DetailSketchVersion41, DetailSketchVersion42
	FROM pStyleImage WITH (NOLOCK)
	WHERE StyleID = @StyleID

END

BEGIN
CREATE TABLE #tempStyleWorkflow (
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
	INSERT INTO #tempStyleWorkflow
	(StyleWorkflowID, StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
	WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate)
	SELECT StyleWorkflowID, @NewStyleID AS StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
	WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate
	FROM  pStyleWorkflow WITH (NOLOCK)
	WHERE StyleID = @StyleID
END

BEGIN

DECLARE @Row_Count int
DECLARE @Row_Loop int
DECLARE @NewStyleWorkflowMasterID uniqueidentifier
DECLARE @StyleWorkflowMasterID uniqueidentifier
DECLARE @StyleWorkflowID uniqueidentifier


	SET @Row_Loop = 1
	SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleWorkflow)

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

	INSERT INTO pStyleWorkflow
	(StyleWorkflowID, StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, WorkComplete, 
	WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate, WorkDay )
	SELECT  newid() AS StyleWorkflowID, @NewStyleID AS StyleID, StyleSet, WorkflowID, WorkflowType, WorkflowOrder, WorkDate, WorkStart, WorkDue, WorkAssignedTo, 0 AS WorkComplete, 
	6 AS WorkStatus, NULL AS WorkStatusDate, NULL  AS WorkStatusBy, 0 AS WorkVersion, WorkComments, WorkSort, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate , WorkDay 
	FROM  pStyleWorkflow WITH (NOLOCK)
	WHERE StyleID = @StyleID
END



/*******************************************************************************************************************************************************************************************************************************************************************************************************************
-- INSERT LOG RECCORD 
*******************************************************************************************************************************************************************************************************************************************************************************************************************/
DECLARE @StyleNo NVARCHAR(20)
DECLARE @CustomField2 NVARCHAR(200)
DECLARE @CustomField4 NVARCHAR(200)
DECLARE @Description NVARCHAR (4000)

SELECT @StyleNo  = StyleNo   , @CustomField2  =  CustomField2   , @CustomField4 = CustomField4  
FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID 

SET  @Description  = 'Style copied from style with StyleNo: '  +  @StyleNo   +  '  ( ' +  @CustomField2   + ' /  '  + @CustomField4  + ' ) '



INSERT INTO pStyleChange (StyleChangeID ,  StyleStatus ,  WorkflowID , StyleID , StyleSet ,  StyleChangeNotifyTo , StyleChangeType, 
StyleChangeDescription ,  StyleChangeBy, StyleChangeDate,  TechPackID , ActiveID ,  Active  ) 
VALUES  ( NEWID() ,   0 , '70000000-0000-0000-0000-000000000001' , @NewStyleID , 0 ,  '' , 'Information', @Description ,
@CreatedBy,  @CreatedDate ,  NULL , '00000000-0000-0000-0000-000000000000'  , 1 )

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04250', GetDate())
GO
