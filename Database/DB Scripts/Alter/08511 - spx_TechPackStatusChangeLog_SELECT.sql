IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackStatusChangeLog_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackStatusChangeLog_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TechPackStatusChangeLog_SELECT](
	@StyleID UNIQUEIDENTIFIER, 
	@SeasonYearID UNIQUEIDENTIFIER)
AS

SELECT stpc.StyleTechPackChangeID, stpc.StyleTechPackChangeNo, stpc.StyleTechPackChangeType, 
	'*By ' + stpc.StyleTechPackChangeBy + ' @ ' 
	+ CONVERT(NVARCHAR(100), stpc.StyleTechPackChangeDate , 101 ) + '<br />' 
	+ ISNULL(stpc.StyleTechPackChangeDescription,'') AS StyleTechPackChangeDescription,
	CASE WHEN stpc.Active = 1  
		THEN '<img src="../System/Icons/icon_ball_green_flash.gif" alt="" />'
		ELSE '<img src="../System/Icons/icon_ball_gray.gif" alt="" />'
	END AS Icon, 
	stpc.StyleTechPackChangeNotifyTo, stpc.StyleTechPackChangeBy, stpc.StyleTechPackChangeDate
FROM pStyleTechPackChange stpc
INNER JOIN pStyleSeasonYear ssy ON stpc.StyleSeasonYearID = ssy.StyleSeasonYearID
WHERE stpc.StyleID = @StyleID AND ssy.SeasonYearID = @SeasonYearID
ORDER BY stpc.StyleTechPackChangeNo DESC





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08511', GetDate())
GO
