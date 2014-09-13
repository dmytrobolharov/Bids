IF  EXISTS (SELECT * FROM sys.procedures WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContentVendorColor_INSERT]'))
DROP PROCEDURE spx_MaterialContentVendorColor_INSERT
GO
  
create  PROCEDURE [dbo].[spx_MaterialContentVendorColor_INSERT] 
(@MaterialTradePartnerID UNIQUEIDENTIFIER ,  
@MaterialID UNIQUEIDENTIFIER ,  
@MaterialContentVendorColorCode nvarchar(5), 
@MaterialContentVendorColorPerc decimal(18,0),
 @MUser nvarchar(200), 
 @MDate datetime ) 
 AS    
 DECLARE @MaterialContentVendorColorName nvarchar(200) 
 DECLARE @MaterialContentVendorColorId uniqueidentifier  
 
 SET @MaterialContentVendorColorId  = NEWID() 
 
 SELECT @MaterialContentVendorColorName = Custom FROM pMaterialContentType WHERE CustomKey = @MaterialContentVendorColorCode   
 INSERT INTO dbo.pMaterialContentVendorColor( MaterialContentVendorColorId, 
 MaterialTradePartnerID, MaterialID ,  MaterialContentVendorColorCode, 
 MaterialContentVendorColorPerc, MaterialContentVendorColorName, MUser, MDate  )  
 VALUES 
 ( @MaterialContentVendorColorId, @MaterialTradePartnerID, @MaterialID, @MaterialContentVendorColorCode,
  @MaterialContentVendorColorPerc, 
 @MaterialContentVendorColorName, @MUser, @MDate  ) 
 
 GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.1.1000', '01095', GetDate())
GO    
  
  