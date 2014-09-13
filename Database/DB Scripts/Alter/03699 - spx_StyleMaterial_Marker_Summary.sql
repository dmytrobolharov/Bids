IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterial_Marker_Summary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterial_Marker_Summary]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleMaterial_Marker_Summary]
(
 @StyleID UNIQUEIDENTIFIER,    
 @StyleSet INT
)
AS

BEGIN    
	DECLARE @Sortsql   NVARCHAR(max)                  
	DECLARE @tempTu	NVARCHAR(100)
  BEGIN        
	  SET @Sortsql='select Marker_Image_Name as ''Fabric Type'',      
	  Round(marker_width,4) as ''Width'',           
	  Round((avg(TotalUsage/36)),4) as ''Avg. Total Usage (Yd)''          
	  from pBodyMarker where StyleId ='+ CHAR(39) + CONVERT(NVARCHAR(50),@StyleID) + CHAR(39) +' AND StyleSet = '+CONVERT(NVARCHAR(50),@StyleSet)+' and IsActive =1 AND IsForAveraging = 1      
	  group by Marker_Image_Name,marker_Width'            
  END    
      
  EXECUTE(@Sortsql) 
  
  CREATE TABLE #tempBOMMaterialMarker (
			 TableRow int NOT NULL IDENTITY (0, 1)				 
			 ,FabricType nvarchar(50) COLLATE database_default
			 ,Width nvarchar(100) COLLATE database_default
			 ,TotalUsage nvarchar(100) COLLATE database_default	
			 )
			 
        
  INSERT #tempBOMMaterialMarker EXEC (@Sortsql) 
 
  UPDATE pStyleMaterials SET Qty=t.TotalUsage FROM pStyleMaterials b
  inner join #tempBOMMaterialMarker t
  ON b.z=t.FabricType and b.width=t.Width
  WHERE b.StyleID = @StyleID And b.StyleSet = @StyleSet
  
  drop table #tempBOMMaterialMarker

End

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03699', GetDate())
GO