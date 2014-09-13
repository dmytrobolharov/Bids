  
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetailGrid_Custom1_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDetailGrid_Custom1_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailGrid_Custom1_INSERT]    
(@StyleID uniqueidentifier,    
@StyleSet int,    
@NoRow int)    
    
AS     
    
    
    
DECLARE @Max as INT     
DECLARE @Len AS INT     
DECLARE @Sort AS  NVARCHAR (4)    
    
SELECT @Max = MAX (Cast(Sort AS INT  )) FROM pStyleDetailGrid_Custom1 WITH (NOLOCK) WHERE styleID = @StyleID    
IF @Max IS NULL     
 SET @Max  = 1    
ELSE    
 SET @Max = @Max + 1     
    
    
DECLARE @Rows INT     
SET @Rows = @NoRow    
    
WHILE @Rows > 0     
BEGIN    
    
 SET @Len = LEN ( CAST ( @Max AS NVARCHAR ( 4 ) ) )      
    
 SELECT @Sort = REPLICATE ('0', 4 - @Len ) + CAST ( @Max AS NVARCHAR (  4 ) )    
    
 INSERT INTO pStyleDetailGrid_Custom1 (StyleID, StyleSet , Sort ) VALUES (@StyleID, @StyleSet , @Sort )    
    
 SET @Max  = @Max  + 1     
    
 SET @Rows = @Rows -1    
END    

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '609', GetDate())

GO