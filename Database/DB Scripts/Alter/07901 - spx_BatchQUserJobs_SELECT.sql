/****** Object:  StoredProcedure [dbo].[spx_BatchQUserJobs_SELECT]    Script Date: 06/05/2014 11:36:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQUserJobs_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQUserJobs_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQUserJobs_SELECT]    Script Date: 06/05/2014 11:36:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQUserJobs_SELECT] (
	@TeamID UNIQUEIDENTIFIER,
	@srmOn INT = 0 
)
AS

IF @srmOn = 0
BEGIN
	DECLARE @Amount INT

	SELECT @Amount = COUNT(*)
	FROM dbo.cDeskUserFolderAccess
	WHERE DeskFolderId = '18' AND DeskAccessId = '1' AND TeamId = @TeamID

	IF @Amount > 0
	BEGIN
		SELECT DISTINCT foo.*
		FROM (
			SELECT a.Description, a.BatchQueueJobID, a.BatchQueueID,
				a.BatchQueueJobDate, a.BatchQueueJobTeamID, a.BatchQueueJobStatusID,
				a.BatchQueueJobCompleted, b.BatchQueueTypeID, b.BatchQueueName,
				b.BatchQueueDesc, b.BatchQueueUrl, b.BatchQueueIcon,
				b.BatchQueuePageHistoryUrl, c.BatchQueuePageID,c.BatchQueuePageTypeID,
				c.BatchQueuePageOrder, d.BatchQueuePageUrl, e.STATUS
			FROM dbo.pBatchQueueJob a WITH (NOLOCK)
			INNER JOIN dbo.pBatchQueue b WITH (NOLOCK) ON a.BatchQueueID = b.BatchQueueID
			INNER JOIN dbo.pBatchQueuePage c WITH (NOLOCK) ON b.BatchQueueID = c.BatchQueueID
			INNER JOIN dbo.pBatchQueuePageType d WITH (NOLOCK) ON c.BatchQueuePageTypeID = d.BatchQueuePageTypeID
			LEFT OUTER JOIN dbo.pBatchQueueJobStatus e WITH (NOLOCK) ON e.BatchQueueJobStatusID = a.BatchQueueJobStatusID
			WHERE c.BatchQueuePageOrder = '0000'
				AND a.BatchQueueJobTeamID = @TeamID
				AND e.BatchQueueJobStatusID <> '20000000-0000-0000-0000-000000000000'
			
			UNION
			
			SELECT -- Removing IDs of BatchQueueJob items and grouping by BatchQueue items, according to WI #13006.
				-- To rollback the changes, remove the Group By clause
				-- and return flat attributes from pBatchQueueJob (a) instead of NULL values and aggregate functions
				COUNT(*) AS Description, NULL AS BatchQueueJobID, a.BatchQueueID,
				MAX(a.BatchQueueJobDate) AS BatchQueueJobDate, a.BatchQueueJobTeamID, a.BatchQueueJobStatusID,
				a.BatchQueueJobCompleted, b.BatchQueueTypeID, b.BatchQueueName,
				b.BatchQueueDesc, b.BatchQueueUrl, b.BatchQueueIcon,
				b.BatchQueuePageHistoryUrl, c.BatchQueuePageID, c.BatchQueuePageTypeID,
				c.BatchQueuePageOrder, d.BatchQueuePageUrl, e.STATUS
			FROM pBatchQueueJob a
			INNER JOIN dbo.pBatchQueuePage c ON a.BatchQueueID = c.BatchQueueID
			INNER JOIN (
				SELECT BatchQueueID, MAX(BatchQueuePageOrder) AS BatchQueuePageOrder
				FROM dbo.pBatchQueuePage
				GROUP BY BatchQueueID
				) AS foo ON foo.BatchQueueID = c.BatchQueueID
				AND foo.BatchQueuePageOrder = c.BatchQueuePageOrder
			INNER JOIN dbo.pBatchQueue b WITH (NOLOCK) ON b.BatchQueueID = a.BatchQueueID
			LEFT OUTER JOIN dbo.pBatchQueuePageType d WITH (NOLOCK) ON d.BatchQueuePageTypeID = c.BatchQueuePageTypeID
			INNER JOIN dbo.pBatchQueueJobStatus e WITH (NOLOCK) ON e.BatchQueueJobStatusID = a.BatchQueueJobStatusID
			WHERE a.BatchQueueJobTeamID = @TeamID
				AND a.BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
			GROUP BY a.BatchQueueID, a.BatchQueueJobTeamID, a.BatchQueueJobStatusID,
				a.BatchQueueJobCompleted, b.BatchQueueTypeID, b.BatchQueueName,
				b.BatchQueueDesc, b.BatchQueueUrl, b.BatchQueueIcon,
				b.BatchQueuePageHistoryUrl, c.BatchQueuePageID, c.BatchQueuePageTypeID,
				c.BatchQueuePageOrder, d.BatchQueuePageUrl, e.STATUS
			) AS foo
		INNER JOIN fnx_Permissions_GetGuidProductType_WorkflowPermissions(@TeamID, 18, NULL) access
		ON access.WorkflowId = foo.BatchQueueID AND access.ProductTypeID = foo.BatchQueueTypeID
		WHERE access.PermissionRoleId = 3
		ORDER BY foo.BatchQueueJobDate DESC
	END
	ELSE
	BEGIN
		SELECT DISTINCT b.* FROM pBatchQueue b WITH (NOLOCK) WHERE b.BatchQueueID IS NULL		
	END
END
ELSE
BEGIN
	SELECT DISTINCT foo.* FROM ( 
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
		WHERE c.BatchQueuePageOrder = '0000'
			AND a.BatchQueueJobTeamID = @TeamID
			AND e.BatchQueueJobStatusID <> '20000000-0000-0000-0000-000000000000'

	UNION

		SELECT 	
			a.Description, a.BatchQueueJobID, a.BatchQueueID, a.BatchQueueJobDate, 
			a.BatchQueueJobTeamID, a.BatchQueueJobStatusID, a.BatchQueueJobCompleted,
			b.BatchQueueTypeID, b.BatchQueueName, b.BatchQueueDesc, b.BatchQueueUrl, 
			b.BatchQueueIcon, b.BatchQueuePageHistoryUrl,
			c.BatchQueuePageID, c.BatchQueuePageTypeID, c.BatchQueuePageOrder,
			d.BatchQueuePageUrl, e.Status
		FROM pBatchQueueJob a 
			INNER JOIN dbo.pBatchQueuePage c ON a.BatchQueueID = c.BatchQueueID
			INNER JOIN ( 
					SELECT BatchQueueID, MAX(BatchQueuePageOrder) AS BatchQueuePageOrder
					FROM dbo.pBatchQueuePage 
					GROUP BY BatchQueueID
			) AS foo ON foo.BatchQueueID = c.BatchQueueID 
						AND foo.BatchQueuePageOrder = c.BatchQueuePageOrder
			INNER JOIN dbo.pBatchQueue b WITH(NOLOCK) ON b.BatchQueueID = a.BatchQueueID 
			LEFT OUTER JOIN dbo.pBatchQueuePageType d WITH(NOLOCK) ON d.BatchQueuePageTypeID = c.BatchQueuePageTypeID
			INNER JOIN dbo.pBatchQueueJobStatus e WITH(NOLOCK) ON e.BatchQueueJobStatusID = a.BatchQueueJobStatusID	
		WHERE a.BatchQueueJobTeamID = @TeamID
			AND a.BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
	) AS foo 
	ORDER BY foo.BatchQueueJobDate DESC
END





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07901', GetDate())
GO
