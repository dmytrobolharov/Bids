IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_ReportWorkFlowItemList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_ReportWorkFlowItemList_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Sample_ReportWorkFlowItemList_SELECT]   
(@ReportMapID uniqueidentifier,  
 @WorkflowItemId UNIQUEIDENTIFIER,
 @SampleApproved INTEGER
)  
AS 

IF @ReportMapID = '00000000-0000-0000-0000-000000000000'
BEGIN
IF  @SampleApproved = 1
	BEGIN
	SELECT ReportSampleRequestSubmitPageID AS ReportPageID, ReportSampleRequestSubmitPageID AS ReportMapID, ReportPageTypeID, ReportPageName, 
					 ReportPageDescription, ReportServerType, ReportPageURL, ReportPKIField, 
					  ReportPageActive, ReportPageFormat, @WorkflowItemId AS WorkflowItemId 
					FROM 
				   rReportSampleRequestSubmitItem
					WHERE 
                		ReportSampleRequestSubmitFolderID = @WorkflowItemId AND ReportPageActive = 1
	END 
ELSE IF @SampleApproved = 0
	BEGIN
	SELECT ReportSampleRequestSubmitPageID AS ReportPageID, ReportSampleRequestSubmitPageID AS ReportMapID, ReportPageTypeID, ReportPageName, 
					 ReportPageDescription, ReportServerType, ReportPageURL, ReportPKIField, 
					  ReportPageActive, ReportPageFormat, @WorkflowItemId AS WorkflowItemId 
					FROM 
				   rReportSampleRequestSubmitItem
					WHERE 
                		ReportSampleRequestSubmitFolderID = @WorkflowItemId AND ReportPageActive = 1 AND ReportPageApproved = 0
	END 	
END
ELSE
BEGIN
SELECT ReportPageID, ReportMapID, ReportPageTypeID, ReportPageName, 
                 ReportPageDescription, ReportServerType, ReportPageURL, ReportPKIField, 
                  ReportPageActive, ReportPageFormat, @WorkflowItemId AS WorkflowItemId 
                FROM 
               	rReportStylePageItem 
                WHERE 
                	ReportMapID = @ReportMapID AND ReportPageActive = 1 AND ReportIsWorkflow = 0 
	
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03065'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03065', GetDate())     

END	  
GO