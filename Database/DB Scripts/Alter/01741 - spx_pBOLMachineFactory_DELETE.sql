IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pBOLMachineFactory_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_pBOLMachineFactory_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_pBOLMachineFactory_DELETE]
(@MachineFactoryID uniqueidentifier)
AS
BEGIN
	DELETE FROM dbo.pBOLFactoryMachines WHERE FactoryMachinesId= @MachineFactoryID
END	

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01741'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01741', GetDate())
END	

GO
