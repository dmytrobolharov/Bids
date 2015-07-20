/****** Object:  StoredProcedure [dbo].[spx_pGRSizeRangeDetail_Reorder]    
Script Date: 02/28/2011 14:27:46 ******/


IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRSizeRangeDetailLibraryEmpty_DELETE') 
DROP PROCEDURE spx_pGRSizeRangeDetailLibraryEmpty_DELETE

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRSizeRangeDetail_Reorder') 
DROP PROCEDURE spx_pGRSizeRangeDetail_Reorder


GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_pGRSizeRangeDetail_Reorder](
@SizeRangeID as uniqueidentifier,
@ClassRangeId as uniqueidentifier
)
AS 
BEGIN  
 
-- Set the Order number to the row number 
WITH tempTable AS  (        
 SELECT SizeCount, ROW_NUMBER() OVER (ORDER BY SizeCount) AS rn        
 FROM pGRSizeRangeDetail   
  WHERE SizeRangeID= @SizeRangeID AND ClassRangeId=@ClassRangeId) 

UPDATE tempTable
SET SizeCount= rn;  



--Delete trailing records
DECLARE @Count INT
SELECT @Count = MAX(SizeCount) FROM pGRSizeRangeDetail
WHERE SizeRangeID =@SizeRangeID AND ClassRangeId=@ClassRangeId
AND SizeName<>'' 


DELETE FROM dbo.pGRSizeRangeDetail WHERE SizeRangeID=@SizeRangeID AND ClassRangeId=@ClassRangeId
AND SizeCount > @Count

END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01207', GetDate())