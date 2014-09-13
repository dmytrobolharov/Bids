IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTextImageItemSort_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTextImageItemSort_Update]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spx_StyleTextImageItemSort_Update]
(@WorkflowID UNIQUEIDENTIFIER,
@ItemID UNIQUEIDENTIFIER,
@TeamID UNIQUEIDENTIFIER,
@Sort NVARCHAR(10),
@MUser NVARCHAR(200),
@MDate DATETIME)
AS 

	If @WorkFlowId = '40000000-0000-0000-0000-000000000018' 
		BEGIN
			UPDATE pStyleDetailForm 
			SET  MUser = @MUser, MDate = @MDate, Sort = @Sort
			WHERE StyleDetailFormID = @ItemID
		END
		
	Else
		BEGIN
			UPDATE pStyleImageItem
			SET  MUser = @MUser, MDate = @MDate, Sort = @Sort
			WHERE StyleImageItemID = @ItemID
		END
GO		
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01970'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01970', GetDate())
END	
GO