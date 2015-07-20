IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Share_Sample_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Share_Sample_SELECT]
GO


CREATE PROCEDURE  dbo.spx_Share_Sample_SELECT(
	@TradePartnerID UNIQUEIDENTIFIER
)
AS
    
	SELECT '<img src="../System/Icons/icon_ball_blue.gif" />' AS IconPath,
		b.StyleNo + ' (' + b.SizeClass + ') ' +  b.Description AS Style,
		a.SampleRequestTradeID, a.CDate, a.TradePartnerID,  a.StyleColorID,  b.StyleID, b.StyleNo,  
		b.Description, b.SizeClass, b.DevelopmentId
	FROM  dbo.pSampleRequestTrade a WITH(NOLOCK)
		INNER JOIN dbo.pStyleHeader b WITH(NOLOCK)  ON a.StyleID=  b.StyleID 
	WHERE a.TradePartnerID = @TradePartnerId  
		AND a.SampleRequestShare = 1 
	ORDER BY a.CDate
  
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01365', GetDate())
GO

    