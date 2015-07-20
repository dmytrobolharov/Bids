IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_UserGroupDropDown_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_UserGroupDropDown_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_UserGroupDropDown_SELECT]
AS
BEGIN
	SELECT * FROM vwx_UserGroupDropDown_SEL ORDER BY UserType, Fullname
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06323', GetDate())
GO
