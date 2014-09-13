IF EXISTS ( SELECT * FROM SysObjects WHERE ID = OBJECT_ID(N'[dbo].[rpx_Style_DesignImages_SELECT]'))
	BEGIN
		PRINT 'Dropping Procedure [rpx_Style_DesignImages_SELECT]'
		DROP PROCEDURE [dbo].[rpx_Style_DesignImages_SELECT]
	END
GO
/*----------------------------------------------------------------------                               
* Name        : rpx_MERREL_Desktop_Merchandising_SELECT
*
* Report Name :	
*
* Description : 
*
* Change History:                  
* ------------------
* Date			Version		Author		Comment
* 08 May 2012	1.0			Sanjay		Work Item # 8115
*										First version as per the requirement
*
---------------------------------------------------------------------- */ 

PRINT ''
PRINT ''
PRINT 'Creating Procedure [rpx_Style_DesignImages_SELECT]'
GO


CREATE PROCEDURE [dbo].[rpx_Style_DesignImages_SELECT]            
(    
	@StyleID	AS NVARCHAR(100)
)          
AS  
BEGIN
	SET NOCOUNT ON

	/* Table to hold initial "Style" row records. */
	CREATE TABLE #tempStyle
	(
		StyleID						UNIQUEIDENTIFIER
		,DesignSketchID				UNIQUEIDENTIFIER		
		,DesignSketchVersion		INT
		,DesignSketchBackID			UNIQUEIDENTIFIER
		,DesignSketchBackVersion	INT
	)

	/* Table to hold "Style" design row records. */
	CREATE TABLE #tempStyleDesign
	(
		TableRow					INT IDENTITY(0,1)
		,StyleID					UNIQUEIDENTIFIER
		,DesignSketchID				UNIQUEIDENTIFIER		
		,DesignSketchVersion		INT
		,StyleDesignType			NVARCHAR(10)
		,StyleDesignSort			INT
	)
		
	/*Get initial style records.*/
	INSERT INTO #tempStyle
	(
		StyleID						
		,DesignSketchID				
		,DesignSketchVersion
		,DesignSketchBackID
		,DesignSketchBackVersion
	)
	SELECT
		pStyleHeader.StyleID
		,pStyleHeader.DesignSketchID	
		,pStyleHeader.DesignSketchVersion
		,pStyleHeader.DesignSketchBackID
		,pStyleHeader.DesignSketchBackVersion
	FROM pStyleHeader		
	WHERE CAST(pStyleHeader.StyleID AS NVARCHAR(100)) = @StyleID

	/*Create style design records (Front & Back )*/
	INSERT INTO #tempStyleDesign
	(
		StyleID
		,DesignSketchID
		,DesignSketchVersion
		,StyleDesignType
		,StyleDesignSort
	)
	SELECT
		StyleID		
		,DesignSketchID		
		,DesignSketchVersion
		,'Front'
		,1
	FROM #tempStyle	
	UNION ALL	
	SELECT
		StyleID		
		,DesignSketchBackID		
		,DesignSketchBackVersion
		,'Back'
		,2
	FROM #tempStyle
								
	/* Final select, style design images */
	SELECT
		TableRow / 2 AS [Row]
		,TableRow % 2 AS [Column]				
		,StyleID
		,(dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])) AS StyleImagePath
		,StyleDesignType
		,StyleDesignSort
	FROM #tempStyleDesign
		LEFT OUTER JOIN hImage ON	#tempStyleDesign.DesignSketchID = hImage.ImageID
									AND #tempStyleDesign.DesignSketchVersion = hImage.[Version]		
	ORDER BY
		TableRow
		
/* Clean Up */
	DROP TABLE #tempStyle
	DROP TABLE #tempStyleDesign
	
	SET NOCOUNT OFF
		
END
GO
PRINT ''
PRINT 'Completed Creating Procedure [rpx_Style_DesignImages_SELECT]'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03483', GetDate())
GO