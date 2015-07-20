
/****** Object:  StoredProcedure [dbo].[spx_pGRSizeRangeDetaiLinked_DELETE]    
Script Date: 02/28/2011 15:36:39 ******/

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRSizeRangeDetaiLinked_DELETE') 
DROP PROCEDURE spx_pGRSizeRangeDetaiLinked_DELETE
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_pGRSizeRangeDetaiLinked_DELETE](
	@SizeRangeGuidId uniqueidentifier
)
 AS 


	BEGIN
		DELETE from pGRSizeRangeDetail where ClassRangeId IN (SELECT     ClassRangeId
		FROM          pGRClassRange WHERE      (pGRSizeRangeDetail.SizeRangeId = @SizeRangeGuidId) AND (IsLinked = 1))
		AND  SizeCount not in (select SizeCount from pGRSizeRangeDetail 
		WHERE SizeRangeId=@SizeRangeGuidId AND classrangeid='00000000-0000-0000-0000-000000000000' )
	END    
	
	EXEC spx_pGRSizeRangeDetaiLinked_Reorder
		@SizeRangeGuidId
	
	                                 

  GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01221', GetDate())
go
