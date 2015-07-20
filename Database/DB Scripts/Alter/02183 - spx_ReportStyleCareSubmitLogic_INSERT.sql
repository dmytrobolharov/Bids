
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 16 Nov 2011                                                                               */
-- * WorkItem #1605                                                                             */
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

/****** Object:  StoredProcedure [dbo].[spx_ReportStyleCareSubmitLogic_INSERT]    Script Date: 11/16/2011 02:03:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ReportStyleCareSubmitLogic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ReportStyleCareSubmitLogic_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ReportStyleCareSubmitLogic_INSERT]    Script Date: 11/16/2011 02:03:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ReportStyleCareSubmitLogic_INSERT]
(
	@StyleId VARCHAR(255),   
	@StyleSet INT,	
	@StyleRequestBodyXml XML		
)
AS

BEGIN

	IF(NOT EXISTS(SELECT * FROM pStyleCareXML WHERE StyleID=@StyleId AND StyleSet=@StyleSet ))
	BEGIN
		INSERT INTO [pStyleCareXML]
		   ([StyleID]
		   ,[StyleSet]
		   ,[SchemaXML])
		VALUES
		   (
		   @StyleId
		   ,@StyleSet
		   ,@StyleRequestBodyXml
		   )
	END	
	ELSE
	BEGIN
		DELETE FROM pStyleCareXML WHERE StyleID=@StyleId AND StyleSet=@StyleSet

		INSERT INTO [pStyleCareXML]
		   ([StyleID]
		   ,[StyleSet]
		   ,[SchemaXML])
		VALUES
		   (
		   @StyleId
		   ,@StyleSet
		   ,@StyleRequestBodyXml
		   )
	END	
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02183'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02183', GetDate())

END

GO
