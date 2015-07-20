IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasHowTo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_MeasHowTo_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_SampleRequest_MeasHowTo_SELECT]
(
@SampleRequestHeaderId nvarchar(50),
@Submit Int
)

AS 
DECLARE @ImageServer nvarchar(200)

SET @ImageServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')

SELECT pMSEvalPom.SamplePomId, SampleRequestHeaderId, AMLMeasHdrId, 
AmlMeaspomid, POMRow, Refcode, POMDescription, TolPlus, TolMinus, HowToMeasurText,
'<img src=''' + @ImageServer + '/ImageStream.ashx?IT=POM&S=50&ID=' + CAST(ISNULL(ImageId, '00000000-0000-0000-0000-000000000000') 
AS NVARCHAR(50)) + ''' />' AS HowToImage, SortId, WSRowId
FROM  pMSEvalPom where SampleRequestHeaderId = @SampleRequestHeaderId 
order by SortId,  Refcode,  POMDescription 

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02559'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02559', GetDate())
END
GO