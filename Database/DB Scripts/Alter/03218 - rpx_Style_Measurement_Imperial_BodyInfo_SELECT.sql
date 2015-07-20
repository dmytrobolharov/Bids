
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 13 March 2012                                                                             	*/
-- * WorkItem #7321                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[rpx_Style_Measurement_Imperial_BodyInfo_SELECT]    Script Date: 03/13/2012 15:45:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Measurement_Imperial_BodyInfo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Measurement_Imperial_BodyInfo_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[rpx_Style_Measurement_Imperial_BodyInfo_SELECT]    Script Date: 03/13/2012 15:45:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[rpx_Style_Measurement_Imperial_BodyInfo_SELECT]
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
			,dbo.fnx_Num2Frac_KeepNegative(pAMLMeasIgc.Grade) AS Incr
			
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
			--,dbo.fnx_Num2Frac_KeepNegative(CAST(pAMLMeasPOM.TolPlus / 2.54 AS DECIMAL(18,4))) AS TolPlus
			--,dbo.fnx_Num2Frac_KeepNegative(CAST(pAMLMeasPOM.TolMinus / 2.54 AS DECIMAL(18,4))) AS TolMinus
			,dbo.fnx_Num2Frac_KeepNegative(CAST(pAMLMeasPOM.TolPlus AS DECIMAL(18,4))) AS TolPlus
			,dbo.fnx_Num2Frac_KeepNegative(CAST(pAMLMeasPOM.TolMinus AS DECIMAL(18,4))) AS TolMinus
			,pAMLMeasLbl.MeasLbl
			--,dbo.fnx_Num2Frac_KeepNegative(pAMLMeasIgc.ConvGrade) AS Incr
			,dbo.fnx_Num2Frac_KeepNegative(pAMLMeasIgc.Grade) AS Incr
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

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03218'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03218', GetDate())

END

GO 

