IF  EXISTS (SELECT * FROM sys.procedures WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContentVendorColor_UPDATE]'))
DROP PROCEDURE spx_MaterialContentVendorColor_UPDATE
GO

CREATE PROCEDURE [dbo].[spx_MaterialContentVendorColor_UPDATE] 
( 
@MaterialContentVendorColorId uniqueidentifier,  
@MaterialContentVendorColorCode nvarchar(5), 
@MaterialContentVendorColorPerc decimal(18,0), 
@ModifiedBy nvarchar(200), 
@ModifiedDate datetime 
) 
AS    

DECLARE @MaterialContentVendorColorName nvarchar(200) 
 
SELECT @MaterialContentVendorColorName =  Custom FROM pMaterialContentType WITH (NOLOCK) WHERE CustomKey = @MaterialContentVendorColorCode  

UPDATE    dbo.pMaterialContentVendorColor SET  MaterialContentVendorColorCode = @MaterialContentVendorColorCode, 
MaterialContentVendorColorPerc = @MaterialContentVendorColorPerc, 
MaterialContentVendorColorName = @MaterialContentVendorColorName,                        
MUser = @ModifiedBy, 
MDate = @ModifiedDate 
WHERE MaterialContentVendorColorId = @MaterialContentVendorColorId  

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.2.1000', '01092', GetDate())
GO    
  
  
  