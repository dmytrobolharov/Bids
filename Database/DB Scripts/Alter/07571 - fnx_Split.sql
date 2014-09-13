IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Split]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_Split]
GO

CREATE FUNCTION [dbo].[fnx_Split]
(@text nvarchar(max), @delimiter nvarchar(20) = ' ')

RETURNS @Strings TABLE

(    

  position int IDENTITY PRIMARY KEY,

  value nvarchar(max)   

)

AS

BEGIN

 

DECLARE @index int 

SET @index = -1 

 
-- because function LEN does not count trailing spaces
-- created a workaround
WHILE (LEN(@text + N'_') - 1 > 0) 

  BEGIN  
	
    SET @index = CHARINDEX(@delimiter , @text)  

    IF (@index = 0) AND (LEN(@text + N'_') - 1 > 0)  

      BEGIN   

        INSERT INTO @Strings VALUES (@text)

          BREAK  

      END  

    IF (@index > 1)  

      BEGIN   

        INSERT INTO @Strings VALUES (LEFT(@text, @index - 1))   

        SET @text = RIGHT(@text, (LEN(@text + N'_') - 1 - @index))  

      END  

    ELSE 

      SET @text = RIGHT(@text, (LEN(@text + N'_') - 1 - @index)) 

    END

  RETURN

END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07571', GetDate())
GO
