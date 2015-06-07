IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style3DFileName_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style3DFileName_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Style3DFileName_SELECT]
(
	@Style3DFileID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT Style3DFileName
	FROM pStyle3DFiles
	WHERE Style3DFileID = @Style3DFileID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09669', GetDate())
GO