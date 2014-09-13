
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 15 Feb 2012																				*/
-- * WorkItem #6961																				*/
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

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_PageItemtemp_INSERT]    Script Date: 02/15/2012 17:29:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_PageItemtemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_PageItemtemp_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_PageItemtemp_INSERT]    Script Date: 02/15/2012 17:29:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TechPackReport_PageItemtemp_INSERT]
    @ReportTechpackID [uniqueidentifier],
    @ReportPageID [uniqueidentifier],
    @WorkflowItemID [uniqueidentifier],
    @WorkflowID [uniqueidentifier] =NULL,
    @SeasonYearID [uniqueidentifier] =NULL,
    @StyleDevelopmentID [uniqueidentifier] =NULL,
    @StyleHeaderID [uniqueidentifier] =NULL,
    @StyleID [uniqueidentifier],
    @StyleSet [int],
    @TechPackName [nvarchar](200),
    @TechPackFinal [int]=NULL,
    @Sort [int],
    @StyleColorwaySeasonYearID [uniqueidentifier],
    @IsTechPackOnTheFly [int] = NULL,
    @SystemCultureId [uniqueidentifier] =NULL
WITH EXECUTE AS CALLER
AS
IF @IsTechPackOnTheFly = 1
    BEGIN
        INSERT INTO rReportStylePageItemTemp  (ReportStylePageItemID , ReportPageID , ReportTechPackID , ReportMapID , ReportPageTypeID ,
            ReportTemplateName, ReportPageName , ReportPageDescription,
            ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID ,
            StyleID, StyleDevelopmentID, StyleSet, Sort , TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID)
        SELECT NEWID() AS ReportStylePageItemID, ReportPageID ,  @ReportTechpackID ,  ReportMapID ,  ReportPageTypeID ,
            ReportTemplateName, ReportPageName , ReportPageDescription,
            ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, @SeasonYearID, @StyleHeaderID,
            @StyleID, @StyleDevelopmentID, @StyleSet, @Sort, @TechPackName, @TechPackFinal, @StyleColorwaySeasonYearID,
            @WorkflowItemID, @WorkflowID
        FROM rReportStylePageItem WHERE ReportPageID= @ReportPageID
    END
ELSE
    BEGIN
        INSERT INTO rReportStylePageItemTemp  (ReportStylePageItemID , ReportPageID , ReportTechPackID , ReportMapID , ReportPageTypeID ,
            ReportTemplateName, ReportPageName , ReportPageDescription,
            ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID ,
            StyleID, StyleDevelopmentID, StyleSet, Sort , TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID)
        SELECT NEWID() AS ReportStylePageItemID, ReportTechPackPageID ,  @ReportTechpackID,  ReportMapID ,  ReportPageTypeID ,
            ReportTemplateName, ReportPageName , ReportPageDescription,
            ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, 0, @SeasonYearID, @StyleHeaderID,
            @StyleID, @StyleDevelopmentID, @StyleSet, @Sort, @TechPackName, @TechPackFinal, @StyleColorwaySeasonYearID,
            @WorkflowItemID, @WorkflowID
        FROM rReportTechPackPageItem WHERE ReportTechPackPageID= @ReportPageID
    END
    
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03126'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03126', GetDate())

END

GO