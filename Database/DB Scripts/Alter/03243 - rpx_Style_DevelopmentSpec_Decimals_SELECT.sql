IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_DevelopmentSpec_Decimals_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_DevelopmentSpec_Decimals_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Style_DevelopmentSpec_Decimals_SELECT]
	@StyleID AS VARCHAR(255), 
	@StyleSet AS INT
AS


SELECT
	pStyleSpec.POM,
	pStyleSpec.PointMeasur,
	CAST(pStyleSpec.TOL AS DECIMAL(8,3)) AS TOL, 
	CAST(pStyleSpec.TOLN AS DECIMAL(8,3)) AS TOLN,
	CAST(pStyleSpec.Spec AS DECIMAL(8,3)) AS Spec,
	CASE
	     WHEN pStyleSpecSize.Sel0 = 1 THEN pStyleSpecSize.Size0
	     WHEN pStyleSpecSize.Sel1 = 1 THEN pStyleSpecSize.Size1
	     WHEN pStyleSpecSize.Sel2 = 1 THEN pStyleSpecSize.Size2
	     WHEN pStyleSpecSize.Sel3 = 1 THEN pStyleSpecSize.Size3
	     WHEN pStyleSpecSize.Sel4 = 1 THEN pStyleSpecSize.Size4
	     WHEN pStyleSpecSize.Sel5 = 1 THEN pStyleSpecSize.Size5
	     WHEN pStyleSpecSize.Sel6 = 1 THEN pStyleSpecSize.Size6
	     WHEN pStyleSpecSize.Sel7 = 1 THEN pStyleSpecSize.Size7
	     WHEN pStyleSpecSize.Sel8 = 1 THEN pStyleSpecSize.Size8
	     WHEN pStyleSpecSize.Sel9 = 1 THEN pStyleSpecSize.Size9
	     WHEN pStyleSpecSize.Sel10 = 1 THEN pStyleSpecSize.Size10
	     WHEN pStyleSpecSize.Sel11 = 1 THEN pStyleSpecSize.Size11
	END AS SizeNo,
	WashType = 
	CASE 
		WHEN UPPER(pStyleHeader.WashType) IS NULL THEN 'TOL'
		WHEN UPPER(pStyleHeader.WashType) = '' THEN 'TOL'
		WHEN UPPER(pStyleHeader.WashType) = 'WASH' THEN 'TOL'
		ELSE 'TOLN'
	END 
FROM pStyleSpec
	INNER JOIN pStyleSpecSize ON	pStyleSpec.StyleID = pStyleSpecSize.StyleID
	INNER JOIN pStyleHeader ON	pStyleSpec.StyleId = pStyleHeader.StyleId
WHERE pStyleSpec.StyleID = @StyleID
	AND pStyleSpec.StyleSet = @StyleSet
	AND pStyleSpec.Spec <> 0
ORDER BY
	pStyleSpec.Sort,
	pStyleSpec.POM,
	pStyleSpec.PointMeasur
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03243', GetDate())
GO