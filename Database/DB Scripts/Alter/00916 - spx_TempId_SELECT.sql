
/****** Object:  StoredProcedure [dbo].[spx_TempId_SELECT]    Script Date: 12/25/2010 02:02:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TempId_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TempId_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_TempId_SELECT]    Script Date: 12/25/2010 02:02:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE    PROCEDURE [dbo].[spx_TempId_SELECT]
(
@TempId varchar(50),
@TableName varchar(200)
)
AS 

BEGIN
	if exists (select * from dbo.sysobjects where id = object_id(N'#TempId'))
	DROP TABLE #TempId
END

BEGIN
	CREATE TABLE #TempId (
        [ID]		[int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[TempId]	[varchar] (50)  NULL,
		[TempNo]	[varchar] (50)  NULL)	
	CREATE INDEX idx_#TempID
	ON #TempID (TempID, TempNo)	
END

BEGIN
	EXEC ('INSERT INTO #TempId  (TempId, TempNo) SELECT TempID, TempNo FROM  ' + @TableName  + ' WHERE TempId = ''' + @TempId + '''' )
	EXEC ('INSERT INTO #TempId  (TempId, TempNo) SELECT TempID, TempNo FROM  sTempId WHERE TempId = ''' + @TempId + '''' )
END


SELECT MAX(CAST(TempNo as int)) AS TempNo, TempId  FROM #TempId GROUP BY TempId-- WHERE TempId = @TempId

DROP TABLE #TempId


GO


