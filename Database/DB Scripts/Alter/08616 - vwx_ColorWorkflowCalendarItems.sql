IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ColorWorkflowCalendarItems]'))
DROP VIEW [dbo].[vwx_ColorWorkflowCalendarItems]
GO


CREATE VIEW [dbo].[vwx_ColorWorkflowCalendarItems]
AS
SELECT     dbo.pColorFolder.*, dbo.pColorFolderWorkflowPage.ColorFolderWorkflowPageID, dbo.pColorFolderWorkflowPage.ColorFolderWorkflowID, 
                      dbo.pColorFolderWorkflowPage.WorkStart, dbo.pColorFolderWorkflowPage.WorkAssignedTo, dbo.pColorFolderWorkflowPage.WorkDue, 
                      dbo.pColorFolderWorkflowPage.WorkStatus, dbo.pColorFolderWorkflowPage.WorkStatusDate, dbo.pColorFolderWorkflowPage.ActualStart, 
                      dbo.pColorFolderWorkflowPage.ActualEnd, dbo.pColorFolderWorkflowPage.Sort, dbo.pWorkflowStatus.WorkflowStatus, 
                      dbo.pWorkflowStatus.WorkflowStatusImage, 'Color' AS WorkflowName, 'COLOR' AS WorkflowFolder, 'Color Palette' AS MapDetail 
FROM         dbo.pColorFolder LEFT OUTER JOIN
                      dbo.pColorFolderWorkflowPage ON dbo.pColorFolder.ColorFolderID = dbo.pColorFolderWorkflowPage.ColorFolderID LEFT OUTER JOIN
                      pWorkflowStatus ON dbo.pColorFolderWorkflowPage.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08616', GetDate())
GO


