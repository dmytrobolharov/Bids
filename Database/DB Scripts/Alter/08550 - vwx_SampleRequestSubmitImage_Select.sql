IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestSubmitImage_Select]'))
DROP VIEW [dbo].[vwx_SampleRequestSubmitImage_Select]
GO

CREATE VIEW [dbo].[vwx_SampleRequestSubmitImage_Select]
AS
SELECT *
	, '<img src=''../System/Control/ImageStream.ashx?IT=S&S=50&IID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&TPVID=' + CAST(ISNULL(TradePartnerVendorId, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&SRTID=' + CAST(ISNULL(SampleRequestTradeID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&SRSID=' + CAST(ISNULL(SampleRequestSubmitImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS sImage
	, CASE
		WHEN ImageSize BETWEEN 1024 AND 1048576 THEN CAST(CAST(CAST(ImageSize AS DECIMAL(18,2)) / 1024 AS DECIMAL(18, 2)) AS NVARCHAR(10)) + ' Kb'
		WHEN ImageSize > 1048576 THEN CAST(CAST(CAST(ImageSize AS DECIMAL(18,2)) / 1048576 AS DECIMAL(18, 2)) AS NVARCHAR(10)) + ' Mb'
		ELSE CAST(ImageSize AS NVARCHAR(10)) + ' B'
	  END AS FormatedImageSize
FROM dbo.pSampleRequestSubmitImage

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08550', GetDate())
GO
