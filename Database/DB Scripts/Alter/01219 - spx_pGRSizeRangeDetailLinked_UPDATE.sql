
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
as


DECLARE @SizeOrder int
SET @SizeOrder = 0
SELECT @SizeOrder = SizeCount FROM pGRSizeRangeDetail WHERE ClassRangeId IN
	 (SELECT  ClassRangeId	FROM pGRClassRange
	  WHERE SizeRangeId = @SizeRangeGuidId AND IsLinked = 1 AND SizeCount = @BeforeCount)

if @SizeOrder <> 0 

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
 ELSE
	BEGIN
		INSERT INTO  pGRSizeRangeDetail 
			 (SizeRangeDetailId, SizeRangeId, SizeCount, SizeName, SizeDesc, Sample, ClassRangeId)
			 (SELECT NEWID(), @SizeRangeGuidId,   @SizeCount, @SizeName,@SizeDesc, @Sample, ClassRangeId
				FROM pGRClassRange WHERE SizeRangeGuidId = @SizeRangeGuidId AND IsLinked = 1)
		
	END 
  GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01219', GetDate())
GO
