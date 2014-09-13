/****** Object:  StoredProcedure [dbo].[spx_MaterialRemoval_Log_INSERT]    Script Date: 06/11/2014 13:25:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRemoval_Log_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRemoval_Log_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRemoval_Log_INSERT]    Script Date: 06/11/2014 13:25:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_MaterialRemoval_Log_INSERT]
	@MaterialID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@RemovalReasonID UNIQUEIDENTIFIER,
	@RemovalComment NVARCHAR(500),
	@RemDate DATETIME
AS
BEGIN
	INSERT INTO pMaterialRemoval
		   ([RemovalTeamID]
		   ,[RemovalReasonID]
		   ,[RemovalComment]
		   ,[RemovalDate]
		   ,[MaterialID]
		   ,[TempID]
		   ,[TempNo]
		   ,[MaterialImageID]
		   ,[MaterialImageVersion]
		   ,[MaterialImageDetailID]
		   ,[MaterialImageDetailVersion]
		   ,[NoColorMatch]
		   ,[SupplierID]
		   ,[MaterialType]
		   ,[MaterialNo]
		   ,[MaterialName]
		   ,[A]
		   ,[B]
		   ,[C]
		   ,[D]
		   ,[E]
		   ,[F]
		   ,[G]
		   ,[H]
		   ,[I]
		   ,[J]
		   ,[K]
		   ,[L]
		   ,[M]
		   ,[N]
		   ,[O]
		   ,[P]
		   ,[Q]
		   ,[R]
		   ,[S]
		   ,[T]
		   ,[U]
		   ,[V]
		   ,[W]
		   ,[X]
		   ,[Y]
		   ,[Z]
		   ,[Source]
		   ,[Notes]
		   ,[VendorPrice]
		   ,[VolumePrice]
		   ,[VolumePriceMinimum]
		   ,[VendorProductionMin]
		   ,[VendorProductionLeadTime]
		   ,[MaterialPlacement]
		   ,[DetailYesNo]
		   ,[ImageType1]
		   ,[height]
		   ,[width]
		   ,[CDate]
		   ,[CUser]
		   ,[MDate]
		   ,[MUser]
		   ,[MChange]
		   ,[DChange]
		   ,[Action]
		   ,[Status]
		   ,[Active]
		   ,[MultiDimension]
		   ,[UOM]
		   ,[MaterialCode]
		   ,[MaterialCodeNo]
		   ,[SAPCode]
		   ,[SAPControl]
		   ,[MaterialColorRequired]
		   ,[FactorySourced]
		   ,[TradePartnerID]
		   ,[TradePartnerVendorID]
		   ,[HeaderLocked]
		   ,[MaterialTemplateID]
		   ,[DutyCategoryID]
		   ,[DueDate]
		   ,[CurrencyType])
     SELECT
		@TeamID,
		@RemovalReasonID,
		@RemovalComment,
		@RemDate,
		@MaterialID,
		[TempID]
      ,[TempNo]
      ,[MaterialImageID]
      ,[MaterialImageVersion]
      ,[MaterialImageDetailID]
      ,[MaterialImageDetailVersion]
      ,[NoColorMatch]
      ,[SupplierID]
      ,[MaterialType]
      ,[MaterialNo]
      ,[MaterialName]
      ,[A]
      ,[B]
      ,[C]
      ,[D]
      ,[E]
      ,[F]
      ,[G]
      ,[H]
      ,[I]
      ,[J]
      ,[K]
      ,[L]
      ,[M]
      ,[N]
      ,[O]
      ,[P]
      ,[Q]
      ,[R]
      ,[S]
      ,[T]
      ,[U]
      ,[V]
      ,[W]
      ,[X]
      ,[Y]
      ,[Z]
      ,[Source]
      ,[Notes]
      ,[VendorPrice]
      ,[VolumePrice]
      ,[VolumePriceMinimum]
      ,[VendorProductionMin]
      ,[VendorProductionLeadTime]
      ,[MaterialPlacement]
      ,[DetailYesNo]
      ,[ImageType1]
      ,[height]
      ,[width]
      ,[CDate]
      ,[CUser]
      ,[MDate]
      ,[MUser]
      ,[MChange]
      ,[DChange]
      ,[Action]
      ,[Status]
      ,[Active]
      ,[MultiDimension]
      ,[UOM]
      ,[MaterialCode]
      ,[MaterialCodeNo]
      ,[SAPCode]
      ,[SAPControl]
      ,[MaterialColorRequired]
      ,[FactorySourced]
      ,[TradePartnerID]
      ,[TradePartnerVendorID]
      ,[HeaderLocked]
      ,[MaterialTemplateID]
      ,[DutyCategoryID]
      ,[DueDate]
      ,[CurrencyType]
	FROM pMaterial
	WHERE MaterialID = @MaterialID
 END         

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07969', GetDate())
GO
