IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pBodyMarker' and COLUMN_NAME = N'StyleSet')
       BEGIN 
             ALTER TABLE pBodyMarker ADD StyleSet int null
       END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Marker_Summary]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Style_Marker_Summary]
GO
/****** Object:  StoredProcedure [dbo].[spx_Style_Marker_Summary]    Script Date: 03/28/2011 11:57:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROC  [dbo].[spx_Style_Marker_Summary]
(
 @StyleID uniqueidentifier,
 @StyleSet int,
 @Imperial nvarchar(2)
)
AS

BEGIN
if Len(@Imperial)= 0

		begin

		select	Marker_Image_Name as 'Fabric Type',
			Round(marker_width,4) as 'Width',
			Count(Marker_Width) as '# Markers',
			Round((avg(usage/36)),4) as 'Avg. Usage (Yd)',
			Round((avg(TotalUsage/36)),4) as 'Avg. Total Usage (Yd)', 
			Round((avg(AdjustedUsage/36)),4) as 'Avg. Adjusted Usage (Yd)',
			Round((avg(Marker_Efficiency)),4) as 'Avg. Efficiency' ,
			Round((avg(Marker_Total_Area)/(36*36)),4) as 'Avg. Total Area (SqYd)',
			Round((avg(Marker_Total_Perim)/36),4) as 'Avg. Total Perimeter (Yd)', 
			--avg(Marker_Drillholes) as 'Avg. Drillholes', 
			avg(Marker_Corners)as 'Avg. Corners ', 
			avg(Marker_Notches) as 'Avg. Notches'
		 
			from pBodyMarker where StyleId =@StyleID AND StyleSet = @StyleSet and IsActive =1 AND IsForAveraging = 1
			group by Marker_Image_Name,marker_Width
			
		end
		
	else
		begin
			select	Marker_Image_Name as 'Fabric Type',
			Round(marker_width*2.54,4) as 'Width',
			Count(Marker_Width) as '# Markers',
			Round(avg((usage/36)*0.9144),4) as 'Avg. Usage (M)',
			Round(avg((TotalUsage/36)*0.9144),4) as 'Avg. Total Usage (M)', 
			Round(avg((AdjustedUsage/36)*0.9144),4) as 'Avg. Adjusted Usage (M)',
			Round(avg(Marker_Efficiency),4) as 'Avg. Efficiency' ,
			Round(avg((Marker_Total_Area/1296)*0.8361),4) as 'Avg. Total Area (SqM)',
			Round(avg((Marker_Total_Perim/36)*0.9144),4) as 'Avg. Total Perimeter (M)', 
			--avg(Marker_Drillholes) as 'Avg. Drillholes', 
			avg(Marker_Corners)as 'Avg. Corners ', 
			avg(Marker_Notches) as 'Avg. Notches'
		 
			from pBodyMarker where StyleId =@StyleID AND StyleSet = @StyleSet and IsActive =1 AND IsForAveraging = 1
			group by Marker_Image_Name,marker_Width
			
		end
		
		
End
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01423', GetDate())

GO