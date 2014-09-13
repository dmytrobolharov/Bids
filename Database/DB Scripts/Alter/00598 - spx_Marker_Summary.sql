
/****** Object:  StoredProcedure [dbo].[spx_Marker_Summary]    Script Date: 10/06/2010 12:35:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Marker_Summary') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Marker_Summary
GO

CREATE PROC  [dbo].[spx_Marker_Summary]
(
 @BodyID uniqueidentifier
)
AS

BEGIN

select	Marker_Image_Name as 'Material Grp.',
		Round(marker_width,4) as 'Width',
		Count(Marker_Width) as '# Markers',
		Round((avg(usage/36)),4) as 'Avg. Usage (Yd)',
		Round((avg(TotalUsage/36)),4) as 'Avg. Total Usage (Yd)', 
		Round((avg(AdjustedUsage/36)),4) as 'Avg. Adjusted Usage (Yd)',
		Round((avg(Marker_Efficiency)),4) as 'Avg. Efficiency' ,
		Round((avg(Marker_Total_Area)/(36*36)),4) as 'Avg. Total Area (SqYd)',
		Round((avg(Marker_Total_Perim)/36),4) as 'Avg. Total Perimeter (Yd)', 
		avg(Marker_Drillholes) as 'Avg. Drillholes', 
		avg(Marker_Corners)as 'Avg. Corners ', 
		avg(Marker_Notches) as 'Avg. Notches'
	 
		from pBodyMarker where BodyId =@BodyID and IsActive =1 and StyleID is null
		group by Marker_Image_Name,marker_Width
End
GO

----------------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '598', GetDate())
GO