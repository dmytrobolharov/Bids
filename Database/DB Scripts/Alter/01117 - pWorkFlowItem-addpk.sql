
ALTER TABLE [dbo].[pWorkFlowItem] drop  CONSTRAINT [PK_pWorkFlowItem] 
	
GO

ALTER TABLE [dbo].[pWorkFlowItem] ADD  CONSTRAINT [PK_pWorkFlowItem] PRIMARY KEY CLUSTERED 
(
	[WorkFlowItemID] ASC,
	[StyleID] ASC)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01117', GetDate())
