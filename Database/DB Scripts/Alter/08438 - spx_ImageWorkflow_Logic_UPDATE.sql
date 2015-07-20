IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWorkflow_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWorkflow_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_ImageWorkflow_Logic_UPDATE]
	@ImageID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS

-- insert missing workflows
INSERT INTO pImageWorkflowPage(
	ImageID, ImageWorkflowTemplateEntryID, ImageWorkflowTemplateItemID,
	WorkStart, WorkDue, WorkAssignedTo, WorkStatus,
	Sort, CUser, CDate, MUser, MDate)
SELECT i.ImageID, iwte.ImageWorkflowTemplateEntryID, iwte.ImageWorkflowTemplateItemID,
	NULL, NULL, NULL, 6,
	iwte.Sort, @CUser, @CDate, @CUser, @CDate
FROM pImage i
INNER JOIN pImageWorkflowTemplateEntry iwte ON i.ImageWorkflowTemplateID = iwte.ImageWorkflowTemplateID
LEFT JOIN pImageWorkflowPage iwp ON i.ImageID = iwp.ImageID 
	AND iwte.ImageWorkflowTemplateItemID = iwp.ImageWorkflowTemplateItemID
WHERE i.ImageID = @ImageID AND iwp.ImageWorkflowPageID IS NULL


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08438', GetDate())
GO
