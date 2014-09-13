IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialChangeLog_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialChangeLog_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialChangeLog_SELECT](
	@MaterialID UNIQUEIDENTIFIER, 
	@WorkflowID UNIQUEIDENTIFIER)
AS

SELECT mc.MaterialChangeID, mc.MaterialChangeNo, mc.MaterialChangeType, 
	'*By ' + mc.MaterialChangeBy + ' @ ' 
	+ CONVERT(NVARCHAR(100) ,mc.MaterialChangeDate , 101 ) + '<br />' 
	+ ISNULL(mc.MaterialChangeDescription,'') AS MaterialChangeDescription,
	CASE WHEN mc.Active = 1  
		THEN '<img src="../System/Icons/icon_ball_green_flash.gif" alt="" />'
		ELSE '<img src="../System/Icons/icon_ball_gray.gif" alt="" />'
	END AS Icon, 
	mc.MaterialChangeNotifyTo, mc.MaterialChangeBy, mc.MaterialChangeDate
FROM pMaterialChange mc WITH(NOLOCK)
WHERE mc.MaterialID = @MaterialID
	AND mc.MaterialWorkflowPageID = @WorkflowID
ORDER BY mc.MaterialChangeNo DESC


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08425', GetDate())
GO
