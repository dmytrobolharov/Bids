/****** Object:  StoredProcedure [dbo].[spx_StyleSpecSizeRangeLogic_UPDATE]    Script Date: 07/04/2013 13:13:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSpecSizeRangeLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSpecSizeRangeLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleSpecSizeRangeLogic_UPDATE]    Script Date: 07/04/2013 13:13:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comments:

#01 - Ryan Cabanas - September 9, 2009
	For some reason, when updating the Size Range at the Style Development Spec page, if there are
Sourcing Quotes existing, when you change the Size Range, three custom fields in 'pStyleQuoteItem'
get overwritten, but there fields are being used in Quote equations.  Going to comment out this
update here and hope that it doesn't break anything related to the Size Range.
*/


CREATE  PROCEDURE [dbo].[spx_StyleSpecSizeRangeLogic_UPDATE]
(
@POMTempID uniqueidentifier, 
@StyleID uniqueidentifier,
@StyleSet NVARCHAR(5),
@ModifiedBy NVARCHAR(200),
@ModifiedDate datetime
)
AS 

DECLARE @tmpSizeRange	nvarchar(50)
DECLARE @POMTempVersion nvarchar(5)

BEGIN

	SELECT @POMTempID = POMTempID, @POMTempVersion = POMTempVersion, @tmpSizeRange = SizeRange FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempID = @POMTempID 

	IF @StyleSet = 1 UPDATE pStyleHeader SET POMTempID1 = @POMTempID, POMTempVersion1 = @POMTempVersion, SizeRange = @tmpSizeRange  WHERE (StyleID = @StyleID)  
	IF @StyleSet = 2 UPDATE pStyleHeader SET POMTempID2 = @POMTempID, POMTempVersion2 = @POMTempVersion, SizeRange = @tmpSizeRange  WHERE (StyleID = @StyleID)  
	IF @StyleSet = 3 UPDATE pStyleHeader SET POMTempID3 = @POMTempID, POMTempVersion3 = @POMTempVersion, SizeRange = @tmpSizeRange  WHERE (StyleID = @StyleID)  
	IF @StyleSet = 4 UPDATE pStyleHeader SET POMTempID4 = @POMTempID, POMTempVersion4 = @POMTempVersion, SizeRange = @tmpSizeRange  WHERE (StyleID = @StyleID)  

END

