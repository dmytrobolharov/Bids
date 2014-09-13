/****** Object:  StoredProcedure [dbo].[spx_IsMigrateRequired]    Script Date: 07/30/2014 14:43:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_IsMigrateRequired]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_IsMigrateRequired]
GO

/****** Object:  StoredProcedure [dbo].[spx_IsMigrateRequired]    Script Date: 07/30/2014 14:43:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_IsMigrateRequired]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM sPermissionFolder)
AND EXISTS(SELECT * FROM sPermissionFolderType)
AND EXISTS(SELECT * FROM sPermissionProductType)
AND EXISTS(SELECT * FROM sPermissionProductTypeMap)
AND EXISTS(SELECT * FROM sPermissionRole)
AND EXISTS(SELECT * FROM sPermissionWorkflow)
SELECT 1
ELSE SELECT 0
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08471', GetDate())
GO
