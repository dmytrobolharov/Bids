-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowSubmitBOMTemp_DELETE]    Script Date: 12/18/2011 18:14:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowSubmitBOMTemp_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowSubmitBOMTemp_DELETE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowSubmitBOMTemp_DELETE]    Script Date: 12/18/2011 18:14:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowSubmitBOMTemp_DELETE]

(

@UserName nvarchar(200)

)


AS

--DELETE FROM pSampleRequestSetItemTemp WHERE SampleRequestGroupID = @SampleRequestGroupID
DELETE FROM pSampleRequestWorkflowBOMTemp WHERE MUser = @UserName
DELETE FROM pSampleRequestSubmitBOMTemp WHERE MUser = @UserName
DELETE FROM pSampleRequestMaterialBOMTemp WHERE MUser = @UserName
DELETE FROM pSampleRequestSpecItemTemp WHERE MUser = @UserName
DELETE FROM pSampleRequestSpecSizeBOMTemp WHERE MUser = @UserName
	

	

	

	

	

	

	

	


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02387'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02387', GetDate())

END

GO