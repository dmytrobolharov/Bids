-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 9 March 2011                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Marker_Summary]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Style_Marker_Summary]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_Style_Marker_Summary] 
(
 @StyleID uniqueidentifier
)
AS

BEGIN
    SELECT Marker_Image_Name as 'Material Grp.',
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

    FROM pBodyMarker 
    WHERE StyleId = @StyleID 
    AND IsActive = 1
    AND IsForAveraging = 1
    GROUP BY Marker_Image_Name, Marker_Width
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01236', GetDate())
GO
