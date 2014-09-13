/****** Object:  StoredProcedure [dbo].[spx_sPermissionWorkflowOnly_UPDATE]    Script Date: 02/11/2014 16:18:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionWorkflowOnly_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sPermissionWorkflowOnly_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_sPermissionWorkflowOnly_UPDATE]    Script Date: 02/11/2014 16:18:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_sPermissionWorkflowOnly_UPDATE]
	@PermissionWorkflowId uniqueidentifier,
	@PermissionRoleId int,
	@PermissionView int,
	@PermissionCreate int,
	@PermissionRemove int,
	@PermissionModify int,
	@PermissionDelete int,
	@PermissionPrint int,
	@CUser nvarchar(200) = NULL,
	@CDate datetime = NULL,
	@MUser nvarchar(200) = NULL,
	@MDate datetime = NULL	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    UPDATE sPermissionWorkflow SET PermissionRoleId = @PermissionRoleId,PermissionView = @PermissionView,PermissionCreate = @PermissionCreate,PermissionRemove = @PermissionRemove,PermissionModify = @PermissionModify,PermissionDelete = @PermissionDelete,PermissionPrint = @PermissionPrint,CUser = @CUser,CDate = @CDate,MUser = @MUser,MDate = @MDate WHERE PermissionWorkflowId = @PermissionWorkflowId
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07661', GetDate())
GO
