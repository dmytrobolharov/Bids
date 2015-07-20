IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOL_GetExceptionEntries]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOL_GetExceptionEntries]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleNBOL_GetExceptionEntries]
	(@StyleNBOLItemID varchar(40))
AS
BEGIN

	DECLARE @ExceptionList varchar(2000)

	SELECT @ExceptionList = COALESCE(@ExceptionList + ', ', '') + 
	   CAST(ExceptionID AS varchar(36))
	FROM pStyleNBOLExceptionEntries
	WHERE StyleNBOLItemID = @StyleNBOLItemID

	SELECT ISNULL(@ExceptionList, '')

END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03547', GetDate())
GO