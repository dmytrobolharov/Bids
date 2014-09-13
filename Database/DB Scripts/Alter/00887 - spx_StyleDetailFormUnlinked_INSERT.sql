IF EXISTS (select * from sysobjects where id = object_id('spx_StyleDetailFormUnlinked_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_StyleDetailFormUnlinked_INSERT
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailFormUnlinked_INSERT]
(@StyleDetailFormID uniqueidentifier,
@WorkflowID uniqueidentifier,
@WorkflowItemID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet int,
@ImageID uniqueidentifier,
@ImageVersion int,
@CreatedBy nvarchar(100),
@CreatedDate datetime)
AS 


	BEGIN
		INSERT INTO pStyleDetailForm
		(StyleDetailFormID, StyleDetailFormMasterID, WorkflowID, WorkFlowItemId, StyleID, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, StyleImageLinked)
		VALUES (@StyleDetailFormID, NEWID(), @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet, @ImageID, @ImageVersion, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 0)
	END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '887', GetDate())
GO