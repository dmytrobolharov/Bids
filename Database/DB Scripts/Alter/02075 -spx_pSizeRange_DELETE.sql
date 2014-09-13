SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pSizeRange_DELETE')
   DROP PROCEDURE spx_pSizeRange_DELETE
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_pSizeRange_DELETE]
( @SizeRangeCode nvarchar(50))
AS 


begin

declare @NoOfSize nvarchar(50)

	SELECT  @NoOfSize = COUNT(*)  FROM  pStyleHeader WITH (NOLOCK) WHERE   SizeRange = @SizeRangeCode

end

IF @NoOfSize = 0 

	BEGIN
	DELETE FROM pSizeRange WHERE SizeRangeCode = @SizeRangeCode
	SELECT @NoOfSize As NoOfSize
	END

ELSE

	BEGIN
	SELECT @NoOfSize As NoOfSize
	END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02075'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02075', GetDate())
	END
GO