IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ResourceLog_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ResourceLog_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ResourceLog_SELECT]
(@ResourceID uniqueidentifier)
AS 

SELECT     ResourceLogID, ResourceTypeID, ResourceID, TeamID, ResourceLog, ResourceLogType, CDate, CUser
FROM      pResourceLog WITH (NOLOCK)
WHERE     (ResourceID = @ResourceID)
ORDER BY CDate DESC

GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03602', GetDate())

GO

