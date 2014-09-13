IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestTradePartners_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestTradePartners_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestTradePartners_SELECT]
	@SearchCond NVARCHAR(MAX) = N''
AS
BEGIN
	SELECT *
	INTO #tmpPartners
	FROM vwx_TradePartnerMgmt_SEL
	ORDER BY
		CASE WHEN AgentName IS NULL	THEN 1 ELSE 0 END
		, AgentName
		, VendorName
		, FactoryName

	EXEC ('SELECT * FROM #tmpPartners ' + @SearchCond)

	DROP TABLE #tmpPartners
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06330', GetDate())
GO
