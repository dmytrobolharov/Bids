IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_TempGradedRules_Decimals_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_TempGradedRules_Decimals_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Style_TempGradedRules_Decimals_SELECT]
	@StyleID varchar(255), 
	@StyleSet int 
AS
 
SELECT
	pStyleSpecSizeTemp.Sel0 AS Sample0,
	pStyleSpecSizeTemp.Sel1 AS Sample1,
	pStyleSpecSizeTemp.Sel2 AS Sample2,
	pStyleSpecSizeTemp.Sel3 AS Sample3,
	pStyleSpecSizeTemp.Sel4 AS Sample4,
	pStyleSpecSizeTemp.Sel5 AS Sample5,
	pStyleSpecSizeTemp.Sel6 AS Sample6,
	pStyleSpecSizeTemp.Sel7 AS Sample7,
	pStyleSpecSizeTemp.Sel8 AS Sample8,
	pStyleSpecSizeTemp.Sel9 AS Sample9,
	pStyleSpecSizeTemp.Sel10 AS Sample10,
	pStyleSpecSizeTemp.Sel11 AS Sample11,
	pStyleSpecSizeTemp.Sel12 AS Sample12,
	pStyleSpecSizeTemp.Sel13 AS Sample13,
	pStyleSpecSizeTemp.Sel14 AS Sample14,
	pStyleSpecSizeTemp.Sel15 AS Sample15,
	pStyleSpecSizeTemp.Sel16 AS Sample16,
	pStyleSpecSizeTemp.Sel17 AS Sample17,
	pStyleSpecSizeTemp.Sel18 AS Sample18,
	pStyleSpecSizeTemp.Sel19 AS Sample19,
	pStyleSpecSizeTemp.Size0 AS Range0,
	pStyleSpecSizeTemp.Size1 AS Range1,
	pStyleSpecSizeTemp.Size2 AS Range2,
	pStyleSpecSizeTemp.Size3 AS Range3,
	pStyleSpecSizeTemp.Size4 AS Range4,
	pStyleSpecSizeTemp.Size5 AS Range5,
	pStyleSpecSizeTemp.Size6 AS Range6,
	pStyleSpecSizeTemp.Size7 AS Range7,
	pStyleSpecSizeTemp.Size8 AS Range8,
	pStyleSpecSizeTemp.Size9 AS Range9,
    pStyleSpecSizeTemp.Size10 AS Range10,
	pStyleSpecSizeTemp.Size11 AS Range11,
	pStyleSpecSizeTemp.Size12 AS Range12,
	pStyleSpecSizeTemp.Size13 AS Range13,
	pStyleSpecSizeTemp.Size14 AS Range14,
	pStyleSpecSizeTemp.Size15 AS Range15,
	pStyleSpecSizeTemp.Size16 AS Range16,
	pStyleSpecSizeTemp.Size17 AS Range17,
	pStyleSpecSizeTemp.Size18 AS Range18,
	pStyleSpecSizeTemp.Size19 AS Range19,
	CAST(pStyleSpecTemp.Size0 AS Decimal(8,3)) AS Size0,
	CAST(pStyleSpecTemp.Size1 AS Decimal(8,3)) AS Size1,
	CAST(pStyleSpecTemp.Size2 AS Decimal(8,3)) AS Size2,
	CAST(pStyleSpecTemp.Size3 AS Decimal(8,3)) AS Size3,
	CAST(pStyleSpecTemp.Size4 AS Decimal(8,3)) AS Size4,
	CAST(pStyleSpecTemp.Size5 AS Decimal(8,3)) AS Size5,
	CAST(pStyleSpecTemp.Size6 AS Decimal(8,3)) AS Size6,
	CAST(pStyleSpecTemp.Size7 AS Decimal(8,3)) AS Size7,
	CAST(pStyleSpecTemp.Size8 AS Decimal(8,3)) AS Size8,
	CAST(pStyleSpecTemp.Size9 AS Decimal(8,3)) AS Size9,
	CAST(pStyleSpecTemp.Size10 AS Decimal(8,3)) AS Size10,
	CAST(pStyleSpecTemp.Size11 AS Decimal(8,3)) AS Size11,
	CAST(pStyleSpecTemp.Size12 AS Decimal(8,3)) AS Size12,
	CAST(pStyleSpecTemp.Size13 AS Decimal(8,3)) AS Size13,
	CAST(pStyleSpecTemp.Size14 AS Decimal(8,3)) AS Size14,
	CAST(pStyleSpecTemp.Size15 AS Decimal(8,3)) AS Size15,
	CAST(pStyleSpecTemp.Size16 AS Decimal(8,3)) AS Size16,
	CAST(pStyleSpecTemp.Size17 AS Decimal(8,3)) AS Size17,
	CAST(pStyleSpecTemp.Size18 AS Decimal(8,3)) AS Size18,
	CAST(pStyleSpecTemp.Size19 AS Decimal(8,3)) AS Size19,
	CAST(pStyleSpecTemp.Grade0 AS Decimal(8,3)) AS Grade0, 
	CAST(pStyleSpecTemp.Grade1 AS Decimal(8,3)) AS Grade1, 
	CAST(pStyleSpecTemp.Grade2 AS Decimal(8,3)) AS Grade2,  
	CAST(pStyleSpecTemp.Grade3 AS Decimal(8,3)) AS Grade3, 
	CAST(pStyleSpecTemp.Grade4 AS Decimal(8,3)) AS Grade4, 
	CAST(pStyleSpecTemp.Grade5 AS Decimal(8,3)) AS Grade5, 
	CAST(pStyleSpecTemp.Grade6 AS Decimal(8,3)) AS Grade6, 
	CAST(pStyleSpecTemp.Grade7 AS Decimal(8,3)) AS Grade7, 
	CAST(pStyleSpecTemp.Grade8 AS Decimal(8,3)) AS Grade8, 
	CAST(pStyleSpecTemp.Grade9 AS Decimal(8,3)) AS Grade9, 
	CAST(pStyleSpecTemp.Grade10 AS Decimal(8,3)) AS Grade10, 
	CAST(pStyleSpecTemp.Grade11 AS Decimal(8,3)) AS Grade11, 
	CAST(pStyleSpecTemp.Grade12 AS Decimal(8,3)) AS Grade12, 
	CAST(pStyleSpecTemp.Grade13 AS Decimal(8,3)) AS Grade13, 
	CAST(pStyleSpecTemp.Grade14 AS Decimal(8,3)) AS Grade14, 
	CAST(pStyleSpecTemp.Grade15 AS Decimal(8,3)) AS Grade15, 
	CAST(pStyleSpecTemp.Grade16 AS Decimal(8,3)) AS Grade16, 
	CAST(pStyleSpecTemp.Grade17 AS Decimal(8,3)) AS Grade17, 
	CAST(pStyleSpecTemp.Grade18 AS Decimal(8,3)) AS Grade18, 
	CAST(pStyleSpecTemp.Grade19 AS Decimal(8,3)) AS Grade19, 
	CAST(pStyleSpecTemp.Proto0 AS Decimal(8,3)) AS Proto0, 
	CAST(pStyleSpecTemp.Proto1 AS Decimal(8,3)) AS Proto1, 
	CAST(pStyleSpecTemp.Proto2 AS Decimal(8,3)) AS Proto2,  
	CAST(pStyleSpecTemp.Proto3 AS Decimal(8,3)) AS Proto3, 
	CAST(pStyleSpecTemp.Proto4 AS Decimal(8,3)) AS Proto4, 
	CAST(pStyleSpecTemp.Proto5 AS Decimal(8,3)) AS Proto5, 
	CAST(pStyleSpecTemp.Proto6 AS Decimal(8,3)) AS Proto6, 
	CAST(pStyleSpecTemp.Proto7 AS Decimal(8,3)) AS Proto7, 
	CAST(pStyleSpecTemp.Proto8 AS Decimal(8,3)) AS Proto8, 
	CAST(pStyleSpecTemp.Proto9 AS Decimal(8,3)) AS Proto9, 
	CAST(pStyleSpecTemp.Proto10 AS Decimal(8,3)) AS Proto10, 
	CAST(pStyleSpecTemp.Proto11 AS Decimal(8,3)) AS Proto11, 
	CAST(pStyleSpecTemp.Proto12 AS Decimal(8,3)) AS Proto12, 
	CAST(pStyleSpecTemp.Proto13 AS Decimal(8,3)) AS Proto13, 
	CAST(pStyleSpecTemp.Proto14 AS Decimal(8,3)) AS Proto14, 
	CAST(pStyleSpecTemp.Proto15 AS Decimal(8,3)) AS Proto15, 
	CAST(pStyleSpecTemp.Proto16 AS Decimal(8,3)) AS Proto16, 
	CAST(pStyleSpecTemp.Proto17 AS Decimal(8,3)) AS Proto17, 
	CAST(pStyleSpecTemp.Proto18 AS Decimal(8,3)) AS Proto18, 
	CAST(pStyleSpecTemp.Proto19 AS Decimal(8,3)) AS Proto19, 	
	pStyleSpecTemp.POM,
	pStyleSpecTemp.PointMeasur, 
	CAST(pStyleSpecTemp.TOL AS Decimal(8,3)) AS TOL, 
	CAST(pStyleSpecTemp.TOLN AS Decimal(8,3)) AS TOLN, 
	WashType = 
		CASE 
			WHEN UPPER(pStyleHeader.WashType) IS NULL THEN 'TOL'
			WHEN UPPER(pStyleHeader.WashType) = '' THEN 'TOL'
			WHEN UPPER(pStyleHeader.WashType) = 'WASH' THEN 'TOL'
			ELSE 'TOLN'
		END 
FROM pStyleSpecTemp
	LEFT OUTER JOIN pStyleSpecSizeTemp ON	pStyleSpecTemp.StyleID = pStyleSpecSizeTemp.StyleID
	LEFT OUTER JOIN pStyleHeader ON	pStyleSpecTemp.StyleID = pStyleHeader.StyleID
WHERE pStyleSpecTemp.StyleID = @StyleID
	AND pStyleSpecTemp.StyleSet = @StyleSet
	AND pStyleSpecTemp.Spec <> 0
ORDER BY
	pStyleSpecTemp.Sort,
	pStyleSpecTemp.POM,
	pStyleSpecTemp.PointMeasur
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '03120', GetDate())
GO