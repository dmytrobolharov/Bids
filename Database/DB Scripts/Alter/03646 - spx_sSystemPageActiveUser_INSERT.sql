IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sSystemPageActiveUser_INSERT]'))
drop procedure spx_sSystemPageActiveUser_INSERT
  go


create procedure spx_sSystemPageActiveUser_INSERT

(@UserID int, @PagePathAccessed varchar(max))

as

if (select  COUNT(SystemPageActiveUserID)  FROM  sSystemPageActiveUser with (NOLOCK) where UserID = @UserID AND PagePathAccessed = @PagePathAccessed) = 0 

	BEGIN
	
		INSERT  INTO sSystemPageActiveUser(UserID, PagePathAccessed, ActiveUserLastUpdate, ActiveUserTimeAccessed)
		VALUES  (@UserID, @PagePathAccessed, (select GETDATE()), (select GETDATE())) 

	END

ELSE

	BEGIN
	
		update sSystemPageActiveUser set ActiveUserLastUpdate = (select GETDATE()) where UserID = @UserID AND PagePathAccessed = @PagePathAccessed
	
	END


go


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03646', GetDate())
GO
