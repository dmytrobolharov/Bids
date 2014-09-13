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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecAdHoc_SELECT]    Script Date: 12/18/2011 18:41:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecAdHoc_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecAdHoc_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecAdHoc_SELECT]    Script Date: 12/18/2011 18:41:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comment #01 - Oct 21 2009 - Ryan Cabanas
 Modified Select to grab MAX value instead of COUNT because if you deleted a lower level adhoc POM it would not add the next POM properly.
*/


Create PROCEDURE [dbo].[spx_SampleRequestBOMSpecAdHoc_SELECT]
(
	@SampleRequestWorkflowID uniqueidentifier,
	@SampleRequestTradeID uniqueidentifier,	
	@StyleID uniqueidentifier,
	@StyleSet int,
	@Submit int,
	@PomCodeDefault varchar(5)
)
AS 



SELECT MAX(RIGHT(POM, 2)) --#01
FROM  pSampleRequestSpecItemBOM WITH (NOLOCK)
WHERE     
((SampleRequestWorkflowID = @SampleRequestWorkflowID) AND 
(SampleRequestTradeID = @SampleRequestTradeID) AND 
(StyleID = @StyleID) AND 
(StyleSet = @StyleSet) AND
(Submit = @Submit)) AND 
(POM LIKE @PomCodeDefault + '%')

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02417'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02417', GetDate())

END

GO