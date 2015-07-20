if not Exists(select * 
			from sys.columns 
		   where Name = N'ActualCompletedDate'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add ActualCompletedDate		datetime	null
end
go


if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowTemplateID'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add WorkflowTemplateID	uniqueidentifier	null
end
go


if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowTemplateItemID'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	alter table pStyleWorkflow
	  add WorkflowTemplateItemID	uniqueidentifier	null
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
       e.StartDate PlannedStartDate, e.DueDate PlannedDueDate, e.WorkflowDays PlannedWorkDays, 
       ISNULL(a.WorkAssignedTo, 0) AS WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, 
       a.WorkVersion, a.WorkComments, a.WorkSort, a.CUser, a.CDate, a.MUser, a.MDate, d.StyleNo, CAST(e.WorkflowSort as int) WorkflowSort, a.WorkflowTemplateID,
       e.WorkflowTemplateItemID,
       WorkflowAssignedTo,
       case 
	        when u1.MiddleName is not null then
				 u1.FirstName + ' ' + u1.MiddleName + ' ' + u1.LastName
	        else
				 u1.FirstName + ' ' + u1.LastName
	    end WorkflowAssignedToName,
	   WorkflowEscalateTo,
       case 
	        when u2.MiddleName is not null then
				 u2.FirstName + ' ' + + u2.MiddleName + ' ' + u2.LastName 
			else
				 u2.FirstName + ' ' + u2.LastName 
	    end WorkflowEscalateToName, 
	    WorkflowAlerts,
	    e.WorkflowAccessTypeID, WorkflowAccessTypeDesc
  FROM pStyleWorkflow AS a WITH (NOLOCK) INNER JOIN
       Mapping AS b WITH (NOLOCK) ON a.WorkflowID = b.Map INNER JOIN
       pWorkflowStatus AS c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID INNER JOIN
       pStyleHeader AS d WITH (NOLOCK) ON a.StyleID = d.StyleID INNER JOIN
       pWorkflowTemplateItem AS e WITH (NOLOCK) ON e.WorkflowTemplateID = a.WorkflowTemplateID and e.WorkflowTemplateItemID = a.WorkflowTemplateItemID
       left outer join Users u1 on u1.UserId = e.WorkflowAssignedTo 
	   left outer join Users u2 on u2.UserId = e.WorkflowEscalateTo
	   left outer join pWorkflowAccessType wat on wat.WorkflowAccessTypeID = e.WorkflowAccessTypeID
	   
) x

)
go



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03426', GetDate())
	

GO





/*
	   
where StyleID = 'a977540b-2553-45b4-b719-cbad6f72cbf3'
   and WorkflowTemplateID = '7cbddd58-b08e-4723-9477-c9e791cdf36e' 
   and StyleSet = 1
 order by WorkflowSort




select Workflow, WorkflowStatus, WorkflowAccessTypeID,
       StartDate, DueDate, WorkflowDays, 
       case 
	        when u1.MiddleName is not null then
				 u1.FirstName + ' ' + u1.MiddleName + ' ' + u1.LastName
	        else
				 u1.FirstName + ' ' + u1.LastName
	    end WorkflowAssignedToName,
       case 
	        when u2.MiddleName is not null then
				 u2.FirstName + ' ' + + u2.MiddleName + ' ' + u2.LastName 
			else
				 u2.FirstName + ' ' + u2.LastName 
	    end WorkflowEscalateToName,
       cast(wti.WorkflowSort as int) WorkflowSort
  from pStyleWorkflow sw
	   left outer join pWorkflow w               on w.WorkflowID = sw.WorkflowID
	   left outer join pWorkflowStatus ws        on ws.WorkflowStatusID  = sw.WorkStatus
	   left outer join pWorkflowTemplateItem wti on wti.WorkflowID = sw.WorkflowID
	   left outer join Users u1                  on u1.UserId = wti.WorkflowAssignedTo 
	   left outer join Users u2                  on u2.UserId = wti.WorkflowEscalateTo
 where StyleID = 'a977540b-2553-45b4-b719-cbad6f72cbf3'
   and WorkflowTemplateID = '7cbddd58-b08e-4723-9477-c9e791cdf36e' 
   and StyleSet = 1
   
	   



select Workflow, * 
  from pStyleWorkflow sw
	   left outer join pWorkflow w               on w.WorkflowID = sw.WorkflowID
	   --left outer join pWorkflowStatus ws        on ws.WorkflowStatusID  = sw.WorkStatus
	   --left outer join pWorkflowTemplateItem wti on wti.WorkflowID = sw.WorkflowID
	   --left outer join Users u1                  on u1.UserId = wti.WorkflowAssignedTo 
	   --left outer join Users u2                  on u2.UserId = wti.WorkflowEscalateTo
 where StyleID = 'a977540b-2553-45b4-b719-cbad6f72cbf3'
   and StyleSet = 1
 
 
 
 select Workflow, styleset,  * 
  from pStyleWorkflow sw
	   left outer join pWorkflow w               on w.WorkflowID = sw.WorkflowID
	   --left outer join pWorkflowStatus ws        on ws.WorkflowStatusID  = sw.WorkStatus
	   --left outer join pWorkflowTemplateItem wti on wti.WorkflowID = sw.WorkflowID
	   --left outer join Users u1                  on u1.UserId = wti.WorkflowAssignedTo 
	   --left outer join Users u2                  on u2.UserId = wti.WorkflowEscalateTo
 where StyleID = 'a977540b-2553-45b4-b719-cbad6f72cbf3'
 order by StyleSet, WorkflowSort
 
 
 --SELECT * FROM vwx_StyleWorkflowItems 
 -- WHERE StyleID = 'a977540b-2553-45b4-b719-cbad6f72cbf3' 
 --   AND StyleSet = 1 
 --   AND WorkflowTemplateID = '7cbddd58-b08e-4723-9477-c9e791cdf36e' 
 -- ORDER BY WorkflowSort, WorkflowID 
*/
 