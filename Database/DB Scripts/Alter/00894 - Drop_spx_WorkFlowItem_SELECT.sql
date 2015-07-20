IF EXISTS (select * from sysobjects where id = object_id('spx_WorkFlowItem_SELECT') and sysstat & 0xf = 4)
	drop procedure spx_WorkFlowItem_SELECT
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '894', GetDate())

GO