/****** Object:  StoredProcedure [dbo].[spx_BatchQ_SELECT]    Script Date: 06/04/2014 10:37:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQ_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQ_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQ_SELECT]    Script Date: 06/04/2014 10:37:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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
		INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 18) c ON c.ProductTypeId = b.BatchQueueTypeID
		INNER JOIN fnx_Permissions_GetGuidProductType_WorkflowPermissions(@TeamID, 18, NULL) a ON a.WorkflowId = b.BatchQueueID
		WHERE a.PermissionRoleId = 3 AND c.PermissionRoleId = 3
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
VALUES ('DB_Version', '0.5.0000', '07853', GetDate())
GO