
/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasQAHowTo_SELECT]    Script Date: 07/14/2011 12:32:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasQAHowTo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_MeasQAHowTo_SELECT]
GO

Create PROCEDURE [dbo].[spx_SampleRequest_MeasQAHowTo_SELECT]
(
@SampleRequestHeaderId nvarchar(50),
@Submit Int
)

AS 

SET NOCOUNT ON

SELECT SamplePomId, SampleRequestHeaderId, AMLMeasHdrId, 
AmlMeaspomid, POMRow, Refcode, POMDescription, TolPlus, TolMinus, HowToMeasurText,
'<img src=''../System/Control/ImageStream.ashx?IT=A&S=50&IID=' + CAST(ISNULL(ImageId, '00000000-0000-0000-0000-000000000000') 
AS NVARCHAR(50)) + ''' />' AS HowToImage, SortId, WSRowId
FROM  pQAPom where SampleRequestHeaderId = @SampleRequestHeaderId 
order by SortId,  Refcode,  POMDescription  
 
SET NOCOUNT OFF

GO
			
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01642', GetDate())