IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorClassSort_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorClassSort_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_ColorClassSort_UPDATE](
@ColorClassID uniqueidentifier,
@Sort nvarchar(200)
)
AS 

UPDATE pColorClass SET ColorClassSort = @Sort WHERE ColorClassID = @ColorClassID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07629', GetDate())
GO

