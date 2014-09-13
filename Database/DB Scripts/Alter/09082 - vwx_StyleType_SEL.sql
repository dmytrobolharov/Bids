IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleType_SEL]'))
DROP VIEW [dbo].[vwx_StyleType_SEL]
GO

CREATE VIEW [dbo].[vwx_StyleType_SEL]
AS

SELECT st.StyleTypeID
	, st.StyleTypeRepId
	, st.StyleType
	, st.StyleTypeDescription
	, d.CustomID
FROM pStyleType st
INNER JOIN pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID
INNER JOIN iCustom1 d ON dst.DivisionID = d.CustomID

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09082', GetDate())
GO