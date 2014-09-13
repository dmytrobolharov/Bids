IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolderChangeLog_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolderChangeLog_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ColorFolderChangeLog_SELECT](
	@ColorFolderID UNIQUEIDENTIFIER, 
	@WorkflowID UNIQUEIDENTIFIER)
AS

SELECT cfc.ColorFolderChangeID, cfc.ColorFolderChangeNo, cfc.ColorFolderChangeType, 
	'*By ' + cfc.ColorFolderChangeBy + ' @ ' 
	+ CONVERT(NVARCHAR(100), cfc.ColorFolderChangeDate , 101 ) + '<br />' 
	+ ISNULL(cfc.ColorFolderChangeDescription,'') AS ColorFolderChangeDescription,
	CASE WHEN cfc.Active = 1  
		THEN '<img src="../System/Icons/icon_ball_green_flash.gif" alt="" />'
		ELSE '<img src="../System/Icons/icon_ball_gray.gif" alt="" />'
	END AS Icon, 
	cfc.ColorFolderChangeNotifyTo, cfc.ColorFolderChangeBy, cfc.ColorFolderChangeDate
FROM pColorFolderChange cfc WITH(NOLOCK)
WHERE cfc.ColorFolderID = @ColorFolderID
	AND cfc.ColorFolderWorkflowID = @WorkflowID
ORDER BY cfc.ColorFolderChangeNo DESC




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08498', GetDate())
GO
