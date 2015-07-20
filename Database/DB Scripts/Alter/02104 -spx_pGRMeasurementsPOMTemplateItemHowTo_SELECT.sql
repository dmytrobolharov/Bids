SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplateItemHowTo_SELECT')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplateItemHowTo_SELECT
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemHowTo_SELECT]
(@POMTempID uniqueidentifier)
AS 

SELECT  POMID, POMCode, POMDesc, How2MeasText, How2MeasName,  ImageId, Sort
FROM pGRMeasurementsPOM  where POMID in (Select distinct(POMID) from 
pGRMeasurementsPOMTemplateItem WHERE POMTempID = @POMTempID AND  POMID IS NOT NULL and active=1)
ORDER BY Sort, POMCode, POMDesc

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02104'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02104', GetDate())
	END
GO