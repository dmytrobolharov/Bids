/****** Object:  StoredProcedure [dbo].[spx_ChangeLogNotification_SELECT]    Script Date: 07/19/2012 18:28:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogNotification_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLogNotification_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLogNotification_SELECT]    Script Date: 07/19/2012 18:28:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ChangeLogNotification_SELECT]
	@ChangeLogBatchID UNIQUEIDENTIFIER,
	@WhereCond NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF CHARINDEX('WHERE', @WhereCond) >= 0
	BEGIN
		SET @WhereCond = @WhereCond + ' AND n.ChangeLogBatchID = @ChangeLogBatchID'
	END
	ELSE
	BEGIN
		SET @WhereCond = ' WHERE n.ChangeLogBatchID = @ChangeLogBatchID'
	END

    DECLARE @SQL NVARCHAR(MAX) = N'SELECT * FROM pChangeLogNotification n
									INNER JOIN vwx_ChangeLogItem_SEL i ON n.ChangeLogItemID = i.ChangeLogItemID ' + @WhereCond;
									
	exec sp_executesql @SQL, N'@ChangeLogBatchID UNIQUEIDENTIFIER', @ChangeLogBatchID = @ChangeLogBatchID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03710', GetDate())
GO