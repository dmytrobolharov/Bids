-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                               */
-- * Database:                                                                                  */
-- * 9 June 2011                                                                                */
-- * WorkItem#2850                                                                                          */
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

/****** Object:  StoredProcedure [dbo].[spx_SelectStyleArtworkImage]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SelectStyleArtworkImage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SelectStyleArtworkImage]
GO

/****** Object:  StoredProcedure [dbo].[spx_SelectStyleArtworkImage]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_SelectStyleArtworkImage]
(
@StyleID uniqueidentifier,
@StyleSet int,
@Workflow int
)
AS 

IF @Workflow = 1

BEGIN 

	SELECT	* 
	FROM	pStyleBOM 
	WHERE	StyleSet = @StyleSet AND 
			StyleID = @StyleID AND 
			MaterialImageID IS NOT NULL AND
			Artwork = 1  
	ORDER BY MainMaterial DESC, MaterialType, MaterialSort, MaterialNo 
		
END 
ELSE 
BEGIN 

	SELECT	* 
	FROM	pStyleMaterials 
	WHERE	StyleSet = @StyleSet AND 
			StyleID = @StyleID AND 
			MaterialImageID IS NOT NULL AND
			Artwork = 1  
	ORDER BY MainMaterial DESC, MaterialType, MaterialSort, MaterialNo 
	
END


Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02062'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02062', GetDate())
END	
GO