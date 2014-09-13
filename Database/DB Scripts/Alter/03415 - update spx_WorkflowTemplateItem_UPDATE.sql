
-- if drop...etc..
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowTemplateItem_UPDATE]'))
drop procedure spx_WorkflowTemplateItem_UPDATE
go


create procedure spx_WorkflowTemplateItem_UPDATE
(
	@WorkflowTemplateID			uniqueidentifier,
	@WorkflowTemplateItemID		uniqueidentifier,
	
	@WorkflowAssignedTo			nvarchar(50),
	@WorkflowEscalateTo			nvarchar(50),
	@WorkflowDays				nvarchar(50),
	@WorkflowAlerts				nvarchar(50),
	@WorkflowSort				nvarchar(50),
	
	@WorkflowAccessTypeID    	nvarchar(50),
	@DueDate					datetime,
	@StartDate					datetime,
	
	@MUser						nvarchar(50),
	@MDate						datetime
)
as

 
 update pWorkflowTemplateItem
    set WorkflowAssignedTo = @WorkflowAssignedTo,
        WorkflowEscalateTo = @WorkflowEscalateTo,
		WorkflowDays = @WorkflowDays,
		WorkflowAlerts = @WorkflowAlerts,
		WorkflowSort = @WorkflowSort,
		WorkflowAccessTypeID = @WorkflowAccessTypeID,
	    DueDate = @DueDate,
	    StartDate = @StartDate,
	    MUser = @MUser,
	    MDate = @MDate
  where WorkflowTemplateID = @WorkflowTemplateID 
    and WorkflowTemplateItemID = @WorkflowTemplateItemID
 

go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03415', GetDate())
	

GO


