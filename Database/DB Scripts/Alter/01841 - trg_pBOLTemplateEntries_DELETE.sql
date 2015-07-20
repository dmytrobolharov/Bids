IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[pBOLTemplateEntries_DELETE]'))
DROP TRIGGER [dbo].[pBOLTemplateEntries_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[pBOLTemplateEntries_DELETE]
   ON  [dbo].[pBOLTemplateEntries]
   AFTER DELETE
AS 
IF @@ROWCOUNT=1
BEGIN
	DECLARE @TemplateId UNIQUEIDENTIFIER
	DECLARE @Sort_del INT
	SELECT @TemplateId = TemplateId, @Sort_del = CAST (Sort AS INT) FROM deleted
	UPDATE pBOLTemplateEntries SET Sort = RIGHT ('00000' +  CAST (CAST (Sort AS INT) - 1 AS NVARCHAR (5)), 5) 
		WHERE CAST (Sort AS INTEGER) > @Sort_del AND TemplateId = @TemplateId
END


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01841'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01841', GetDate())
END

GO
