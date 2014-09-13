/****** Object:  StoredProcedure [dbo].[spx_TACalReference_DELETE]    Script Date: 08/21/2014 13:38:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReference_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReference_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReference_DELETE]    Script Date: 08/21/2014 13:38:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_TACalReference_DELETE](
 @TACalTemplateID uniqueidentifier
 ,@ProductID uniqueidentifier
)

AS 
BEGIN
	DECLARE @FolderTypeID INT
	DECLARE @TACalReferenceId uniqueidentifier
	SELECT @TACalReferenceId = TACalReferenceId, @FolderTypeID = TACalReferenceTypeId 
	FROM pTACalReference 
	WHERE TACalTemplateId = @TACalTemplateID AND ReferenceId = @ProductID

	DELETE FROM pTACalReferenceTask WHERE TACalReferenceId = @TACalReferenceId
	DELETE FROM pTACalReference WHERE TACalReferenceId = @TACalReferenceId

	-- Recalculating progresses
	IF @FolderTypeID = 2 -- Style and Style Techpack
	BEGIN
		EXEC spx_TACalendar_StyleWorkflowReferences_Progress_UPDATE NULL, NULL, NULL, @TACalTemplateID
		EXEC spx_TACalendar_StyleTechPackWorkflowReferences_Progress_UPDATE NULL, NULL, @TACalTemplateID
	END
	ELSE IF @FolderTypeID = 5 -- Sample Request
		EXEC spx_TACalendar_SampleRequestWorkflowReferences_Progress_UPDATE NULL, NULL, @TACalTemplateID
	ELSE IF @FolderTypeID = 6 -- Image
		EXEC spx_TACalendar_ImageWorkflowReferences_Progress_UPDATE NULL, NULL, @TACalTemplateID
	ELSE IF @FolderTypeID = 7 -- Color
		EXEC spx_TACalendar_ColorWorkflowReferences_Progress_UPDATE NULL, @TACalTemplateID
	ELSE IF @FolderTypeID = 8 -- Material
		EXEC spx_TACalendar_MaterialWorkflowReferences_Progress_UPDATE NULL, NULL, @TACalTemplateID
	ELSE IF @FolderTypeID = 19 -- Sourcing
	BEGIN
		EXEC spx_TACalendar_SourcingQuoteWorkflowReferences_Progress_UPDATE NULL, @TACalTemplateID
		EXEC spx_TACalendar_SourcingCommitmentWorkflowReferences_Progress_UPDATE NULL, @TACalTemplateID
	END
	ELSE IF @FolderTypeID = 24 -- Material Request
		EXEC spx_TACalendar_MaterialRequestWorkflowReferences_Progress_UPDATE NULL, NULL, @TACalTemplateID

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08918', GetDate())
GO
