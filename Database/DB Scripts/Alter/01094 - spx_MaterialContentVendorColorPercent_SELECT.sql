IF  EXISTS (SELECT * FROM sys.procedures WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContentVendorColorPercent_SELECT]'))
DROP PROCEDURE spx_MaterialContentVendorColorPercent_SELECT
GO
  
CREATE PROCEDURE [dbo].[spx_MaterialContentVendorColorPercent_SELECT] 
(@MaterialTradePartnerID UNIQUEIDENTIFIER,
@MaterialID uniqueidentifier) 
AS   
SELECT SUM(MaterialContentVendorColorPerc) FROM pMaterialContentVendorColor 
WITH (NOLOCK) WHERE MaterialContentVendorColorCode <> '0' AND MaterialID = @MaterialID AND  MaterialTradePartnerID= @MaterialTradePartnerID

 GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.2.1000', '01094', GetDate())
GO   
  
  