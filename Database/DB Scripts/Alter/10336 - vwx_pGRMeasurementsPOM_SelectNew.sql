IF OBJECT_ID(N'[dbo].[vwx_pGRMeasurementsPOM_SelectNew]') IS NOT NULL
 DROP VIEW [dbo].[vwx_pGRMeasurementsPOM_SelectNew]
GO

CREATE VIEW [dbo].[vwx_pGRMeasurementsPOM_SelectNew]
AS
SELECT POMID, POMCode, POMDesc,  How2MeasText, CUser, CDate, MUser, MDate,Sort,
       dbo.fnx_GetStreamingTypedImageHTML('POM', ImageID, 50, '') AS ImageURL, ImageId
FROM dbo.pGRMeasurementsPOM


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10336', GetUTCDate())
GO
