IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE ALL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DELETE ALL]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07241', GetDate())
GO

