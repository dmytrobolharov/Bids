
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 22 July 2011                                                                               */
-- * WorkItem #4107                                                                             */
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

/****** Object:  StoredProcedure [dbo].[spx_Style_Marker_Summary]    Script Date: 07/22/2011 21:03:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Marker_Summary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Marker_Summary]
GO

/****** Object:  StoredProcedure [dbo].[spx_Style_Marker_Summary]    Script Date: 07/22/2011 21:03:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROC  [dbo].[spx_Style_Marker_Summary]  
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
   
IF CHARINDEX(N'Marker_Rev1 Desc', @strSortOrder) != 0     
 BEGIN     
	SET @SortColumn = ''        
	--select @strSortOrder as strSortOrder1     
	SET @SortColumn = REPLACE(@strSortOrder, ' Desc', '')      
	--select @SortColumn as SortColumn    
	SET @strSortOrder = @SortColumn + ' ' + 'Desc'    
	--select @strSortOrder as strSortOrder2    
 END    
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
		avg(Marker_Notches) as ''Avg. Notches'',
		Marker_Rev1 as ''Last Modified Date''    

		from pBodyMarker where StyleId ='+ CHAR(39) + CONVERT(NVARCHAR(50),@StyleID) + CHAR(39) +' AND StyleSet = '+CONVERT(NVARCHAR(50),@StyleSet)+' and IsActive =1 AND IsForAveraging = 1    
		group by Marker_Image_Name,marker_Width,Marker_Rev1  
		order by '+ CONVERT(NVARCHAR(50),@strSortOrder)  
     
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
		avg(Marker_Notches) as ''Avg. Notches'',
		Marker_Rev1 as ''Last Modified Date''  

		from pBodyMarker where StyleId ='+ CHAR(39) + Convert(NVARCHAR(50),@StyleID) + CHAR(39) +' AND StyleSet = '+CONVERT(NVARCHAR(50),@StyleSet)+' and IsActive =1 AND IsForAveraging = 1    
		group by Marker_Image_Name,marker_Width,Marker_Rev1    
		order by '+ CONVERT(NVARCHAR(50),@strSortOrder)  
     
  END  
    
  EXECUTE(@Sortsql)     
End  

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01756'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01756', GetDate())

END

GO
