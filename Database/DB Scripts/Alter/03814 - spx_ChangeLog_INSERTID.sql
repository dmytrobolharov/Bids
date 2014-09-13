IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLog_INSERTID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLog_INSERTID]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_ChangeLog_INSERTID] (
	@changeTableId varchar(40),
	@changeTransId varchar(40),
	@changeTablePKId varchar(40),
	@changeUserId varchar(40),
	@ChangeUserName nvarchar(200),
	@changeDate datetime,
	@changeSort varchar(5),
	@ShowResult INT = 1, 
	@ChangeLogID UNIQUEIDENTIFIER = NULL OUTPUT,
	@ChangeTransPageName NVARCHAR(200) = NULL,
	@ChangeTransTypeID INT = NULL
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
	ChangeSort,
	ChangeTransPageName,
	ChangeTransTypeID)
Output inserted.ChangeLogID	INTO @tmpChangeLog
VALUES
	(
	@ChangeTableID,
	@ChangeTransID,
	@ChangeTablePKID,
	@ChangeUserID,
	@ChangeUserName,
	@ChangeDate,
	@ChangeSort,
	@ChangeTransPageName,
	@ChangeTransTypeID)

SELECT @ChangeLogID = ChangeLogID FROM @tmpChangeLog

IF @ShowResult = 1
	SELECT ChangeLogID FROM @tmpChangeLog


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03814', GetDate())
GO
