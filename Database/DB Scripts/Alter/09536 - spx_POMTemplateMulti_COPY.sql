IF OBJECT_ID(N'[dbo].[spx_POMTemplateMulti_COPY]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_POMTemplateMulti_COPY]
GO

CREATE  PROCEDURE [dbo].[spx_POMTemplateMulti_COPY](
@POMTempID uniqueidentifier,
@NewPOMTempID uniqueidentifier,
@CopyPOMTempID uniqueidentifier,
@POMTempGroupID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime 
)
AS 


DECLARE 
@POMType nvarchar(100), 
@POMTypeDescription nvarchar(200)

DECLARE @SizeRange NVARCHAR (200) 

SELECT @POMType = POMType, @POMTypeDescription = POMTypeDescription 
FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempID = @POMTempID

SELECT @SizeRange   = SizeRange FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempID = @CopyPOMTempID



BEGIN

	INSERT INTO pPOMTemplate
		(POMTempID, POMTempGroupID, POMTempVersion, POMType, POMTypeDescription, SpecSketchID, SpecSketchVersion, SizeClass, SizeRange, CustomField1, 
		CustomField2, CustomField3, CustomField4, CustomField5, Sort, POMTempActive, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, 
		Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, CUser, CDate, MUser, MDate)
	SELECT @NewPOMTempID, @POMTempGroupID, POMTempVersion, @POMType, @POMTypeDescription, SpecSketchID, SpecSketchVersion, SizeClass, SizeRange, 
		CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, Sort, POMTempActive, Size0, Size1, Size2, Size3, Size4, 
		Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM  pPOMTemplate WITH (NOLOCK)
	WHERE (POMTempID = @CopyPOMTempID)
	
END
		
		
		
BEGIN

	INSERT INTO pPOMTemplateItem
		(POMTempID, POMTempGroupID, POMLibraryID, Critical, POM, PointMeasur, HowToMeasurText, HowToMeasurImage, TOL, TOLN, Spec, Grade0, 
		Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, 
		Grade17, Grade18, Grade19, CDate, CUser, MDate, MUser, Change, Sort, CopyPOMTempItemID , Conv, TempCopyPOMTempItemID )
	SELECT  @NewPOMTempID, @POMTempGroupID, POMLibraryID, Critical, POM, PointMeasur, HowToMeasurText, HowToMeasurImage, TOL, TOLN, Spec, 
		Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, 
		Grade16, Grade17, Grade18, Grade19, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy, Change, Sort, NULL, Conv, CopyPOMTempItemID 
	FROM pPOMTemplateItem WITH (NOLOCK)
	WHERE (POMTempID = @CopyPOMTempID)
	
END
		

INSERT INTO pPOMTemplateGroup ( POMTempGroupItemID , POMTempGroupID , POMTempID , SizeRange, CUser, CDate,  MUser , MDate  ) 
VALUES  ( NEWID() ,  @POMTempGroupID , @NewPOMTempID , @SizeRange  ,  @CreatedBy, @CreatedDate , @CreatedBy, @CreatedDate  )


--***
--** Define a new CopyPOMTempItemID value for the new PomTemplate
--***

CREATE TABLE  #tmp (
	ROWID INT IDENTITY (1,1),
	TempCopyPOMTempItemID UNIQUEIDENTIFIER 
)



INSERT INTO #tmp ( TempCopyPOMTempItemID ) 
SELECT DISTINCT TempCopyPOMTempItemID
FROM pPOMTemplateItem 
WHERE POMTempGroupID = @POMTempGroupID


DECLARE @ROWID INT
DECLARE @TOTAL INT 
DECLARE @TempCopyPOMTempItemID UNIQUEIDENTIFIER 
DECLARE @NEWID UNIQUEIDENTIFIER 

SET @ROWID = 1 
SELECT @TOTAL =  COUNT(*) FROM #tmp 

WHILE @ROWID <= @TOTAL 
BEGIN 
	SELECT @TempCopyPOMTempItemID = TempCopyPOMTempItemID FROM #tmp WHERE ROWID = @ROWID 
	SET @NEWID = NEWID()

	UPDATE pPOMTemplateItem SET CopyPOMTempItemID = @NEWID 
	WHERE POMTempGroupID = @POMTempGroupID 
	AND TempCopyPOMTempItemID = @TempCopyPOMTempItemID
	
	SET @ROWID = @ROWID + 1
END 



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09536', GetDate())
GO