BEGIN

	DECLARE @Size0  NVARCHAR(5)
	DECLARE @Size1  NVARCHAR(5)
	DECLARE @Size2  NVARCHAR(5)
	DECLARE @Size3  NVARCHAR(5)
	DECLARE @Size4  NVARCHAR(5)
	DECLARE @Size5  NVARCHAR(5)
	DECLARE @Size6  NVARCHAR(5)
	DECLARE @Size7  NVARCHAR(5)
	DECLARE @Size8  NVARCHAR(5)
	DECLARE @Size9  NVARCHAR(5)
	DECLARE @Size10  NVARCHAR(5)
	DECLARE @Size11  NVARCHAR(5)
	DECLARE @Size12  NVARCHAR(5)
	DECLARE @Size13  NVARCHAR(5)
	DECLARE @Size14  NVARCHAR(5)
	DECLARE @Size15  NVARCHAR(5)
	DECLARE @Size16  NVARCHAR(5)
	DECLARE @Size17  NVARCHAR(5)
	DECLARE @Size18  NVARCHAR(5)
	DECLARE @Size19  NVARCHAR(5)

	DECLARE @Sel0 BIT
	DECLARE @Sel1 BIT
	DECLARE @Sel2 BIT
	DECLARE @Sel3 BIT
	DECLARE @Sel4 BIT
	DECLARE @Sel5 BIT
	DECLARE @Sel6 BIT
	DECLARE @Sel7 BIT
	DECLARE @Sel8 BIT
	DECLARE @Sel9 BIT
	DECLARE @Sel10 BIT
	DECLARE @Sel11 BIT
	DECLARE @Sel12 BIT
	DECLARE @Sel13 BIT
	DECLARE @Sel14 BIT
	DECLARE @Sel15 BIT
	DECLARE @Sel16 BIT
	DECLARE @Sel17 BIT
	DECLARE @Sel18 BIT
	DECLARE @Sel19 BIT

	DECLARE @Col0 BIT 
	DECLARE @Col1 BIT
	DECLARE @Col2 BIT
	DECLARE @Col3 BIT
	DECLARE @Col4 BIT
	DECLARE @Col5 BIT
	DECLARE @Col6 BIT
	DECLARE @Col7 BIT
	DECLARE @Col8 BIT
	DECLARE @Col9 BIT
	DECLARE @Col10 BIT
	DECLARE @Col11 BIT
	DECLARE @Col12 BIT
	DECLARE @Col13 BIT
	DECLARE @Col14 BIT
	DECLARE @Col15 BIT
	DECLARE @Col16 BIT
	DECLARE @Col17 BIT
	DECLARE @Col18 BIT
	DECLARE @Col19 BIT

	SELECT 
		@Size0 = Size0, @Size1 = Size1, @Size2 = Size2, @Size3 = Size3, @Size4 = Size4, @Size5 = Size5, @Size6 = Size6, @Size7 = Size7, @Size8 = Size8, @Size9 = Size9, 
		@Size10 = Size10, @Size11 = Size11, @Size12 = Size12, @Size13 = Size13, @Size14 = Size14, @Size15 = Size15, @Size16 = Size16, @Size17 = Size17, @Size18 = Size18, @Size19 = Size19, 
		@Sel0 = Sel0, @Sel1 = Sel1, @Sel2 = Sel2, @Sel3 = Sel3, @Sel4 = Sel4, @Sel5 = Sel5, @Sel6 = Sel6, @Sel7 = Sel7, @Sel8 = Sel8, @Sel9 = Sel9, 
		@Sel10 = Sel10, @Sel11 = Sel11, @Sel12 = Sel12, @Sel13 = Sel13, @Sel14 = Sel14, @Sel15 = Sel15, @Sel16 = Sel16, @Sel17 = Sel17, @Sel18 = Sel18, @Sel19 = Sel19
	FROM pSizeRange WITH (NOLOCK)
	WHERE SizeRangeCode = @tmpSizeRange


	IF  (SELECT @Size0) IS NULL  
		SELECT @Col0 = 0
	ELSE
		SELECT @Col0 = 1

	IF  (SELECT @Size1) IS NULL  
		SELECT @Col1 = 0
	ELSE
		SELECT @Col1 = 1

	IF  (SELECT @Size2) IS NULL   
		SELECT @Col2 = 0
	ELSE
		SELECT @Col2 = 1

	IF  (SELECT @Size3) IS NULL   
		SELECT @Col3 = 0
	ELSE
		SELECT @Col3 = 1

	IF  (SELECT @Size4) IS NULL   
		SELECT @Col4 = 0
	ELSE
		SELECT @Col4 = 1

	IF  (SELECT @Size5) IS NULL   
		SELECT @Col5 = 0
	ELSE
		SELECT @Col5 = 1

	IF  (SELECT @Size6) IS NULL   
		SELECT @Col6 = 0
	ELSE
		SELECT @Col6 = 1

	IF  (SELECT @Size7) IS NULL  
		SELECT @Col7 = 0
	ELSE
		SELECT @Col7 = 1

	IF  (SELECT @Size8) IS NULL   
		SELECT @Col8 = 0
	ELSE
		SELECT @Col8 = 1

	IF  (SELECT @Size9) IS NULL   
		SELECT @Col9 = 0
	ELSE
		SELECT @Col9 = 1

	IF  (SELECT @Size10) IS NULL   
		SELECT @Col10 = 0
	ELSE
		SELECT @Col10 = 1

	IF  (SELECT @Size11) IS NULL   
		SELECT @Col11 = 0
	ELSE
		SELECT @Col11 = 1

	IF  (SELECT @Size12) IS NULL   
		SELECT @Col12 = 0
	ELSE
		SELECT @Col12 = 1

	IF  (SELECT @Size13) IS NULL   
		SELECT @Col13 = 0
	ELSE
		SELECT @Col13 = 1

	IF  (SELECT @Size14) IS NULL  
		SELECT @Col14 = 0
	ELSE
		SELECT @Col14 = 1

	IF  (SELECT @Size15) IS NULL   
		SELECT @Col15 = 0
	ELSE
		SELECT @Col15 = 1

	IF  (SELECT @Size16) IS NULL   
		SELECT @Col16 = 0
	ELSE
		SELECT @Col16 = 1

	IF  (SELECT @Size17) IS NULL   
		SELECT @Col17 = 0
	ELSE
		SELECT @Col17 = 1

	IF  (SELECT @Size18) IS NULL   
		SELECT @Col18 = 0
	ELSE
		SELECT @Col18 = 1

	IF  (SELECT @Size19) IS NULL   
		SELECT @Col19 = 0
	ELSE
		SELECT @Col19 = 1

END

