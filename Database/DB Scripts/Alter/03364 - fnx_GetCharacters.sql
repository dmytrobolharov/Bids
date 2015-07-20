IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetCharacters]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetCharacters]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnx_GetCharacters](@userString varchar(500), @validChars varchar(100))
RETURNS VARCHAR(500) AS
BEGIN
 
	WHILE @userString LIKE '%[^' + @validChars + ']%'
		SELECT @userString = REPLACE(@userString,SUBSTRING(@userString, PATINDEX('%[^' + @validChars + ']%',@userString),1),'')

	RETURN @userString
END
GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03364', GetDate())

GO