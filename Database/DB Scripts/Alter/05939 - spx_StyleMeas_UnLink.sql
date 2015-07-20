IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_UnLink]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_UnLink]
GO

CREATE PROCEDURE [dbo].[spx_StyleMeas_UnLink]
(
	@WorkFlowItemId UNIQUEIDENTIFIER
	, @StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
	, @NewWorkFlowItemId UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
	DELETE FROM pWorkFlowItemLinked WHERE WorkFlowItemID = @WorkFlowItemId AND StyleID = @StyleID AND StyleSet = @StyleSet
	IF @NewWorkFlowItemId IS NOT NULL
		BEGIN
			UPDATE pMSEvalHeader SET WorkFlowItemId = @NewWorkFlowItemId WHERE WorkFlowItemID = @WorkFlowItemId AND StyleID = @StyleID AND StyleSet = @StyleSet
			UPDATE pQAHeader SET WorkFlowItemId = @NewWorkFlowItemId WHERE WorkFlowItemID = @WorkFlowItemId AND StyleID = @StyleID AND StyleSet = @StyleSet
		END
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05939', GetDate())
GO
