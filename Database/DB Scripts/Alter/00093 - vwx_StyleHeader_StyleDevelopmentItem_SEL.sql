

/****** Object:  View [dbo].[vwx_StyleHeader_StyleDevelopmentItem_SEL]    Script Date: 05/06/2010 17:11:59 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleHeader_StyleDevelopmentItem_SEL]'))
DROP VIEW [dbo].[vwx_StyleHeader_StyleDevelopmentItem_SEL]
GO


CREATE VIEW [dbo].[vwx_StyleHeader_StyleDevelopmentItem_SEL]
AS
SELECT     pStyleHeader.*
FROM         dbo.pStyleHeader INNER JOIN
                      dbo.pStyleDevelopmentItem ON dbo.pStyleHeader.StyleID = dbo.pStyleDevelopmentItem.StyleID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '093', GetDate())
GO








