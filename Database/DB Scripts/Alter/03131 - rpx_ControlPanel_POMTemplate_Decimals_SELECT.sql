IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ControlPanel_POMTemplate_Decimals_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ControlPanel_POMTemplate_Decimals_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_ControlPanel_POMTemplate_Decimals_SELECT]
(
	@POMTempID VARCHAR(50)
)
AS

SELECT DISTINCT
	pPOMTemplateItem.Critical,
	pPOMTemplateItem.POM,
	pPOMTemplateItem.PointMeasur,
	CAST(pPOMTemplateItem.TOLN AS DECIMAL(8,3)) AS TOLN, 
	CAST(pPOMTemplateItem.TOL AS DECIMAL(8,3)) AS TOL, 
	CAST(pPOMTemplateItem.Spec AS DECIMAL(8,3)) AS Spec, 
	CAST(pPOMTemplateItem.Grade0 AS DECIMAL(8,3)) AS Grade0, 
	CAST(pPOMTemplateItem.Grade1 AS DECIMAL(8,3)) AS Grade1, 
	CAST(pPOMTemplateItem.Grade2 AS DECIMAL(8,3)) AS Grade2,  
	CAST(pPOMTemplateItem.Grade3 AS DECIMAL(8,3)) AS Grade3, 
	CAST(pPOMTemplateItem.Grade4 AS DECIMAL(8,3)) AS Grade4, 
	CAST(pPOMTemplateItem.Grade5 AS DECIMAL(8,3)) AS Grade5, 
	CAST(pPOMTemplateItem.Grade6 AS DECIMAL(8,3)) AS Grade6, 
	CAST(pPOMTemplateItem.Grade7 AS DECIMAL(8,3)) AS Grade7, 
	CAST(pPOMTemplateItem.Grade8 AS DECIMAL(8,3)) AS Grade8, 
	CAST(pPOMTemplateItem.Grade9 AS DECIMAL(8,3)) AS Grade9, 
	CAST(pPOMTemplateItem.Grade10 AS DECIMAL(8,3)) AS Grade10, 
	CAST(pPOMTemplateItem.Grade11 AS DECIMAL(8,3)) AS Grade11, 
	CAST(pPOMTemplateItem.Grade12 AS DECIMAL(8,3)) AS Grade12, 
	CAST(pPOMTemplateItem.Grade13 AS DECIMAL(8,3)) AS Grade13, 
	CAST(pPOMTemplateItem.Grade14 AS DECIMAL(8,3)) AS Grade14, 
	CAST(pPOMTemplateItem.Grade15 AS DECIMAL(8,3)) AS Grade15, 
	CAST(pPOMTemplateItem.Grade16 AS DECIMAL(8,3)) AS Grade16, 
	CAST(pPOMTemplateItem.Grade17 AS DECIMAL(8,3)) AS Grade17, 
	CAST(pPOMTemplateItem.Grade18 AS DECIMAL(8,3)) AS Grade18, 
	CAST(pPOMTemplateItem.Grade19 AS DECIMAL(8,3)) AS Grade19,
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
VALUES ('DB_Version', '4.1.0000', '03131', GetDate())
GO