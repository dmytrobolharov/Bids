IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sSystemPageActiveUserCleanUp_DELETE]'))
drop procedure spx_sSystemPageActiveUserCleanUp_DELETE
  go


create procedure spx_sSystemPageActiveUserCleanUp_DELETE
as

--select ActiveUserID, DATEDIFF(SECOND, LastTimeAccessed, (select GETDATE())) TimeElapsed
--  from ActiveUser
 
delete from sSystemPageActiveUser 
 where DATEDIFF(SECOND, ActiveUserLastUpdate, (select GETDATE())) > 4

go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03647', GetDate())
go

