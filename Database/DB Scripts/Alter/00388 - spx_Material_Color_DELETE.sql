IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Color_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_Color_DELETE]
GO
  
  
CREATE PROCEDURE [dbo].[spx_Material_Color_DELETE]  (  
@MaterialColorID UNIQUEIDENTIFIER   
)  
AS  
BEGIN   
  
----WE NO LONGER USE LABDIP----
-- DELETE FROM dbo.pMaterialTradePartnerLabDipSubmitComment  
-- WHERE MaterialTradePartnerLabDipSubmitItemID  IN (  
--  SELECT MaterialTradePartnerLabDipSubmitItemID FROM dbo.pMaterialTradePartnerLabDipSubmitItem  
--  WHERE MaterialTradePartnerColorID IN ( SELECT MaterialTradePartnerColorID    
--   FROM dbo.pMaterialTradePartnerColor WHERE MaterialColorID = @MaterialColorID  )  
-- )  
--  
--  
-- DELETE FROM dbo.pMaterialTradePartnerLabDipSubmitItem  
-- WHERE MaterialTradePartnerColorID IN ( SELECT MaterialTradePartnerColorID    
--  FROM dbo.pMaterialTradePartnerColor WHERE MaterialColorID = @MaterialColorID  )  
--  
--  
-- DELETE FROM dbo.pMaterialTradePartnerLabDipSubmit   
-- WHERE MaterialTradePartnerColorID IN ( SELECT MaterialTradePartnerColorID    
--  FROM dbo.pMaterialTradePartnerColor WHERE MaterialColorID = @MaterialColorID  )  
  
 DELETE FROM dbo.pMaterialTradePartnerColor WHERE MaterialColorID = @MaterialColorID   
  
  
 DELETE FROM pMaterialColor WHERE MaterialColorID =  @MaterialColorID   
  
 DELETE FROM  pMaterialLinkColorwayItem  where MaterialLinkColorwayID IN (   
  select MaterialLinkColorwayID from pMaterialLinkColorway WHERE MaterialColorID = @MaterialColorID  )    
  
 DELETE FROM pMaterialLinkColorway WHERE MaterialColorID = @MaterialColorID   
  
 DELETE FROM  pMaterialLinkColorwayItem   
 WHERE  MaterialLinkColorwayID  IN  (  
  SELECT MaterialLinkColorwayID  FROM  pMaterialLinkColorway WHERE  @MaterialColorID =  MaterialColorID   
 )  
  
 DELETE FROM  pMaterialLinkColorway    
 WHERE  MaterialLinkColorwayID  IN  (  
  SELECT MaterialLinkColorwayID  FROM  pMaterialLinkColorway WHERE  @MaterialColorID =  MaterialColorID   
 )  
  
  
END   
  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0', '388', GetDate())

GO
  
  