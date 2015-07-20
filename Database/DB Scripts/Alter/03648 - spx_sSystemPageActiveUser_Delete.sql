IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sSystemPageActiveUser_DELETE]'))
drop procedure spx_sSystemPageActiveUser_DELETE
  go


create procedure spx_sSystemPageActiveUser_DELETE

(@UserID int, @PagePathAccessed varchar(max))

as

delete from sSystemPageActiveUser 
 where UserId = @UserID AND PagePathAccessed = @PagePathAccessed
 
go
 


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03648', GetDate())
go


