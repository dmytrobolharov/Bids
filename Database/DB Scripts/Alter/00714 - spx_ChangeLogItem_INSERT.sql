IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogItem_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ChangeLogItem_INSERT]
GO


CREATE procedure [dbo].[spx_ChangeLogItem_INSERT] (
	@ChangeLogID varchar(40),
	@ChangeTransID varchar(40),
	@ChangeFieldName varchar(200),
	@ChangeFieldAlias nvarchar(400),
	@ChangeBeforeValue varchar(4000),
	@ChangeAfterValue varchar(4000),
	@ChangeBeforeText varchar(4000),
	@ChangeAfterText varchar(4000),
	@ChangeSort varchar(5),
	@ChangeLogItemID UNIQUEIDENTIFIER = NULL OUTPUT
)
AS


IF @changeTransId IS NULL OR CAST(@changeTransId AS NVARCHAR(40)) = '00000000-0000-0000-0000-000000000000'
BEGIN
	SET @ChangeLogItemID = NULL
	RETURN 
END 


SET @ChangeLogItemID = NEWID()

INSERT INTO pChangeLogItem (
	ChangeLogItemID,
	ChangeLogID,
	ChangeTransID,
	ChangeFieldName,
	ChangeFieldAlias,
	ChangeBeforeValue,
	ChangeAfterValue,
	ChangeBeforeText,
	ChangeAfterText,
	ChangeSort)
VALUES(
	@ChangeLogItemID,
	@ChangeLogID,
	@ChangeTransID,
	@ChangeFieldName,
	@ChangeFieldAlias,
	@ChangeBeforeValue,
	@ChangeAfterValue,
	@ChangeBeforeText,
	@ChangeAfterText,
	@ChangeSort);

EXECUTE spx_ChangeLogItem_Logic_INSERT @ChangeLogItemID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '714', GetDate())
GO

