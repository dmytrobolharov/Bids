

/****** Object:  StoredProcedure [dbo].[spx_ChangeLog_DELETE]    Script Date: 10/13/2010 09:44:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLog_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLog_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLog_INSERTID]    Script Date: 10/13/2010 09:44:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLog_INSERTID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLog_INSERTID]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLog_SELECTED]    Script Date: 10/13/2010 09:44:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLog_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLog_SELECTED]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLogItem_INSERT]    Script Date: 10/13/2010 09:44:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLogItem_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLogItem_SELECT]    Script Date: 10/13/2010 09:44:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLogItem_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLogItem_SELECTED]    Script Date: 10/13/2010 09:44:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogItem_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLogItem_SELECTED]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeTable_SELECTED]    Script Date: 10/13/2010 09:44:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeTable_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeTable_SELECTED]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeTransaction_DELETE]    Script Date: 10/13/2010 09:44:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeTransaction_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeTransaction_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeTransaction_INSERTID]    Script Date: 10/13/2010 09:44:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeTransaction_INSERTID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeTransaction_INSERTID]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLog_DELETE]    Script Date: 10/13/2010 09:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ChangeLog_DELETE]
(
@ChangeLogID uniqueidentifier
)
AS 

DELETE FROM pChangeLog WHERE ChangeLogID = @ChangeLogID

GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLog_INSERTID]    Script Date: 10/13/2010 09:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[spx_ChangeLog_INSERTID] (
	@changeTableId varchar(40),
	@changeTransId varchar(40),
	@changeTablePKId varchar(40),
	@changeUserId varchar(40),
	@ChangeUserName varchar(40),
	@changeDate datetime,
	@changeSort varchar(5)
)
as

INSERT
	INTO pChangeLog (
	ChangeTableID,
	ChangeTransID,
	ChangeTablePKID,
	ChangeUserID,
	ChangeUserName,
	ChangeDate,
	ChangeSort)
Output inserted.ChangeLogID	
VALUES
	(
	@ChangeTableID,
	@ChangeTransID,
	@ChangeTablePKID,
	@ChangeUserID,
	@ChangeUserName,
	@ChangeDate,
	@ChangeSort)


GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLog_SELECTED]    Script Date: 10/13/2010 09:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_ChangeLog_SELECTED]
(
@ChangeLogID uniqueidentifier
)
AS 

SELECT ChangeLogID, ChangeTableID, ChangeTablePKID, ChangeUserID, ChangeUserName, ChangeDate, ChangeSort
FROM pChangeLog WITH (NOLOCK)
WHERE ChangeLogID = @ChangeLogID


GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLogItem_INSERT]    Script Date: 10/13/2010 09:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
	@ChangeSort varchar(5)
)
as

INSERT
	INTO pChangeLogItem (
	ChangeLogID,
	ChangeTransID,
	ChangeFieldName,
	ChangeFieldAlias,
	ChangeBeforeValue,
	ChangeAfterValue,
	ChangeBeforeText,
	ChangeAfterText,
	ChangeSort)
VALUES
	(@ChangeLogID,
	@ChangeTransID,
	@ChangeFieldName,
	@ChangeFieldAlias,
	@ChangeBeforeValue,
	@ChangeAfterValue,
	@ChangeBeforeText,
	@ChangeAfterText,
	@ChangeSort);
	
	
	
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLogItem_SELECT]    Script Date: 10/13/2010 09:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ChangeLogItem_SELECT]
(
@ChangeLogID uniqueidentifier
)
AS 

SELECT ChangeLogItemID, ChangeLogID, ChangeFieldName, ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSort
FROM pChangeLogItem WITH (NOLOCK)
WHERE ChangeLogID = @ChangeLogID


GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLogItem_SELECTED]    Script Date: 10/13/2010 09:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_ChangeLogItem_SELECTED]
(
@ChangeLogItemID uniqueidentifier
)
AS 

SELECT ChangeLogItemID, ChangeLogID, ChangeFieldName, ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSort
FROM pChangeLogItem WITH (NOLOCK)
WHERE ChangeLogItemID = @ChangeLogItemID


GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeTable_SELECTED]    Script Date: 10/13/2010 09:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_ChangeTable_SELECTED]
(
@ChangeTableID uniqueidentifier
)
AS 

SELECT ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML 
FROM pChangeTable WITH (NOLOCK)
WHERE ChangeTableID = @ChangeTableID


GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeTransaction_DELETE]    Script Date: 10/13/2010 09:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[spx_ChangeTransaction_DELETE] (@ChangeTransID uniqueidentifier)
AS

--It will clean the change tranasaction table if it no change found.
IF NOT EXISTS(SELECT ChangeLogItemID, ChangeTransID, ChangeLogID, ChangeFieldName, 
		ChangeFieldAlias, ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText,  
		ChangeAfterText, ChangeSort FROM pChangeLogItem 
	WHERE EXISTS (SELECT ChangeLogID FROM pChangeLog WHERE ChangeTransID = @ChangeTransID))
BEGIN
	DELETE FROM pChangeLog WHERE ChangeTransID = @ChangeTransID
END

IF NOT EXISTS(SELECT * FROM pChangeLog WHERE ChangeTransID = @ChangeTransID) 
BEGIN
	DELETE FROM pChangeTransaction WHERE ChangeTransID = @ChangeTransID
END





GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeTransaction_INSERTID]    Script Date: 10/13/2010 09:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[spx_ChangeTransaction_INSERTID] (
	@ChangeTransPageName varchar(200),
	@ChangeTransTableID uniqueidentifier,
	@ChangeTransTablePKID varchar(200),
	@ChangeTransUserID uniqueidentifier,
	@ChangeTransDate datetime
)
AS

INSERT INTO pChangeTransaction (
				ChangeTransPageName,
				ChangeTransTableID,
				ChangeTransTablePKID,
				ChangeTransUserID,
				ChangeTransDate)
Output inserted.ChangeTransID	
VALUES
				(@ChangeTransPageName,
				@ChangeTransTableID,
				@ChangeTransTablePKID,
				@ChangeTransUserID,
				@ChangeTransDate
				)
;




GO


