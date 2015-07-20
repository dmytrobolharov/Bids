/****** Object:  StoredProcedure [dbo].[spx_ChangeLogTransactions_SELECT]    Script Date: 07/23/2012 15:25:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogTransactions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLogTransactions_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLogTransactions_SELECT]    Script Date: 07/23/2012 15:25:45 ******/
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
	ELSE IF @ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00008' -- pStyleHeader
		BEGIN

			SELECT DISTINCT a.*, b.* FROM pChangeTransaction a WITH(NOLOCK)
				INNER JOIN pChangeLog b WITH(NOLOCK) ON a.ChangeTransID =  b.ChangeTransID
			WHERE ChangeTransTablePKID = @ChangeTransTablePKID -- StyleID
				AND b.ChangeTableID IN (@ChangeTableID, 'DD12FAAE-7ACD-DF11-AF06-005056C00008', '036F8B4C-C1CC-DF11-AF06-005056C00008', '00000002-C1CC-DF11-AF06-005056C00008', '00000003-C1CC-DF11-AF06-005056C00008', 'D612FAAE-7ACD-DF11-AF06-005056C00009')
			
			UNION ALL
			-- pStyleCare
			SELECT DISTINCT a.*, b.* FROM pChangeTransaction a WITH(NOLOCK)
				INNER JOIN pChangeLog b WITH(NOLOCK) ON a.ChangeTransID =  b.ChangeTransID
				INNER JOIN pStyleCare c WITH(NOLOCK) ON c.StyleCareId = a.ChangeTransTablePKID
			WHERE c.StyleId = @ChangeTransTablePKID
				AND b.ChangeTableID = 'D616FAAE-7ACD-DF11-AF06-005056C00008'
			ORDER BY a.ChangeTransDate DESC

		END 
	ELSE --IF @ChangeTableID = '00000010-C1CC-DF11-AF06-005056C00008' -- pMaterial
		BEGIN

			SELECT DISTINCT * FROM pChangeTransaction a WITH(NOLOCK)
				INNER JOIN pChangeLog b WITH(NOLOCK) ON a.ChangeTransID =  b.ChangeTransID
			WHERE ChangeTransTablePKID = @ChangeTransTablePKID
				AND b.ChangeTableID = @ChangeTableID
			ORDER BY a.ChangeTransDate DESC

		END 




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03712', GetDate())
GO