IF OBJECT_ID(N'[dbo].[vwx_pGRMeasurementsPOM_Select]') IS NOT NULL
 DROP VIEW [dbo].[vwx_pGRMeasurementsPOM_Select]
GO

CREATE VIEW [dbo].[vwx_pGRMeasurementsPOM_Select]
AS

SELECT POMId, POMCode, POMDesc, How2MeasName, How2MeasText, Sort, Muser, MDate, 
       dbo.fnx_GetStreamingTypedImageHTML('POM', ImageID, 50, '') AS POMImage, 
	   Active
FROM dbo.pGRMeasurementsPOM 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10335', GetUTCDate())
GO
