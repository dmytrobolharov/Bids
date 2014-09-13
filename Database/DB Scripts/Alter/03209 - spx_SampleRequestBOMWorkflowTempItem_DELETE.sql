-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 7 March 2012                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflowTempItem_DELETE]    Script Date: 03/08/2012 13:33:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMWorkflowTempItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowTempItem_DELETE]

GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflowTempItem_DELETE]    Script Date: 03/08/2012 13:33:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowTempItem_DELETE]
(
@SampleRequestGroupID uniqueidentifier,
@SampleWorkflowID nvarchar(10) ,
@StyleID nvarchar (50)
)
AS
BEGIN  

    DELETE FROM  pSampleRequestWorkflowBOMTemp
    WHERE SampleRequestGroupID = @SampleRequestGroupID
    AND SampleWorkflowID = @SampleWorkflowID
    AND StyleID  =  @StyleID
    
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03209'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03209', GetDate())

END

GO