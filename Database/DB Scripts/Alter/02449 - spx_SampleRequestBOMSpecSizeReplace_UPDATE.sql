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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecSizeReplace_UPDATE]    Script Date: 12/18/2011 19:02:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecSizeReplace_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecSizeReplace_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecSizeReplace_UPDATE]    Script Date: 12/18/2011 19:02:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMSpecSizeReplace_UPDATE]
(
@SampleRequestWorkflowID uniqueidentifier,
@SampleRequestTradeID uniqueidentifier,
@StyleID	uniqueidentifier,
@Sel0		varchar(2),
@Sel1		varchar(2),
@Sel2		varchar(2),
@Sel3		varchar(2),
@Sel4		varchar(2),
@Sel5		varchar(2),
@Sel6		varchar(2),
@Sel7		varchar(2),
@Sel8		varchar(2),
@Sel9		varchar(2),
@Sel10		varchar(2),
@Sel11		varchar(2),
@Sel12		varchar(2),
@Sel13		varchar(2),
@Sel14		varchar(2),
@Sel15		varchar(2),
@Sel16		varchar(2),
@Sel17		varchar(2),
@Sel18		varchar(2),
@Sel19		varchar(2)
)
AS 

UPDATE pSampleRequestSpecSizeBOM
SET Sel0 = @Sel0, Sel1 = @Sel1, Sel2 = @Sel2, Sel3 = @Sel3, Sel4 = @Sel4, Sel5 = @Sel5, Sel6 = @Sel6, Sel7 = @Sel7, Sel8 = @Sel8, Sel9 = @Sel9, Sel10 = @Sel10, 
    Sel11 = @Sel11, Sel12 = @Sel12, Sel13 = @Sel13, Sel14 = @Sel14, Sel15 = @Sel15, Sel16 = @Sel16, Sel17 = @Sel17, Sel18 = @Sel18, Sel19 = @Sel19
WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND SampleRequestTradeID = @SampleRequestTradeID AND StyleID = @StyleID 
	
DECLARE 
@Grade0			numeric(18,4),
@Grade1			numeric(18,4),
@Grade2			numeric(18,4),
@Grade3			numeric(18,4),
@Grade4			numeric(18,4),
@Grade5			numeric(18,4),
@Grade6			numeric(18,4),
@Grade7			numeric(18,4),
@Grade8			numeric(18,4),
@Grade9			numeric(18,4),
@Grade10		numeric(18,4),
@Grade11		numeric(18,4),
@Grade12		numeric(18,4),
@Grade13		numeric(18,4),
@Grade14		numeric(18,4),
@Grade15		numeric(18,4),
@Grade16		numeric(18,4),
@Grade17		numeric(18,4),
@Grade18		numeric(18,4),
@Grade19		numeric(18,4)

SELECT 
	@Grade0 = Grade0, 
	@Grade1 = Grade1, 
	@Grade2 = Grade2, 
	@Grade3 = Grade3, 
	@Grade4 = Grade4, 
	@Grade5 = Grade5, 
	@Grade6 = Grade6, 
	@Grade7 = Grade7, 
	@Grade8 = Grade8, 
	@Grade9 = Grade9, 
	@Grade10 = Grade10, 
	@Grade11 = Grade11, 
	@Grade12 = Grade12, 
	@Grade13 = Grade13, 
	@Grade14 = Grade14, 
	@Grade15 = Grade15, 
	@Grade16 = Grade16, 
	@Grade17 = Grade17, 
	@Grade18 = Grade18, 
	@Grade19 = Grade19
FROM pSampleRequestSpecItemBOM WITH (NOLOCK)
WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID AND 
SampleRequestTradeID = @SampleRequestTradeID AND StyleID = @StyleID

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02449'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02449', GetDate())

END

GO
