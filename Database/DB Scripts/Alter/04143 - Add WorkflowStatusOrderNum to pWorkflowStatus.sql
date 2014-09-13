if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowStatusOrderNum'               
             and Object_ID = Object_ID(N'pWorkflowStatus'))
             
begin      
-- Column Exists 
	alter table pWorkflowStatus
	  add WorkflowStatusOrderNum				int		null
end
go


update pWorkflowStatus
   set WorkflowStatusOrderNum = WorkflowStatusID
 where WorkflowStatusOrderNum is null
go


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='04143'))
begin
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04143', GetDate())
end
GO


