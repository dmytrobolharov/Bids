-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 12 June 2012                                                                               */
-- * WorkItem #7485 & #7173                                                                      */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */

/****** Object:  StoredProcedure [dbo].[spx_pImageWFValidation_INSERT]    Script Date: 06/12/2012 15:02:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pImageWFValidation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pImageWFValidation_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_pImageWFValidation_INSERT]    Script Date: 06/12/2012 15:02:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

GO

CREATE PROCEDURE [dbo].[spx_pImageWFValidation_INSERT]
	-- Add the parameters for the stored procedure here
	@WorkFlowID AS UNIQUEIDENTIFIER,
	@WorkFlowName AS NVARCHAR(100),
	@CUser AS NVARCHAR(100)
AS
BEGIN
	IF NOT EXISTS(SELECT WORKFLOWID FROM pImageWFValidation WHERE WorkflowID=@WorkFlowID)	
	BEGIN
	
		INSERT INTO [pImageWFValidation]
			   (
			   [CustomID]
			   ,[WorkflowID]
			   ,[CustomKey]			   
			   ,[CUser]
			   ,[CDate]      
			   )
		 VALUES
			   (
			   NEWID()
			   ,@WorkFlowID
			   ,@WorkFlowName			  
			   ,@CUser
			   ,GETDATE()
			   )	           
	END
		
END

GO

EXEC spx_pImageWFValidation_INSERT '40000000-0000-0000-0000-000000000080','Dimensional BOM Image','GerberAdmin'
GO

EXEC spx_pImageWFValidation_INSERT '80000000-0000-0000-0000-000000000008','Process Detail Image','GerberAdmin'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03617', GetDate())
	
GO

