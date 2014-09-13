
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 23 Dec 2011                                                                               */
-- * WorkItem #5307                                                                             */
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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpec_SampleSize]    Script Date: 12/23/2011 00:08:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpec_SampleSize]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpec_SampleSize]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpec_SampleSize]    Script Date: 12/23/2011 00:08:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestBOMSpec_SampleSize]
(
	@StyleID UNIQUEIDENTIFIER,
	@SampleRequestWorkflowID UNIQUEIDENTIFIER,
	@SampleWorkflowID NVARCHAR(5),
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@ItemDim1Id UNIQUEIDENTIFIER = NULL,
	@ItemDim2Id UNIQUEIDENTIFIER = NULL,
	@ItemDim3Id UNIQUEIDENTIFIER = NULL
)
AS 
BEGIN
	SELECT 
		StyleID, SizeRange, 
		CASE WHEN Sel0 = 1 THEN Size0 
				WHEN Sel1 = 1 THEN Size1 
					WHEN Sel2 = 1 THEN Size2 
						WHEN Sel3 = 1 THEN Size3 
							WHEN Sel4 = 1 THEN Size4 
								WHEN Sel5 = 1 THEN Size5 
									WHEN Sel6 = 1 THEN Size6 
										WHEN Sel7 = 1 THEN Size7 
											WHEN Sel8 = 1 THEN Size8 
												WHEN Sel9 = 1 THEN Size9 
													WHEN Sel10 = 1 THEN Size10 
														WHEN Sel11 = 1 THEN Size11 END AS SampleSize 
	FROM  
		pSampleRequestSpecSizeBOM WITH (NOLOCK)
	WHERE     
		(StyleID = @StyleID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
		AND (SampleWorkflowID = @SampleWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) 
		AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id)
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02507'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02507', GetDate())
END

GO

