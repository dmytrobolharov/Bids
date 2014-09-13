IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSpecHowToMeasure_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleSpecHowToMeasure_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleSpecHowToMeasure_SELECT](
	@StyleID uniqueidentifier,
	@StyleSet INT
)
AS 

SELECT a.SpecID, a.StyleID, a.POMTempItemID, a.POMLibraryID, a.ModelSpecID, a.ModelID, a.POMTempID, a.StyleSet, 
	a.Critical, a.POM, a.PointMeasur, a.TOL, a.TOLN, a.Spec, 
	a.Proto0, a.Proto1, a.Proto2, a.Proto3, a.Proto4, a.Proto5, a.Proto6, a.Proto7, a.Proto8, a.Proto9, a.Proto10, a.Proto11, 
	a.Grade0, a.Grade1, a.Grade2, a.Grade3, a.Grade4, a.Grade5, a.Grade6, a.Grade7, a.Grade8, a.Grade9, a.Grade10, a.Grade11, 
	a.Size0, a.Size1, a.Size2, a.Size3, a.Size4, a.Size5, a.Size6, a.Size7, a.Size8, a.Size9, a.Size10, a.Size11, 
	a.CDate, a.CUser, a.MDate, a.MUser, a.Change, a.Sort, b.HowToMeasurText, a.HowToMeasurImage
FROM dbo.pStyleSpec a WITH (NOLOCK) 
	LEFT OUTER JOIN	dbo.pPOMLibrary b WITH(NOLOCK) ON a.POMLibraryID = b.POMLibraryID
WHERE a.StyleID = @StyleID
	AND a.StyleSet = @StyleSet
	AND a.POMLibraryID IS NOT NULL
ORDER BY a.Sort, a.POM, a.PointMeasur

GO	

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01368', GetDate())
GO

    
