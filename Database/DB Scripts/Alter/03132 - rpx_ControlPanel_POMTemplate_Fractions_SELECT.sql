IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ControlPanel_POMTemplate_Fractions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ControlPanel_POMTemplate_Fractions_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_ControlPanel_POMTemplate_Fractions_SELECT]
(
	@POMTempID VARCHAR(50)
)
AS

SELECT DISTINCT
	pPOMTemplateItem.Critical,
	pPOMTemplateItem.POM,
	pPOMTemplateItem.PointMeasur,
	dbo.fnx_Num2Frac(pPOMTemplateItem.TOLN) AS TOLN, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.TOL) AS TOL, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Spec) AS Spec, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade0) AS Grade0, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade1) AS Grade1, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade2) AS Grade2,  
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade3) AS Grade3, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade4) AS Grade4, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade5) AS Grade5, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade6) AS Grade6, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade7) AS Grade7, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade8) AS Grade8, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade9) AS Grade9, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade10) AS Grade10, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade11) AS Grade11, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade12) AS Grade12, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade13) AS Grade13, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade14) AS Grade14, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade15) AS Grade15, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade16) AS Grade16, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade17) AS Grade17, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade18) AS Grade18, 
	dbo.fnx_Num2Frac(pPOMTemplateItem.Grade19) AS Grade19,
	pPOMTemplate.Size0 AS Range0,
	pPOMTemplate.Size1 AS Range1,
	pPOMTemplate.Size2 AS Range2,
	pPOMTemplate.Size3 AS Range3,
	pPOMTemplate.Size4 AS Range4,
	pPOMTemplate.Size5 AS Range5,
	pPOMTemplate.Size6 AS Range6,
	pPOMTemplate.Size7 AS Range7,
	pPOMTemplate.Size8 AS Range8,
	pPOMTemplate.Size9 AS Range9,
	pPOMTemplate.Size10 AS Range10,
	pPOMTemplate.Size11 AS Range11,
	pPOMTemplate.Size12 AS Range12,
	pPOMTemplate.Size13 AS Range13,
	pPOMTemplate.Size14 AS Range14,
	pPOMTemplate.Size15 AS Range15,
	pPOMTemplate.Size16 AS Range16,
	pPOMTemplate.Size17 AS Range17,
	pPOMTemplate.Size18 AS Range18,
	pPOMTemplate.Size19 AS Range19,
	pPOMTemplate.SizeClass + ' (' + pPOMTemplate.SizeRange + ')' AS SizeClassRangeStr,
	pPOMTemplateItem.Sort
FROM pPOMTemplateItem
	LEFT OUTER JOIN pPOMTemplateGroup ON	pPOMTemplateItem.POMTempID = pPOMTemplateGroup.POMTempID
	LEFT OUTER JOIN pPOMTemplate ON	pPOMTemplateGroup.POMTempID = pPOMTemplate.POMTempID
WHERE pPOMTemplate.POMTempID = @POMTempID
ORDER BY
	pPOMTemplateItem.Sort,
	pPOMTemplateItem.POM
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '03132', GetDate())
GO