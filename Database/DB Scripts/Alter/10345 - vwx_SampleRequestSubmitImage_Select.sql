IF OBJECT_ID(N'[dbo].[vwx_SampleRequestSubmitImage_Select]') IS NOT NULL
 DROP VIEW [dbo].[vwx_SampleRequestSubmitImage_Select]
GO

CREATE VIEW [dbo].[vwx_SampleRequestSubmitImage_Select]
AS
SELECT *
	, '<img src="' + dbo.fnx_GetStreamingSampleImagePath(SampleRequestTradeID, TradePartnerVendorId, SampleRequestSubmitImageID, ImageID, '50') + '" />' AS sImage
	, CASE
		WHEN ImageSize BETWEEN 1024 AND 1048576 THEN CAST(CAST(CAST(ImageSize AS DECIMAL(18,2)) / 1024 AS DECIMAL(18, 2)) AS NVARCHAR(10)) + ' Kb'
		WHEN ImageSize > 1048576 THEN CAST(CAST(CAST(ImageSize AS DECIMAL(18,2)) / 1048576 AS DECIMAL(18, 2)) AS NVARCHAR(10)) + ' Mb'
		ELSE CAST(ImageSize AS NVARCHAR(10)) + ' B'
	  END AS FormatedImageSize
FROM dbo.pSampleRequestSubmitImage


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10345', GetUTCDate())
GO
