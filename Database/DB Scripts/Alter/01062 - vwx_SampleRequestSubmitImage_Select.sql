/****** Object:  View [dbo].[vwx_SampleRequestSubmitImage_Select]    Script Date: 01/26/2011 10:48:08 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestSubmitImage_Select]'))
DROP VIEW [dbo].[vwx_SampleRequestSubmitImage_Select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SampleRequestSubmitImage_Select]
AS
SELECT     SampleRequestSubmitImageID, SampleRequestWorkflowID, SampleRequestTradeID, SampleWorkflowID, StyleID, StyleColorID, StyleSet, TradePartnerVendorId, 
                      Submit, ImageNo, '<img src=''../System/Control/ImageStream.ashx?IT=S&S=50&IID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + '&TPVID=' + CAST(ISNULL(TradePartnerVendorId, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '&SRTID=' + CAST(ISNULL(SampleRequestTradeID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '&SRSID=' + CAST(ISNULL(SampleRequestSubmitImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS sImage, ImageCode, 
                      ImageDescription, ImageFile, ImageFileType, ImageSize, ImageType, CUser, CDate, MUser, MDate, Version, SystemServerStorageID
FROM         dbo.pSampleRequestSubmitImage

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01062', GetDate())
GO