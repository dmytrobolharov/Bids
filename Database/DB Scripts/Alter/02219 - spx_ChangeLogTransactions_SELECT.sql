IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogTransactions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLogTransactions_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[spx_ChangeLogTransactions_SELECT](
	@ChangeTransTablePKID NVARCHAR(40),
	@ChangeTableID NVARCHAR(40),
	@ChangeTablePKId NVARCHAR(40)
)
AS

	IF @ChangeTableID = '036F8B4C-C1CC-DF11-AF06-005056C00008' -- pStyleMaterials
	BEGIN

		SELECT DISTINCT * FROM pChangeTransaction a WITH(NOLOCK)
			INNER JOIN pChangeLog b WITH(NOLOCK) ON a.ChangeTransID =  b.ChangeTransID
		WHERE ChangeTransTablePKID = @ChangeTransTablePKID -- StyleID
			AND b.ChangeTableID = @ChangeTableID
		ORDER BY a.ChangeTransDate DESC

	END 
	ELSE IF @ChangeTableID = '00000009-C1CC-DF11-AF06-005056C00008' -- pStyleQuoteItem
	BEGIN

		SELECT DISTINCT a.* 
		FROM pChangeTransaction a WITH(NOLOCK)
			INNER JOIN pChangeLog b WITH(NOLOCK) ON a.ChangeTransID =  b.ChangeTransID
		WHERE b.ChangeTablePKID = @ChangeTablePKID -- StyleQuoteItemID
			AND b.ChangeTableID = @ChangeTableID
		ORDER BY a.ChangeTransDate DESC

	END 
	ELSE IF @ChangeTableID = '00000008-C1CC-DF11-AF06-005056C00008' -- pLinePlanShowroomStyleColor
		OR  @ChangeTableID = '00000006-C1CC-DF11-AF06-005056C00008' -- pStyleCostingHeader
	BEGIN
		--** @ChangeTransTablePKID = LinePlanRangeID
		SELECT DISTINCT a.*  
		FROM dbo.pChangeTransaction a WITH(NOLOCK)
			INNER JOIN dbo.pChangeLog b WITH(NOLOCK) ON a.ChangeTransID = b.ChangeTransID
		WHERE a.ChangeTransTablePKID = @ChangeTransTablePKID
			AND b.ChangeTableID = @ChangeTableID 
		ORDER BY a.ChangeTransDate DESC
	END
	ELSE IF @ChangeTableID = '00000010-C1CC-DF11-AF06-005056C00008' -- pMaterial
		BEGIN

			SELECT DISTINCT * FROM pChangeTransaction a WITH(NOLOCK)
				INNER JOIN pChangeLog b WITH(NOLOCK) ON a.ChangeTransID =  b.ChangeTransID
			WHERE ChangeTransTablePKID = @ChangeTransTablePKID -- MaterialID
				AND b.ChangeTableID = @ChangeTableID
			ORDER BY a.ChangeTransDate DESC

		END 



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02219'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02219', GetDate())
END	
GO