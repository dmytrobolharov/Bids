
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 16 Nov 2011																				*/
-- * WorkItem #1605																				*/
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  UserDefinedFunction [dbo].[fnx_GetTableName]    Script Date: 11/16/2011 14:47:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetTableName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetTableName]
GO



/****** Object:  UserDefinedFunction [dbo].[fnx_GetTableName]    Script Date: 11/16/2011 14:47:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnx_GetTableName]
(
    @LookUpString VARCHAR(200) = NULL
)

RETURNS NVARCHAR(255)

AS

BEGIN
    DECLARE @CST VARCHAR (200)
    DECLARE @CSV VARCHAR (200)    
    SET @CST = @LookUpString
    SET @CSV = LTRIM(SUBSTRING(@CST, CHARINDEX('FROM',@CST) + 4,LEN(@CST)))
    SET @CSV = SUBSTRING(@CSV,1,CHARINDEX(' ',@CSV))
    RETURN @CSV
END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02184'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02184', GetDate())
	END
GO