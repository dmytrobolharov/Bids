IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHistory_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleHistory_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleHistory_SELECT](
	@TeamId UNIQUEIDENTIFIER
)
AS 

	SELECT a.StyleId, b.StyleNo, b.[Description] 
	FROM pStyleHistory a WITH (NOLOCK) 
		INNER JOIN pStyleHeader b WITH (NOLOCK) ON a.StyleID =  b.StyleID
	WHERE a.TeamID = @TeamID
	ORDER BY a.CDate DESC


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01283', GetDate())
GO