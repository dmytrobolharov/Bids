IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NBOLOperationFromMacro_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NBOLOperationFromMacro_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_NBOLOperationFromMacro_DELETE]
(@OpToMacroID uniqueidentifier)
AS
BEGIN
	DELETE FROM dbo.pNBOLOpToMacro WHERE OpToMacroId = @OpToMacroID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04600', GetDate())
GO
