IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Measurement_Sample_BodyInfo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Measurement_Sample_BodyInfo_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[rpx_Style_Measurement_Sample_BodyInfo_SELECT]
(
	@StyleId NVARCHAR(50)
	,@StyleSet NVARCHAR(5)
	,@WorkflowItemId NVARCHAR(50)
)
AS


/*Declare variables.*/
DECLARE @IsMetric INT


/*Determine measurement system.*/
SELECT @IsMetric = IsMetric
FROM pAMLMeasHdr
WHERE StyleId = @StyleId
	AND StyleSet = @StyleSet
	AND WorkflowItemId = @WorkflowItemId


/*Select*/
IF(@IsMetric = 0)
	BEGIN
		SELECT
			pAMLMeasPOM.RefCode AS POM
			,pAMLMeasPOM.[Description]
			,dbo.fnx_Num2Frac_KeepNegative(pAMLMeasPOM.TolPlus) AS TolPlus
			,dbo.fnx_Num2Frac_KeepNegative(pAMLMeasPOM.TolMinus) AS TolMinus
			,pAMLMeasLbl.MeasLbl
			,dbo.fnx_Num2Frac_KeepNegative(pAMLMeasIgc.Incr) AS Incr
			
			,pAMLMeasPOM.SortId
			,pAMLMeasLbl.SizeCol
			,pAMLMeasPOM.POM_Row
			,ISNULL(pAMLMeasLbl.MeasLblDesc,'') AS MeasLblDesc
		FROM pAMLMeasHdr
			INNER JOIN pAMLMeasLbl ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasLbl.AMLMeasHdrId
			INNER JOIN pAMLMeasPOM ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasPOM.AMLMeasHdrId
			INNER JOIN pAMLMeasIgc ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasIgc.AMLMeasHdrId
										AND pAMLMeasLbl.SizeCol = pAMLMeasIgc.SizeCol
										AND pAMLMeasPOM.POM_Row = pAMLMeasIgc.POM_Row
		WHERE pAMLMeasHdr.StyleId = @StyleId
			AND pAMLMeasHdr.StyleSet = @StyleSet
			AND pAMLMeasHdr.WorkflowItemId = @WorkflowItemId
			AND pAMLMeasLbl.IsSample = 1
		ORDER BY
			pAMLMeasPOM.SortId
			,pAMLMeasPOM.RefCode
			,pAMLMeasPOM.[Description]
	END
ELSE
	BEGIN
		SELECT
			pAMLMeasPOM.RefCode AS POM
			,pAMLMeasPOM.[Description]
			,pAMLMeasPOM.TolPlus
			,pAMLMeasPOM.TolMinus
			,pAMLMeasLbl.MeasLbl
			,pAMLMeasIgc.Incr
			
			,pAMLMeasPOM.SortId
			,pAMLMeasLbl.SizeCol
			,pAMLMeasPOM.POM_Row
			,ISNULL(pAMLMeasLbl.MeasLblDesc,'') AS MeasLblDesc
		FROM pAMLMeasHdr
			INNER JOIN pAMLMeasLbl ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasLbl.AMLMeasHdrId
			INNER JOIN pAMLMeasPOM ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasPOM.AMLMeasHdrId
			INNER JOIN pAMLMeasIgc ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasIgc.AMLMeasHdrId
										AND pAMLMeasLbl.SizeCol = pAMLMeasIgc.SizeCol
										AND pAMLMeasPOM.POM_Row = pAMLMeasIgc.POM_Row
		WHERE pAMLMeasHdr.StyleId = @StyleId
			AND pAMLMeasHdr.StyleSet = @StyleSet
			AND pAMLMeasHdr.WorkflowItemId = @WorkflowItemId
			AND pAMLMeasLbl.IsSample = 1
		ORDER BY
			pAMLMeasPOM.SortId
			,pAMLMeasPOM.RefCode
			,pAMLMeasPOM.[Description]
	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07107', GetDate())
GO
