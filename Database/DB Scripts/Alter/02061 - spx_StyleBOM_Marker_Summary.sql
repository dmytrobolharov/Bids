IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_Marker_Summary]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_StyleBOM_Marker_Summary]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE  [dbo].[spx_StyleBOM_Marker_Summary]    
(    
 @StyleID UNIQUEIDENTIFIER,    
 @StyleSet INT,
 @StyleBOMDimensionId UNIQUEIDENTIFIER         
)    

AS    
    
BEGIN    
DECLARE @Sortsql   NVARCHAR(max)                  
    
  BEGIN        
	  SET @Sortsql='select Marker_Image_Name as ''Fabric Type'',      
	  Round(marker_width,4) as ''Width'',           
	  Round((avg(TotalUsage/36)),4) as ''Avg. Total Usage (Yd)''          
	  from pBodyMarker where StyleId ='+ CHAR(39) + CONVERT(NVARCHAR(50),@StyleID) + CHAR(39) +' AND StyleSet = '+CONVERT(NVARCHAR(50),@StyleSet)+' and IsActive =1 AND IsForAveraging = 1      
	  group by Marker_Image_Name,marker_Width'            
  END    
      
  EXECUTE(@Sortsql) 
  
  CREATE TABLE tempBOMMarker (
			 TableRow int NOT NULL IDENTITY (0, 1)				 
			 ,FabricType nvarchar(50)	
			 ,Width nvarchar(100)
			 ,TotalUsage nvarchar(100)			
			 )
        
  INSERT tempBOMMarker EXEC (@Sortsql) 
  
  update pStylebom set Qty=t.TotalUsage from pStylebom b
  inner join tempBOMMarker t
  on b.z=t.FabricType and b.width=t.Width
  where b.StyleBOMDimensionID = @StyleBOMDimensionId 
  
  update pStylebomitem set MaterialQuantity=t.TotalUsage from pStylebomitem p
  inner join pStylebom b on p.styleMaterialId=b.styleMaterialId
  and p.StyleBOMDimensionID=b.StyleBOMDimensionID inner join tempBOMMarker t
  on b.z=t.FabricType and b.width=t.Width
  where p.StyleBOMDimensionID = @StyleBOMDimensionId
  
  drop table tempBOMMarker   
     
  
End

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02061'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02061', GetDate())
END	
GO