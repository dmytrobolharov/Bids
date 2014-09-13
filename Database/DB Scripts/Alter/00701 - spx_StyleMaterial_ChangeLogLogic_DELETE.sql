IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterial_ChangeLogLogic_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMaterial_ChangeLogLogic_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_StyleMaterial_ChangeLogLogic_DELETE](
	@ChangeTransID UNIQUEIDENTIFIER
)
AS

--** If transaction record doesnt exist, return
IF @ChangeTransID IS NULL OR CAST(@ChangeTransID AS NVARCHAR(40)) = '00000000-0000-0000-0000-000000000000'
	RETURN

IF NOT EXISTS ( SELECT  * FROM dbo.pChangeTransaction  WITH (NOLOCK) WHERE ChangeTransID = @ChangeTransID )
	RETURN


DECLARE 
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@RowCounter INT,
	@TotalCount INT


--***
--** Beacuse materials can be delete from multiple (linked) styles, need to rearrange the ChangeTransactionID
--** using ChangeAfterValue column to store StyleID 
--***
DECLARE 
	@NewChangeTransID  UNIQUEIDENTIFIER,
	@ChangeTransPageName NVARCHAR(200),
	@ChangeTransTableID UNIQUEIDENTIFIER,
	@ChangeTransTablePKID UNIQUEIDENTIFIER,
	@ChangeTransDate DATETIME

CREATE TABLE #tmpStyle( 
	RowID INT IDENTITY (1,1),
	StyleID UNIQUEIDENTIFIER,
	ChangeTransID UNIQUEIDENTIFIER DEFAULT NEWID()
)

INSERT INTO #tmpStyle ( StyleID )
SELECT DISTINCT ChangeAftervalue 
FROM pChangeLogItem a WITH (NOLOCK)
	INNER JOIN pChangeLog b WITH (NOLOCK) ON a.ChangeLogID = b.ChangeLogID
WHERE a.ChangeTransID = @ChangeTransID
AND b.ChangeTableID = '036F8B4C-C1CC-DF11-AF06-005056C00008' -- pStyleMaterials


SELECT @ChangeTransPageName =  ChangeTransPageName, 
	@ChangeTransTableID = ChangeTransTableID,
	@ChangeTransTablePKID = ChangeTransTablePKID,
	@ChangeTransUserID  = ChangeTransUserID,
	@ChangeTransDate  = ChangeTransDate 
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
	          2 --DELETE
			)

	-- UPDATE Log with new Transaction ID		
	UPDATE pChangeLogItem
	SET ChangeTransID = @NewChangeTransID,
		ChangeAfterValue = NULL
	WHERE ChangeTransID = @ChangeTransID 
	AND ChangeAfterValue = CAST( @StyleID AS NVARCHAR(40))

	UPDATE dbo.pChangeLog
	SET ChangeTransID = @NewChangeTransID
	FROM pChangeLog WITH (NOLOCK)
		INNER JOIN pChangeLogItem WITH (NOLOCK) ON pChangeLog.ChangeLogID = pChangeLogItem.ChangeLogID
	WHERE pChangeLogItem.ChangeTransID = @NewChangeTransID

	SET @RowCounter = @RowCounter  + 1 

END

--Delete previous Transaction ID
DELETE FROM pChangeTransaction WHERE ChangeTransID = @ChangeTransID


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '701', GetDate())
GO
