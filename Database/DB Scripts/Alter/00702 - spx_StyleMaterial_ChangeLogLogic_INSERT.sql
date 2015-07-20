IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterial_ChangeLogLogic_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMaterial_ChangeLogLogic_INSERT]
GO



CREATE PROCEDURE [dbo].[spx_StyleMaterial_ChangeLogLogic_INSERT](
	@ChangeTransID UNIQUEIDENTIFIER
)
AS



--** If transaction record doesnt exist, return
IF @ChangeTransID IS NULL OR CAST(@ChangeTransID AS NVARCHAR(40)) = '00000000-0000-0000-0000-000000000000'
	RETURN

IF NOT EXISTS ( SELECT  * FROM dbo.pChangeTransaction  WITH (NOLOCK) WHERE ChangeTransID = @ChangeTransID )
	RETURN


--***
--** Beacuse materials can be added to multiple (linked) styles, need to rearrange the ChangeTransactionID
--***
DECLARE 
	@NewChangeTransID  UNIQUEIDENTIFIER,
	@ChangeTransPageName NVARCHAR(200),
	@ChangeTransTableID UNIQUEIDENTIFIER,
	@ChangeTransTablePKID UNIQUEIDENTIFIER,
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@ChangeTransDate DATETIME,
	@ChangeTransTypeID INT,
	@RowCounter INT,
	@TotalCount INT,
	@StyleID UNIQUEIDENTIFIER


CREATE TABLE #tmpStyle( 
	RowID INT IDENTITY (1,1),
	StyleID UNIQUEIDENTIFIER,
	ChangeTransID UNIQUEIDENTIFIER DEFAULT NEWID()
)

INSERT INTO #tmpStyle ( StyleID )
SELECT DISTINCT b.StyleID
FROM dbo.pChangeLog a WITH (NOLOCK)  
	INNER JOIN dbo.pStyleMaterials b ON a.ChangeTablePKID = b.StyleMaterialID
WHERE ChangeTransID = @ChangeTransID
AND ChangeTableID = '036F8B4C-C1CC-DF11-AF06-005056C00008' -- pStyleMaterials

SELECT @ChangeTransPageName =  ChangeTransPageName, 
	@ChangeTransTableID = ChangeTransTableID,
	@ChangeTransTablePKID = ChangeTransTablePKID,
	@ChangeTransUserID  = ChangeTransUserID,
	@ChangeTransDate  = ChangeTransDate,
	@ChangeTransTypeID = ChangeTransTypeID
FROM dbo.pChangeTransaction 
WHERE ChangeTransID = @ChangeTransID	


SET @RowCounter = 1
SELECT @TotalCount = COUNT(*) FROM #tmpStyle

WHILE @RowCounter <= @TotalCount 
BEGIN
	SELECT @StyleID = StyleID , @NewChangeTransID = ChangeTransID 
	FROM #tmpStyle WHERE RowID = @RowCounter 

	INSERT INTO dbo.pChangeTransaction 
	        ( ChangeTransID ,
	          ChangeTransPageName ,
	          ChangeTransTableID ,
	          ChangeTransTablePKID ,
	          ChangeTransUserID ,
	          ChangeTransDate,
	          ChangeTransTypeID
	        )
	VALUES  ( @NewChangeTransID,
		      @ChangeTransPageName ,
	          @ChangeTransTableID ,
	          @StyleID,
	          @ChangeTransUserID ,
	          @ChangeTransDate, 
	          @ChangeTransTypeID
			)

	-- UPDATE Log with new Transaction ID
	UPDATE pChangeLog
	SET ChangeTransID = @NewChangeTransID
	FROM pChangeLog
		INNER JOIN pStyleMaterials ON pChangeLog.ChangeTablePKID  = pStyleMaterials.StyleMaterialID
	WHERE pStyleMaterials.StyleID = @StyleID
	AND pChangeLog.ChangeTransID = @ChangeTransID

	UPDATE pChangeLogItem
	SET ChangeTransID = @NewChangeTransID
	FROM pChangeLogItem
		INNER JOIN pChangeLog ON pChangeLogItem.ChangeLogID =  pChangeLog.ChangeLogID
	WHERE pChangeLog.ChangeTransID = @NewChangeTransID


	SET @RowCounter = @RowCounter  + 1 

END

--Delete previous Transaction ID
DELETE FROM pChangeTransaction WHERE ChangeTransID = @ChangeTransID

GO

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '702', GetDate())
GO
