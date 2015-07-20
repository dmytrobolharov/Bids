IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Share_TechPack_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Share_TechPack_SELECT]
GO


CREATE PROCEDURE  dbo.spx_Share_TechPack_SELECT(
	@TradePartnerID UNIQUEIDENTIFIER
)
AS


	SELECT 
		'<img src="../System/Icons/icon_package.gif" />' AS IconPath,
		b.StyleNo + ' (' + b.SizeClass + ') ' +  b.Description AS Style,
		a.StyleId,  b.StyleNo, b.Description, b.SizeClass, a.TechPackId, c.CDate, b.DevelopmentId  
	FROM pTechPackTeam a WITH(NOLOCK) 
		INNER JOIN pStyleHeader b WITH(NOLOCK) ON a.StyleId  = b.StyleID
		INNER JOIN pTechPack c WITH(NOLOCK) ON a.TechPackID = c.TechPackID
    WHERE a.TeamID = @TradePartnerID 
    ORDER BY c.CDate 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01363', GetDate())
GO

    