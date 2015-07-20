

/****** Object:  StoredProcedure [dbo].[spx_GetErrorInfo]    Script Date: 06/07/2011 06:08:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GetErrorInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GetErrorInfo]
GO

/****** Object:  StoredProcedure [dbo].[spx_GetErrorInfo]    Script Date: 06/07/2011 06:08:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Create procedure to retrieve error information.
CREATE PROCEDURE [dbo].[spx_GetErrorInfo]
AS
SELECT
    ERROR_NUMBER() AS ErrorNumber
    ,ERROR_SEVERITY() AS ErrorSeverity
    ,ERROR_STATE() AS ErrorState
    ,ERROR_PROCEDURE() AS ErrorProcedure
    ,ERROR_LINE() AS ErrorLine
    ,ERROR_MESSAGE() AS ErrorMessage;

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01509', GetDate())
GO