BEGIN
	UPDATE pStyleSpecSize
	SET  SizeRange = @tmpSizeRange, Size0 = @Size0, Size1 = @Size1, Size2 = @Size2, Size3 = @Size3, Size4 = @Size4, Size5 = @Size5, Size6 = @Size6, Size7 = @Size7, Size8 = @Size8, Size9 = @Size9, Size10 = @Size10, Size11 = @Size11, Size12 = @Size12, Size13 = @Size13, Size14 = @Size14, Size15 = @Size15, Size16 = @Size16, Size17 = @Size17, Size18 = @Size18, Size19 = @Size19,
		 Sel0 = @Sel0, Sel1 = @Sel1, Sel2 = @Sel2, Sel3 = @Sel3, Sel4 = @Sel4, Sel5 = @Sel5, Sel6 = @Sel6, Sel7 = @Sel7, Sel8 = @Sel8, Sel9 = @Sel9, Sel10 = @Sel10, Sel11 = @Sel11, Sel12 = @Sel12, Sel13 = @Sel13, Sel14 = @Sel14, Sel15 = @Sel15, Sel16 = @Sel16, Sel17 = @Sel17, Sel18 = @Sel18, Sel19 = @Sel19
	WHERE (StyleID = @StyleID)
END


BEGIN
	UPDATE pStyleSpec SET   
		pStyleSpec.POMTempID = @POMTempID,	
		pStyleSpec.POMTempItemID = pPOMTemplateItem.POMTempItemID,	
		pStyleSpec.TOL = pPOMTemplateItem.TOL, 
		pStyleSpec.TOLN = pPOMTemplateItem.TOLN, 
		pStyleSpec.Grade0 = pPOMTemplateItem.Grade0, 
		pStyleSpec.Grade1 = pPOMTemplateItem.Grade1, 
		pStyleSpec.Grade2 = pPOMTemplateItem.Grade2, 
		pStyleSpec.Grade3 = pPOMTemplateItem.Grade3, 
		pStyleSpec.Grade4 = pPOMTemplateItem.Grade4, 
		pStyleSpec.Grade5 = pPOMTemplateItem.Grade5, 
		pStyleSpec.Grade6 = pPOMTemplateItem.Grade6, 
		pStyleSpec.Grade7 = pPOMTemplateItem.Grade7, 
		pStyleSpec.Grade8 = pPOMTemplateItem.Grade8, 
		pStyleSpec.Grade9 = pPOMTemplateItem.Grade9, 
		pStyleSpec.Grade10 = pPOMTemplateItem.Grade10, 
		pStyleSpec.Grade11 = pPOMTemplateItem.Grade11, 
		pStyleSpec.Grade12 = pPOMTemplateItem.Grade12, 
		pStyleSpec.Grade13 = pPOMTemplateItem.Grade13, 
		pStyleSpec.Grade14 = pPOMTemplateItem.Grade14, 
		pStyleSpec.Grade15 = pPOMTemplateItem.Grade15, 
		pStyleSpec.Grade16 = pPOMTemplateItem.Grade16, 
		pStyleSpec.Grade17 = pPOMTemplateItem.Grade17, 
		pStyleSpec.Grade18 = pPOMTemplateItem.Grade18, 
		pStyleSpec.Grade19 = pPOMTemplateItem.Grade19, 
		pStyleSpec.Sort = pPOMTemplateItem.Sort
	FROM pPOMTemplateItem INNER JOIN
		pStyleSpec ON pPOMTemplateItem.POM = pStyleSpec.POM 
	WHERE 
		(pStyleSpec.StyleID = @StyleID) AND 
		(pStyleSpec.StyleSet = @StyleSet) AND
		(pPOMTemplateItem.POMTempID = @POMTempID)
END


--Comment #01
--BEGIN
--
--	UPDATE pStyleQuoteItem SET
--		StyleQuoteItemCustomField28 = @tmpSizeRange,
--		StyleQuoteItemCustomField29 = @ModifiedBy,
--		StyleQuoteItemCustomField30 = @ModifiedDate 
--	WHERE StyleId = @StyleId
--
--END

