-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 27 April 2011                                                                              */
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DataDictionaryValidator_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_DataDictionaryValidator_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_DataDictionaryValidator_SELECT] 
(
    @ColumnID uniqueidentifier = NULL
)
AS
BEGIN

    IF @ColumnID IS NULL
    BEGIN

        SELECT ddv.*, vc.ItemValue AS ValidatorClass, vt.ItemValue AS ValidatorType
        FROM dDataDictionaryValidator ddv
        INNER JOIN dvtValidatorClass vc ON ddv.ColumnValidatorClassID = vc.ItemID
        LEFT OUTER JOIN dvtValidatorType vt ON ddv.ColumnValidatorTypeID = vt.ItemID
        ORDER BY ddv.ColumnID, vc.ItemValue

    END

    ELSE
    BEGIN

        SELECT ddv.*, vc.ItemValue AS ValidatorClass, vt.ItemValue AS ValidatorType
        FROM dDataDictionaryValidator ddv
        INNER JOIN dvtValidatorClass vc ON ddv.ColumnValidatorClassID = vc.ItemID
        LEFT OUTER JOIN dvtValidatorType vt ON ddv.ColumnValidatorTypeID = vt.ItemID
        WHERE ddv.ColumnID = @ColumnID

    END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01691', GetDate())
GO

SET NOCOUNT Off
GO
