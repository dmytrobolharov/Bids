/****** Object:  StoredProcedure [dbo].[spx_aaTest]    Script Date: 02/28/2011 15:36:39 ******/
IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRSizeRangeDetailLinked_UPDATE') 
DROP PROCEDURE spx_pGRSizeRangeDetailLinked_UPDATE
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_pGRSizeRangeDetailLinked_UPDATE](
	@SizeRangeGuidId uniqueidentifier,
	@SizeCount int,
	@SizeName nvarchar(50),
	@SizeDesc nvarchar(50),
	@Sample int,
    @BeforeCount  int
)
AS 
DECLARE @TotalCount int
DECLARE @RowCounter int
DECLARE @ClassRangeId UNIQUEIDENTIFIER
/************************/
/*Create temp table.	*/
/************************/
CREATE TABLE dbo.#temp_Linked	(		
	TableRow int NOT NULL IDENTITY (1, 1)
	,ClassRangeId UNIQUEIDENTIFIER
	
)  


BEGIN
	UPDATE    pGRSizeRangeDetail 

		Set SizeCount = @SizeCount, 
		SizeName = @SizeName,
		SizeDesc = @SizeDesc, 
		Sample = @Sample

	WHERE     (ClassRangeId IN
							  (SELECT     ClassRangeId
								FROM          pGRClassRange
								WHERE      (pGRSizeRangeDetail.SizeRangeId = @SizeRangeGuidId) AND (IsLinked = 1))
	AND SizeCount=@BeforeCount)
END 
 
 
  /*Reorder sizerangedetails*/
 BEGIN
	INSERT INTO #temp_Linked(ClassRangeId)
		(SELECT DISTINCT ClassRangeId
		from pGRClassRange where SizeRangeGuidId =@SizeRangeGuidId AND IsLinked =1)
END 



	SELECT @TotalCount = COUNT(*) FROM #temp_Linked	
	SET @RowCounter = 1
    
     BEGIN   
   
		WHILE(@RowCounter <= @TotalCount)
         BEGIN   
        /*Get 'ClassRangeId'.*/
        SET @ClassRangeId = NULL 
                    
			SELECT @ClassRangeId = ClassRangeId FROM #temp_Linked WHERE TableRow =@RowCounter  
           
	 
			EXEC spx_pGRSizeRangeDetail_Reorder
			@SizeRangeGuidId,
			@ClassRangeId
	   
			SET @RowCounter = @RowCounter + 1
	END 
  end 
  
  
  
--delete from pGRSizeRangeDetail where ClassRangeId IN (SELECT     ClassRangeId
--FROM          pGRClassRange WHERE      (pGRSizeRangeDetail.SizeRangeId = @SizeRangeGuidId) AND (IsLinked = 1))
--AND  SizeCount not in (select SizeCount from pGRSizeRangeDetail 
--WHERE SizeRangeId=@SizeRangeGuidId AND classrangeid='00000000-0000-0000-0000-000000000000' )
                                                
                                                


  GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01208', GetDate())
