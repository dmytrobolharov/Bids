SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pGRMeasurementsPOM_Select]'))
DROP VIEW [dbo].[vwx_pGRMeasurementsPOM_Select]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



create VIEW [dbo].[vwx_pGRMeasurementsPOM_Select]
AS

SELECT     dbo.pGRMeasurementsPOM.POMId, dbo.pGRMeasurementsPOM.POMCode, dbo.pGRMeasurementsPOM.POMDesc, dbo.pGRMeasurementsPOM.How2MeasName, 
                      dbo.pGRMeasurementsPOM.How2MeasText, dbo.pGRMeasurementsPOM.Sort, dbo.pGRMeasurementsPOM.Muser, dbo.pGRMeasurementsPOM.MDate, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=POM&S=50&ID=' + CAST(ISNULL(dbo.pGRMeasurementsPOM.ImageId, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + ''' />' AS POMImage, pGRMeasurementsPOM.Active
FROM         dbo.pGRMeasurementsPOM 




GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02096'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02096', GetDate())
	END
GO