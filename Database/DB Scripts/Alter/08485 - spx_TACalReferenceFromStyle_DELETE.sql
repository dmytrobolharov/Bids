IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromStyle_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromStyle_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_TACalReferenceFromStyle_DELETE](
 @TACalTemplateID uniqueidentifier,
 @StyleID uniqueidentifier
)

AS 

DECLARE @FolderID integer
DECLARE @TACalReferenceId uniqueidentifier

SELECT @TACalReferenceId = TACalReferenceId FROM pTACalReference WHERE TACalTemplateId=@TACalTemplateID AND ReferenceId = @StyleID

DELETE FROM pTACalReferenceTask WHERE TACalReferenceId = @TACalReferenceId
DELETE FROM pTACalReference WHERE TACalTemplateId=@TACalTemplateID AND ReferenceId = @StyleID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08485', GetDate())
GO


