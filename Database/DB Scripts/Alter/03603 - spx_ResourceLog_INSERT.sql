IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ResourceLog_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ResourceLog_INSERT]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_ResourceLog_INSERT]
(@ResourceTypeID int,
@ResourceID uniqueidentifier,
@TeamId uniqueidentifier,
@CreatedDate datetime,
@CreatedBy nvarchar(150),
@ResourceLogType nvarchar(2))
AS 

DECLARE @ResourceLog varchar(200)

IF @ResourceLogType = 'N'
	BEGIN
		SET @ResourceLog = 'File Created' 
	END
ELSE IF	@ResourceLogType = 'D'
	BEGIN
		SET @ResourceLog = 'File Downloaded'
	END
ELSE IF	@ResourceLogType = 'V'
	BEGIN
		SET @ResourceLog = 'Resource File Accessed'
	END
ELSE IF	@ResourceLogType = 'S'
	BEGIN
		SET @ResourceLog = 'Shared File With Agent'
	END
ELSE IF	@ResourceLogType = 'U'
	BEGIN
		SET @ResourceLog = 'Resource File Uploaded'
	END
ELSE IF	@ResourceLogType = 'US'
	BEGIN
		SET @ResourceLog = 'Unshared File With Agent'
	END			
ELSE
	BEGIN
		SET @ResourceLog = ''
	END
	

IF @ResourceLog <> ''
	BEGIN
	IF (SELECT COUNT(*) FROM  pResourceLog WITH (NOLOCK) WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND ResourceLogType = @ResourceLogType AND @ResourceID = @ResourceID) <> 0
		IF	@ResourceLogType <> 'V'
		 UPDATE pResourceLog SET CDATE = GETDATE() WHERE TeamId = @TeamId AND TeamId = @TeamId AND ResourceLogType = @ResourceLogType AND ResourceID = @ResourceID	
		ELSE
		SELECT 1	
	ELSE
		INSERT INTO pResourceLog
			(ResourceTypeID, ResourceLogType, ResourceID, TeamID, ResourceLog, CDate, CUser)
		VALUES (@ResourceTypeID, @ResourceLogType, @ResourceID, @TeamId, @ResourceLog, @CreatedDate, @CreatedBy)
	END

GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03603', GetDate())

GO
