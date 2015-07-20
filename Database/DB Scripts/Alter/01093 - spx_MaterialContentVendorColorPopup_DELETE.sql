IF  EXISTS (SELECT * FROM sys.procedures WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContentVendorColorPopup_DELETE]'))
DROP PROCEDURE spx_MaterialContentVendorColorPopup_DELETE
GO

CREATE PROCEDURE [dbo].[spx_MaterialContentVendorColorPopup_DELETE]  
(@MaterialContentVendorColorID uniqueidentifier)  
AS   
  
 BEGIN  
    
  DELETE FROM  pMaterialContentVendorColor WHERE MaterialContentVendorColorID = @MaterialContentVendorColorID  
   
 END  
 
 GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.1.1000', '01093', GetDate())
GO    
  
  