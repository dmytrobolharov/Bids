
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailFormUnlinked_INSERT]
(@StyleDetailFormID uniqueidentifier,
@WorkflowID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet int,
@ImageID uniqueidentifier,
@ImageVersion int,
@CreatedBy nvarchar(100),
@CreatedDate datetime)
AS 


	BEGIN
		INSERT INTO pStyleDetailForm
		(StyleDetailFormID, StyleDetailFormMasterID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, StyleImageLinked)
		VALUES (@StyleDetailFormID, NEWID(), @WorkflowID, @StyleID, @StyleSet, @ImageID, @ImageVersion, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 0)
	END
