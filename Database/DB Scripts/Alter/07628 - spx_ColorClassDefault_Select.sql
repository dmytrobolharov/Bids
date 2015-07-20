IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorClassDefault_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorClassDefault_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ColorClassDefault_SELECT]
AS

SELECT ColorClassID FROM pColorClass WHERE ColorClassDefault = 1

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07628', GetDate())
GO