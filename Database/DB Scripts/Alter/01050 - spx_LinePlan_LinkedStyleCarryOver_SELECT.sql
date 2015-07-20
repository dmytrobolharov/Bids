IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_LinkedStyleCO_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_LinkedStyleCO_SELECT]
GO


CREATE PROCEDURE dbo.spx_LinePlan_LinkedStyleCO_SELECT(
@StyleID UNIQUEIDENTIFIER 
)
AS 

	SELECT  b.* 
	FROM pStyleHeader a WITH(NOLOCK)
		INNER JOIN pStyleHeader b WITH(NOLOCK) ON a.StyleLinkID =  b.StyleLinkID 
	WHERE a.StyleID = @StyleID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01050', GetDate())
GO


