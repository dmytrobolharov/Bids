IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReference_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReference_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_TACalReference_DELETE](
 @TACalTemplateID uniqueidentifier
 ,@ProductID uniqueidentifier
)

AS 

DECLARE @TACalReferenceId uniqueidentifier
SELECT @TACalReferenceId = TACalReferenceId FROM pTACalReference WHERE TACalTemplateId = @TACalTemplateID AND ReferenceId = @ProductID

DELETE FROM pTACalReferenceTask WHERE TACalReferenceId = @TACalReferenceId
DELETE FROM pTACalReference WHERE TACalReferenceId = @TACalReferenceId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08523', GetDate())
GO
