
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_xCustom8')
DROP VIEW vwx_xCustom8
GO

CREATE VIEW [dbo].[vwx_xCustom8]
AS
SELECT     Custom, Custom AS CustomKey
FROM         dbo.xCustom8
------
GO

----
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '547', GetDate())
GO