/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromColor_DELETE]    Script Date: 08/20/2014 15:55:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromColor_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromColor_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromColor_DELETE]    Script Date: 08/20/2014 15:55:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_TACalReferenceFromColor_DELETE] (
	@TACalTemplateID UNIQUEIDENTIFIER,
	@ColorFolderID UNIQUEIDENTIFIER
)
AS 
BEGIN
	DECLARE @FolderID INT
	DECLARE @TACalReferenceId UNIQUEIDENTIFIER

	SELECT @TACalReferenceId = TACalReferenceId FROM pTACalReference WHERE TACalTemplateId=@TACalTemplateID AND ReferenceId = @ColorFolderID

	DELETE FROM pTACalReferenceTask WHERE TACalReferenceId = @TACalReferenceId
	DELETE FROM pTACalReference WHERE TACalTemplateId=@TACalTemplateID AND ReferenceId = @ColorFolderID
	
	EXEC spx_TACalendar_ColorWorkflowReferences_Progress_UPDATE NULL, @TACalTemplateID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08905', GetDate())
GO
