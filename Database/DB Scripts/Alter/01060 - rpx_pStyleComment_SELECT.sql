IF EXISTS (select * from sysobjects where id = object_id('rpx_pStyleComment_SELECT') and sysstat & 0xf = 4)
    drop procedure rpx_pStyleComment_SELECT
GO

CREATE PROCEDURE [dbo].[rpx_pStyleComment_SELECT]
	@StyleID varchar(255),	 
	@WorkflowItemID varchar(255),	
	@StyleSet As int
AS

SELECT StyleComment AS StyleComment
INTO	#tblTemp
 FROM pStyleComment
 WHERE WorkFlowItemId = @WorkflowItemID
	AND StyleSet = @StyleSet AND StyleID = @StyleID


SELECT 	StyleComment
FROM	#tblTemp

DROP TABLE #tblTemp
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01060', GetDate())
GO