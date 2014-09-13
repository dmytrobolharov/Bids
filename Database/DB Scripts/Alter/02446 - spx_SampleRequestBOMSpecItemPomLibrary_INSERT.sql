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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecItemPomLibrary_INSERT]    Script Date: 12/18/2011 19:00:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecItemPomLibrary_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecItemPomLibrary_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecItemPomLibrary_INSERT]    Script Date: 12/18/2011 19:00:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMSpecItemPomLibrary_INSERT]
(@POMLibraryID uniqueidentifier,
@SampleRequestTradeID varchar(50),
@SampleRequestWorkflowID varchar(50),
@SampleWorkflowID varchar(50),
@TradePartnerVendorID varchar(50),
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null,
@StyleID nvarchar(50),
@StyleSet nvarchar(50),
@Submit varchar(2),
@CreatedDate datetime,
@CreatedBy nvarchar(200))
AS INSERT INTO dbo.pSampleRequestSpecItemBOM
                      (POM, PointMeasur, TOL, TOLN, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Spec, 
                      SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, TradePartnerVendorID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleID, StyleSet, Submit, 
                      POMLibraryID, CDate, CUser, MDate, MUser)
SELECT     POM, PointMeasur, 0 AS TOL, 0 AS TOLN, 0 AS Grade0, 0 AS Grade1, 0 AS Grade2, 0 AS Grade3, 0 AS Grade4, 0 AS Grade5, 0 AS Grade6, 0 AS Grade7, 
                      0 AS Grade8, 0 AS Grade9, 0 AS Grade10, 0 AS Grade11, 0 AS Spec, @SampleRequestTradeID AS SampleRequestTradeID, 
                      @SampleRequestWorkflowID AS SampleRequestWorkflowID, @SampleWorkflowID AS SampleWorkflowID, 
                      @TradePartnerVendorID AS TradePartnerVendorID,  @ItemDim1Id AS ItemDim1Id,@ItemDim2Id AS ItemDim2Id,@ItemDim3Id AS ItemDim3Id, @StyleID AS StyleID, @StyleSet AS StyleSet, @Submit AS Submit, 
                      POMLibraryID, @CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser
FROM         dbo.pPOMLibrary WITH (NOLOCK)
WHERE     (POMLibraryID = @POMLibraryID)

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02446'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02446', GetDate())

END

GO
