if not Exists(select * 
			from sys.columns 
		   where Name = N'PlannedStartDate'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add PlannedStartDate				datetime		null
end
go


if not Exists(select * 
			from sys.columns 
		   where Name = N'PlannedDueDate'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add PlannedDueDate				datetime		null
end
go


if not Exists(select * 
			from sys.columns 
		   where Name = N'PlannedWorkDays'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add PlannedWorkDays				int		null
end
go



if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkAssignedTo'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add WorkAssignedTo		int		null
end
go



if Exists(select * 
			from sys.columns 
		   where Name = N'WorkAssignedToName'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	 drop column WorkAssignedToName
end
go




if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkEscalateTo'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add WorkEscalateTo		int		null
end
go



if Exists(select * 
			from sys.columns 
		   where Name = N'WorkEscalateToName'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  drop column WorkEscalateToName
end
go


if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowAlerts'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add WorkflowAlerts		int		null
end
go


if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowAccessTypeID'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add WorkflowAccessTypeID		int		null
end
go



if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowAccessTypeDesc'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add WorkflowAccessTypeDesc		varchar(255)		null
end
go









IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_StyleWorkflowItems')
drop view vwx_StyleWorkflowItems
go

create view vwx_StyleWorkflowItems
    as
(
select 
	(select COUNT(*) from pWorkflowTemplateItemDep where DependentWorkflowTemplateItemID = WorkflowTemplateItemID) RequirementNum    
	, *
from
(
SELECT b.Map, b.MapDetail, b.MapUrl, c.WorkflowStatus, c.WorkflowStatusImage, a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID, a.WorkflowType, a.WorkflowOrder, 
       a.WorkDate, a.WorkStart ActualStartDate, a.WorkDue ActualDueDate, a.WorkDay ActualWorkDays, a.ActualCompletedDate,
       a.PlannedStartDate, a.PlannedDueDate, PlannedWorkDays, 
       ISNULL(a.WorkAssignedTo, 0) AS WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, 
       a.WorkVersion, a.WorkComments, CAST(a.WorkSort as int) WorkSort, a.CUser, a.CDate, a.MUser, a.MDate, d.StyleNo, a.WorkflowTemplateID,
       a.WorkflowTemplateItemID, u1.FirstName + ' ' + u1.Lastname WorkAssignedToName, WorkEscalateTo, 
       u2.FirstName + ' ' + u2.LastName WorkEscalateToName, WorkflowAlerts,
	   WorkflowAccessTypeID, WorkflowAccessTypeDesc
  FROM pStyleWorkflow AS a WITH (NOLOCK) INNER JOIN
       Mapping AS b WITH (NOLOCK) ON a.WorkflowID = b.Map INNER JOIN
       pWorkflowStatus AS c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID INNER JOIN
       pStyleHeader AS d WITH (NOLOCK) ON a.StyleID = d.StyleID
       left outer join Users u1 on u1.UserId = a.WorkAssignedTo
       left outer join Users u2 on u2.UserId = a.WorkEscalateTo
) x

)

go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03457', GetDate())
	

GO



