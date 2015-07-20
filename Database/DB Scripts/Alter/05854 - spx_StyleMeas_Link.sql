IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_Link]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_Link]
GO

CREATE PROCEDURE [dbo].[spx_StyleMeas_Link]
(
	@WorkFlowItemId UNIQUEIDENTIFIER
	, @StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
)
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM pWorkFlowItemLinked WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkFlowItemID = @WorkFlowItemId)
	BEGIN
		INSERT INTO pWorkFlowItemLinked (WorkFlowItemID, StyleID, StyleSet)
		VALUES (@WorkFlowItemId, @StyleID, @StyleSet)
	END	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05854', GetDate())
GO
