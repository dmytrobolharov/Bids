IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_StyleNBOL_GetExceptionEntriesString]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_StyleNBOL_GetExceptionEntriesString]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnx_StyleNBOL_GetExceptionEntriesString]
(
	@StyleNBOLItemID varchar(40),
	@WorkflowItemID varchar(40)
)
RETURNS nvarchar(800)
AS
BEGIN

	DECLARE @ExceptionList varchar(2000)
	
	IF NOT EXISTS (SELECT * FROM pStyleNBOLExceptionEntries WHERE StyleNBOLItemID = @StyleNBOLItemID AND ExceptionID = '00000000-0000-0000-0000-000000000000')
	BEGIN
		SET @ExceptionList = 'Standard'
	END

	SELECT @ExceptionList = COALESCE(@ExceptionList + ', ', '') + 
	   CAST(e.ExceptionName AS varchar(100))
	FROM pStyleNBOLException e
	WHERE WorkflowItemID = @WorkflowItemID
		AND @StyleNBOLItemID NOT IN (SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries WHERE ExceptionID = e.ExceptionID) 
	ORDER BY e.Sort

	RETURN ISNULL(@ExceptionList, '')

END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03585', GetDate())
GO