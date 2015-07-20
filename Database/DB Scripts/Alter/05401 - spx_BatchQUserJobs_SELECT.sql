/****** Object:  StoredProcedure [dbo].[spx_BatchQUserJobs_SELECT]    Script Date: 03/25/2013 18:27:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQUserJobs_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQUserJobs_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_BatchQUserJobs_SELECT]    Script Date: 03/25/2013 18:27:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



	
CREATE PROCEDURE [dbo].[spx_BatchQUserJobs_SELECT] (
	@TeamID UNIQUEIDENTIFIER
)
AS

DECLARE @Amount int
select @Amount=COUNT(*)  from dbo.cDeskUserFolderAccess WHERE DeskFolderId='18' AND DeskAccessId='1' AND TeamId=@TeamID

IF @Amount>0 
	Begin

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
	WHERE     c.BatchQueuePageOrder = '0000'
		AND a.BatchQueueJobTeamID = @TeamID
		AND e.BatchQueueJobStatusID <> '20000000-0000-0000-0000-000000000000'
	
	UNION
	
	SELECT 	-- Removing IDs of BatchQueueJob items and grouping by BatchQueue items, according to WI #13006.
			-- To rollback the changes, remove the Group By clause
			-- and return flat attributes from pBatchQueueJob (a) instead of NULL values and aggregate functions
		COUNT(*) AS Description, NULL AS BatchQueueJobID, a.BatchQueueID, MAX(a.BatchQueueJobDate) AS BatchQueueJobDate, 
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
				GROUP BY BatchQueueID) AS foo ON foo.BatchQueueID = c.BatchQueueID
					AND foo.BatchQueuePageOrder = c.BatchQueuePageOrder
		INNER JOIN dbo.pBatchQueue b WITH(NOLOCK) ON b.BatchQueueID = a.BatchQueueID 
		LEFT OUTER JOIN dbo.pBatchQueuePageType d WITH(NOLOCK) ON d.BatchQueuePageTypeID = c.BatchQueuePageTypeID
		INNER JOIN dbo.pBatchQueueJobStatus e WITH(NOLOCK) ON e.BatchQueueJobStatusID = a.BatchQueueJobStatusID	
	WHERE a.BatchQueueJobTeamID = @TeamID
		AND a.BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
	GROUP BY a.BatchQueueID, a.BatchQueueJobTeamID, a.BatchQueueJobStatusID, a.BatchQueueJobCompleted, 
			b.BatchQueueTypeID, b.BatchQueueName, b.BatchQueueDesc, b.BatchQueueUrl, b.BatchQueueIcon, b.BatchQueuePageHistoryUrl,
			c.BatchQueuePageID, c.BatchQueuePageTypeID, c.BatchQueuePageOrder,
			d.BatchQueuePageUrl, e.Status
		
		
) AS foo 
	INNER JOIN  sAccessBatchQFolderItems a ON a.BatchQueueID =  foo.BatchQueueID 
	INNER JOIN sAccessBatchQFolder c WITH(NOLOCK) ON c.BatchQTypeId =  foo.BatchQueueTypeID
WHERE a.AccessRoleId = 3 AND c.AccessRoleId = 3
ORDER BY foo.BatchQueueJobDate DESC
END
ELSE
	BEGIN
		SELECT DISTINCT b.* FROM pBatchQueue b  WITH(NOLOCK) WHERE b.BatchQueueID is NULL
	END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05401', GetDate())
GO
