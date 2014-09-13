
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                               */
-- * Database:                                                                                  */
-- * 23 June 2011                                                                                */
-- * WorkItem#3489                                                                                          */
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

/****** Object:  StoredProcedure [dbo].[spx_StyleImage_Linked_UPDATE]    Script Date: 06/23/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImage_Linked_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleImage_Linked_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleImage_Linked_UPDATE]    Script Date: 06/23/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleImage_Linked_UPDATE] (
	@StyleID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER, 
	@ImageVersion INT,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS

SELECT 1

--DECLARE 
--	@StyleLinkID UNIQUEIDENTIFIER,
--	@StyleNonApparel INT
	

--SELECT @StyleLinkID = a.StyleLinkID, @StyleNonApparel = b.StyleNonApparel
--FROM dbo.pStyleHeader a
--	INNER JOIN	dbo.pStyleType b ON a.StyleType =  b.StyleTypeID
--WHERE StyleID =  @StyleID

--IF @StyleLinkID IS NOT NULL AND @StyleNonApparel = 0
--BEGIN
--	UPDATE dbo.pStyleHeader
--	SET DesignSketchID = @ImageID, DesignSketchVersion = @ImageVersion,
--	MUser = @MUser, MDate = @MDate
--	WHERE StyleLinkID = @StyleLinkID
--END 
--ELSE 
BEGIN

	UPDATE dbo.pStyleHeader
	SET DesignSketchID = @ImageID, DesignSketchVersion = @ImageVersion,
	MUser = @MUser, MDate = @MDate
	WHERE StyleID = @StyleID

END 


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01566'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01566', GetDate())
END	

