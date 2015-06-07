/****** Object:  UserDefinedFunction [dbo].[fnx_CreatePagingString]    Script Date: 02/09/2015 16:44:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_CreatePagingString]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_CreatePagingString]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_CreatePagingString]    Script Date: 02/09/2015 16:44:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnx_CreatePagingString](
@TableName NVARCHAR(MAX),
@PageNo INT ,
@PageSize INT ,
@SortOrder NVARCHAR(MAX) = NULL,
@Filter NVARCHAR(MAX) = NULL
)
RETURNS NVARCHAR(MAX) AS
BEGIN
	DECLARE @resultString NVARCHAR(MAX) = ''
	SET @Filter = REPLACE(@Filter, ' WHERE ','')
	
 IF (@PageNo IS NULL OR @PageSize IS NULL) 
	SET @resultString = 'SELECT * FROM ' + @TableName + CASE WHEN @Filter IS NULL THEN '' ELSE ' WHERE  '+ @Filter END + CASE WHEN @SortOrder IS NULL THEN '' ELSE ' ORDER BY '+ @SortOrder END
 else
	SET @resultString = N'SELECT * FROM (
			SELECT ROW_NUMBER() OVER(ORDER BY ' + CASE WHEN @SortOrder IS NULL THEN 'RAND()' ELSE @SortOrder END + ') AS YSRowNumber, Count(*) OVER () AS YSTotalRowCount, * 
			FROM ' +  @TableName + CASE WHEN @Filter IS NULL THEN '' ELSE ' WHERE  '+ @Filter END + ') YSPaged 
		WHERE YSRowNumber BETWEEN ' + CAST(((@PageNo - 1) * @PageSize + 1) AS NVARCHAR(50)) + ' AND ' +  CAST((@PageNo * @PageSize) AS NVARCHAR(50))
			
	
	RETURN @resultString
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09327', GetDate())
GO