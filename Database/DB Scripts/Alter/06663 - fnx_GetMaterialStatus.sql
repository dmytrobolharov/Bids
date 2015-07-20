/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialStatus]    Script Date: 11/22/2013 12:08:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialStatus]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialStatus]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialStatus]    Script Date: 11/22/2013 12:08:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[fnx_GetMaterialStatus]
(
    @MaterialStatusID NVARCHAR(200)
)

RETURNS NVARCHAR(255)

AS

BEGIN
	DECLARE @MaterialStatus NVARCHAR (255)
	
	SELECT @MaterialStatus=Custom  FROM xCustom8 Where Active = 1 AND CustomKey=@MaterialStatusID
	
	RETURN @MaterialStatus
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06663', GetDate())
GO