BEGIN

	UPDATE pSampleRequestSpecSize SET pSampleRequestSpecSize.SizeRange = pStyleSpecSize.SizeRange, pSampleRequestSpecSize.Size0 = pStyleSpecSize.Size0, 
	      pSampleRequestSpecSize.Size1 = pStyleSpecSize.Size1, pSampleRequestSpecSize.Size2 = pStyleSpecSize.Size2, 
	      pSampleRequestSpecSize.Size3 = pStyleSpecSize.Size3, pSampleRequestSpecSize.Size4 = pStyleSpecSize.Size4, 
	      pSampleRequestSpecSize.Size5 = pStyleSpecSize.Size5, pSampleRequestSpecSize.Size6 = pStyleSpecSize.Size6, 
	      pSampleRequestSpecSize.Size7 = pStyleSpecSize.Size7, pSampleRequestSpecSize.Size8 = pStyleSpecSize.Size8, 
	      pSampleRequestSpecSize.Size9 = pStyleSpecSize.Size9, pSampleRequestSpecSize.Size10 = pStyleSpecSize.Size10, 
	      pSampleRequestSpecSize.Size11 = pStyleSpecSize.Size11, pSampleRequestSpecSize.Size12 = pStyleSpecSize.Size12, 
	      pSampleRequestSpecSize.Size13 = pStyleSpecSize.Size13, pSampleRequestSpecSize.Size14 = pStyleSpecSize.Size14, 
	      pSampleRequestSpecSize.Size15 = pStyleSpecSize.Size15, pSampleRequestSpecSize.Size16 = pStyleSpecSize.Size16, 
	      pSampleRequestSpecSize.Size17 = pStyleSpecSize.Size17, pSampleRequestSpecSize.Size18 = pStyleSpecSize.Size18, 
	      pSampleRequestSpecSize.Size19 = pStyleSpecSize.Size19, pSampleRequestSpecSize.Sel0 = pStyleSpecSize.Sel0, 
	      pSampleRequestSpecSize.Sel1 = pStyleSpecSize.Sel1, pSampleRequestSpecSize.Sel2 = pStyleSpecSize.Sel2, 
	      pSampleRequestSpecSize.Sel3 = pStyleSpecSize.Sel3, pSampleRequestSpecSize.Sel4 = pStyleSpecSize.Sel4, 
	      pSampleRequestSpecSize.Sel5 = pStyleSpecSize.Sel5, pSampleRequestSpecSize.Sel6 = pStyleSpecSize.Sel6, 
	      pSampleRequestSpecSize.Sel7 = pStyleSpecSize.Sel7, pSampleRequestSpecSize.Sel8 = pStyleSpecSize.Sel8, 
	      pSampleRequestSpecSize.Sel9 = pStyleSpecSize.Sel9, pSampleRequestSpecSize.Sel10 = pStyleSpecSize.Sel10, 
	      pSampleRequestSpecSize.Sel11 = pStyleSpecSize.Sel11, pSampleRequestSpecSize.Sel12 = pStyleSpecSize.Sel12, 
	      pSampleRequestSpecSize.Sel13 = pStyleSpecSize.Sel13, pSampleRequestSpecSize.Sel14 = pStyleSpecSize.Sel14, 
	      pSampleRequestSpecSize.Sel15 = pStyleSpecSize.Sel15, pSampleRequestSpecSize.Sel16 = pStyleSpecSize.Sel16, 
	      pSampleRequestSpecSize.Sel17 = pStyleSpecSize.Sel17, pSampleRequestSpecSize.Sel18 = pStyleSpecSize.Sel18, 
	      pSampleRequestSpecSize.Sel19 = pStyleSpecSize.Sel19, pSampleRequestSpecSize.Col0 = pStyleSpecSize.Col0, 
	      pSampleRequestSpecSize.Col1 = pStyleSpecSize.Col1, pSampleRequestSpecSize.Col2 = pStyleSpecSize.Col2, 
	      pSampleRequestSpecSize.Col3 = pStyleSpecSize.Col3, pSampleRequestSpecSize.Col4 = pStyleSpecSize.Col4, 
	      pSampleRequestSpecSize.Col5 = pStyleSpecSize.Col5, pSampleRequestSpecSize.Col6 = pStyleSpecSize.Col6, 
	      pSampleRequestSpecSize.Col7 = pStyleSpecSize.Col7, pSampleRequestSpecSize.Col8 = pStyleSpecSize.Col8, 
	      pSampleRequestSpecSize.Col9 = pStyleSpecSize.Col9, pSampleRequestSpecSize.Col10 = pStyleSpecSize.Col10, 
	      pSampleRequestSpecSize.Col11 = pStyleSpecSize.Col11, pSampleRequestSpecSize.Col12 = pStyleSpecSize.Col12, 
	      pSampleRequestSpecSize.Col13 = pStyleSpecSize.Col13, pSampleRequestSpecSize.Col14 = pStyleSpecSize.Col14, 
	      pSampleRequestSpecSize.Col15 = pStyleSpecSize.Col15, pSampleRequestSpecSize.Col16 = pStyleSpecSize.Col16, 
	      pSampleRequestSpecSize.Col17 = pStyleSpecSize.Col17, pSampleRequestSpecSize.Col18 = pStyleSpecSize.Col18, 
	      pSampleRequestSpecSize.Col19 = pStyleSpecSize.Col19
	FROM         pSampleRequestSpecSize INNER JOIN
	      pStyleSpecSize ON pSampleRequestSpecSize.StyleID = pStyleSpecSize.StyleID


END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05998', GetDate())
GO
