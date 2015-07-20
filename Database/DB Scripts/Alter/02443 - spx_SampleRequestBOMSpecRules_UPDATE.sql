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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecRules_UPDATE]    Script Date: 12/18/2011 18:59:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecRules_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecRules_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecRules_UPDATE]    Script Date: 12/18/2011 18:59:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_SampleRequestBOMSpecRules_UPDATE]
(@SampleRequestTradeID uniqueidentifier,
@SampleRequestWorkflowID uniqueidentifier,
@Submit int,
@StyleID uniqueidentifier,
@StyleSet int)
AS 
	
BEGIN

		UPDATE pSampleRequestSpecItemBOM  SET    
			pSampleRequestSpecItemBOM.Proto0 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto1 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto2 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto3 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto4 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto5 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto6 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto7 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto8 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto9 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto10 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto11 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto12 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto13 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto14 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto15 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto16 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto17 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto18 = pStyleSpec.Spec, 
			pSampleRequestSpecItemBOM.Proto19 = pStyleSpec.Spec,
			pSampleRequestSpecItemBOM.Grade0 = pStyleSpec.Grade0, 
			pSampleRequestSpecItemBOM.Grade1 = pStyleSpec.Grade1, 
			pSampleRequestSpecItemBOM.Grade2 = pStyleSpec.Grade2, 
			pSampleRequestSpecItemBOM.Grade3 = pStyleSpec.Grade3, 
			pSampleRequestSpecItemBOM.Grade4 = pStyleSpec.Grade4, 
			pSampleRequestSpecItemBOM.Grade5 = pStyleSpec.Grade5, 
			pSampleRequestSpecItemBOM.Grade6 = pStyleSpec.Grade6, 
			pSampleRequestSpecItemBOM.Grade7 = pStyleSpec.Grade7, 
			pSampleRequestSpecItemBOM.Grade8 = pStyleSpec.Grade8, 
			pSampleRequestSpecItemBOM.Grade9 = pStyleSpec.Grade9, 
			pSampleRequestSpecItemBOM.Grade10 = pStyleSpec.Grade10, 
			pSampleRequestSpecItemBOM.Grade11 = pStyleSpec.Grade11, 
			pSampleRequestSpecItemBOM.Grade12 = pStyleSpec.Grade12, 
			pSampleRequestSpecItemBOM.Grade13 = pStyleSpec.Grade13, 
			pSampleRequestSpecItemBOM.Grade14 = pStyleSpec.Grade14, 
			pSampleRequestSpecItemBOM.Grade15 = pStyleSpec.Grade15, 
			pSampleRequestSpecItemBOM.Grade16 = pStyleSpec.Grade16, 
			pSampleRequestSpecItemBOM.Grade17 = pStyleSpec.Grade17, 
			pSampleRequestSpecItemBOM.Grade18 = pStyleSpec.Grade18, 
			pSampleRequestSpecItemBOM.Grade19 = pStyleSpec.Grade19
		FROM  pSampleRequestSpecItemBOM INNER JOIN
              pStyleSpec ON pStyleSpec.POM = pSampleRequestSpecItemBOM.POM AND pSampleRequestSpecItemBOM.StyleID = pStyleSpec.StyleID AND 
              pSampleRequestSpecItemBOM.StyleSet = pStyleSpec.StyleSet
		WHERE (pSampleRequestSpecItemBOM.SampleRequestTradeID = @SampleRequestTradeID) AND 
			(pSampleRequestSpecItemBOM.SampleRequestWorkflowID = @SampleRequestWorkflowID) AND 
			(pSampleRequestSpecItemBOM.Submit = @Submit) AND 
			(pStyleSpec.StyleID = @StyleID) AND 
			(pStyleSpec.StyleSet = @StyleSet)
		
END


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02443'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02443', GetDate())

END

GO

