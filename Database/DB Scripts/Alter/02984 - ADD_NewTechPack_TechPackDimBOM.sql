-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 23 January 2012                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
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

IF (SELECT COUNT(*) FROM rReportTechPackFolder WHERE ReportTechPackFolderID = 'F1000000-0000-0000-0000-000000000014') = 0
BEGIN

	INSERT INTO rReportTechPackFolder (ReportTechPackFolderID, ReportTechPackFolderName, ReportTechPackFormName, ReportTechPackGroup, ReportTechPackFinal, CDate, CUser, MDate, MUser, Sort, Active)
	VALUES ('F1000000-0000-0000-0000-000000000014', 'Tech Pack (Dim BOM)', 'Style_Coversheet_LLT', 0, 1, GETUTCDATE(), 'Yunique''s Team', GETUTCDATE(), 'Yunique''s Team', '00008', 1)

	-- Style Comments
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Style Comments'
		,'Style Comments'
		,'SQL'
		,'Style_Comments_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,0
		,'PDF'
		,1
		,'001'
		,NULL
		,0)

	-- Style Detail
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Style Detail'
		,'Style Detail Page'
		,'SQL'
		,'Style_StyleDetailTab_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,0
		,'PDF'
		,1
		,'002'
		,NULL
		,0)


	-- Seasonal Colorway
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Colorway'
		,'Style Colorway'
		,'SQL'
		,'Style_MaterialColorway_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,0
		,'PDF'
		,1
		,'003'
		,NULL
		,0)

	-- Colorway
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Colorway'
		,'Style Colorway'
		,'SQL'
		,'Style_MaterialColorway_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,0
		,'PDF'
		,1
		,'004'
		,NULL
		,0)

	-- Dimensional BOM
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Dimensional BOM'
		,'Dimensional BOM'
		,'SQL'
		,'Style_mBOM_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,1
		,'PDF'
		,1
		,'005'
		,'40000000-0000-0000-0000-000000000080'
		,0)

	-- Design Detail
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Design Detail Grid'
		,'Style Design Detail Grid'
		,'SQL'
		,'Style_DesignDetailGrid_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,1
		,'PDF'
		,1
		,'006'
		,NULL
		,0)

	-- Text Image
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Text-Image Images With Text'
		,'Text-Image'
		,'SQL'
		,'Style_DesignDetail2_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,1
		,'PDF'
		,1
		,'007'
		,'40000000-0000-0000-0000-000000000018'
		,0)

	-- Process Details
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Process Details & 3 User Defined'
		,'Style Process Details'
		,'SQL'
		,'Style_ConstructionDetails_2_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,1
		,'PDF'
		,1
		,'008'
		,'80000000-0000-0000-0000-000000000008'
		,0)

	-- Measurement Imperial View
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Measurement Imperial View'
		,'Style Measurement'
		,'SQL'
		,'Style_Measurement_Imperial_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,1
		,'PDF'
		,1
		,'009'
		,'40000000-0000-0000-0000-000000000050'
		,0)

	-- Measurement Worksheet
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Measurement WorkSheet'
		,'Style Measurement'
		,'SQL'
		,'Style_Measurement_Worksheet_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,0
		,'PDF'
		,1
		,'010'
		,'40000000-0000-0000-0000-000000000050'
		,0)

	-- Model - 21 Images per Page
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Model - 21 Images per Page'
		,'Model - 21 Images per Page'
		,'SQL'
		,'Style_Model_7x3_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,1
		,'PDF'
		,1
		,'011'
		,NULL
		,0)

	-- Marker - 1 Image per Page - Imperial
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Marker - 1 Image per Page - Imperial'
		,'Marker - 1 Image per Page - Imperial'
		,'SQL'
		,'Style_Marker_1x1_Imperial_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,1
		,'PDF'
		,1
		,'012'
		,NULL
		,0)

	-- Material Artwork (Two Image Per Page)
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Material Artwork (Two Image Per Page)'
		,'Style Material Artwork 2 Per Page'
		,'SQL'
		,'Style_MaterialArtwork_2_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,1
		,'PDF'
		,1
		,'013'
		,NULL
		,0)

	-- Style Care
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Style Care'
		,'Style Care Instruction'
		,'SQL'
		,'Style_Care_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,1
		,'PDF'
		,1
		,'014'
		,NULL
		,0)

	-- Style Tech Pack Change Log
	INSERT INTO rReportTechPackPageItem
		(ReportTechPackPageID
		,ReportTechPackFolderID
		,ReportPageTypeID
		,ReportTemplateName
		,ReportPageName
		,ReportPageDescription
		,ReportServerType
		,ReportFormName
		,ReportPageURL
		,ReportPKIField
		,ReportPageActive
		,ReportPageFormat
		,ReportPageBySet
		,ReportPageSort
		,ReportMapID
		,ReportSourcing)
	VALUES
		(NEWID()
		,'f1000000-0000-0000-0000-000000000014'
		,'00000000-0000-0000-0000-000000000000'
		,'Style_Header_LLT'
		,'Style Tech Pack Change Log'
		,'Style Tech Pack Change Log'
		,'SQL'
		,'Style_TechPack_ChangeLog_Body_LLT'
		,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
		,'StyleID'
		,1
		,'PDF'
		,1
		,'015'
		,NULL
		,0)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '02984', GetDate())
GO

SET NOCOUNT Off
GO
