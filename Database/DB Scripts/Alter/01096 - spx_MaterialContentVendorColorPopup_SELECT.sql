  
IF  EXISTS (SELECT * FROM sys.procedures WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContentVendorColorPopup_SELECT]'))
DROP PROCEDURE spx_MaterialContentVendorColorPopup_SELECT
GO
  
  
CREATE PROCEDURE [dbo].[spx_MaterialContentVendorColorPopup_SELECT]  
(@MaterialTradePartnerID uniqueidentifier,
@MaterialID uniqueidentifier,  
@CreatedBy nvarchar(200),  
@CreatedDate datetime)  
AS   
  
DELETE FROM  dbo.pMaterialContentVendorColor  WHERE MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialContentVendorColorPerc < 0   
  
  
IF (SELECT COUNT(*) FROM  dbo.pMaterialContentVendorColor WITH (NOLOCK) WHERE MaterialTradePartnerID = @MaterialTradePartnerID) = 0  
 BEGIN  
  INSERT INTO pMaterialContentVendorColor  
   (MaterialTradePartnerID, MaterialId, MaterialContentVendorColorPerc, MaterialContentVendorColorCode)  
  VALUES (@MaterialTradePartnerID, @MaterialId, 100, 0)  
    
  SELECT MaterialContentVendorColorId, MaterialTradePartnerID, MaterialId, MaterialContentVendorColorCode, MaterialContentVendorColorPerc, MaterialContentVendorColorName, CDate, CUser, MDate, MUser  
  FROM  pMaterialContentVendorColor WITH (NOLOCK) WHERE MaterialTradePartnerID = @MaterialTradePartnerID ORDER BY MaterialContentVendorColorPerc DESC  
 END  
ELSE  
 BEGIN  
   
  DECLARE @ContentPerc decimal(18,0)   
  DECLARE @ContentPercTemp decimal(18,0)   
  
  -- Delete negative values    
  DELETE FROM  dbo.pMaterialContentVendorColor WHERE MaterialTradePartnerID = @MaterialTradePartnerID    
  AND ( MaterialContentVendorColorPerc IS NULL OR MaterialContentVendorColorPerc <=0 )   
  
  SET @ContentPerc = (SELECT SUM(MaterialContentVendorColorPerc) FROM  dbo.pMaterialContentVendorColor WITH (NOLOCK) WHERE MaterialTradePartnerID = @MaterialTradePartnerID)  
  
  
  IF @ContentPerc >  100  
  BEGIN   
  
  
   DECLARE @Rows  INT   
   DECLARE @Current INT   
   DECLARE @MaterialContentVendorColorId  UNIQUEIDENTIFIER    
   DECLARE @MaterialContentVendorColorPerc  INT   
   DECLARE @Total INT   
  
   CREATE TABLE #tmpMaterialContentVendorColor (  
    Rec_ID  INT IDENTITY (1,1),  
    MaterialContentVendorColorId UNIQUEIDENTIFIER  ,   
    MaterialContentVendorColorPerc INT  
   )  
  
   INSERT INTO #tmpMaterialContentVendorColor  ( MaterialContentVendorColorId , MaterialContentVendorColorPerc )  
   SELECT MaterialContentVendorColorId , MaterialContentVendorColorPerc   
   FROM  pMaterialContentVendorColor WITH (NOLOCK) WHERE MaterialTradePartnerID = @MaterialTradePartnerID ORDER BY MaterialContentVendorColorPerc DESC  
    
   SET @Total   = 0   
   SET @Current = 1   
   SELECT @Rows  = COUNT (*)  FROM  #tmpMaterialContentVendorColor  
  
   WHILE @Current <= @Rows   
   BEGIN  
  
    SELECT @MaterialContentVendorColorId  = MaterialContentVendorColorId , @MaterialContentVendorColorPerc  = MaterialContentVendorColorPerc   
    FROM #tmpMaterialContentVendorColor    
    WHERE  Rec_ID =  @Current   
      
  
    IF  @Total + @MaterialContentVendorColorPerc   > 100   
    BEGIN  
     -- DELETE RECORDS   
     DELETE FROM pMaterialContentVendorColor  
     WHERE  MaterialContentVendorColorId = @MaterialContentVendorColorId  
      
    END   
    ELSE  
    BEGIN  
     SET @Total   =  @Total  + @MaterialContentVendorColorPerc  
    END   
      
    SET @Current  = @Current + 1   
   END   
     
   DROP TABLE #tmpMaterialContentVendorColor  
     
  
   SET @ContentPercTemp = 100 - ISNULL(@Total,0)  
   IF @ContentPercTemp > 0   
   BEGIN  
    INSERT INTO pMaterialContentVendorColor(MaterialTradePartnerID, MaterialId, MaterialContentVendorColorPerc, MaterialContentVendorColorCode)  
    VALUES (@MaterialTradePartnerID, @MaterialId, @ContentPercTemp, 0)  
   END   
      
  
  END  
  ELSE   
  BEGIN   
     
   IF @ContentPerc <> 100   
   BEGIN   
    SET @ContentPercTemp = 100 - ISNULL(@ContentPerc,0)  
    INSERT INTO pMaterialContentVendorColor(MaterialTradePartnerID, MaterialId, MaterialContentVendorColorPerc, MaterialContentVendorColorCode)  
    VALUES (@MaterialTradePartnerID, @MaterialId, @ContentPercTemp, 0)   
   END   
  
   --  IF @ContentPerc   = 100   DO NOTHING        
  
  END  
  
  
    
