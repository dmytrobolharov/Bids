/****** Object:  StoredProcedure [dbo].[spx_BatchQType_SELECT]    Script Date: 06/05/2014 13:20:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQType_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQType_SELECT]    Script Date: 06/05/2014 13:20:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQType_SELECT](
	@TeamID UNIQUEIDENTIFIER = NULL,
	@srmOn INT = 0
)
AS 

IF @srmOn = 0 
	SELECT DISTINCT a.* 
	FROM pBatchQueueType a WITH(NOLOCK)
		INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 18) access ON access.ProductTypeId = a.BatchQueueTypeID
	WHERE access.PermissionRoleId <> 0
ELSE 
	SELECT * FROM dbo.pBatchQueueType WITH(NOLOCK) WHERE srmOn = 1


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07900', GetDate())
GO
