IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleChangeLog_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleChangeLog_SELECT]
GO

CREATE PROCEDURE dbo.spx_StyleChangeLog_SELECT(
	@StyleID UNIQUEIDENTIFIER, 
	@WorkflowID UNIQUEIDENTIFIER,
	@StyleSet INT
)
AS


IF @styleSet = 1 OR @StyleSet = 0
BEGIN
	SELECT a.StyleChangeID,a.StyleChangeNo, a.StyleChangeType, '*By ' + a.StyleChangeBy + ' @ ' +  
		CONVERT(NVARCHAR(100) ,a.StyleChangeDate , 101 ) + '</br>' 
		+  ISNULL(a.StyleChangeDescription,'') AS StyleChangeDescription,
		CASE WHEN a.Active = 1  THEN '<img src=''../System/Icons/icon_ball_green_flash.gif'' />'
			ELSE '<img src=''../System/Icons/icon_ball_gray.gif'' />'
		END AS Icon, a.StyleChangeNotifyTo, StyleChangeBy, StyleChangeDate
	FROM pStyleChange a WITH(NOLOCK)
	WHERE a.StyleID = @StyleID
		AND (a.StyleSet = 1 OR a.StyleSet  = 0)
		AND a.WorkflowID = @WorkflowID
	ORDER BY StyleChangeNo DESC
		
END
ELSE 
BEGIN
	SELECT a.StyleChangeID,a.StyleChangeNo, a.StyleChangeType, '*By ' + a.StyleChangeBy + ' @ ' +  
	CONVERT(NVARCHAR(100) ,a.StyleChangeDate , 101 ) + '</br>' 
	+ ISNULL(a.StyleChangeDescription,'') AS StyleChangeDescription,
		CASE WHEN a.Active = 1  THEN '<img src=''../System/Icons/icon_ball_green_flash.gif'' />'
			ELSE '<img src=''../System/Icons/icon_ball_gray.gif'' />'
	END AS Icon, a.StyleChangeNotifyTo, StyleChangeBy, StyleChangeDate
	FROM pStyleChange a WITH(NOLOCK)
	WHERE a.StyleID = @StyleID
		AND a.StyleSet = @StyleSet
		AND a.WorkflowID = @WorkflowID
	ORDER BY StyleChangeNo DESC
	
END	

GO 
	
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01265', GetDate())
GO
