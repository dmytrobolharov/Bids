/****** Object:  StoredProcedure [dbo].[spx_Group_OverFlowPermissionsOnProductOnID_SELECT]    Script Date: 02/11/2014 16:09:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_OverFlowPermissionsOnProductOnID_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_OverFlowPermissionsOnProductOnID_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_OverFlowPermissionsOnProductOnID_SELECT]    Script Date: 02/11/2014 16:09:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_Group_OverFlowPermissionsOnProductOnID_SELECT]
	-- Add the parameters for the stored procedure here
	@ProductTypeID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select * from sPermissionWorkflow as workFlow where workFlow.PermissionProductTypeId = @ProductTypeID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07657', GetDate())
GO
