IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorClassDefault_RESET]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorClassDefault_RESET]
GO


CREATE PROCEDURE [dbo].[spx_ColorClassDefault_RESET]
AS 

UPDATE pColorClass SET ColorClassDefault = 0

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07627', GetDate())
GO

