IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_StyleType_SELECT]'))
DROP VIEW [dbo].[vwx_Sourcing_StyleType_SELECT]
GO

CREATE VIEW [dbo].[vwx_Sourcing_StyleType_SELECT]
AS
SELECT TOP 100 PERCENT
	st.StyleTypeID
	, st.StyleTypeDescription
	, shst.SourcingHeaderID
FROM pStyleType st
	INNER JOIN pSourcingHeaderToStyleType shst ON st.StyleTypeID = shst.StyleTypeID
ORDER BY StyleTypeOrder

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10399', GetUTCDate())
GO
