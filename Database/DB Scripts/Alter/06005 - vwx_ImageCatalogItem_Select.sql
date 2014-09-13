-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 08 July 2013                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ImageCatalogItem_Select]'))
	DROP VIEW [dbo].[vwx_ImageCatalogItem_Select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_ImageCatalogItem_Select]
AS
SELECT  
	pImageCatalogItem.ImageCatalogItemID, 
	pImageCatalogItem.ImageCatalogID, 
	pImageCatalogItem.ImageID, 
	pImageCatalogItem.ImageVersion, 
	pImage.ImageNo, 
	pImage.ImageDescription, 
	--pImageCatalogItem.CUser, 
	--pImageCatalogItem.CDate, 
	--pImageCatalogItem.MUser, 
	--pImageCatalogItem.MDate, 
	pImage.CUser,
	pImage.CDate,
	pImage.MUser,
	pImage.MDate,
	pImage.ImageFile, 
	pImageCatalogItem.ImageSort,
	pImage.ImageTypeID,
	pImage.ImageSubFolder1,
	pImage.ImageWorkflowTemplateID,
	pImage.ImageFileType,
	pImage.ImageSubFolder2,
	pImage.ImageSubFolder3,
	pImage.ImageSubFolder4,
	pImage.ImageSubFolder5,
	pImage.ImageSubFolder6,
	pImage.ImageSubFolder7,
	pImage.ImageSubFolder8,
	pImage.ImageSubFolder9,
	pImage.ImageSubFolder12,
	pImage.ImageKeywords,
	pImage.ImageLocation,
	pImage.Version,
	pImage.ImageSize,
	pImage.ImageType,
	pImage.ImageDateLastAccessed,
	pImage.ImageDateLastModified

FROM        
	pImageCatalogItem WITH (NOLOCK) 
	INNER JOIN
	pImage WITH (NOLOCK) ON pImageCatalogItem.ImageID = pImage.ImageID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '0.5.0000', '06005', GetDate())
GO
