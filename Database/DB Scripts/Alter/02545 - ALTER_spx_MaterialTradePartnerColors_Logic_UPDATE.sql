IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerColors_Logic_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_MaterialTradePartnerColors_Logic_UPDATE]
GO


CREATE PROCEDURE dbo.spx_MaterialTradePartnerColors_Logic_UPDATE(
	@MaterialTradePartnerID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS 

DECLARE @dummy INT
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02545'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02545', GetDate())

END
GO
