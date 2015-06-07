IF OBJECT_ID(N'[dbo].[spx_pSizeRange_DELETE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pSizeRange_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_pSizeRange_DELETE]( 
	@SizeRangeId nvarchar(50)
)
AS 

declare @NoOfSize INT,
		@UsedForTemplates INT;
		
SELECT @NoOfSize = CASE WHEN EXISTS(SELECT * FROM pStyleHeader WITH (NOLOCK) WHERE SizeRangeId = @SizeRangeId) THEN 1 ELSE 0 END
SELECT @UsedForTemplates = CASE WHEN EXISTS(SELECT * FROM pGRMeasurementsPOMTemplateGroup WHERE SizeRangeId = @SizeRangeId) THEN 1 ELSE 0 END

IF @NoOfSize + @UsedForTemplates = 0 
BEGIN
	DELETE FROM pSizeRange WHERE CustomId = @SizeRangeId
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
VALUES ('DB_Version', '6.1.0000', '09935', GetDate())
GO

