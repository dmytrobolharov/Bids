-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 18 April 2012                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_MaterialAttachment_INSERT]    Script Date: 04/18/2012 11:22:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialAttachment_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialAttachment_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialAttachment_INSERT]    Script Date: 04/18/2012 11:22:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_MaterialAttachment_INSERT] (
@MaterialDocumentID UNIQUEIDENTIFIER  ,
@MaterialID UNIQUEIDENTIFIER,
@GenMaterialDocumentID NVARCHAR(100) OUT, 
@CUser NVARCHAR(200), 
@CDate DATETIME 
)

--Declare @GenMaterialDocumentID Varchar(100) 
--EXEC spx_MaterialAttachment_INSERT '2118261f-4079-4564-956a-f6b9fbc45556','6f3a305d-f134-4919-bddc-4ad2540f8395',@GenMaterialDocumentID OUTPUT,'administrator',NULL
--PRINT @GenMaterialDocumentID

AS 
BEGIN

	DECLARE @MaterialDocumentName	varchar(500)
	DECLARE @MaterialDocumentDescription nvarchar(MAX)
	DECLARE @MaterialDocumentExt	varchar(5)
	DECLARE @MaterialDocumentSize	varchar(20)
	DECLARE @MaterialDocumentShared	int
	
	SELECT 
		@MaterialDocumentName=MaterialDocumentName,
		@MaterialDocumentDescription= MaterialDocumentDescription,
		@MaterialDocumentExt=MaterialDocumentExt,
		@MaterialDocumentSize=MaterialDocumentSize,
		@MaterialDocumentShared=MaterialDocumentShared		 
	FROM 
	pMaterialDocument 
	WHERE 
	MaterialDocumentID=@MaterialDocumentID 
	
	IF EXISTS(SELECT MaterialDocumentID FROM pMaterialDocument WHERE MaterialDocumentID=@MaterialDocumentID)
	BEGIN	
		
		SET @GenMaterialDocumentID=Convert(NVARCHAR(150),NEWID())
		
		INSERT INTO pMaterialDocument 
		( 		
			MaterialDocumentID,
			MaterialID,
			MaterialDocumentName,
			MaterialDocumentDescription,
			MaterialDocumentExt,
			MaterialDocumentSize,
			MaterialDocumentShared,
			CUser,
			CDate
		)  
		values 
		( 
			@GenMaterialDocumentID,
			@MaterialID, 
			@MaterialDocumentName, 
			@MaterialDocumentDescription, 
			@MaterialDocumentExt,
			@MaterialDocumentSize,
			@MaterialDocumentShared,
			@CUser, 
			@CDate 
		)  
		
		SELECT @GenMaterialDocumentID
	END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03361', GetDate())
	
GO
