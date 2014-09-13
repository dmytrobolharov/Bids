/****** Object:  StoredProcedure [dbo].[spx_LinePlanFinancialPlan_Level_SELECT]    Script Date: 06/12/2014 10:57:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanFinancialPlan_Level_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanFinancialPlan_Level_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanFinancialPlan_Level_SELECT]    Script Date: 06/12/2014 10:57:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Trigger [tgx_uGroup_PermissionsForNewGroup_INSERT]    Script Date: 06/12/2014 11:46:57 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_uGroup_PermissionsForNewGroup_INSERT]'))
DROP TRIGGER [dbo].[tgx_uGroup_PermissionsForNewGroup_INSERT]
GO

/****** Object:  Trigger [dbo].[tgx_uGroup_PermissionsForNewGroup_INSERT]    Script Date: 06/12/2014 11:46:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[tgx_uGroup_PermissionsForNewGroup_INSERT]
   ON  [dbo].[uGroup] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    exec spx_FillTablesNewPermissions;

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07993', GetDate())
GO
