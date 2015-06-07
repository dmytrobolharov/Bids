IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_MeasHowTo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasHowTo_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasHowTo_SELECT]
(
	@SampleRequestAmlMeasHdrID NVARCHAR(50)
)
AS 

	SELECT SampleRequestAMLMeasPOMId
		, SampleRequestAMLMeasHdrId
		, POM_Row
		, Refcode
		, Description
		, TolPlus
		, TolMinus
		, How2MeasText
		, '<img src=''' + dbo.fnx_GetStreamingImageGRPOMPath(ISNULL(ImageId,'00000000-0000-0000-0000-000000000000'), 50) + ''' />' AS HowToImage
		, SortId
		, WSRowId
	FROM pSamplerequestAMLMeasPOM
	WHERE SampleRequestAMLMeasHdrId = @SampleRequestAmlMeasHdrID
	ORDER BY SortId
		, Refcode
		, Description

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10053', GetUTCDate())
GO