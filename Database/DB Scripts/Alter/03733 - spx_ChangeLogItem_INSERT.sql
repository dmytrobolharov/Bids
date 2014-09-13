/****** Object:  StoredProcedure [dbo].[spx_ChangeLogItem_INSERT]    Script Date: 07/27/2012 12:52:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLogItem_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLogItem_INSERT]    Script Date: 07/27/2012 12:52:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[spx_ChangeLogItem_INSERT] (
	@ChangeLogID varchar(40),
	@ChangeTransID varchar(40),
	@ChangeFieldName varchar(200),
	@ChangeFieldAlias nvarchar(400),
	@ChangeBeforeValue nvarchar(4000),
	@ChangeAfterValue nvarchar(4000),
	@ChangeBeforeText nvarchar(4000),
	@ChangeAfterText nvarchar(4000),
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
VALUES ('DB_Version', '5.0.0000', '03733', GetDate())
GO