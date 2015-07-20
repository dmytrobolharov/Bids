if not Exists(select * 
			from sys.columns 
		   where Name = N'SetAsDefaultAccessType'               
             and Object_ID = Object_ID(N'pWorkflowAccessType'))
             
begin      
-- Column Exists 
	alter table pWorkflowAccessType
	  add SetAsDefaultAccessType		bit null
end
go


update pWorkflowAccessType
   set SetAsDefaultAccessType = 1 
 where WorkflowAccessTypeDesc = 'Draft'
 
go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03414', GetDate())
	

GO

