IF  EXISTS (SELECT * FROM sys.procedures WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContentVendorColorType_SELECT]'))
DROP PROCEDURE spx_MaterialContentVendorColorType_SELECT

GO

CREATE PROCEDURE [dbo].[spx_MaterialContentVendorColorType_SELECT]  
(@MaterialTradePartnerID uniqueidentifier,
@MaterialId uniqueidentifier,  
@MaterialContentVendorColorId uniqueidentifier)  
AS   
  
/* Added       and Active =1    This will only select material contents that are active 1    Clay 5.09.08  */  
  
SELECT CustomKey, Custom FROM pMaterialContentType WITH (NOLOCK)  
WHERE     (CustomKey NOT IN  
    (SELECT     MaterialContentVendorColorCode  
    FROM          pMaterialContentVendorColor WITH (NOLOCK)  
    WHERE      MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialID = @MaterialID AND MaterialContentVendorColorId <> @MaterialContentVendorColorId))  
and Active = 1  
ORDER BY Custom  

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.1.1000', '01097', GetDate())
GO    
  
  
  