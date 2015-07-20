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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestStyleBOMColorwayTemp_INSERT]    Script Date: 12/18/2011 17:59:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestStyleBOMColorwayTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestStyleBOMColorwayTemp_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestStyleBOMColorwayTemp_INSERT]    Script Date: 12/18/2011 17:59:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create  PROCEDURE [dbo].[spx_SampleRequestStyleBOMColorwayTemp_INSERT]
(
@SampleRequestGroupID uniqueidentifier,
@StyleID uniqueidentifier,
@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
@StyleSet nvarchar(10),
@CreatedBy nvarchar(200),
@CreatedDate nvarchar(100)
)

AS

DELETE FROM  pSampleRequestStyleBOMColorwayTemp WHERE ItemDim1Id = @ItemDim1Id AND ItemDim2Id = @ItemDim2Id AND ItemDim3Id = @ItemDim3Id  AND SampleRequestGroupID = @SampleRequestGroupID AND StyleSet = @StyleSet AND  StyleID = @StyleID 

IF (SELECT COUNT(*) FROM pSampleRequestStyleBOMColorwayTemp WITH (NOLOCK) WHERE ItemDim1Id = @ItemDim1Id AND ItemDim2Id = @ItemDim2Id AND ItemDim3Id = @ItemDim3Id AND StyleID = @StyleID AND SampleRequestGroupID = @SampleRequestGroupID AND StyleSet = @StyleSet)  = 0

BEGIN
	INSERT INTO pSampleRequestStyleBOMColorwayTemp
	(SampleRequestGroupID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleID, StyleSet, CUser, CDate, MUser, MDate, Submit)
	VALUES (@SampleRequestGroupID, @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @StyleID, @StyleSet,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1)
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02363'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02363', GetDate())

END

GO
