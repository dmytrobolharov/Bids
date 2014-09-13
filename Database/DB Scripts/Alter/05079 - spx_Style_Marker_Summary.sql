IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Marker_Summary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Marker_Summary]
GO


CREATE PROC  [dbo].[spx_Style_Marker_Summary]    
(    
 @StyleID UNIQUEIDENTIFIER,    
 @StyleSet INT,    
 @Imperial NVARCHAR(2),    
 @strSortOrder NVARCHAR(50)    
)    
AS    
    
BEGIN    
DECLARE @SortColumn NVARCHAR(50),      
@Sortsql   NVARCHAR(max)      
     
IF LEN(@Imperial)= 0    
    
  BEGIN    
    
  SET @Sortsql='select Marker_Image_Name as ''Fabric Type'',      
  Round(marker_width,4) as ''Width'',      
  Count(Marker_Width) as ''# Markers'',      
  Round((avg(usage/36)),4) as ''Avg. Usage (Yd)'',      
  Round((avg(TotalUsage/36)),4) as ''Avg. Total Usage (Yd)'',       
  Round((avg(AdjustedUsage/36)),4) as ''Avg. Adjusted Usage (Yd)'',      
  Round((avg(Marker_Efficiency)),4) as ''Avg. Efficiency'' ,      
  Round((avg(Marker_Total_Area)/(36*36)),4) as ''Avg. Total Area (SqYd)'',      
  Round((avg(Marker_Total_Perim)/36),4) as ''Avg. Total Perimeter (Yd)'',       
  --avg(Marker_Drillholes) as ''Avg. Drillholes'',       
  avg(Marker_Corners)as ''Avg. Corners'',       
  avg(Marker_Notches) as ''Avg. Notches''    
  from pBodyMarker where StyleId ='+ CHAR(39) + CONVERT(NVARCHAR(50),@StyleID) + CHAR(39) +' AND StyleSet = '+CONVERT(NVARCHAR(50),@StyleSet)+' and IsActive =1 AND IsForAveraging = 1      
  group by Marker_Image_Name,marker_Width 
  order by Marker_Image_Name,marker_Width'
   
       
  END    
      
 ELSE    
  BEGIN    
  SET @Sortsql='select Marker_Image_Name as ''Fabric Type'',      
  Round(marker_width*2.54,4) as ''Width'',      
  Count(Marker_Width) as ''# Markers'',      
  Round(avg((usage/36)*0.9144),4) as ''Avg. Usage (M)'',      
  Round(avg((TotalUsage/36)*0.9144),4) as ''Avg. Total Usage (M)'',       
  Round(avg((AdjustedUsage/36)*0.9144),4) as ''Avg. Adjusted Usage (M)'',      
  Round(avg(Marker_Efficiency),4) as ''Avg. Efficiency'' ,      
  Round(avg((Marker_Total_Area/1296)*0.8361),4) as ''Avg. Total Area (SqM)'',      
  Round(avg((Marker_Total_Perim/36)*0.9144),4) as ''Avg. Total Perimeter (M)'',       
  --avg(Marker_Drillholes) as ''Avg. Drillholes'',       
  avg(Marker_Corners)as ''Avg. Corners'',       
  avg(Marker_Notches) as ''Avg. Notches''  
  
  from pBodyMarker where StyleId ='+ CHAR(39) + Convert(NVARCHAR(50),@StyleID) + CHAR(39) +' AND StyleSet = '+CONVERT(NVARCHAR(50),@StyleSet)+' and IsActive =1 AND IsForAveraging = 1      
  group by Marker_Image_Name,marker_Width 
  order by Marker_Image_Name,marker_Width'      
       
  END    
      
  EXECUTE(@Sortsql)       
End

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05079', GetDate())
GO