/*   
  IF @ContentPerc <> 100  
  BEGIN  
    
   SET @ContentPercTemp = 100 - ISNULL(@ContentPerc,0)  
   INSERT INTO pMaterialContentVendorColor(MaterialId, MaterialContentVendorColorPerc, MaterialContentVendorColorCode)  
   VALUES (@MaterialId, @ContentPercTemp, 0)  
     
  END  
*/  
  
   
   
  --SELECT MaterialContentVendorColorId, MaterialId, MaterialContentVendorColorCode, MaterialContentVendorColorPerc, MaterialContentVendorColorName, CDate, CUser, MDate, MUser  
  --FROM  pMaterialContentVendorColor WITH (NOLOCK) WHERE MaterialID = @MaterialID ORDER BY MaterialContentVendorColorPerc DESC  
  
  
  SELECT IDENTITY(int, 1,1) AS ID_Num,MaterialContentVendorColorId, MaterialTradePartnerID, MaterialId, MaterialContentVendorColorCode, MaterialContentVendorColorPerc, MaterialContentVendorColorName, CDate, CUser, MDate, MUser  
  INTO #tmpContent  
  FROM  pMaterialContentVendorColor WITH (NOLOCK)   
  WHERE MaterialTradePartnerID = @MaterialTradePartnerID  
  AND MaterialContentVendorColorCode <> '0'  
  ORDER BY MaterialContentVendorColorPerc DESC , MaterialContentVendorColorName  
  
  
  insert into  #tmpContent   
  SELECT MaterialContentVendorColorId, MaterialTradePartnerID, MaterialId, MaterialContentVendorColorCode, MaterialContentVendorColorPerc, MaterialContentVendorColorName, CDate, CUser, MDate, MUser  
  FROM  pMaterialContentVendorColor WITH (NOLOCK)   
  WHERE MaterialTradePartnerID = @MaterialTradePartnerID  
  AND MaterialContentVendorColorCode = '0'  
  ORDER BY MaterialContentVendorColorPerc DESC , MaterialContentVendorColorName  
  
  select * from #tmpContent   
  order by ID_NUM   
  
  drop table #tmpContent   
  
  
    
 END  
 
 GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.1.1000', '01096', GetDate())
GO    
  
  
  
  
  
  