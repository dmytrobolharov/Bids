-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 5 July 2011                                                                                */
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


IF EXISTS (select * from sysobjects where id = object_id('spx_TechPackReport_PageItemtemp_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_TechPackReport_PageItemtemp_INSERT
GO


CREATE PROCEDURE spx_TechPackReport_PageItemtemp_INSERT
(
@ReportTechpackID UNIQUEIDENTIFIER,
@ReportPageID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@TechPackName NVARCHAR(200),
@Sort INT,
@StyleColorwaySeasonYearID UNIQUEIDENTIFIER,
@SystemCultureId uniqueidentifier = NULL
) 
AS   

INSERT INTO rReportStylePageItemTemp (ReportStylePageItem, ReportPageID, ReportTechPackID, ReportMapID, ReportPageTypeID, 
                                      ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, 
                                      ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, 
                                      ReportSrmOn, StyleID, StyleSet, Sort, TechPackName, StyleColorwaySeasonYearID, 
                                      SystemCultureId) 
SELECT NEWID() AS ReportStylePageItem, ReportPageID, @ReportTechpackID AS RerportTechPackID, ReportMapID, ReportPageTypeID, 
       ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, 
       ReportPageActive, ReportPageFormat, ReportSrmOn, @StyleID AS StyleID, @StyleSet AS StyleSet, @Sort AS Sort, 
       @TechPackName AS TechPackName, @StyleColorwaySeasonYearID AS StyleColorwaySeasonYearID, @SystemCultureId
FROM rReportStylePageItem 
WHERE ReportPageID = @ReportPageID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '4.1.0000', '01630', GetDate())
GO
