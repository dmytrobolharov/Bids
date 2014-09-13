
/****** Object:  StoredProcedure [dbo].[spx_Style_Marker_Summary]    Script Date: 10/06/2010 13:19:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Style_Marker_Summary') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Style_Marker_Summary
GO

CREATE PROC  [dbo].[spx_Style_Marker_Summary]
(
 @StyleID uniqueidentifier
)
AS

BEGIN

select	Round(marker_width,4) as 'Width',
		Count(Marker_Width) as '# Markers',
		Round((avg(usage/36)),4) as 'Average Usage (Yd)',
		Round((avg(TotalUsage/36)),4) as 'Average Total Usage (Yd)', 
		Round((avg(AdjustedUsage/36)),4) as 'Average Adjusted Usage (Yd)',
		Round((avg(Marker_Efficiency)),4) as 'Average Efficiency' ,
		Round((avg(Marker_Total_Area)/(36*36)),4) as 'Average Total Area (SqYd)',
		Round((avg(Marker_Total_Perim)/36),4) as 'Average Total Perimeter (Yd)', 
		avg(Marker_Drillholes) as 'Average Drillholes', 
		avg(Marker_Corners)as 'Average Corners ', 
		avg(Marker_Notches) as 'Average Notches'
	 
		from pBodyMarker where StyleId =@StyleID and IsActive =1 -- and BodyID is null
		group by marker_Width
End
GO

----------------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '494', GetDate())
GO
