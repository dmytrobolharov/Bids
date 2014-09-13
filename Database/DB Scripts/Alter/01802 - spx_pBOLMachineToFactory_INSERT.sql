IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pBOLMachineToFactory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pBOLMachineToFactory_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_pBOLMachineToFactory_INSERT] 
	(@FactoryId   uniqueidentifier,
	@TradePartnerVendorID  uniqueidentifier,
	@MachineId  uniqueidentifier,
	@CUser nvarchar(200),
	@CDate datetime,
	@Active int)
	
AS INSERT INTO pBOLFactoryMachines
    (FactoryId, MachineId, CUser, CDate, MUser, MDate, Active, TradePartnerVendorID)
VALUES (@FactoryId, @MachineId, @CUser, @CDate, @CUser, @CDate, @Active, @TradePartnerVendorID)

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01802'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01802', GetDate())
END

GO 
