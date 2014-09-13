-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 25 Nov 2011                                                                               */
-- * WorkItem #5775                                                                             */
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

/****** Object:  StoredProcedure [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_Header_SELECT]    Script Date: 11/25/2011 16:23:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ControlPanel_MeasurementPOMTemplate_Header_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_Header_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_Header_SELECT]    Script Date: 11/25/2011 16:23:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_Header_SELECT]
(
	@POMTempID VARCHAR(50)
)
AS
BEGIN
	SELECT SizeClass
	FROM pGRMeasurementsPOMTemplate
	WHERE POMTempID = @POMTempID
END

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02208'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02208', GetDate())
	END
GO

