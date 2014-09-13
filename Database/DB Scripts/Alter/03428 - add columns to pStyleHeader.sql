if not Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowTemplateID'               
             and Object_ID = Object_ID(N'pStyleHeader'))
             
begin      
-- Column Exists 
	alter table pStyleHeader
	  add WorkflowTemplateID		UNIQUEIDENTIFIER
end

go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03428', GetDate())
	

GO




