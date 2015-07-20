/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_TACalReference_DELETE]    Script Date: 08/08/2014 12:05:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_TACalReference_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_TACalReference_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_TACalReference_DELETE]    Script Date: 08/08/2014 12:05:19 ******/
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
	
	SELECT @TACalReferenceID = TACalReferenceId FROM pTACalReference
	WHERE ReferenceId = @StyleQuoteItemID AND TACalReferenceTypeId = @FolderID AND TACalTemplateId = @TACalTemplateID
	
	DELETE FROM pTACalReferenceTask WHERE TACalReferenceId = @TACalReferenceID
	DELETE FROM pTACalReference WHERE TACalReferenceId = @TACalReferenceID
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08651', GetDate())
GO
