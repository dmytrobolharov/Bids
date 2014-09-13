IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromColor_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromColor_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_TACalReferenceFromColor_DELETE] (
	@TACalTemplateID UNIQUEIDENTIFIER,
	@ColorFolderID UNIQUEIDENTIFIER
)
AS 

DECLARE @FolderID INT
DECLARE @TACalReferenceId UNIQUEIDENTIFIER

SELECT @TACalReferenceId = TACalReferenceId FROM pTACalReference WHERE TACalTemplateId=@TACalTemplateID AND ReferenceId = @ColorFolderID

DELETE FROM pTACalReferenceTask WHERE TACalReferenceId = @TACalReferenceId
DELETE FROM pTACalReference WHERE TACalTemplateId=@TACalTemplateID AND ReferenceId = @ColorFolderID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08618', GetDate())
GO


