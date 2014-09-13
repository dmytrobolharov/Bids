/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromStyle_DELETE]    Script Date: 08/21/2014 17:03:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromStyle_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromStyle_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromStyle_DELETE]    Script Date: 08/21/2014 17:03:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_TACalReferenceFromStyle_DELETE](
 @TACalTemplateID uniqueidentifier,
 @StyleID uniqueidentifier
)

AS 
BEGIN
	DECLARE @FolderID integer
	DECLARE @TACalReferenceId uniqueidentifier

	SELECT @TACalReferenceId = TACalReferenceId FROM pTACalReference WHERE TACalTemplateId=@TACalTemplateID AND ReferenceId = @StyleID

	DELETE FROM pTACalReferenceTask WHERE TACalReferenceId = @TACalReferenceId
	DELETE FROM pTACalReference WHERE TACalTemplateId=@TACalTemplateID AND ReferenceId = @StyleID

	-- Updating correspondent calendar records
	EXEC spx_TACalendar_StyleWorkflowReferences_Progress_UPDATE NULL, NULL, NULL, @TACalTemplateID
	EXEC spx_TACalendar_StyleTechPackWorkflowReferences_Progress_UPDATE NULL, NULL, @TACAlTemplateID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08930', GetDate())
GO
