drop procedure spx_WorkflowTemplateItem_UPDATE
go


create procedure spx_WorkflowTemplateItem_UPDATE
(
	@WorkflowTemplateID			uniqueidentifier,
	@WorkflowTemplateItemID		uniqueidentifier,
	
	@WorkflowAssignedTo			nvarchar(50),
	@WorkflowDays				nvarchar(50),
	@WorkflowAlerts				nvarchar(50),
	@WorkflowSort				nvarchar(50),
	@DueDate					datetime,
	@StartDate					datetime,
	
	-- all
	@MUser						nvarchar(50),
	@MDate						datetime
)
as

 update pWorkflowTemplateItem
    set WorkflowAssignedTo = @WorkflowAssignedTo,
		WorkflowDays = @WorkflowDays,
		WorkflowAlerts = @WorkflowAlerts,
		WorkflowSort = @WorkflowSort,
	    DueDate = @DueDate,
	    StartDate = @StartDate,
	    MUser = @MUser,
	    MDate = @MDate
  where WorkflowTemplateID = @WorkflowTemplateID 
    and WorkflowTemplateItemID = @WorkflowTemplateItemID
 

go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03331', GetDate())
GO

