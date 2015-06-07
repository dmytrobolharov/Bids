IF OBJECT_ID(N'[dbo].[rpx_Style_DevelopmentSpecGroup_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_Style_DevelopmentSpecGroup_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_DevelopmentSpecGroup_SELECT] 
	@StyleDevelopmentID AS nvarchar(50), 
	@StyleSet int
AS

SELECT DISTINCT
	ps.POM,
	ps.PointMeasur,
	dbo.fnx_Num2Frac(ps.Spec) AS Spec,
	ps.Sort, 
	CASE
	     WHEN sz.Sel0 = 1 THEN sz.Size0
	     WHEN sz.Sel1 = 1 THEN sz.Size1
	     WHEN sz.Sel2 = 1 THEN sz.Size2
	     WHEN sz.Sel3 = 1 THEN sz.Size3
	     WHEN sz.Sel4 = 1 THEN sz.Size4
	     WHEN sz.Sel5 = 1 THEN sz.Size5
	     WHEN sz.Sel6 = 1 THEN sz.Size6
	     WHEN sz.Sel7 = 1 THEN sz.Size7
	     WHEN sz.Sel8 = 1 THEN sz.Size8
	     WHEN sz.Sel9 = 1 THEN sz.Size9
	     WHEN sz.Sel10 = 1 THEN sz.Size10
	     WHEN sz.Sel11 = 1 THEN sz.Size11
	     WHEN sz.Sel12 = 1 THEN sz.Size12
	     WHEN sz.Sel13 = 1 THEN sz.Size13
	     WHEN sz.Sel14 = 1 THEN sz.Size14
	     WHEN sz.Sel15 = 1 THEN sz.Size15
	     WHEN sz.Sel16 = 1 THEN sz.Size16
	     WHEN sz.Sel17 = 1 THEN sz.Size17
	     WHEN sz.Sel18 = 1 THEN sz.Size18
	     WHEN sz.Sel19 = 1 THEN sz.Size19
	END AS SizeNo,
	COALESCE(sc.Custom, ph.SizeClass) AS SizeClass  
FROM pStyleHeader ph 
INNER JOIN pStyleSpecSize sz ON sz.StyleID = ph.StyleID 
INNER JOIN pStyleSpec ps ON ps.StyleID = ph.StyleID 
LEFT JOIN pSizeClass sc ON sc.CustomID = ph.SizeClassId
WHERE	((ps.StyleSet = @StyleSet) AND 
	(ph.DevelopmentID = @StyleDevelopmentID))
ORDER BY ps.Sort, ps.POM, SizeNo

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09615', GetDate())
GO
