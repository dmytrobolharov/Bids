IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_POMLibraryToStyleSpec_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_POMLibraryToStyleSpec_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_POMLibraryToStyleSpec_INSERT]
(@POMLibraryID uniqueidentifier,
@StyleID nvarchar(50),
@StyleSet nvarchar(50))
AS 

CREATE TABLE [#tempStyleDevelopmentItem] ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
	[StyleDevelopmentItemID]	uniqueidentifier NULL,
	[StyleDevelopmentID]    	uniqueidentifier NULL,
	[StyleID]               	uniqueidentifier NULL,
	[SizeRange]             	nvarchar(50) NULL,
	[Variation]             	int NULL,
	[CUser]                 	nvarchar(200) NULL,
	[CDate]                 	datetime NULL,
	[MUser]                 	nvarchar(200) NULL,
	[MDate]                 	datetime NULL,
)

DECLARE @RowStyleLoop 			int
DECLARE @RowStyleCount 			int
DECLARE @tmpStyleID				uniqueidentifier
DECLARE @SpecMasterID			uniqueidentifier
DECLARE @tmpStyleVariation		int

SET @SpecMasterID = newid()

DECLARE @StyleDevelopmentId uniqueidentifier
SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleId = @StyleId

BEGIN
	INSERT INTO #tempStyleDevelopmentItem
		(StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation)
	SELECT StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation FROM pStyleDevelopmentItem WITH (NOLOCK) 
	WHERE StyleDevelopmentID = @StyleDevelopmentId AND Variation = @tmpStyleVariation
END

SET @RowStyleLoop = 1
SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)

WHILE @RowStyleLoop <= @RowStyleCount 

BEGIN

	SELECT @tmpStyleID = StyleID FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

		INSERT INTO pStyleSpec
			(SpecMasterID, StyleID, StyleSet, POM, PointMeasur, TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, 
			Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Spec , POMLibraryID )
		SELECT @SpecMasterID AS Expr1, @tmpStyleID AS StyleID, @StyleSet AS StyleSet, POM, PointMeasur, 0 AS TOL, 0 AS TOLN, 0 AS Grade0, 0 AS Grade1, 
			0 AS Grade2, 0 AS Grade3, 0 AS Grade4, 0 AS Grade5, 0 AS Grade6, 0 AS Grade7, 0 AS Grade8, 0 AS Grade9, 0 AS Grade10, 0 AS Grade11, 
			0 AS Grade12, 0 AS Grade13, 0 AS Grade14, 0 AS Grade15, 0 AS Grade16, 0 AS Grade17, 0 AS Grade18, 0 AS Grade19, 0 AS Spec, POMLibraryID
		FROM  pPOMLibrary WITH (NOLOCK)
		WHERE (POMLibraryID = @POMLibraryID) AND POM NOT IN (SELECT POM FROM pStyleSpec WITH (NOLOCK) WHERE StyleID = @tmpStyleID AND StyleSet = @StyleSet)

	SET @RowStyleLoop = @RowStyleLoop + 1
	
	DECLARE @MaxSort int
	DECLARE @StringSort NVARCHAR(5)
	SELECT @MaxSort = MAX(ISNULL(Sort, 0)) FROM pStyleSpec WHERE StyleID=@tmpStyleID
	SET @MaxSort = @MaxSort + 1
	SET @StringSort = RIGHT ( '0000' +  cast ( @MaxSort as nvarchar (5) ) , 4 )
	UPDATE pStyleSpec SET Sort = @StringSort WHERE SpecMasterID = @SpecMasterID AND (Sort IS NULL Or Sort = '0000')
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03869', GetDate())
GO
