/****** Object:  StoredProcedure [dbo].[spx_Translation_Toggle]    Script Date: 02/06/2013 14:49:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Translation_Toggle]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Translation_Toggle]
GO

/****** Object:  StoredProcedure [dbo].[spx_Translation_Toggle]    Script Date: 02/06/2013 14:49:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Rajul Radadia
-- Create date: 
-- Description:	This SP is used to enable "Add New Language button under Help Wiki"
-- If sSystemHelpDetail does not have any record for HelpID then "Add New Language" should not be enabled.
-- Because use should create at least one language wiki before utilizing "Add New Language" translation functionality
-- =============================================
CREATE PROCEDURE [dbo].[spx_Translation_Toggle]
	@sSystemHelpID UNIQUEIDENTIFIER
AS
BEGIN --01
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT COUNT(*) AS AddNewLangBtnEnable 
	FROM sSystemHelpDetail inner join sSystemCulture a on a.CultureIndentifierID = sSystemHelpDetail.CultureIndentifierID
	WHERE sSystemHelpID = @sSystemHelpID and a.Active=1
END --01

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04984', GetDate())

GO
