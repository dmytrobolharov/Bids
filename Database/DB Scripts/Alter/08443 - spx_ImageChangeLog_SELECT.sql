IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageChangeLog_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageChangeLog_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ImageChangeLog_SELECT](
	@ImageID UNIQUEIDENTIFIER, 
	@WorkflowID UNIQUEIDENTIFIER)
AS

SELECT ic.ImageChangeID, ic.ImageChangeNo, ic.ImageChangeType, 
	'*By ' + ic.ImageChangeBy + ' @ ' 
	+ CONVERT(NVARCHAR(100) ,ic.ImageChangeDate , 101 ) + '<br />' 
	+ ISNULL(ic.ImageChangeDescription,'') AS ImageChangeDescription,
	CASE WHEN ic.Active = 1  
		THEN '<img src="../System/Icons/icon_ball_green_flash.gif" alt="" />'
		ELSE '<img src="../System/Icons/icon_ball_gray.gif" alt="" />'
	END AS Icon, 
	ic.ImageChangeNotifyTo, ic.ImageChangeBy, ic.ImageChangeDate
FROM pImageChange ic WITH(NOLOCK)
WHERE ic.ImageID = @ImageID
	AND ic.ImageWorkflowTemplateItemID = @WorkflowID
ORDER BY ic.ImageChangeNo DESC



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08443', GetDate())
GO
