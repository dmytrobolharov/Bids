/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasHowTo_SELECT]    Script Date: 01/27/2011 10:20:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasHowTo_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_SampleRequest_MeasHowTo_SELECT]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequest_MeasHowTo_SELECT]
(
@SampleRequestHeaderId nvarchar(50),
@Submit Int
)

AS 

SELECT pMSEvalPom.SamplePomId, SampleRequestHeaderId, AMLMeasHdrId, 
AmlMeaspomid, POMRow, Refcode, POMDescription, TolPlus, TolMinus, HowToMeasurText,
'<img src=''../System/Control/ImageStream.ashx?IT=A&S=50&IID=' + CAST(ISNULL(ImageId, '00000000-0000-0000-0000-000000000000') 
AS NVARCHAR(50)) + ''' />' AS HowToImage, SortId, WSRowId
FROM  pMSEvalPom where SampleRequestHeaderId = @SampleRequestHeaderId 
order by SortId,  Refcode,  POMDescription   

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01066', GetDate())
GO 