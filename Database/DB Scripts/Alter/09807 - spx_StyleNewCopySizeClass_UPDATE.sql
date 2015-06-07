IF OBJECT_ID(N'[dbo].[spx_StyleNewCopySizeClass_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleNewCopySizeClass_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleNewCopySizeClass_UPDATE] (
@StyleID UNIQUEIDENTIFIER, 
@NewStyleID UNIQUEIDENTIFIER, 
@NewStyleDevelopmentID UNIQUEIDENTIFIER, 
@CreatedDate DATETIME, 
@CreatedBy NVARCHAR(200),
@LinkImage INT, 
@CarryOver INT, 

@StyleTempID NVARCHAR(20),
@StyleTempNo NVARCHAR(20),
@StyleNo NVARCHAR(20),

@DevelopmentTempID NVARCHAR(20),
@DevelopmentTempNo NVARCHAR(20),
@DevelopmentNo NVARCHAR(20) ,
@DesignSketchID UNIQUEIDENTIFIER
)
AS
BEGIN


DECLARE @tmpStyleNo NVARCHAR(20), 
@tmpStyleTempID NVARCHAR(20),
@tmpStyleTempNo NVARCHAR(20), 
@tmpNewStyleID UNIQUEIDENTIFIER 


SET @tmpStyleNo = @StyleNo
SET	@tmpStyleTempID =  @StyleTempID
SET @tmpStyleTempNo = @StyleTempNo
SET @tmpNewStyleID = @NewStyleID
 		

	DECLARE @StyleType AS NVARCHAR(5)
	DECLARE @SizeRange AS NVARCHAR(200)
	
	SELECT @StyleType = b.StyleType, 
		   @SizeRange = COALESCE(sr.SizeRangeCode, a.SizeRange)
	FROM  pStyleHeader a 
	INNER JOIN pStyleType b ON a.StyleType = b.StyleTypeID 
	LEFT JOIN pSizeRange sr ON sr.customId = a.SizeRangeId
	WHERE a.StyleID = @StyleID 


	IF @StyleType = 'V' 
	BEGIN 
		EXEC dbo.spx_StyleDevelopmentCopy_INSERT  @StyleDevelopmentID = @NewStyleDevelopmentID , 
			@StyleID = @NewStyleID,  @TempID = @DevelopmentTempID , @TempNo = @DevelopmentTempNo,
			@StyleDevelopmentNo = @DevelopmentNo, 
			@SizeRange = @SizeRange ,  @CreatedBy = @CreatedBy , @CreatedDate = @CreatedDate


		EXEC dbo.spx_StyleDevelopmentItemCopy_INSERT  @StyleDevelopmentID = @NewStyleDevelopmentID, 
			@StyleID = @NewStyleID ,  
			@TempID = @DevelopmentTempID , @TempNo = @DevelopmentTempNo,
			@StyleDevelopmentNo = @DevelopmentNo,
			@SizeRange = @SizeRange ,  @CreatedBy = @CreatedBy , @CreatedDate = @CreatedDate

	END
	ELSE
	BEGIN

		EXEC dbo.spx_StyleDevelopmentNew_INSERT @StyleDevelopmentID = @NewStyleDevelopmentID , 
			@StyleID = @NewStyleID, @TempID = @DevelopmentTempID , @TempNo = @DevelopmentTempNo, 
			@StyleDevelopmentNo = @DevelopmentNo, 
			@SizeRange = @SizeRange ,  @CreatedBy = @CreatedBy , @CreatedDate = @CreatedDate
	END 


/*

	EXEC dbo.spx_StyleDevelopmentNew_INSERT @StyleDevelopmentID = @NewStyleDevelopmentID , 
			@StyleID = @NewStyleID, @TempID = @DevelopmentTempID , @TempNo = @DevelopmentTempNo, 
			@StyleDevelopmentNo = @DevelopmentNo, 
			@SizeRange = @SizeRange ,  @CreatedBy = @CreatedBy , @CreatedDate = @CreatedDate
*/



/*
-- Removed from store procedure to execute
-- It will run at end of the page runtime right after all the records
-- have been created.  
-- DP 7/14/2009 

	IF @CarryOver  = 0 
	BEGIN			
		EXEC dbo.spx_StyleHeaderNoLogic_UPDATE  @StyleNo = @StyleNo , @TempId = @StyleTempID, @TempNo  = @StyleTempNo, @StyleId = @NewStyleID
	END
	ELSE	
	BEGIN

			DECLARE @oStyleNo NVARCHAR(20)
			DECLARE @oTempId NVARCHAR(20)
			DECLARE @oTempNo NVARCHAR(20)
			
			SELECT @oStyleNo = StyleNo, @oTempId = TempId, @oTempNo = TempNo
			FROM pStyleHeader	
			WHERE StyleID = @StyleID

			UPDATE pStyleHeader SET StyleNo = @oStyleNo,  TempId = @oTempId,  TempNo = @oTempNo
			WHERE StyleID = @NewStyleID

	END 
*/
	
	IF @LinkImage = 0 
	BEGIN

		UPDATE pStyleHeader SET DesignSketchID = @DesignSketchID , DesignSketchVersion = 1 
		WHERE StyleID = @NewStyleID
	END 
	ELSE
	BEGIN
		-- LINK STYLE DESIGN DETAIL IMAGES

		DECLARE @StyleSet INT 

		SELECT @StyleSet  = StyleSet 
		FROM pStyleHeader 
		WHERE StyleID = @NewStyleID

		IF @StyleSet IS NULL
			SET @StyleSet = 1 

		INSERT INTO pStyleImageItem  ( StyleImageItemID, StyleImageItemMasterID, WorkflowID , StyleID , StyleSet, ImageID, 
		ImageVersion, CUser, CDate, MUser, MDate, StyleImageLinked, Sort )   		
		SELECT NEWID() as StyleImageItemID , NEWID() as StyleImageItemMasterID, WorkflowID , @NewStyleID AS StyleID , StyleSet, 
		ImageID, ImageVersion, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate, StyleImageLinked, Sort 
		FROM pStyleImageItem 
		WHERE StyleID = @StyleID AND StyleSet <= @StyleSet
		AND WorkflowID = '40000000-0000-0000-0000-000000000006' 

	END 


	--EXEC spx_StyleImageItemVariation_SELECT @StyleId = @NewStyleID
	--EXEC spx_StyleImageItemMasterId_UPDATE @StyleId = @NewStyleID
	--EXEC spx_StyleMaterialMasterId_UPDATE @StyleId = @NewStyleID
	--EXEC spx_StyleHeaderLogic_UPDATE @StyleId = @NewStyleID

	-- Update SAPcode 
	IF @CarryOver = 0
	BEGIN
		UPDATE pStyleColorway SET SAPCode  =  NULL
		WHERE StyleID  = @NewStyleID

		-- Added by AG 20090827
		UPDATE pStyleHeader SET 
		StyleNo = @tmpStyleNo,
		TempId = @tmpStyleTempID, 
		TempNo = @tmpStyleTempNo
		WHERE StyleID = @tmpNewStyleID
	END 


	-- Update PLMCode 
	EXEC spx_StyleColorway_PLMCode_UPDATE @NewStyleID, 0



END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09807', GetDate())
GO
