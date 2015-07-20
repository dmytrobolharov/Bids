/****** Object:  StoredProcedure [dbo].[spx_BatchQUserJobsByStatus_SELECT]    Script Date: 06/03/2014 20:08:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQUserJobsByStatus_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQUserJobsByStatus_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQUserJobsByStatus_SELECT]    Script Date: 06/03/2014 20:08:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Stepa
-- Create date: 10.07.2012
-- Description:	Creates the dataset of BatchQ jobs with given job status and TeamID
-- =============================================
CREATE PROCEDURE [dbo].[spx_BatchQUserJobsByStatus_SELECT]
	-- Add the parameters for the stored procedure here
	@TeamID UNIQUEIDENTIFIER, 
	@BatchQueueJobStatusID UNIQUEIDENTIFIER = NULL,
	@WhereCondition NVARCHAR(MAX) = ''
AS

DECLARE @Amount int
select @Amount=COUNT(*)  from dbo.cDeskUserFolderAccess WHERE DeskFolderId='18' AND DeskAccessId='1' AND TeamId=@TeamID

IF @Amount>0 
BEGIN

	IF Not (@BatchQueueJobStatusID is NULL)
	BEGIN
		SELECT DISTINCT foo.* INTO #tempBatchQJob FROM ( 
			SELECT 
				a.Description, a.BatchQueueJobID, a.BatchQueueID, a.BatchQueueJobDate, 
				a.BatchQueueJobTeamID, a.BatchQueueJobStatusID, a.BatchQueueJobCompleted,
				 
				b.BatchQueueTypeID, b.BatchQueueName, b.BatchQueueDesc, b.BatchQueueUrl, 
				b.BatchQueueIcon, b.BatchQueuePageHistoryUrl,
				
				c.BatchQueuePageID, c.BatchQueuePageTypeID, c.BatchQueuePageOrder, 
				d.BatchQueuePageUrl, e.Status
				
			FROM dbo.pBatchQueueJob a WITH(NOLOCK)
				INNER JOIN dbo.pBatchQueue b WITH(NOLOCK) ON a.BatchQueueID = b.BatchQueueID 
				INNER JOIN dbo.pBatchQueuePage c WITH(NOLOCK) ON b.BatchQueueID = c.BatchQueueID 
				INNER JOIN dbo.pBatchQueuePageType d WITH(NOLOCK) ON c.BatchQueuePageTypeID = d.BatchQueuePageTypeID
				LEFT OUTER JOIN dbo.pBatchQueueJobStatus e WITH(NOLOCK) ON e.BatchQueueJobStatusID = a.BatchQueueJobStatusID
			WHERE     c.BatchQueuePageOrder = '0000'
				AND a.BatchQueueJobTeamID = @TeamID
				AND a.BatchQueueJobStatusID = @BatchQueueJobStatusID
		) AS foo
		INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 18) c ON c.ProductTypeId = foo.BatchQueueTypeID
		INNER JOIN fnx_Permissions_GetGuidProductType_WorkflowPermissions(@TeamID, 18, NULL) a ON a.WorkflowId = foo.BatchQueueID
		WHERE a.PermissionRoleId = 3 AND c.PermissionRoleId = 3
		ORDER BY foo.BatchQueueJobDate DESC

		EXEC('SELECT * FROM #tempBatchQJob ' + @WhereCondition)
		
		DROP TABLE #tempBatchQJob
		
	END
	ELSE
	BEGIN
	SELECT DISTINCT foo.* INTO #anotherTempBatchQJob FROM ( 
			SELECT 
				a.Description, a.BatchQueueJobID, a.BatchQueueID, a.BatchQueueJobDate, 
				a.BatchQueueJobTeamID, a.BatchQueueJobStatusID, a.BatchQueueJobCompleted,
				 
				b.BatchQueueTypeID, b.BatchQueueName, b.BatchQueueDesc, b.BatchQueueUrl, 
				b.BatchQueueIcon, b.BatchQueuePageHistoryUrl,
				
				c.BatchQueuePageID, c.BatchQueuePageTypeID, c.BatchQueuePageOrder, 
				d.BatchQueuePageUrl, e.Status
				
			FROM dbo.pBatchQueueJob a WITH(NOLOCK)
				INNER JOIN dbo.pBatchQueue b WITH(NOLOCK) ON a.BatchQueueID = b.BatchQueueID 
				INNER JOIN dbo.pBatchQueuePage c WITH(NOLOCK) ON b.BatchQueueID = c.BatchQueueID 
				INNER JOIN dbo.pBatchQueuePageType d WITH(NOLOCK) ON c.BatchQueuePageTypeID = d.BatchQueuePageTypeID
				LEFT OUTER JOIN dbo.pBatchQueueJobStatus e WITH(NOLOCK) ON e.BatchQueueJobStatusID = a.BatchQueueJobStatusID
			WHERE     c.BatchQueuePageOrder = '0000'
				AND a.BatchQueueJobTeamID = @TeamID
		) AS foo 
			INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 18) c ON c.ProductTypeId = foo.BatchQueueTypeID
		INNER JOIN fnx_Permissions_GetGuidProductType_WorkflowPermissions(@TeamID, 18, NULL) a ON a.WorkflowId = foo.BatchQueueID
		WHERE a.PermissionRoleId = 3 AND c.PermissionRoleId = 3
		ORDER BY foo.BatchQueueJobDate DESC
		
		EXEC('SELECT * FROM #anotherTempBatchQJob ' + @WhereCondition)
		
		DROP TABLE #anotherTempBatchQJob
	END
END
ELSE
	BEGIN
		SELECT DISTINCT a.*, b.*, c.*, d.*, e.* 
		FROM pBatchQueue b, pBatchQueuePage c, pBatchQueueJob a, pBatchQueuePageType d, dbo.pBatchQueueJobStatus e
		WITH(NOLOCK) WHERE b.BatchQueueID is NULL
	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07831', GetDate())
GO
