/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_TACalReference_DELETE]    Script Date: 08/17/2014 15:31:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_TACalReference_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_TACalReference_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_TACalReference_DELETE]    Script Date: 08/17/2014 15:31:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SourcingQuote_TACalReference_DELETE]
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@TACalTemplateID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @FolderID INTEGER
	SELECT @FolderID = PermissionFolderTypeId 
	FROM sPermissionFolderType 
	WHERE LOWER(PermissionFolderTypeName) = LOWER('Sourcing Folder')
	
	DECLARE @TACalReferenceID UNIQUEIDENTIFIER
	
	SELECT @TACalReferenceID = cr.TACalReferenceId FROM pTACalReference cr
	WHERE ReferenceId = @StyleQuoteItemID AND cr.TACalReferenceTypeId = @FolderID AND cr.TACalTemplateId = @TACalTemplateID
	
	DELETE FROM pTACalReferenceTask WHERE TACalReferenceId = @TACalReferenceID
	DELETE FROM pTACalReference WHERE TACalReferenceId = @TACalReferenceID
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08871', GetDate())
GO
