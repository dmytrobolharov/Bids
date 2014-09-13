IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VendorInfrastructureImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VendorInfrastructureImage_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_VendorInfrastructureImage_SELECT](
	@TradePartnerID UNIQUEIDENTIFIER,
	@TradePartnerInfrastructureID UNIQUEIDENTIFIER

)
AS


	SELECT 
	'<img src="../System/Control/ImageStream.ashx?IT=VINF&TPID=' +  CAST(@TradePartnerID AS VARCHAR(40)) +
	'&TINFID=' +  CAST(@TradePartnerInfrastructureID AS VARCHAR(40)) + 
	'&L=0&Comp=100&S=100&TINFIID=' + CAST(a.TradePartnerInfrastructureImageID AS VARCHAR(40)) +
	'&IID=' +   CAST(a.ImageID AS VARCHAR(40))+  '&V='  +  CAST(a.ImageVersion AS NVARCHAR(5)) +  '" />' AS sImage,
	a.TradePartnerInfrastructureImageID, a.TradePartnerInfrastructureID, a.ImageDescription, a.MUser
	FROM uTradePartnerInfrastructureImage a WITH(NOLOCK)
    WHERE  TradePartnerInfrastructureID = @TradePartnerInfrastructureID
    order by Sort
	
  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04001', GetDate())
GO

