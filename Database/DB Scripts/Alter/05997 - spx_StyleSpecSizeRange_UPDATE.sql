/****** Object:  StoredProcedure [dbo].[spx_StyleSpecSizeRange_UPDATE]    Script Date: 07/04/2013 13:06:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSpecSizeRange_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSpecSizeRange_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleSpecSizeRange_UPDATE]    Script Date: 07/04/2013 13:06:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleSpecSizeRange_UPDATE]
(
@POMTempID uniqueidentifier, 
@StyleID uniqueidentifier,
@StyleSet NVARCHAR(5),
@ModifiedBy NVARCHAR(200),
@ModifiedDate datetime
)
AS 

DECLARE @tmpSizeRange nvarchar(50)
DECLARE @POMTempVersion nvarchar(5)

BEGIN

	SELECT @POMTempID = POMTempID, @POMTempVersion = POMTempVersion, @tmpSizeRange = SizeRange FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempID = @POMTempID 

	IF @StyleSet = 1 UPDATE dbo.pStyleHeader SET POMTempID1 = @POMTempID, POMTempVersion1 = @POMTempVersion, SizeRange = @tmpSizeRange  WHERE (StyleID = @StyleID)  
	IF @StyleSet = 2 UPDATE dbo.pStyleHeader SET POMTempID2 = @POMTempID, POMTempVersion2 = @POMTempVersion, SizeRange = @tmpSizeRange  WHERE (StyleID = @StyleID)  
	IF @StyleSet = 3 UPDATE dbo.pStyleHeader SET POMTempID3 = @POMTempID, POMTempVersion3 = @POMTempVersion, SizeRange = @tmpSizeRange  WHERE (StyleID = @StyleID)  
	IF @StyleSet = 4 UPDATE dbo.pStyleHeader SET POMTempID4 = @POMTempID, POMTempVersion4 = @POMTempVersion, SizeRange = @tmpSizeRange  WHERE (StyleID = @StyleID)  

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

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05997', GetDate())
GO
