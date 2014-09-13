IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[pBOLOpToMacro_DELETE]'))
DROP TRIGGER [dbo].[pBOLOpToMacro_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[pBOLOpToMacro_DELETE] 
   ON  [dbo].[pBOLOpToMacro]
   AFTER DELETE
AS 
IF @@ROWCOUNT=1
BEGIN
	DECLARE @MacroId UNIQUEIDENTIFIER
	DECLARE @Sort_del INT
	SELECT @MacroId = MacroId, @Sort_del = CAST (Sort AS INT) FROM deleted
	UPDATE pBOLOpToMacro SET Sort = RIGHT ('00000' +  CAST (CAST (Sort AS INT) - 1 AS NVARCHAR (5)), 5) 
		WHERE CAST (Sort AS INTEGER) > @Sort_del AND MacroId = @MacroId
END


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01840'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01840', GetDate())
END

GO
