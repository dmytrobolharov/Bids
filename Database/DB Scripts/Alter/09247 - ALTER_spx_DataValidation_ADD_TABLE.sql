-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 14 January 2015                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2015 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DataValidation_ADD_TABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_DataValidation_ADD_TABLE]
GO

CREATE PROCEDURE [dbo].[spx_DataValidation_ADD_TABLE]
(
	@DVTableName nvarchar(50),
	@ControlPanelName nvarchar(50),
	@DVDescription nvarchar(200) = NULL
)
AS
BEGIN
	SET @DVDescription = ISNULL(@DVDescription, @ControlPanelName)

	DECLARE @Task nvarchar(MAX)
	DECLARE @FullTableName nvarchar(53)
	DECLARE @PKConstraintName nvarchar(56)
	DECLARE @ValueConstraintName nvarchar(63)
	DECLARE @KeyConstraintName nvarchar(63)
	DECLARE @ActiveConstraintName nvarchar(63)
	DECLARE @CDateConstraintName nvarchar(62)
	DECLARE @MDateConstraintName nvarchar(62)
	DECLARE @SortConstraintName nvarchar(65)
	DECLARE @IDConstraintName nvarchar(63)

	SET @FullTableName = N'dvt' + REPLACE(@DVTableName, '''', '')
	SET @PKConstraintName = N'PK_' + @FullTableName
	SET @ValueConstraintName = N'UC_' + @FullTableName + N'_ItemValue'
	SET @KeyConstraintName = N'UC_' + @FullTableName + N'_ItemKey'
	SET @ActiveConstraintName = N'DF_' + @FullTableName + N'_Active'
	SET @CDateConstraintName = N'DF_' + @FullTableName + N'_CDate'
	SET @MDateConstraintName = N'DF_' + @FullTableName + N'_MDate'
	SET @SortConstraintName = N'DF_' + @FullTableName + N'_ItemSort'
	SET @IDConstraintName = N'DF_' + @FullTableName + N'_ItemID'


	-- Check if the table already exists.
	DECLARE @retval int   
	DECLARE @ParmDefinition nvarchar(500)

	SET @Task = N'SELECT @retvalOUT = COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N' + CHAR(39) + @FullTableName + CHAR(39)
	SET @ParmDefinition = N'@retvalOUT int OUTPUT'

	EXEC sp_executesql @Task, @ParmDefinition, @retvalOUT=@retval OUTPUT

	IF @retval > 0
	BEGIN
		-- Drop Constraints.
		SET @Task = N'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' + CHAR(39) + 'dbo.' + @ValueConstraintName + CHAR(39) + ') AND type = ' + CHAR(39) + 'UQ' + CHAR(39) + ') ALTER TABLE [dbo].[' + @FullTableName + '] DROP CONSTRAINT [' + @ValueConstraintName + ']'
		EXECUTE (@Task)

		SET @Task = N'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' + CHAR(39) + 'dbo.' + @KeyConstraintName + CHAR(39) + ') AND type = ' + CHAR(39) + 'UQ' + CHAR(39) + ') ALTER TABLE [dbo].[' + @FullTableName + '] DROP CONSTRAINT [' + @KeyConstraintName + ']'
		EXECUTE (@Task)

		SET @Task = N'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' + CHAR(39) + 'dbo.' + @ActiveConstraintName + CHAR(39) + ') AND type = ' + CHAR(39) + 'D' + CHAR(39) + ') ALTER TABLE [dbo].[' + @FullTableName + '] DROP CONSTRAINT [' + @ActiveConstraintName + ']'
		EXECUTE (@Task)

		SET @Task = N'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' + CHAR(39) + 'dbo.' + @CDateConstraintName + CHAR(39) + ') AND type = ' + CHAR(39) + 'D' + CHAR(39) + ') ALTER TABLE [dbo].[' + @FullTableName + '] DROP CONSTRAINT [' + @CDateConstraintName + ']'
		EXECUTE (@Task)

		SET @Task = N'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' + CHAR(39) + 'dbo.' + @MDateConstraintName + CHAR(39) + ') AND type = ' + CHAR(39) + 'D' + CHAR(39) + ') ALTER TABLE [dbo].[' + @FullTableName + '] DROP CONSTRAINT [' + @MDateConstraintName + ']'
		EXECUTE (@Task)

		SET @Task = N'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' + CHAR(39) + 'dbo.' + @SortConstraintName + CHAR(39) + ') AND type = ' + CHAR(39) + 'D' + CHAR(39) + ') ALTER TABLE [dbo].[' + @FullTableName + '] DROP CONSTRAINT [' + @SortConstraintName + ']'
		EXECUTE (@Task)

		SET @Task = N'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N' + CHAR(39) + 'dbo.' + @IDConstraintName + CHAR(39) + ') AND type = ' + CHAR(39) + 'D' + CHAR(39) + ') ALTER TABLE [dbo].[' + @FullTableName + '] DROP CONSTRAINT [' + @IDConstraintName + ']'
		EXECUTE (@Task)
	END

	ELSE
	BEGIN
		-- Add Table.
		SET @Task = N'CREATE TABLE ' + @FullTableName + N'('
		SET @Task = @Task + N' [ItemValue] [nvarchar](200) NOT NULL,'
		SET @Task = @Task + N' [ItemKey] [nvarchar](30) NOT NULL,'
		SET @Task = @Task + N' [Active] [int] NULL,'
		SET @Task = @Task + N' [CUser] [nvarchar](50) NULL,'
		SET @Task = @Task + N' [CDate] [datetime] NULL,'
		SET @Task = @Task + N' [MUser] [nvarchar](50) NULL,'
		SET @Task = @Task + N' [MDate] [datetime] NULL,'
		SET @Task = @Task + N' [ItemSort] [nvarchar](5) NULL,'
		SET @Task = @Task + N' [ItemID] [uniqueidentifier] ROWGUIDCOL NOT NULL,'
		SET @Task = @Task + N' CONSTRAINT ' + @PKConstraintName + N' PRIMARY KEY CLUSTERED'
		SET @Task = @Task + N' ([ItemID] ASC)'
		SET @Task = @Task + N' WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY])'
		SET @Task = @Task + N' ON [PRIMARY]'
		EXECUTE (@Task)


		-- Add to pControlPanel table.
		SET @Task = N'INSERT INTO pControlPanel (ControlPanelID,'
		SET @Task = @Task + N' ControlPanelName,'
		SET @Task = @Task + N' ControlPanelDescription,'
		SET @Task = @Task + N' ControlPanelOrder,'
		SET @Task = @Task + N' ControlPanelSchema,'
		SET @Task = @Task + N' ControlPanelSearchSchema,'
		SET @Task = @Task + N' ControlPanelTableName,'
		SET @Task = @Task + N' ControlPanelUrl,'
		SET @Task = @Task + N' IsDataValidation)'
		SET @Task = @Task + N' SELECT COALESCE(MAX(ControlPanelID),0) + 1,'
		SET @Task = @Task + N' ' + CHAR(39) + REPLACE(@ControlPanelName, '''', '''''') + CHAR(39) + N','
		SET @Task = @Task + N' ' + CHAR(39) + REPLACE(@DVDescription, '''', '''''') + CHAR(39) + N','
		SET @Task = @Task + N' COALESCE(MAX(ControlPanelOrder),0) + 1,'
		SET @Task = @Task + N' ' + CHAR(39) + N'Control_DV_' + @FullTableName + N'_Default.xml' + CHAR(39) + N','
		SET @Task = @Task + N' ' + CHAR(39) + N'Control_DV_' + @FullTableName + N'_Search.xml' + CHAR(39) + N','
		SET @Task = @Task + N' ' + CHAR(39) + @FullTableName + CHAR(39) + N','
		SET @Task = @Task + N' ' + CHAR(39) + N'Control_DataValidation_Table_List.aspx?CPID=' + CHAR(39) + N' + convert(varchar(12), COALESCE(MAX(ControlPanelID),0) + 1),'
		SET @Task = @Task + N' 1'
		SET @Task = @Task + N' FROM pControlPanel'
		EXECUTE (@Task)
	END


	-- Add Constraints.
	SET @Task = N'ALTER TABLE ' + @FullTableName + N' ADD CONSTRAINT [' + @ValueConstraintName + N'] UNIQUE (ItemValue)'
	EXECUTE (@Task)

	SET @Task = N'ALTER TABLE ' + @FullTableName + N' ADD CONSTRAINT [' + @KeyConstraintName + N'] UNIQUE (ItemKey)'
	EXECUTE (@Task)

	SET @Task = N'ALTER TABLE ' + @FullTableName + N' ADD CONSTRAINT [' + @ActiveConstraintName + N'] DEFAULT (1) FOR [Active]'
	EXECUTE (@Task)

	SET @Task = N'ALTER TABLE ' + @FullTableName + N' ADD CONSTRAINT [' + @CDateConstraintName + N'] DEFAULT (getutcdate()) FOR [CDate]'
	EXECUTE (@Task)

	SET @Task = N'ALTER TABLE ' + @FullTableName + N' ADD CONSTRAINT [' + @MDateConstraintName + N'] DEFAULT (getutcdate()) FOR [MDate]'
	EXECUTE (@Task)

	SET @Task = N'ALTER TABLE ' + @FullTableName + N' ADD CONSTRAINT [' + @SortConstraintName + N'] DEFAULT (' + CHAR(39) + N'00000' + CHAR(39) + N') FOR [ItemSort]'
	EXECUTE (@Task)

	SET @Task = N'ALTER TABLE ' + @FullTableName + N' ADD CONSTRAINT [' + @IDConstraintName + N'] DEFAULT (newid()) FOR [ItemID]'
	EXECUTE (@Task)


	-- Get the record from pControlPanel for this lookup table.
	SET @Task = N'SELECT * FROM pControlPanel WHERE ControlPanelName = ' + CHAR(39) + REPLACE(@ControlPanelName, '''', '''''') + CHAR(39)
	EXECUTE (@Task)
END
GO


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0', '09247', GetDate())
GO
