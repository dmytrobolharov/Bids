-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 07 February 2014                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
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
    DECLARE @ConstraintName nvarchar(63)

    SET @FullTableName = 'dvt' + @DVTableName
    SET @PKConstraintName = 'PK_' + @FullTableName
    SET @ConstraintName = 'DF_' + @FullTableName + '_ItemID'

    SET @Task = 'IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N' + CHAR(39) + @FullTableName + CHAR(39) + ') DROP TABLE ' + @FullTableName
    EXECUTE (@Task)


    SET @Task = 'CREATE TABLE ' + @FullTableName + '('
    SET @Task = @Task + ' [ItemValue] [nvarchar](200) NOT NULL,'
    SET @Task = @Task + ' [ItemKey] [nvarchar](30) NOT NULL,'
    SET @Task = @Task + ' [Active] [int] NULL,'
    SET @Task = @Task + ' [CUser] [nvarchar](50) NULL,'
    SET @Task = @Task + ' [CDate] [datetime] NULL,'
    SET @Task = @Task + ' [MUser] [nvarchar](50) NULL,'
    SET @Task = @Task + ' [MDate] [datetime] NULL,'
    SET @Task = @Task + ' [ItemSort] [nvarchar](5) NULL,'
    SET @Task = @Task + ' [ItemID] [uniqueidentifier] ROWGUIDCOL NOT NULL,'
    SET @Task = @Task + ' CONSTRAINT ' + @PKConstraintName + ' PRIMARY KEY CLUSTERED'
    SET @Task = @Task + ' ([ItemID] ASC)'
    SET @Task = @Task + ' WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY])'
    SET @Task = @Task + ' ON [PRIMARY]'
    EXECUTE (@Task)


    SET @Task = 'ALTER TABLE ' + @FullTableName + ' ADD CONSTRAINT ' + @ConstraintName + ' DEFAULT (newid()) FOR [ItemID]'
    EXECUTE (@Task)


    SET @Task = 'INSERT INTO pControlPanel (ControlPanelID,'
    SET @Task = @Task + ' ControlPanelName,'
    SET @Task = @Task + ' ControlPanelDescription,'
    SET @Task = @Task + ' ControlPanelOrder,'
    SET @Task = @Task + ' ControlPanelSchema,'
    SET @Task = @Task + ' ControlPanelSearchSchema,'
    SET @Task = @Task + ' ControlPanelTableName,'
    SET @Task = @Task + ' ControlPanelUrl,'
    SET @Task = @Task + ' IsDataValidation)'
    SET @Task = @Task + ' SELECT COALESCE(MAX(ControlPanelID),0) + 1,'
    SET @Task = @Task + ' ' + CHAR(39) + REPLACE(@ControlPanelName, '''', '''''') + CHAR(39) + ','
    SET @Task = @Task + ' ' + CHAR(39) + REPLACE(@DVDescription, '''', '''''') + CHAR(39) + ','
    SET @Task = @Task + ' COALESCE(MAX(ControlPanelOrder),0) + 1,'
    SET @Task = @Task + ' ' + CHAR(39) + 'Control_DV_' + @FullTableName + '_Default.xml' + CHAR(39) + ','
    SET @Task = @Task + ' ' + CHAR(39) + 'Control_DV_' + @FullTableName + '_Search.xml' + CHAR(39) + ','
    SET @Task = @Task + ' ' + CHAR(39) + @FullTableName + CHAR(39) + ','
    SET @Task = @Task + ' ' + CHAR(39) + 'Control_DataValidation_Table_List.aspx?CPID=' + CHAR(39) + ' + convert(varchar(12), COALESCE(MAX(ControlPanelID),0) + 1),'
    SET @Task = @Task + ' 1'
    SET @Task = @Task + ' FROM pControlPanel'
    EXECUTE (@Task)

END
GO


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07094', GetDate())
GO
