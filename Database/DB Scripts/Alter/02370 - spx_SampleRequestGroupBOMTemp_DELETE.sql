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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestGroupBOMTemp_DELETE]    Script Date: 12/18/2011 18:03:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestGroupBOMTemp_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestGroupBOMTemp_DELETE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestGroupBOMTemp_DELETE]    Script Date: 12/18/2011 18:03:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_SampleRequestGroupBOMTemp_DELETE]
(
@SampleRequestGroupID uniqueidentifier
)

AS

DELETE FROM pSampleRequestSubmitBOMTemp WHERE SampleRequestGroupID = @SampleRequestGroupID
DELETE FROM pSampleRequestStyleBOMTemp WHERE SampleRequestGroupID = @SampleRequestGroupID
DELETE FROM pSampleRequestSetBOMItemTemp WHERE SampleRequestGroupID = @SampleRequestGroupID
DELETE FROM pSampleRequestWorkflowBOMTemp WHERE SampleRequestGroupID = @SampleRequestGroupID
DELETE FROM pSampleRequestStyleSourcingBOMTemp WHERE SampleRequestGroupID = @SampleRequestGroupID

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02370'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02370', GetDate())

END

GO