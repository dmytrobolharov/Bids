
/****** Object:  StoredProcedure [dbo].[spx_UserPreference_UPDATE]    Script Date: 04/14/2014 16:08:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_UserPreference_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_UserPreference_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_UserPreference_UPDATE]    Script Date: 04/14/2014 16:08:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_UserPreference_UPDATE](
	@TeamID uniqueidentifier,
	@UserPreferenceKey nvarchar(300),
	@UserPreferenceValue nvarchar(MAX),
	@UserPreferenceObjectName nvarchar(300),
	@UserPreferencePage nvarchar(200)
)

AS 

if (NOT EXISTS (SELECT * FROM uUserPreferenceObject WHERE UserPreferenceObjectName = @UserPreferenceObjectName and UserPreferencePage = @UserPreferencePage))
begin
	INSERT INTO uUserPreferenceObject (UserPreferenceObjectName, UserPreferencePage) VALUES (@UserPreferenceObjectName, @UserPreferencePage)
end

declare @UserPreferenceObjectID UNIQUEIDENTIFIER = (SELECT UserPreferenceObectID FROM uUserPreferenceObject WHERE UserPreferenceObjectName = @UserPreferenceObjectName and UserPreferencePage = @UserPreferencePage)

if (NOT EXISTS (SELECT * FROM uUserPreference WHERE TeamID = @TeamID and UserPreferenceKey = @UserPreferenceKey and UserPreferenceObjectID=@UserPreferenceObjectID))
begin
	INSERT INTO uUserPreference (TeamID, UserPreferenceObjectID, UserPreferenceKey, UserPreferenceValue) VALUES (@TeamID, @UserPreferenceObjectID, @UserPreferenceKey, @UserPreferenceValue)
end
ELSE
BEGIN
 UPDATE uUserPreference SET UserPreferenceValue=@UserPreferenceValue WHERE TeamID = @TeamID and UserPreferenceKey = @UserPreferenceKey and UserPreferenceObjectID=@UserPreferenceObjectID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07496', GetDate())
GO