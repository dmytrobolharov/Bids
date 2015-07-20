
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 02 Dec 2011                                                                               */
-- * WorkItem #5026                                                                             */
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

/****** Object:  StoredProcedure [dbo].[rpx_ImageCatalog_Customer_SELECT]    Script Date: 12/02/2011 10:23:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ImageCatalog_Customer_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ImageCatalog_Customer_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_ImageCatalog_Customer_SELECT]    Script Date: 12/02/2011 10:23:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_ImageCatalog_Customer_SELECT] 	 
	@ImageCatalogID AS varchar(255)
AS


SELECT IDENTITY(INT,0,1) AS RowNumber, 
hi.ImageDescription, 
hi.ImageSubFolder3 AS Customer, 
hi.ImageSubFolder4 AS Brand, 
hi.ImageSubFolder5 AS Component, 
hi.ImageCode AS ProjectNo, 
(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath,	--Comment #01
ic.CatalogName, ic.CUser, CONVERT(varchar(20), ic.CDate, 101) AS CDate, 
ci.ImageSort,ip.ImageSubFolder1 AS ImageType,ip.ImageSubFolder2 as Division
INTO	#TblTemp
FROM	pImageCatalog ic, pImageCatalogItem ci, hImage hi,pImage ip
WHERE	((ci.ImageCatalogID = ic.ImageCatalogID) 
	AND (ci.ImageID = hi.ImageID) 
	AND (ci.ImageID = ip.ImageID) 
	AND (ci.ImageVersion = hi.Version) 
	AND (ic.ImageCatalogID = @ImageCatalogID))
ORDER BY ci.ImageSort, hi.ImageCode 

SELECT	RowNumber % 4 AS [Column], RowNumber / 4 AS Row, ImageDescription, Customer, Brand, 
Component, ProjectNo,FilePath, CatalogName, CUser, CDate, ImageSort,ImageType,Division
FROM #TblTemp ORDER BY ImageSort, ProjectNo

		
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02271'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02271', GetDate())

END

GO 





 

