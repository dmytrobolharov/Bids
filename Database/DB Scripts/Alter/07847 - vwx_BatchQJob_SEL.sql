/****** Object:  View [dbo].[vwx_BatchQJob_SEL]    Script Date: 06/03/2014 12:31:41 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQJob_SEL]'))
DROP VIEW [dbo].[vwx_BatchQJob_SEL]
GO

/****** Object:  View [dbo].[vwx_BatchQJob_SEL]    Script Date: 06/03/2014 12:31:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE VIEW [dbo].[vwx_BatchQJob_SEL]
AS

SELECT DISTINCT TOP (100) PERCENT  foo.* FROM ( 
	SELECT     
		a.BatchQueueJobID, a.BatchQueueID, a.BatchQueueJobDate, 
		a.BatchQueueJobTeamID, a.BatchQueueJobStatusID, a.BatchQueueJobCompleted, 
		b.BatchQueueTypeID, b.BatchQueueName, b.BatchQueueDesc, b.BatchQueueUrl, 
		b.BatchQueueIcon, c.BatchQueuePageID, c.BatchQueuePageTypeID, 
		c.BatchQueuePageOrder, d.BatchQueuePageUrl, e.Status, a.Description, b.BatchQueuePageHistoryUrl
	FROM dbo.pBatchQueueJob a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueue b WITH(NOLOCK) ON a.BatchQueueID = b.BatchQueueID 
		INNER JOIN dbo.pBatchQueuePage c WITH(NOLOCK) ON b.BatchQueueID = c.BatchQueueID 
		INNER JOIN dbo.pBatchQueuePageType d WITH(NOLOCK) ON c.BatchQueuePageTypeID = d.BatchQueuePageTypeID
		LEFT OUTER JOIN dbo.pBatchQueueJobStatus e WITH(NOLOCK) ON e.BatchQueueJobStatusID = a.BatchQueueJobStatusID
	WHERE  c.BatchQueuePageOrder = '0000'
		AND a.BatchQueueJobStatusID <> '20000000-0000-0000-0000-000000000000'

	UNION 

	SELECT 	
		a.BatchQueueJobID, a.BatchQueueID, a.BatchQueueJobDate, 
		a.BatchQueueJobTeamID, a.BatchQueueJobStatusID, a.BatchQueueJobCompleted, 
		b.BatchQueueTypeID, b.BatchQueueName, b.BatchQueueDesc, b.BatchQueueUrl, 
		b.BatchQueueIcon, c.BatchQueuePageID, c.BatchQueuePageTypeID, 
		c.BatchQueuePageOrder, d.BatchQueuePageUrl, e.Status, a.Description, b.BatchQueuePageHistoryUrl
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
	WHERE a.BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
) AS foo 
CROSS APPLY fnx_Permissions_GetGuidProductType_WorkflowPermissions(foo.BatchQueueJobTeamID, 18, NULL) access
WHERE access.WorkflowId = foo.BatchQueueID AND access.PermissionRoleId <> 0
ORDER BY foo.BatchQueueJobDate DESC



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07847', GetDate())
GO