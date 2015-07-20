/****** Object:  StoredProcedure [dbo].[spx_Group_OverFlowPermissionsOnProduct_SELECT]    Script Date: 02/11/2014 16:08:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_OverFlowPermissionsOnProduct_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_OverFlowPermissionsOnProduct_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_OverFlowPermissionsOnProduct_SELECT]    Script Date: 02/11/2014 16:08:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_Group_OverFlowPermissionsOnProduct_SELECT]
	@GroupID uniqueidentifier,
	@ProductTypeID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
     select workFlow.*, workFlow.PermissionWorkflowName AS TypeName from sPermissionWorkflow as workFlow where workFlow.PermissionProductTypeId = @ProductTypeID and workFlow.GroupID = @GroupID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07656', GetDate())
GO
