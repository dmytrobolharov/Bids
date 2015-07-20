IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_TempGradedRules_Fractions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_TempGradedRules_Fractions_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Style_TempGradedRules_Fractions_SELECT]
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
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size0) AS Size0,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size1) AS Size1,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size2) AS Size2,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size3) AS Size3,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size4) AS Size4,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size5) AS Size5,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size6) AS Size6,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size7) AS Size7,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size8) AS Size8,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size9) AS Size9,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size10) AS Size10,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size11) AS Size11,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size12) AS Size12,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size13) AS Size13,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size14) AS Size14,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size15) AS Size15,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size16) AS Size16,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size17) AS Size17,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size18) AS Size18,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Size19) AS Size19,
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade0) AS Grade0, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade1) AS Grade1, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade2) AS Grade2,  
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade3) AS Grade3, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade4) AS Grade4, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade5) AS Grade5, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade6) AS Grade6, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade7) AS Grade7, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade8) AS Grade8, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade9) AS Grade9, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade10) AS Grade10, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade11) AS Grade11, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade12) AS Grade12, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade13) AS Grade13, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade14) AS Grade14, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade15) AS Grade15, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade16) AS Grade16, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade17) AS Grade17, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade18) AS Grade18, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Grade19) AS Grade19, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto0) AS Proto0, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto1) AS Proto1, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto2) AS Proto2,  
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto3) AS Proto3, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto4) AS Proto4, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto5) AS Proto5, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto6) AS Proto6, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto7) AS Proto7, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto8) AS Proto8, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto9) AS Proto9, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto10) AS Proto10, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto11) AS Proto11, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto12) AS Proto12, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto13) AS Proto13, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto14) AS Proto14, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto15) AS Proto15, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto16) AS Proto16, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto17) AS Proto17, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto18) AS Proto18, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.Proto19) AS Proto19, 	
	pStyleSpecTemp.POM,
	pStyleSpecTemp.PointMeasur, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.TOL) AS TOL, 
	dbo.fnx_Num2Frac(pStyleSpecTemp.TOLN) AS TOLN, 
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
VALUES ('DB_Version', '4.1.0000', '03121', GetDate())
GO