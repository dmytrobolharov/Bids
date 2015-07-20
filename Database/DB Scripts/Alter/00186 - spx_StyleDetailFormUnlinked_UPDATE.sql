
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailFormUnlinked_UPDATE]
(@StyleDetailFormID uniqueidentifier,
@ModifiedBy nvarchar(200),
@ModifiedDate datetime)
AS 

BEGIN
		DECLARE @StyleDetailFormMasterID uniqueidentifier 
		SELECT @StyleDetailFormMasterID = StyleDetailFormMasterID FROM pStyleDetailForm WITH (NOLOCK) WHERE StyleDetailFormID = @StyleDetailFormID

		UPDATE pStyleDetailForm
			SET StyleImageLinked = 0, StyleDetailFormMasterID = NEWID(), 
			MDate = @ModifiedDate, MUser = @modifiedBy
		WHERE StyleDetailFormMasterID = @StyleDetailFormMasterID
END