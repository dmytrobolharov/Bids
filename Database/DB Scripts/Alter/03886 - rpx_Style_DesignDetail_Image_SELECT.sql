IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_DesignDetail_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_DesignDetail_Image_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/


CREATE        PROCEDURE [dbo].[rpx_Style_DesignDetail_Image_SELECT] 	 
	@StyleID varchar(255),	
	@StyleSet As int
AS


--/************/
--/*Testing.	*/
--/************/
--BEGIN
--	DECLARE @StyleID varchar(255)
--	DECLARE @StyleSet As int

--	SET @StyleID = '6151b1a3-cedd-4a4b-bf98-0bf8ed6785d8'
--	SET @StyleSet = 1
--END


--Comment #01
SELECT	identity(int,0,1) as RowNumber,
	dbo.fnx_GetStreamingImagePath(si.ImageID, si.ImageVersion) AS FilePath,
	CAST(hi.ImageDescription AS nvarchar(255)) AS ImageDescription
INTO	#tblTemp
FROM	pStyleImageItem si, hImage hi 
WHERE	((si.ImageID = hi.ImageID) AND
	(si.ImageVersion = hi.Version) AND
	(si.StyleSet = @StyleSet) AND
	(si.StyleID = @StyleID))
ORDER BY si.Sort, si.ImageID ASC

SELECT	RowNumber,
	FilePath,
	ImageDescription
FROM	#tblTemp

/*Drop temp table.*/
DROP TABLE #tblTemp

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03886', GetDate())
GO
