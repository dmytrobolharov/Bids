IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style3DFiles_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style3DFiles_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Style3DFiles_SELECT]
(
	@WorkflowItemID UNIQUEIDENTIFIER
	, @isSRM INT = NULL
	, @PageNo INT = NULL
	, @PageSize INT = NULL
	, @SqlFilter NVARCHAR(MAX) = NULL	
	, @SortOrder NVARCHAR(MAX) = NULL
)
AS
BEGIN

	SELECT *
	INTO #tmp0
	FROM pStyle3DFiles
	WHERE WorkflowItemID = @WorkflowItemID
		AND (Style3DFileShared = @isSRM OR @isSRM IS NULL)
		
	DECLARE @sqlString NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp0', @PageNo, @PageSize, @SortOrder, @SqlFilter)
	EXEC sp_executesql @sqlString
	
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10210', GetUTCDate())
GO
