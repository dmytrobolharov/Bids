/****** Object:  StoredProcedure [dbo].[spx_ChangeLogNotification_INSERT]    Script Date: 07/23/2012 15:07:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogNotification_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLogNotification_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLogNotification_INSERT]    Script Date: 07/23/2012 15:07:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ChangeLogNotification_INSERT]
	@ChangeLogBatchID UNIQUEIDENTIFIER,
	@ChangeLogItemID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO pChangeLogNotification(ChangeLogBatchID, ChangeLogItemID, CUser, CDate)
    VALUES (@ChangeLogBatchID, @ChangeLogItemID, @CUser, @CDate)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03709', GetDate())
GO