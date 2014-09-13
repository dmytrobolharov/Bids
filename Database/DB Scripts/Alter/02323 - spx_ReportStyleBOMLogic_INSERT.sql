
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 16 Dec 2011                                                                                */
-- * WorkItem #5300                                                                             */
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

/****** Object:  StoredProcedure [dbo].[spx_ReportStyleBOMLogic_INSERT]    Script Date: 12/16/2011 12:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ReportStyleBOMLogic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ReportStyleBOMLogic_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ReportStyleBOMLogic_INSERT]    Script Date: 12/16/2011 12:38:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_ReportStyleBOMLogic_INSERT]
(
	@StyleId VARCHAR(255),   
	@StyleSet INT,
	@WorkflowItemID varchar(255),
	@StyleRequestBodyXml XML		
)
AS

BEGIN

	IF(NOT EXISTS(SELECT * FROM pStyleBOMXML WHERE StyleID=@StyleId 
	AND StyleSet=@StyleSet AND WorkflowItemID=@WorkflowItemID ))
	BEGIN
		INSERT INTO [pStyleBOMXML]
		   ([StyleID]
		   ,[StyleSet]
		   ,[WorkflowItemID]
		   ,[SchemaXML])
		VALUES
		   (
		   @StyleId
		   ,@StyleSet
		   ,@WorkflowItemID
		   ,@StyleRequestBodyXml
		   )
	END	
	ELSE
	BEGIN
		DELETE FROM pStyleBOMXML WHERE StyleID=@StyleId AND StyleSet=@StyleSet 
		AND WorkflowItemID=@WorkflowItemID

		INSERT INTO [pStyleBOMXML]
		   ([StyleID]
		   ,[StyleSet]
		   ,[WorkflowItemID]
		   ,[SchemaXML])
		VALUES
		   (
		   @StyleId
		   ,@StyleSet
		   ,@WorkflowItemID
		   ,@StyleRequestBodyXml
		   )
	END	
END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02323'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02323', GetDate())

END

