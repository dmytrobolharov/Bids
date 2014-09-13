ALTER  PROCEDURE [dbo].[rpx_ControlPanel_POMTemplate_SELECT]
(
	@POMTempID varchar(50)
)
AS

SELECT DISTINCT
	a.Critical,
	a.POM,
	a.PointMeasur,
	dbo.fnx_Num2Frac(a.TOLN) AS TOLN, 
	dbo.fnx_Num2Frac(a.TOL) AS TOL, 
	dbo.fnx_Num2Frac(a.Spec) AS Spec, 
	dbo.fnx_Num2Frac(a.Grade0) AS Grade0, 
	dbo.fnx_Num2Frac(a.Grade1) AS Grade1, 
	dbo.fnx_Num2Frac(a.Grade2) AS Grade2,  
	dbo.fnx_Num2Frac(a.Grade3) AS Grade3, 
	dbo.fnx_Num2Frac(a.Grade4) AS Grade4, 
	dbo.fnx_Num2Frac(a.Grade5) AS Grade5, 
	dbo.fnx_Num2Frac(a.Grade6) AS Grade6, 
	dbo.fnx_Num2Frac(a.Grade7) AS Grade7, 
	dbo.fnx_Num2Frac(a.Grade8) AS Grade8, 
	dbo.fnx_Num2Frac(a.Grade9) AS Grade9, 
	dbo.fnx_Num2Frac(a.Grade10) AS Grade10, 
	dbo.fnx_Num2Frac(a.Grade11) AS Grade11, 
	dbo.fnx_Num2Frac(a.Grade12) AS Grade12, 
	dbo.fnx_Num2Frac(a.Grade13) AS Grade13, 
	dbo.fnx_Num2Frac(a.Grade14) AS Grade14, 
	dbo.fnx_Num2Frac(a.Grade15) AS Grade15, 
	dbo.fnx_Num2Frac(a.Grade16) AS Grade16, 
	dbo.fnx_Num2Frac(a.Grade17) AS Grade17, 
	dbo.fnx_Num2Frac(a.Grade18) AS Grade18, 
	dbo.fnx_Num2Frac(a.Grade19) AS Grade19,
	c.Size0 AS Range0,
	c.Size1 AS Range1,
	c.Size2 AS Range2,
	c.Size3 AS Range3,
	c.Size4 AS Range4,
	c.Size5 AS Range5,
	c.Size6 AS Range6,
	c.Size7 AS Range7,
	c.Size8 AS Range8,
	c.Size9 AS Range9,
	c.Size10 AS Range10,
	c.Size11 AS Range11,
	c.Size12 AS Range12,
	c.Size13 AS Range13,
	c.Size14 AS Range14,
	c.Size15 AS Range15,
	c.Size16 AS Range16,
	c.Size17 AS Range17,
	c.Size18 AS Range18,
	c.Size19 AS Range19,
	c.SizeClass + ' (' + c.SizeRange + ')' AS SizeClassRangeStr,
	a.Sort
FROM pPOMTemplateItem a LEFT OUTER JOIN pPOMTemplateGroup b ON
a.POMTempID = b.POMTempID LEFT OUTER JOIN pPOMTemplate c ON
b.POMTempID = c.POMTempID
WHERE c.POMTempID = @POMTempID
ORDER BY a.Sort, a.POM
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '260', GetDate())
GO