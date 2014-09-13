-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 21 September2010                                                                               */
-- *                                                                                            */
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
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select * from sysobjects where id = object_id('spx_Style_Model_DELETE') and sysstat & 0xf = 4)
    drop procedure spx_Style_Model_DELETE
GO


CREATE PROCEDURE [dbo].[spx_Style_Model_DELETE]
(
@StyleID uniqueidentifier,
@ID uniqueidentifier
)
AS 

DELETE FROM pBodyPatternSheetModel WHERE StyleID = @StyleID and ID = @ID

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01225', GetDate())
GO


