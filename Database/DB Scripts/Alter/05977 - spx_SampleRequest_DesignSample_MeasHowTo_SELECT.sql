/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasHowTo_SELECT]    Script Date: 07/02/2013 15:46:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_MeasHowTo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasHowTo_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasHowTo_SELECT]    Script Date: 07/02/2013 15:46:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasHowTo_SELECT]
(
@SampleRequestAmlMeasHdrID nvarchar(50)
)

AS 
DECLARE @ImageServer nvarchar(200)

SET @ImageServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')

SELECT SampleRequestAMLMeasPOMId,  SampleRequestAMLMeasHdrId, 
 POM_Row, Refcode, Description, TolPlus, TolMinus, How2MeasText,
'<img src=''' + @ImageServer + '/ImageStream.ashx?IT=POM&S=50&ID=' + CAST(ISNULL(ImageId, '00000000-0000-0000-0000-000000000000') 
AS NVARCHAR(50)) + ''' />' AS HowToImage, SortId, WSRowId
FROM  pSamplerequestAMLMeasPOM where SampleRequestAMLMeasHdrId = @SampleRequestAmlMeasHdrID 
order by SortId,  Refcode,  Description 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05977', GetDate())
GO