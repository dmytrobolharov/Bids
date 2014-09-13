IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Measurement_Metric_BodyInfo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Measurement_Metric_BodyInfo_SELECT]
GO

CREATE PROCEDURE rpx_Style_Measurement_Metric_BodyInfo_SELECT
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
			,CAST(pAMLMeasPOM.TolPlus * 2.54 AS DECIMAL(18,4)) AS TolPlus
			,CAST(pAMLMeasPOM.TolMinus * 2.54 AS DECIMAL(18,4)) AS TolMinus
			,pAMLMeasLbl.MeasLbl
			,pAMLMeasIgc.ConvGrade AS Incr
			
			,pAMLMeasPOM.SortId
			,pAMLMeasLbl.SizeCol
			,pAMLMeasPOM.POM_Row
		FROM pAMLMeasHdr
			INNER JOIN pAMLMeasLbl ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasLbl.AMLMeasHdrId
			INNER JOIN pAMLMeasPOM ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasPOM.AMLMeasHdrId
			INNER JOIN pAMLMeasIgc ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasIgc.AMLMeasHdrId
										AND pAMLMeasLbl.SizeCol = pAMLMeasIgc.SizeCol
										AND pAMLMeasPOM.POM_Row = pAMLMeasIgc.POM_Row
		WHERE pAMLMeasHdr.StyleId = @StyleId
			AND pAMLMeasHdr.StyleSet = @StyleSet
			AND pAMLMeasHdr.WorkflowItemId = @WorkflowItemId
			AND pAMLMeasLbl.IsVisible = 1
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
			,pAMLMeasIgc.Grade AS Incr
			
			,pAMLMeasPOM.SortId
			,pAMLMeasLbl.SizeCol
			,pAMLMeasPOM.POM_Row
		FROM pAMLMeasHdr
			INNER JOIN pAMLMeasLbl ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasLbl.AMLMeasHdrId
			INNER JOIN pAMLMeasPOM ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasPOM.AMLMeasHdrId
			INNER JOIN pAMLMeasIgc ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasIgc.AMLMeasHdrId
										AND pAMLMeasLbl.SizeCol = pAMLMeasIgc.SizeCol
										AND pAMLMeasPOM.POM_Row = pAMLMeasIgc.POM_Row
		WHERE pAMLMeasHdr.StyleId = @StyleId
			AND pAMLMeasHdr.StyleSet = @StyleSet
			AND pAMLMeasHdr.WorkflowItemId = @WorkflowItemId
			AND pAMLMeasLbl.IsVisible = 1
		ORDER BY
			pAMLMeasPOM.SortId
			,pAMLMeasPOM.RefCode
			,pAMLMeasPOM.[Description]
	END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01445', GetDate())
GO