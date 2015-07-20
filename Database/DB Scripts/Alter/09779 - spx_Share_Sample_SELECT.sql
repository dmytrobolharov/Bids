IF OBJECT_ID(N'[dbo].[spx_Share_Sample_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_Share_Sample_SELECT]
GO

CREATE PROCEDURE  [dbo].[spx_Share_Sample_SELECT](
	@TradePartnerID UNIQUEIDENTIFIER
)
AS
    
	SELECT '<img src="../System/Icons/icon_ball_blue.gif" />' AS IconPath,
		b.StyleNo + ' (' + COALESCE(sc.Custom, b.SizeClass) + ') ' +  b.Description AS Style,
		a.SampleRequestTradeID, a.CDate, a.TradePartnerID,  a.StyleColorID,  b.StyleID, b.StyleNo,  
		b.Description, COALESCE(sc.Custom, b.SizeClass) AS SizeClass, b.DevelopmentId
	FROM  dbo.pSampleRequestTrade a WITH(NOLOCK)
		INNER JOIN dbo.pStyleHeader b WITH(NOLOCK)  ON a.StyleID=  b.StyleID 
		LEFT JOIN pSizeClass sc ON sc.Custom = b.SizeClass
	WHERE a.TradePartnerID = @TradePartnerId  
		AND a.SampleRequestShare = 1 
	ORDER BY a.CDate
  

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09779', GetDate())
GO
