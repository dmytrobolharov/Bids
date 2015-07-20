
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('rpx_Style_Measurement_HowToMeasure_BodyInfo_SELECT') and sysstat & 0xf = 4)
    DROP PROCEDURE rpx_Style_Measurement_HowToMeasure_BodyInfo_SELECT
GO
/****** Object:  StoredProcedure [dbo].[rpx_Style_Measurement_HowToMeasure_BodyInfo_SELECT]    Script Date: 04/15/2011 13:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create PROCEDURE [dbo].[rpx_Style_Measurement_HowToMeasure_BodyInfo_SELECT]
(
	@StyleId NVARCHAR(50)
	,@StyleSet NVARCHAR(5)
	,@WorkflowItemId NVARCHAR(50)
)
AS


/*Select.*/
SELECT
	pAMLMeasPOM.RefCode AS POM
	,pAMLMeasPOM.[Description]
	,pAMLMeasPOM.How2MeasText
	,dbo.fnx_GetStreamingMeasImagePath(pAMLMeasPOM.ImageId) AS ImagePath	
	,pAMLMeasPOM.SortId
FROM pAMLMeasHdr
	INNER JOIN pAMLMeasPOM ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasPOM.AMLMeasHdrId
WHERE pAMLMeasHdr.StyleId = @StyleId
	AND pAMLMeasHdr.StyleSet = @StyleSet
	AND pAMLMeasHdr.WorkflowItemId = @WorkflowItemId
ORDER BY
	pAMLMeasPOM.SortId
	,pAMLMeasPOM.RefCode
	,pAMLMeasPOM.[Description]
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01386', GetDate())
GO
