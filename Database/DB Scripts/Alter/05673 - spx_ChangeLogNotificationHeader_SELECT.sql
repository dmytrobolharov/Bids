/****** Object:  StoredProcedure [dbo].[spx_ChangeLogNotificationHeader_SELECT]    Script Date: 05/13/2013 16:55:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogNotificationHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLogNotificationHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ChangeLogNotificationHeader_SELECT]
	@ChangeLogBatchID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Msg NVARCHAR(MAX);
	WITH change as (
		SELECT ct.*, cl.ChangeTablePKID FROM pChangeLogNotification cln
		INNER JOIN pChangeLogItem cli ON cln.ChangeLogItemID = cli.ChangeLogItemID
		INNER JOIN pChangeLog cl ON cli.ChangeLogID = cl.ChangeLogID
		INNER JOIN pChangeTable ct ON cl.ChangeTableID = ct.ChangeTableID
		WHERE cln.ChangeLogBatchID = @ChangeLogBatchID
	)
	SELECT @Msg = COALESCE(@Msg + ', ', '') + Msg  FROM (
		SELECT DISTINCT 'Style No: ' + sh.StyleNo AS Msg
		FROM change c INNER JOIN pStyleHeader sh ON c.ChangeTablePKID = sh.StyleID
		WHERE c.ChangeTableFieldName = 'StyleID'
		
		UNION
	
		SELECT DISTINCT 'Style No: ' + sh.StyleNo AS Msg
		FROM change c 
		INNER JOIN pWorkFlowItem wfi ON c.ChangeTablePKID = wfi.WorkFlowItemID
		INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
		WHERE c.ChangeTableFieldName = 'WorkFlowItemID'

		UNION 

		SELECT DISTINCT 'Material No: ' + m.MaterialNo AS Msg
		FROM change c INNER JOIN pMaterial m ON c.ChangeTablePKID = m.MaterialID
		WHERE c.ChangeTableFieldName = 'MaterialID'

		UNION

		SELECT DISTINCT 'Color Code: ' + cp.ColorCode AS Msg
		FROM change c INNER JOIN pColorPalette cp ON c.ChangeTablePKID = cp.ColorPaletteID
		WHERE c.ChangeTableFieldName = 'ColorPaletteID'

		UNION

		SELECT DISTINCT 'Image No: ' + i.ImageNo AS Msg
		FROM change c INNER JOIN pImage i ON c.ChangeTablePKID = i.ImageID
		WHERE c.ChangeTableFieldName = 'ImageID'
	) msgs

	SELECT @Msg

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05673', GetDate())
GO
