
if not Exists(select * 
			from sys.columns 
		   where Name = N'ScheduleBy'               
             and Object_ID = Object_ID(N'pStyleHeader'))
             
begin      
-- Column Exists 
	alter table pStyleHeader
	  add ScheduleBy		char(1)		null
end




if not Exists(select * 
			from sys.columns 
		   where Name = N'EnforceDependency'               
             and Object_ID = Object_ID(N'pStyleHeader'))
             
begin      
-- Column Exists 
	alter table pStyleHeader
	  add EnforceDependency		bit			null
end





INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03425', GetDate())
	

GO



