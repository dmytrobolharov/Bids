/****** Object:  StoredProcedure [dbo].[spx_StyleSpec_SELECT]    Script Date: 06/06/2011 11:16:27 ******/
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleSpec_SELECT')
   DROP PROCEDURE spx_StyleSpec_SELECT
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleSpec_SELECT]
(@StyleID uniqueidentifier,
@StyleSet int)

AS 


SELECT SpecID, StyleID, POMTempItemID, POMLibraryID, POMTempID, StyleSet, POM, PointMeasur, TOL, TOLN, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, 
Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, 
Grade11, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, CDate, CUser, MDate, MUser, Change, Sort, 
HowToMeasurText, HowToMeasurImage, Critical, '(' + POM + ') ' + PointMeasur AS FullSpec
FROM dbo.pStyleSpec WITH (NOLOCK)
WHERE     (StyleID = @StyleID) AND (StyleSet = @StyleSet) 
ORDER BY Sort, POM, PointMeasur

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01501', GetDate())
GO