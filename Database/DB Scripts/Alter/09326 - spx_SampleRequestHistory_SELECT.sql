IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestHistory_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestHistory_SELECT]
(@TeamId UNIQUEIDENTIFIER)
AS
BEGIN
	SELECT
		hsh.SampleRequestTradeID
		, hsh.CDate
		, hsh.StyleID
		, sh.StyleNo
		, sh.Description
		, tp.TradePartnerCode AS VendorCode
	FROM hSampleHistory hsh
		INNER JOIN pStyleHeader sh ON hsh.StyleId = sh.StyleID
		INNER JOIN uTradePartner tp ON hsh.TeamId = tp.TradePartnerID
		INNER JOIN pSampleRequestShare srs ON hsh.SampleRequestTradeId = srs.SampleRequestTradeID
			AND hsh.TeamId = srs.TradePartnerID
	WHERE hsh.TeamId = @TeamID
	ORDER BY hsh.CDate
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09326', GetDate())
GO
