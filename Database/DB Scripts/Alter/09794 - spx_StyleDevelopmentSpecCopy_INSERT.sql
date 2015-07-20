IF OBJECT_ID(N'[dbo].[spx_StyleDevelopmentSpecCopy_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleDevelopmentSpecCopy_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleDevelopmentSpecCopy_INSERT]
(
@StyleID uniqueidentifier,
@StyleSet int,
@NewStyleID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

SET NOCOUNT ON


DECLARE @POMTempItemID	varchar(50)
DECLARE @POMTempID	varchar(50)
DECLARE @Row_Count int
DECLARE @Row_Loop int
DECLARE	@Size0 nvarchar (200), @SizeRange nvarchar(200), @SizeClass nvarchar(400),
@Size1 nvarchar (200), @Size2 nvarchar (200), @Size3 nvarchar (200), @Size4 nvarchar (200),
@Size5 nvarchar (200), @Size6 nvarchar (200), @Size7 nvarchar (200), @Size8 nvarchar (200), 
@Size9 nvarchar (200), @Size10 nvarchar (200), @Size11 nvarchar (200), @Size12 nvarchar (200),
@Size13 nvarchar (200), @Size14 nvarchar (200), @Size15 nvarchar (200), @Size16 nvarchar (200),
@Size17 nvarchar (200), @Size18 nvarchar (200), @Size19 nvarchar (200)


BEGIN
CREATE TABLE dbo.#tempStyleSpec1 (
	RecID int IDENTITY(1,1)  NOT NULL,
	SpecID  uniqueidentifier,
	SpecMasterID uniqueidentifier,
	StyleID uniqueidentifier,
	POMTempItemID uniqueidentifier,
	POMLibraryID uniqueidentifier,
	POMTempID uniqueidentifier,
	StyleSet int,
	Critical int,
	POM nvarchar (10),
	PointMeasur nvarchar (225),
	TOL numeric(18, 3) NOT NULL ,
	TOLN numeric(18, 3) NOT NULL ,
	Spec decimal(18, 3) NOT NULL ,
	Proto0 numeric(18, 3) NOT NULL ,
	Proto1 numeric(18, 3) NOT NULL ,
	Proto2 numeric(18, 3) NOT NULL ,
	Proto3 numeric(18, 3) NOT NULL ,
	Proto4 numeric(18, 3) NOT NULL ,
	Proto5 numeric(18, 3) NOT NULL ,
	Proto6 numeric(18, 3) NOT NULL ,
	Proto7 numeric(18, 3) NOT NULL ,
	Proto8 numeric(18, 3) NOT NULL ,
	Proto9 numeric(18, 3) NOT NULL ,
	Proto10 numeric(18, 0) NOT NULL ,
	Proto11 numeric(18, 0) NOT NULL ,
	Proto12 numeric(18, 3) NOT NULL ,
	Proto13 numeric(18, 3) NOT NULL ,
	Proto14 numeric(18, 3) NOT NULL ,
	Proto15 numeric(18, 3) NOT NULL ,
	Proto16 numeric(18, 3) NOT NULL ,
	Proto17 numeric(18, 3) NOT NULL ,
	Proto18 numeric(18, 3) NOT NULL ,
	Proto19 numeric(18, 3) NOT NULL ,
	Grade0 numeric(18, 3) NOT NULL ,
	Grade1 numeric(18, 3) NOT NULL ,
	Grade2 numeric(18, 3) NOT NULL ,
	Grade3 numeric(18, 3) NOT NULL ,
	Grade4 numeric(18, 3) NOT NULL ,
	Grade5 numeric(18, 3) NOT NULL ,
	Grade6 numeric(18, 3) NOT NULL ,
	Grade7 numeric(18, 3) NOT NULL ,
	Grade8 numeric(18, 3) NOT NULL ,
	Grade9 numeric(18, 3) NOT NULL ,
	Grade10 numeric(18, 3) NOT NULL ,
	Grade11 numeric(18, 3) NOT NULL ,
	Grade12 numeric(18, 3) NOT NULL ,
	Grade13 numeric(18, 3) NOT NULL ,
	Grade14 numeric(18, 3) NOT NULL ,
	Grade15 numeric(18, 3) NOT NULL ,
	Grade16 numeric(18, 3) NOT NULL ,
	Grade17 numeric(18, 3) NOT NULL ,
	Grade18 numeric(18, 3) NOT NULL ,
	Grade19 numeric(18, 3) NOT NULL ,
	Size0 numeric(18, 3) NOT NULL ,
	Size1 numeric(18, 3) NOT NULL ,
	Size2 numeric(18, 3) NOT NULL ,
	Size3 numeric(18, 3) NOT NULL ,
	Size4 numeric(18, 3) NOT NULL ,
	Size5 numeric(18, 3) NOT NULL ,
	Size6 numeric(18, 3) NOT NULL ,
	Size7 numeric(18, 3) NOT NULL ,
	Size8 numeric(18, 3) NOT NULL ,
	Size9 numeric(18, 3) NOT NULL ,
	Size10 numeric(18, 3) NOT NULL ,
	Size11 numeric(18, 3) NOT NULL ,
	Size12 numeric(18, 3) NOT NULL ,
	Size13 numeric(18, 3) NOT NULL ,
	Size14 numeric(18, 3) NOT NULL ,
	Size15 numeric(18, 3) NOT NULL ,
	Size16 numeric(18, 3) NOT NULL ,
	Size17 numeric(18, 3) NOT NULL ,
	Size18 numeric(18, 3) NOT NULL ,
	Size19 numeric(18, 3) NOT NULL ,
	CDate datetime,
	CUser nvarchar (200),
	MDate datetime,
	MUser nvarchar (200),
	Change int,
	Sort nvarchar (5)
) 
END

BEGIN
	INSERT INTO dbo.#tempStyleSpec1
		(SpecID, StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1, 
		Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, 
		Grade18, Grade19, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, 
		Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, 
		Size14, Size15, Size16, Size17, Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort)
	SELECT  NEWID() AS SpecID, @NewStyleID AS StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, 
		TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, 
		Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, Spec AS P6,
		Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, Spec AS P17, 
		Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S2, 0 AS S3, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 0 AS S12, 
		0 AS S13, 0 AS S14, 0 AS S15, 0 AS S16, 0 AS S17, 0 AS S18, 0 AS S19, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, Change, Sort
	FROM  dbo.pStyleSpec WITH (NOLOCK)
	WHERE (StyleID = @StyleID) AND (StyleSet = @StyleSet)
END


DECLARE @POMTempGroupID nvarchar(50)
DECLARE @StyleSpecID uniqueidentifier
DECLARE @StyleSpecMasterID uniqueidentifier
DECLARE @NewStyleSpecMasterID uniqueidentifier
DECLARE @POM nvarchar(10)
DECLARE @PointMeasur nvarchar(225)
DECLARE @TOL numeric(18, 3), @TOLN numeric(18, 3), @Spec decimal(18, 3),
@Grade0 numeric(18, 3), @Grade1 numeric(18, 3), @Grade2 numeric(18, 3),
@Grade3 numeric(18, 3), @Grade4 numeric(18, 3), @Grade5 numeric(18, 3),
@Grade6 numeric(18, 3), @Grade7 numeric(18, 3), @Grade8 numeric(18, 3),
@Grade9 numeric(18, 3), @Grade10 numeric(18, 3), @Grade11 numeric(18, 3),
@Grade12 numeric(18, 3), @Grade13 numeric(18, 3), @Grade14 numeric(18, 3),
@Grade15 numeric(18, 3), @Grade16 numeric(18, 3), @Grade17 numeric(18, 3),
@Grade18 numeric(18, 3), @Grade19 numeric(18, 3)


BEGIN

IF @StyleSet = 1 
BEGIN
	SELECT @SizeRange = SizeRange, @SizeClass = SizeClass,  @POMTempID = POMTempID1  FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleId
END
IF @StyleSet = 2
BEGIN 
	SELECT @SizeRange = SizeRange, @SizeClass = SizeClass,  @POMTempID = POMTempID2  FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleId
END
IF @StyleSet = 3
BEGIN 
	SELECT @SizeRange = SizeRange, @SizeClass = SizeClass,  @POMTempID = POMTempID3  FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleId
END
IF @StyleSet = 4 
BEGIN
	SELECT @SizeRange = SizeRange, @SizeClass = SizeClass,  @POMTempID = POMTempID4  FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleId
END

/*******
 * 5/1/07 - 5:50pm EST - Ryan Cabanas - Commented out this SELECT statement because it will return multiple
 * records and it is a repetition of the SELECT statements directly above this one.  Those SELECT statements
 * based on the StyleSet are the correct way of doing this.
 ******/
-- 	BEGIN
-- 		SELECT @POMTempID = POMTempID FROM dbo.pStyleSpec WITH (NOLOCK) WHERE (StyleID = @StyleID) AND StyleSet = @StyleSet
-- 	END

SELECT @POMTempGroupID = POMTempGroupID FROM dbo.pPOMTemplate WITH (NOLOCK) WHERE POMTempID = @POMTempID 
SELECT @POMTempID = POMTempID, 
	@Size0 = Size0, @Size1 = Size1, @Size2 = Size2,
	@Size3 = Size3, @Size4 = Size4, @Size5 = Size5, @Size6 = Size6, @Size7 = Size7, @Size8 = Size8,
	@Size9 = Size9, @Size10 = Size10, @Size11 = Size11, @Size12 = Size12, @Size13 = Size13, @Size14 = Size14,
	@Size15 = Size15, @Size16 = Size16, @Size17 = Size17, @Size18 = Size18, @Size19 = Size19
FROM dbo.pPOMTemplate WITH (NOLOCK) WHERE POMTempGroupID = @POMTempGroupID AND SizeRange = @SizeRange AND SizeClass = @SizeClass



IF @StyleSet = 1 
BEGIN
	UPDATE pStyleHeader SET POMTempID1 = @POMTempID WHERE StyleID = @NewStyleID
END
IF @StyleSet = 2
BEGIN 
	UPDATE pStyleHeader SET POMTempID2 = @POMTempID WHERE StyleID = @NewStyleID
END
IF @StyleSet = 3
BEGIN 
	UPDATE pStyleHeader SET POMTempID3 = @POMTempID WHERE StyleID = @NewStyleID
END
IF @StyleSet = 4 
BEGIN
	UPDATE pStyleHeader SET POMTempID4 = @POMTempID WHERE StyleID = @NewStyleID
END



SET @Row_Loop = 1
SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleSpec1)

