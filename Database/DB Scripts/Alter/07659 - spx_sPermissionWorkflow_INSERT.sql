/****** Object:  StoredProcedure [dbo].[spx_sPermissionWorkflow_INSERT]    Script Date: 02/11/2014 16:16:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionWorkflow_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sPermissionWorkflow_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_sPermissionWorkflow_INSERT]    Script Date: 02/11/2014 16:16:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_sPermissionWorkflow_INSERT]
	@PermissionFolderId uniqueidentifier,
	@PermissionProductTypeId uniqueidentifier,
	@PermissionProductTypeMapId int,
	@GroupID uniqueidentifier,
	@WorkflowId uniqueidentifier,
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
	@MDate datetime = NULL,
	@PermissionWorkflowName nvarchar(256) = NUll
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	    
		DECLARE @MyIdentity uniqueidentifier;
	SET @MyIdentity = NewID();
    INSERT INTO sPermissionWorkflow(PermissionWorkflowId,PermissionFolderId,PermissionProductTypeId,PermissionProductTypeMapId,GroupID,WorkflowId,PermissionRoleId,PermissionView,PermissionCreate,PermissionRemove,PermissionModify,PermissionDelete,PermissionPrint,CUser,CDate,MUser,MDate,PermissionWorkflowName) VALUES(@MyIdentity,@PermissionFolderId,@PermissionProductTypeId,@PermissionProductTypeMapId,@GroupID,@WorkflowId,@PermissionRoleId,@PermissionView,@PermissionCreate,@PermissionRemove,@PermissionModify,@PermissionDelete,@PermissionPrint,@CUser,@CDate,@MUser,@MDate,@PermissionWorkflowName)
    SELECT @MyIdentity
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07659', GetDate())
GO
