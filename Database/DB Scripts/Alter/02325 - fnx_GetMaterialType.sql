
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 16 Dec 2011                                                                                */
-- * WorkItem #5300                                                                             */
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

/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialType]    Script Date: 12/16/2011 12:55:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialType]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialType]
GO



/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialType]    Script Date: 12/16/2011 12:55:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[fnx_GetMaterialType]
(
    @MaterialTypeID INT
)

RETURNS NVARCHAR(255)

AS

BEGIN
    DECLARE @MaterialType VARCHAR (255)

	SELECT @MaterialType=ComponentDescription FROM pComponentType WHERE ComponentTypeID=@MaterialTypeID

    RETURN @MaterialType
END


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02325'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02325', GetDate())

END

GO

