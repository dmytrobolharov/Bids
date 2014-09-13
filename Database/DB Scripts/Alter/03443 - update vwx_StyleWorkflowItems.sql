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
		   where Name = N'WorkflowAssignedTo'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add WorkflowAssignedTo		int		null
end
go



if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowAssignedToName'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add WorkflowAssignedToName		varchar(255)		null
end
go




if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowEscalateTo'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add WorkflowEscalateTo		int		null
end
go



if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowEscalateToName'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add WorkflowEscalateToName		varchar(255)		null
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
       a.WorkVersion, a.WorkComments, a.WorkSort, a.CUser, a.CDate, a.MUser, a.MDate, d.StyleNo, a.WorkflowTemplateID,
       a.WorkflowTemplateItemID, WorkflowAssignedTo, WorkflowAssignedToName, WorkflowEscalateTo, WorkflowEscalateToName, WorkflowAlerts,
	   WorkflowAccessTypeID, WorkflowAccessTypeDesc
  FROM pStyleWorkflow AS a WITH (NOLOCK) INNER JOIN
       Mapping AS b WITH (NOLOCK) ON a.WorkflowID = b.Map INNER JOIN
       pWorkflowStatus AS c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID INNER JOIN
       pStyleHeader AS d WITH (NOLOCK) ON a.StyleID = d.StyleID
) x

)

go


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03443'))
BEGIN

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03443', GetDate())
	
END
GO



