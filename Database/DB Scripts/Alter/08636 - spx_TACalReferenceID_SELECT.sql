IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceID_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceID_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TACalReferenceID_SELECT]
	@TACalTemplateId UNIQUEIDENTIFIER,
	@ReferenceId UNIQUEIDENTIFIER
AS

SELECT TACalReferenceId
FROM pTACalReference
WHERE TACalTemplateId = @TACalTemplateId
	AND ReferenceId = @ReferenceId


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08636', GetDate())
GO
