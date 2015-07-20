IF OBJECT_ID(N'[dbo].[spx_POMTemplate_StyleWhereUsed_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_POMTemplate_StyleWhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_POMTemplate_StyleWhereUsed_SELECT]

	(
		@POMTempID uniqueidentifier
	)

AS

CREATE TABLE #tempStyleAvailable (
	[StyleID]  uniqueidentifier,
	[StyleNo] [nvarchar] (20) ,
	[Description] [nvarchar] (200) ,
	[SizeClass] [nvarchar] (400) ,
	[SizeRange] [nvarchar] (200) ,
	[StyleSet] [int] NULL ,
	[POMTempID] [uniqueidentifier] NULL ,
	[POMTempVersion] [int] NULL ,
	[DesignSketchID] [uniqueidentifier] NULL ,
	[DesignSketchVersion] [int] NULL 
) 	

BEGIN
	INSERT INTO #tempStyleAvailable
	(StyleID, StyleNo, Description, StyleSet, SizeClass, SizeRange, POMTempID, POMTempVersion, DesignSketchID, DesignSketchVersion)
	SELECT  sh.StyleID, sh.StyleNo, sh.Description, sh.StyleSet, 
	        COALESCE(sc.Custom, sh.SizeClass), COALESCE(sr.SizeRangeCode, sh.SizeRange), 
			sh.POMTempID1, sh.POMTempVersion1, sh.DesignSketchID, sh.DesignSketchVersion
	FROM pStyleHeader sh WITH (NOLOCK) 
	LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
	WHERE sh.POMTempID1 = @POMTempId

	INSERT INTO #tempStyleAvailable
	(StyleID, StyleNo, Description, StyleSet, SizeClass, SizeRange, POMTempID, POMTempVersion, DesignSketchID, DesignSketchVersion)
	SELECT sh.StyleID, sh.StyleNo, sh.Description, sh.StyleSet, 
	       COALESCE(sc.Custom, sh.SizeClass), COALESCE(sr.SizeRangeCode, sh.SizeRange), 
		   sh.POMTempID2, sh.POMTempVersion2, sh.DesignSketchID, sh.DesignSketchVersion
	FROM pStyleHeader sh WITH (NOLOCK) 
	LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
	WHERE sh.POMTempID2 = @POMTempId

	INSERT INTO #tempStyleAvailable
	(StyleID, StyleNo, Description, StyleSet, SizeClass, SizeRange, POMTempID, POMTempVersion, DesignSketchID, DesignSketchVersion)
	SELECT sh.StyleID, sh.StyleNo, sh.Description, sh.StyleSet, 
	       COALESCE(sc.Custom, sh.SizeClass), COALESCE(sr.SizeRangeCode, sh.SizeRange), 
		   sh.POMTempID3, sh.POMTempVersion3, sh.DesignSketchID, sh.DesignSketchVersion
	FROM pStyleHeader sh WITH (NOLOCK) 
	LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
	WHERE sh.POMTempID3 = @POMTempId

	INSERT INTO #tempStyleAvailable
	(StyleID, StyleNo, Description, StyleSet, SizeClass, SizeRange, POMTempID, POMTempVersion, DesignSketchID, DesignSketchVersion)
	SELECT sh.StyleID, sh.StyleNo, sh.Description, sh.StyleSet, 
	       COALESCE(sc.Custom, sh.SizeClass), COALESCE(sr.SizeRangeCode, sh.SizeRange), 
		   sh.POMTempID4, sh.POMTempVersion4, sh.DesignSketchID, sh.DesignSketchVersion
	FROM  pStyleHeader sh WITH (NOLOCK) 
	LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
	WHERE sh.POMTempID4 = @POMTempId
END


BEGIN
	SELECT * FROM #tempStyleAvailable
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09673', GetDate())
GO