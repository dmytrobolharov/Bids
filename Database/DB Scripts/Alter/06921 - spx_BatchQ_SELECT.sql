IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQ_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQ_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQ_SELECT](
	@TeamID UNIQUEIDENTIFIER = NULL,
	@srmOn INT = 0
)
AS 

IF @srmOn = 0 
BEGIN
	DECLARE @Amount INT

	SELECT @Amount = COUNT(*) FROM dbo.cDeskUserFolderAccess
	WHERE DeskFolderId = '18' AND DeskAccessId = '1' AND TeamId = @TeamID


	IF @Amount > 0
	BEGIN
		SELECT DISTINCT b.*
		FROM pBatchQueue b WITH (NOLOCK)
		INNER JOIN sAccessBatchQFolderItems a WITH (NOLOCK) ON a.BatchQueueID = b.BatchQueueID
		INNER JOIN sAccessBatchQFolder c WITH (NOLOCK) ON c.BatchQTypeId = b.BatchQueueTypeID
		WHERE a.TeamID = @TeamID
			AND a.AccessRoleId = 3
			AND c.AccessRoleId = 3
			AND ISNULL(b.srmOn, 0) = 0
	END
	ELSE
	BEGIN
		SELECT DISTINCT b.*
		FROM pBatchQueue b WITH (NOLOCK)
		WHERE b.BatchQueueID IS NULL
	END
END
ELSE
	SELECT * FROM dbo.pBatchQueue a WITH(NOLOCK) WHERE srmOn = 1


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06921', GetDate())
GO
