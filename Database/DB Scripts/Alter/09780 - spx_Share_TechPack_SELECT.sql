IF OBJECT_ID(N'[dbo].[spx_Share_TechPack_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_Share_TechPack_SELECT]
GO

CREATE PROCEDURE  [dbo].[spx_Share_TechPack_SELECT](
	@TradePartnerID UNIQUEIDENTIFIER
)
AS


	SELECT 
		'<img src="../System/Icons/icon_package.gif" />' AS IconPath,
		b.StyleNo + ' (' + COALESCE(sc.Custom, b.SizeClass) + ') ' +  b.Description AS Style,
		a.StyleId,  b.StyleNo, b.Description, COALESCE(sc.Custom, b.SizeClass) AS SizeClass, 
		a.TechPackId, c.CDate, b.DevelopmentId  
	FROM pTechPackTeam a WITH(NOLOCK) 
		INNER JOIN pStyleHeader b WITH(NOLOCK) ON a.StyleId  = b.StyleID
		INNER JOIN pTechPack c WITH(NOLOCK) ON a.TechPackID = c.TechPackID
		LEFT JOIN pSizeClass sc ON sc.Custom = b.SizeClass
    WHERE a.TeamID = @TradePartnerID 
    ORDER BY c.CDate 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09780', GetDate())
GO
