-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 11 June 2010                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */                                                                     */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS                                                                                    
--
--
--set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MeasurementLibraryVariation_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MeasurementLibraryVariation_DELETE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pGRGradeType_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pGRGradeType_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_pGRAlternates_DELETE]
(@AlternatesGuidID uniqueidentifier)
AS 

DELETE FROM dbo.pGRAlternates WHERE AlternatesGuidID = @AlternatesGuidID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '241', GetDate())
GO

