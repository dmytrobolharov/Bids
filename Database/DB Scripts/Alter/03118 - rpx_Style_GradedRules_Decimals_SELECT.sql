IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_GradedRules_Decimals_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_GradedRules_Decimals_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Style_GradedRules_Decimals_SELECT]
	@StyleID varchar(255), 
	@StyleSet int 
AS
 
SELECT
	pStyleSpecSize.Sel0 AS Sample0,
	pStyleSpecSize.Sel1 AS Sample1,
	pStyleSpecSize.Sel2 AS Sample2,
	pStyleSpecSize.Sel3 AS Sample3,
	pStyleSpecSize.Sel4 AS Sample4,
	pStyleSpecSize.Sel5 AS Sample5,
	pStyleSpecSize.Sel6 AS Sample6,
	pStyleSpecSize.Sel7 AS Sample7,
	pStyleSpecSize.Sel8 AS Sample8,
	pStyleSpecSize.Sel9 AS Sample9,
	pStyleSpecSize.Sel10 AS Sample10,
	pStyleSpecSize.Sel11 AS Sample11,
	pStyleSpecSize.Sel12 AS Sample12,
	pStyleSpecSize.Sel13 AS Sample13,
	pStyleSpecSize.Sel14 AS Sample14,
	pStyleSpecSize.Sel15 AS Sample15,
	pStyleSpecSize.Sel16 AS Sample16,
	pStyleSpecSize.Sel17 AS Sample17,
	pStyleSpecSize.Sel18 AS Sample18,
	pStyleSpecSize.Sel19 AS Sample19,
	pStyleSpecSize.Size0 AS Range0,
	pStyleSpecSize.Size1 AS Range1,
	pStyleSpecSize.Size2 AS Range2,
	pStyleSpecSize.Size3 AS Range3,
	pStyleSpecSize.Size4 AS Range4,
	pStyleSpecSize.Size5 AS Range5,
	pStyleSpecSize.Size6 AS Range6,
	pStyleSpecSize.Size7 AS Range7,
	pStyleSpecSize.Size8 AS Range8,
	pStyleSpecSize.Size9 AS Range9,
	pStyleSpecSize.Size10 AS Range10,
	pStyleSpecSize.Size11 AS Range11,
	pStyleSpecSize.Size12 AS Range12,
	pStyleSpecSize.Size13 AS Range13,
	pStyleSpecSize.Size14 AS Range14,
	pStyleSpecSize.Size15 AS Range15,
	pStyleSpecSize.Size16 AS Range16,
	pStyleSpecSize.Size17 AS Range17,
	pStyleSpecSize.Size18 AS Range18,
	pStyleSpecSize.Size19 AS Range19,
	CAST(pStyleSpec.Size0 AS Decimal(8,3)) AS Size0,
	CAST(pStyleSpec.Size1 AS Decimal(8,3)) AS Size1,
	CAST(pStyleSpec.Size2 AS Decimal(8,3)) AS Size2,
	CAST(pStyleSpec.Size3 AS Decimal(8,3)) AS Size3,
	CAST(pStyleSpec.Size4 AS Decimal(8,3)) AS Size4,
	CAST(pStyleSpec.Size5 AS Decimal(8,3)) AS Size5,
	CAST(pStyleSpec.Size6 AS Decimal(8,3)) AS Size6,
	CAST(pStyleSpec.Size7 AS Decimal(8,3)) AS Size7,
	CAST(pStyleSpec.Size8 AS Decimal(8,3)) AS Size8,
	CAST(pStyleSpec.Size9 AS Decimal(8,3)) AS Size9,
	CAST(pStyleSpec.Size10 AS Decimal(8,3)) AS Size10,
	CAST(pStyleSpec.Size11 AS Decimal(8,3)) AS Size11,
	CAST(pStyleSpec.Size12 AS Decimal(8,3)) AS Size12,
	CAST(pStyleSpec.Size13 AS Decimal(8,3)) AS Size13,
	CAST(pStyleSpec.Size14 AS Decimal(8,3)) AS Size14,
	CAST(pStyleSpec.Size15 AS Decimal(8,3)) AS Size15,
	CAST(pStyleSpec.Size16 AS Decimal(8,3)) AS Size16,
	CAST(pStyleSpec.Size17 AS Decimal(8,3)) AS Size17,
	CAST(pStyleSpec.Size18 AS Decimal(8,3)) AS Size18,
	CAST(pStyleSpec.Size19 AS Decimal(8,3)) AS Size19,
	CAST(pStyleSpec.Grade0 AS Decimal(8,3)) AS Grade0, 
	CAST(pStyleSpec.Grade1 AS Decimal(8,3)) AS Grade1, 
	CAST(pStyleSpec.Grade2 AS Decimal(8,3)) AS Grade2,  
	CAST(pStyleSpec.Grade3 AS Decimal(8,3)) AS Grade3, 
	CAST(pStyleSpec.Grade4 AS Decimal(8,3)) AS Grade4, 
	CAST(pStyleSpec.Grade5 AS Decimal(8,3)) AS Grade5, 
	CAST(pStyleSpec.Grade6 AS Decimal(8,3)) AS Grade6, 
	CAST(pStyleSpec.Grade7 AS Decimal(8,3)) AS Grade7, 
	CAST(pStyleSpec.Grade8 AS Decimal(8,3)) AS Grade8, 
	CAST(pStyleSpec.Grade9 AS Decimal(8,3)) AS Grade9, 
	CAST(pStyleSpec.Grade10 AS Decimal(8,3)) AS Grade10, 
	CAST(pStyleSpec.Grade11 AS Decimal(8,3)) AS Grade11, 
	CAST(pStyleSpec.Grade12 AS Decimal(8,3)) AS Grade12, 
	CAST(pStyleSpec.Grade13 AS Decimal(8,3)) AS Grade13, 
	CAST(pStyleSpec.Grade14 AS Decimal(8,3)) AS Grade14, 
	CAST(pStyleSpec.Grade15 AS Decimal(8,3)) AS Grade15, 
	CAST(pStyleSpec.Grade16 AS Decimal(8,3)) AS Grade16, 
	CAST(pStyleSpec.Grade17 AS Decimal(8,3)) AS Grade17, 
	CAST(pStyleSpec.Grade18 AS Decimal(8,3)) AS Grade18, 
	CAST(pStyleSpec.Grade19 AS Decimal(8,3)) AS Grade19, 
	CAST(pStyleSpec.Proto0 AS Decimal(8,3)) AS Proto0, 
	CAST(pStyleSpec.Proto1 AS Decimal(8,3)) AS Proto1, 
	CAST(pStyleSpec.Proto2 AS Decimal(8,3)) AS Proto2,  
	CAST(pStyleSpec.Proto3 AS Decimal(8,3)) AS Proto3, 
	CAST(pStyleSpec.Proto4 AS Decimal(8,3)) AS Proto4, 
	CAST(pStyleSpec.Proto5 AS Decimal(8,3)) AS Proto5, 
	CAST(pStyleSpec.Proto6 AS Decimal(8,3)) AS Proto6, 
	CAST(pStyleSpec.Proto7 AS Decimal(8,3)) AS Proto7, 
	CAST(pStyleSpec.Proto8 AS Decimal(8,3)) AS Proto8, 
	CAST(pStyleSpec.Proto9 AS Decimal(8,3)) AS Proto9, 
	CAST(pStyleSpec.Proto10 AS Decimal(8,3)) AS Proto10, 
	CAST(pStyleSpec.Proto11 AS Decimal(8,3)) AS Proto11, 
	CAST(pStyleSpec.Proto12 AS Decimal(8,3)) AS Proto12, 
	CAST(pStyleSpec.Proto13 AS Decimal(8,3)) AS Proto13, 
	CAST(pStyleSpec.Proto14 AS Decimal(8,3)) AS Proto14, 
	CAST(pStyleSpec.Proto15 AS Decimal(8,3)) AS Proto15, 
	CAST(pStyleSpec.Proto16 AS Decimal(8,3)) AS Proto16, 
	CAST(pStyleSpec.Proto17 AS Decimal(8,3)) AS Proto17, 
	CAST(pStyleSpec.Proto18 AS Decimal(8,3)) AS Proto18, 
	CAST(pStyleSpec.Proto19 AS Decimal(8,3)) AS Proto19, 	
	pStyleSpec.POM,
	pStyleSpec.PointMeasur, 
	CAST(pStyleSpec.TOL AS Decimal(8,3)) AS TOL, 
	CAST(pStyleSpec.TOLN AS Decimal(8,3)) AS TOLN, 
	WashType = 
		CASE 
			WHEN UPPER(pStyleHeader.WashType) IS NULL THEN 'TOL'
			WHEN UPPER(pStyleHeader.WashType) = '' THEN 'TOL'
			WHEN UPPER(pStyleHeader.WashType) = 'WASH' THEN 'TOL'
			ELSE 'TOLN'
		END 
FROM pStyleSpecSize
	INNER JOIN pStyleSpec ON	pStyleSpecSize.StyleID = pStyleSpec.StyleID
	INNER JOIN pStyleHeader ON	pStyleSpec.StyleID = pStyleHeader.StyleID 
WHERE (pStyleSpec.StyleID = @StyleID)
	AND (pStyleSpec.StyleSet = @StyleSet)
	AND	(pStyleSpec.Spec <> 0)
ORDER BY
	Sort,
	POM,
	PointMeasur
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '03118', GetDate())
GO