IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Image_New_WorkflowStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Image_New_WorkflowStatus_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Image_New_WorkflowStatus_UPDATE] (
	@ImageID UNIQUEIDENTIFIER,
	@ImageWorkflowTemplateID UNIQUEIDENTIFIER,
	@ImageUploaded INT = 0
)
AS

DECLARE @ImageWorkflowTemplateEntryID UNIQUEIDENTIFIER

SELECT @ImageWorkflowTemplateEntryID = ImageWorkflowTemplateEntryID FROM pImageWorkflowTemplateEntry WHERE  ImageWorkflowTemplateID = @ImageWorkflowTemplateID

IF @ImageUploaded = 0
	BEGIN
		UPDATE pImageWorkflowPage SET WorkStatus = 1 WHERE ImageID = @ImageID AND 
														   ImageWorkflowTemplateEntryID = @ImageWorkflowTemplateEntryID
	END 
ELSE IF @ImageUploaded = 1
	BEGIN
		UPDATE pImageWorkflowPage SET WorkStatus = 6 WHERE ImageID = @ImageID AND 
														   ImageWorkflowTemplateEntryID = @ImageWorkflowTemplateEntryID
   		UPDATE pImageWorkflowPage SET ActualStart = GETDATE() WHERE ImageID = @ImageID AND 
														   ImageWorkflowTemplateEntryID = @ImageWorkflowTemplateEntryID
	END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08788', GetDate())
GO

