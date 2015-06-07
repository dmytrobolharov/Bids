IF OBJECT_ID(N'[dbo].[spx_TechPackWorkflowItem_DELETE]') IS NOT NULL
	DROP PROCEDURE [dbo].[spx_TechPackWorkflowItem_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_TechPackWorkflowItem_DELETE] (
	@TechPackID UNIQUEIDENTIFIER 
)
AS
BEGIN

	DELETE FROM pTechPackWorkflowItem WHERE TechPackID = @TechPackID

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10402', GetUTCDate())
GO