IF @Row_Count <> 0
	BEGIN
	WHILE @Row_Loop <= @Row_Count 
		BEGIN
		
			SELECT @StyleSpecMasterID = SpecMasterID, @StyleSpecID = SpecID, 
			 @POM = POM, @PointMeasur = PointMeasur 
			FROM #tempStyleSpec1 WHERE RecID = @Row_Loop
			
			IF @StyleSpecMasterID IS NULL
			BEGIN
				SET @NewStyleSpecMasterID = newid()
				UPDATE pStyleSpec SET SpecMasterID = @NewStyleSpecMasterID WHERE SpecID = @StyleSpecID
				SET @StyleSpecMasterID = @NewStyleSpecMasterID
			END	
		
			UPDATE  #tempStyleSpec1 SET 
				SpecMasterID = @StyleSpecMasterID
			WHERE RecID = @Row_Loop

			/*********
			 * 5/1/07 - 5:20pm EST - Ryan Cabanas - Update the temp table POMS with the newer POMTempID.  Do this only for the POMs that were
			 * linked in the original Style that the Development Specs were copied from.
			 ********/
			BEGIN
				--IF ((SELECT POMTempID FROM #tempStyleSpec1 WHERE RecID = @Row_Loop) IS NOT NULL)
					BEGIN
						UPDATE #tempStyleSpec1
						SET POMTempID = @POMTempID
						WHERE RecID = @Row_Loop
							AND POMTempID IS NOT NULL
					END
			END

			SET @Row_Loop = @Row_Loop + 1
		END
		
	--UPDATE pStyleHeader SET POMTempID1 = @POMTempID WHERE StyleID = @NewStyleID

/*********
 * 5/1/07 - 5:55pm EST - Ryan Cabanas - In the SELECT part of the INSERT/SELECT statement below, I changed "@POMTempID AS POMTempID" to just "POMTempID"
 * because I'm updating the temp table first and doing it this way was incorrect and all the POMs were coming in linked.
 ********/
	INSERT INTO dbo.pStyleSpec
		(SpecID, StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID, Critical, POM, PointMeasur, TOL, TOLN, Grade0, Grade1, 
		Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, 
		Grade18, Grade19, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, 
		Proto15, Proto16, Proto17, Proto18, Proto19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, 
		Size19, Size18, Size17, Size16, Size15, Size14, CDate, CUser, MDate, MUser, Change, Sort)
	SELECT NEWID() AS SpecID, @NewStyleID AS StyleID, StyleSet, SpecMasterID, POMLibraryID, POMTempItemID, POMTempID /*@POMTempID AS POMTempID*/, Critical, POM, 
		PointMeasur, TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, 
		Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Spec AS Spec, Spec AS P0, Spec AS P1, Spec AS P2, Spec AS P3, Spec AS P4, Spec AS P5, 
		Spec AS P6, Spec AS P7, Spec AS P8, Spec AS P9, Spec AS P10, Spec AS P11, Spec AS P12, Spec AS P13, Spec AS P14, Spec AS P15, Spec AS P16, 
		Spec AS P17, Spec AS P18, Spec AS P19, 0 AS S0, 0 AS S1, 0 AS S3, 0 AS S4, 0 AS S4, 0 AS S5, 0 AS S6, 0 AS S7, 0 AS S8, 0 AS S9, 0 AS S10, 0 AS S11, 
		0 AS S12, 0 AS S13, 0 AS S19, 0 AS S18, 0 AS S17, 0 AS S16, 0 AS S15, 0 AS S14, CDate, CUser, @CreatedDate AS MUser, @CreatedBy AS MDate, 
		Change, Sort
	FROM  dbo.#tempStyleSpec1		
	END	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09794', GetDate())
GO
