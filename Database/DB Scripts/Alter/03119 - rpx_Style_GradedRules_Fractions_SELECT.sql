IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_GradedRules_Fractions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_GradedRules_Fractions_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Style_GradedRules_Fractions_SELECT]
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
	dbo.fnx_Num2Frac(pStyleSpec.Size0) AS Size0,
	dbo.fnx_Num2Frac(pStyleSpec.Size1) AS Size1,
	dbo.fnx_Num2Frac(pStyleSpec.Size2) AS Size2,
	dbo.fnx_Num2Frac(pStyleSpec.Size3) AS Size3,
	dbo.fnx_Num2Frac(pStyleSpec.Size4) AS Size4,
	dbo.fnx_Num2Frac(pStyleSpec.Size5) AS Size5,
	dbo.fnx_Num2Frac(pStyleSpec.Size6) AS Size6,
	dbo.fnx_Num2Frac(pStyleSpec.Size7) AS Size7,
	dbo.fnx_Num2Frac(pStyleSpec.Size8) AS Size8,
	dbo.fnx_Num2Frac(pStyleSpec.Size9) AS Size9,
	dbo.fnx_Num2Frac(pStyleSpec.Size10) AS Size10,
	dbo.fnx_Num2Frac(pStyleSpec.Size11) AS Size11,
	dbo.fnx_Num2Frac(pStyleSpec.Size12) AS Size12,
	dbo.fnx_Num2Frac(pStyleSpec.Size13) AS Size13,
	dbo.fnx_Num2Frac(pStyleSpec.Size14) AS Size14,
	dbo.fnx_Num2Frac(pStyleSpec.Size15) AS Size15,
	dbo.fnx_Num2Frac(pStyleSpec.Size16) AS Size16,
	dbo.fnx_Num2Frac(pStyleSpec.Size17) AS Size17,
	dbo.fnx_Num2Frac(pStyleSpec.Size18) AS Size18,
	dbo.fnx_Num2Frac(pStyleSpec.Size19) AS Size19,
	dbo.fnx_Num2Frac(pStyleSpec.Grade0) AS Grade0, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade1) AS Grade1, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade2) AS Grade2,  
	dbo.fnx_Num2Frac(pStyleSpec.Grade3) AS Grade3, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade4) AS Grade4, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade5) AS Grade5, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade6) AS Grade6, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade7) AS Grade7, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade8) AS Grade8, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade9) AS Grade9, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade10) AS Grade10, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade11) AS Grade11, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade12) AS Grade12, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade13) AS Grade13, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade14) AS Grade14, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade15) AS Grade15, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade16) AS Grade16, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade17) AS Grade17, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade18) AS Grade18, 
	dbo.fnx_Num2Frac(pStyleSpec.Grade19) AS Grade19, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto0) AS Proto0, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto1) AS Proto1, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto2) AS Proto2,  
	dbo.fnx_Num2Frac(pStyleSpec.Proto3) AS Proto3, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto4) AS Proto4, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto5) AS Proto5, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto6) AS Proto6, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto7) AS Proto7, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto8) AS Proto8, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto9) AS Proto9, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto10) AS Proto10, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto11) AS Proto11, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto12) AS Proto12, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto13) AS Proto13, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto14) AS Proto14, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto15) AS Proto15, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto16) AS Proto16, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto17) AS Proto17, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto18) AS Proto18, 
	dbo.fnx_Num2Frac(pStyleSpec.Proto19) AS Proto19, 	
	pStyleSpec.POM,
	pStyleSpec.PointMeasur, 
	dbo.fnx_Num2Frac(pStyleSpec.TOL) AS TOL,	
	dbo.fnx_Num2Frac(pStyleSpec.TOLN) AS TOLN, 
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
	AND (pStyleSpec.Spec <> 0)
ORDER BY
	Sort,
	POM,
	PointMeasur
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '03119', GetDate())
GO