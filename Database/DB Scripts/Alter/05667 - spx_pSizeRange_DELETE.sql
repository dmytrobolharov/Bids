/****** Object:  StoredProcedure [dbo].[spx_pSizeRange_DELETE]    Script Date: 05/13/2013 11:30:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pSizeRange_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pSizeRange_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_pSizeRange_DELETE]( 
	@SizeRangeCode nvarchar(50)
)
AS 

declare @NoOfSize INT,
		@UsedForTemplates INT;
		
SELECT @NoOfSize = COUNT(*) FROM pStyleHeader WITH (NOLOCK) WHERE SizeRange = @SizeRangeCode
SELECT @UsedForTemplates = COUNT(*) FROM pGRMeasurementsPOMTemplateGroup WHERE SizeRange = @SizeRangeCode

IF @NoOfSize + @UsedForTemplates = 0 
BEGIN
	DELETE FROM pSizeRange WHERE SizeRangeCode = @SizeRangeCode
	SELECT 0 As NoOfSize
END
ELSE IF @NoOfSize <> 0 AND @UsedForTemplates <> 0	
	SELECT 3 As NoOfSize
ELSE IF @NoOfSize <> 0
	SELECT 1 AS NoOfSize
ELSE IF @UsedForTemplates <> 0
	SELECT 2 As NoOfSize

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05667', GetDate())
GO
