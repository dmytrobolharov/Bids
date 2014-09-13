IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pBOLMachineToFactory_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_pBOLMachineToFactory_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_pBOLMachineToFactory_INSERT]
	(@FactoryId   uniqueidentifier,
	@MachineId  uniqueidentifier,
	@CUser nvarchar(200),
	@CDate datetime,
	@Active int)
	
AS INSERT INTO pBOLFactoryMachines
    (FactoryId, MachineId, CUser, CDate, MUser, MDate, Active)
VALUES (@FactoryId, @MachineId, @CUser, @CDate, @CUser, @CDate, @Active)

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01740'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01740', GetDate())
END	

GO
