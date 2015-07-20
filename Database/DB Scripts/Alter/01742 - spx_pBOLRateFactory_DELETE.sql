IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pBOLRateFactory_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_pBOLRateFactory_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_pBOLRateFactory_DELETE] 
(@RateFactoryID uniqueidentifier)
AS
BEGIN
	DELETE FROM dbo.pBOLFactoryRates WHERE FactoryRateId = @RateFactoryID
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01742'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01742', GetDate())
END	

GO
