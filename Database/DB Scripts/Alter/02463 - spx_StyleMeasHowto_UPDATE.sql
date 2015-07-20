-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 19 Dec 2011                                                                                */
-- * WorkItem #6368																				*/
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

/****** Object:  StoredProcedure [dbo].[spx_StyleMeasHowto_UPDATE]    Script Date: 12/19/2011 19:25:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasHowto_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeasHowto_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_StyleMeasHowto_UPDATE]    Script Date: 12/19/2011 19:25:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMeasHowto_UPDATE]
(@AMLMeasHdrId uniqueidentifier,
@AMLMeasPOMId uniqueidentifier,
@Refcode nvarchar(10),
@How2MeasText nvarchar(4000),
@ImageId nvarchar(50),
@ModifiedBy nvarchar(200),
@ModifiedDate datetime
)
AS 
BEGIN
IF LEN(@ImageId) > 0 

	BEGIN
		UPDATE pGRMeasurementsPOM SET How2MeasText=@How2MeasText, ImageId= CAST(@ImageId AS NVARCHAR(50)), MUser=@ModifiedBy, MDate=@ModifiedDate 
		WHERE
		POMId=@AMLMeasPOMId AND POMCode=@Refcode
	END
ELSE
	BEGIN
		UPDATE pGRMeasurementsPOM SET How2MeasText=@How2MeasText, MUser=@ModifiedBy, MDate=@ModifiedDate 
		WHERE
		POMId=@AMLMeasPOMId and POMCode=@Refcode
	END
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02463'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02463', GetDate())

END

GO