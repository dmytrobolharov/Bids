IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasQAHowTo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_MeasQAHowTo_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_MeasQAHowTo_SELECT]
(
	@SampleRequestHeaderId NVARCHAR(50)
	, @Submit INT
)
AS 
BEGIN

SELECT SamplePomId
	, SampleRequestHeaderId
	, AMLMeasHdrId
	, AmlMeaspomid
	, POMRow
	, Refcode
	, POMDescription
	, TolPlus
	, TolMinus
	, HowToMeasurText
	, '<img src=''' + dbo.fnx_GetStreamingImageGRPOMPath(ISNULL(ImageId,'00000000-0000-0000-0000-000000000000'), 50) + ''' />' AS HowToImage
	, SortId
	, WSRowId
FROM pQAPom
WHERE SampleRequestHeaderId = @SampleRequestHeaderId
ORDER BY SortId
	, Refcode
	, POMDescription

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10055', GetUTCDate())
GO