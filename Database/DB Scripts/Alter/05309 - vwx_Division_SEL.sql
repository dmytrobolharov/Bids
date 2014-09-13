IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Division_SEL]'))
DROP VIEW [dbo].[vwx_Division_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Division_SEL]
AS
SELECT     dbo.iCustom1.*, 
	STUFF(
		(SELECT ', ' + pStyleType.StyleTypeDescription
		FROM pDivisionStyleType LEFT JOIN pStyleType ON pDivisionStyleType.StyleTypeID = pStyleType.StyleTypeID
		WHERE pDivisionStyleType.DivisionID = iCustom1.CustomID
		FOR XML PATH('')), 1, 2, '') AS StyleTypes
FROM         dbo.iCustom1

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05309', GetDate())
GO
