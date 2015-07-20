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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecSizeIndex_SELECT]    Script Date: 12/18/2011 18:59:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecSizeIndex_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecSizeIndex_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecSizeIndex_SELECT]    Script Date: 12/18/2011 18:59:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create  PROCEDURE [dbo].[spx_SampleRequestBOMSpecSizeIndex_SELECT]
(
@SampleRequestTradeID uniqueidentifier,
@SampleRequestWorkflowID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet int,
@Submit int,
@OUT INT = 0 OUTPUT 
)
AS 

Declare @SampleSizePosition int

BEGIN
	SELECT  @SampleSizePosition = (CASE 
        WHEN Sel0 = 1 THEN 0
        WHEN Sel1 = 1 THEN 1 
        WHEN Sel2 = 1 THEN 2 
        WHEN Sel3 = 1 THEN 3 
        WHEN Sel4 = 1 THEN 4 
        WHEN Sel5 = 1 THEN 5 
        WHEN Sel6 = 1 THEN 6 
        WHEN Sel7 = 1 THEN 7 
        WHEN Sel8 = 1 THEN 8 
        WHEN Sel9 = 1 THEN 9 
        WHEN Sel10 = 1 THEN 10 
        WHEN Sel11 = 1 THEN 11 
        WHEN Sel12 = 1 THEN 12 
        WHEN Sel13 = 1 THEN 13 
        WHEN Sel14 = 1 THEN 14 
        WHEN Sel15 = 1 THEN 15 
        WHEN Sel16 = 1 THEN 16 
        WHEN Sel17 = 1 THEN 17 
        WHEN Sel18 = 1 THEN 18 
        WHEN Sel19 = 1 THEN 19 
        END) FROM pSampleRequestSpecSizeBOM WITH (NOLOCK)
	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID) AND (StyleSet = @StyleSet) 
END

BEGIN
	IF @OUT = 0 
		SELECT ISNULL(@SampleSizePosition, 0)	--Comment #01
	ELSE
		SET @OUT = ISNULL(@SampleSizePosition, 0)
END








GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02445'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02445', GetDate())

END

GO
