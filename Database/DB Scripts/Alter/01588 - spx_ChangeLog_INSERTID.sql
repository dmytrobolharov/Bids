IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLog_INSERTID]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ChangeLog_INSERTID]
GO

CREATE PROCEDURE [dbo].[spx_ChangeLog_INSERTID] (
	@changeTableId varchar(40),
	@changeTransId varchar(40),
	@changeTablePKId varchar(40),
	@changeUserId varchar(40),
	@ChangeUserName varchar(40),
	@changeDate datetime,
	@changeSort varchar(5),
	@ShowResult INT = 1, 
	@ChangeLogID UNIQUEIDENTIFIER = NULL OUTPUT
)
as

IF @changeTransId IS NULL OR CAST(@changeTransId AS NVARCHAR(40)) = '00000000-0000-0000-0000-000000000000'
BEGIN
	SET @ChangeLogID = '00000000-0000-0000-0000-000000000000'
	SELECT @ChangeLogID AS ChangeLogID 
	RETURN 
END 

DECLARE @tmpChangeLog TABLE (
    ChangeLogID UNIQUEIDENTIFIER
)

INSERT
	INTO pChangeLog (
	ChangeTableID,
	ChangeTransID,
	ChangeTablePKID,
	ChangeUserID,
	ChangeUserName,
	ChangeDate,
	ChangeSort)
Output inserted.ChangeLogID	INTO @tmpChangeLog
VALUES
	(
	@ChangeTableID,
	@ChangeTransID,
	@ChangeTablePKID,
	@ChangeUserID,
	@ChangeUserName,
	@ChangeDate,
	@ChangeSort)

SELECT @ChangeLogID = ChangeLogID FROM @tmpChangeLog

IF @ShowResult = 1
	SELECT ChangeLogID FROM @tmpChangeLog



GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01588'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01588', GetDate())
END	

GO

