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


IF EXISTS (select * from sysobjects where id = object_id('spx_TechPackStyleDevelopment_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_TechPackStyleDevelopment_INSERT
GO


CREATE PROCEDURE spx_TechPackStyleDevelopment_INSERT
(
@StyleID uniqueidentifier,
@DataXmlId uniqueidentifier,
@CreatedBy varchar(200),
@CreatedDate datetime,
@StyleColorwaySeasonYearID uniqueidentifier, 
@SystemCultureId uniqueidentifier = NULL
) 
AS   

DECLARE @StyleDevelopmentID uniqueidentifier
DECLARE @StyleVariation int

SELECT @StyleDevelopmentId = StyleDevelopmentId, @StyleVariation = ISNULL(Variation,1) 
FROM pStyleDevelopmentItem WITH (NOLOCK) 
WHERE StyleID = @StyleID

BEGIN
	INSERT INTO rReportStyleTemp (DataXmlId, StyleDevelopmentId, StyleId, CUser, CDate, StyleColorwaySeasonYearID, SystemCultureId)
	SELECT @DataXmlId, StyleDevelopmentID, StyleID, @CreatedBy, @CreatedDate, @StyleColorwaySeasonYearID, @SystemCultureId
	FROM pStyleDevelopmentItem WITH (NOLOCK)
	WHERE StyleDevelopmentId = @StyleDevelopmentId AND Variation = @StyleVariation
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '4.1.0000', '01628', GetDate())
GO
