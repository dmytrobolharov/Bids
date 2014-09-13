-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 26 August 2011                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'vwx_ColumnTypeDataType_SELECT') AND type = N'V')
	DROP VIEW vwx_ColumnTypeDataType_SELECT
GO

CREATE VIEW vwx_ColumnTypeDataType_SELECT
AS
	SELECT a.ColumnTypeID, a.ColumnDataTypeID, a.CUser, a.CDate, a.MUser, a.MDate, 
	       b.ColumnTypeName, c.ColumnDataTypeName
	FROM dColumnTypeDataType a
	INNER JOIN dColumnType b ON a.ColumnTypeID = b.ColumnTypeID
	INNER JOIN dColumnDataType c ON a.ColumnDataTypeID = c.ColumnDataTypeID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01792', GetDate())
GO

SET NOCOUNT Off
GO
