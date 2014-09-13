-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 January 2012                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMaterial_Marker_Summary') and sysstat & 0xf = 4)
    drop procedure spx_StyleMaterial_Marker_Summary
GO


CREATE PROCEDURE spx_StyleMaterial_Marker_Summary
(
 @StyleID UNIQUEIDENTIFIER,    
 @StyleSet INT
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
  
  CREATE TABLE #tempBOMMaterialMarker (
			 TableRow int NOT NULL IDENTITY (0, 1)				 
			 ,FabricType nvarchar(50)	
			 ,Width nvarchar(100)
			 ,TotalUsage nvarchar(100)			
			 )
        
  INSERT #tempBOMMaterialMarker EXEC (@Sortsql) 
  
  update pStyleMaterials set Qty=t.TotalUsage from pStyleMaterials b
  inner join #tempBOMMaterialMarker t
  on b.z=t.FabricType and b.width=t.Width
  where b.StyleID = @StyleID And b.StyleSet = @StyleSet
  
  drop table #tempBOMMaterialMarker

End
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03024', GetDate())
GO

SET NOCOUNT Off
GO
