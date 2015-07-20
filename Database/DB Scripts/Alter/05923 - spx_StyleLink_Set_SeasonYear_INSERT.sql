IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleLink_Set_SeasonYear_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleLink_Set_SeasonYear_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleLink_Set_SeasonYear_INSERT](
	@StyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@StyleSet INT ,
	@PomTempId NVARCHAR(50),
	@StyleSpecConversion NVARCHAR(10),
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS


DECLARE @SizeRange NVARCHAR(100)
DECLARE @SizeClass NVARCHAR(100)
 
SELECT @SizeClass = SizeClass, @SizeRange = SizeRange FROM pPOMTemplate WHERE POMTempId = @POMTempId


IF @StyleSet = 1 
BEGIN 
	--***
	--** INSERT pStyleHeader, pStyleAttribute, pStyleImage, pStyleWorkflow, pStyleDevelopmentItem, pStyleDetail,
	--** pStyleWorkflowSchedule
	--***
	EXEC spx_StyleHeaderLink_INSERT @StyleID = @StyleID, @NewStyleID = @NewStyleID, 
	@SizeClass = @SizeClass, @SizeRange = @SizeRange, @CreatedBy = @CUser, @CreatedDate = @CDate

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


--***
--** INSERT pStyleSpec
--***	
EXEC spx_StyleDevelopmentSpecLinkSet_INSERT @StyleID = @StyleID, @NewStyleID = @NewStyleID, @SizeClass = @SizeClass,
@SizeRange = @SizeRange, @CreatedBy = @CUser, @CreatedDate = @CDate, @StyleSet = @StyleSet

--***
--** INSERT pStyleSpecSize
--***	
EXEC spx_StyleSpecSize_SELECT @StyleID = @NewStyleID



IF LOWER(@StyleSpecConversion) = 'true'
BEGIN 
	EXEC spx_StyleSpecReconvert_UPDATE @StyleID = @NewStyleID, @StyleSet  = @StyleSet
	

/*
	--IF (SELECT TOP 1 SpecConversion FROM pSizeClass WHERE (Custom IN (SELECT SizeClass FROM  pStyleHeader WHERE Styleid = @StyleId))) = 1

	IF ( SELECT TOP 1 SpecConversion FROM pSizeClass WHERE Custom = @SizeClass ) = 1
	BEGIN
		
		UPDATE pStyleSpec SET Spec = 0 WHERE StyleId  = @NewStyleID AND StyleSet = @StyleSet 
				
		UPDATE pStyleSpec SET pStyleSpec.Spec = pStyleSpec_1.Spec 
		FROM pStyleSpec INNER JOIN
		pStyleSpec pStyleSpec_1 ON pStyleSpec.POM = pStyleSpec_1.POM AND pStyleSpec.StyleSet = pStyleSpec_1.StyleSet
		WHERE   pStyleSpec.StyleID = @NewStyleId
		AND pStyleSpec_1.StyleID = @StyleId 
		AND pStyleSpec_1.POMTempID IS NOT NULL
		AND pStyleSpec.StyleSet  = @StyleSet 


		UPDATE pStyleSpec SET 
		pStyleSpec.Spec = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0))
		FROM   pStyleSpec INNER JOIN  pPOMTemplateItem ON pStyleSpec.POM = pPOMTemplateItem.POM
		WHERE pStyleSpec.StyleID = @StyleId 
		AND pStyleSpec.StyleSet = @StyleSet 
		AND pPOMTemplateItem.POMTempID = @POMTempId

	END
*/	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05923', GetDate())
GO
