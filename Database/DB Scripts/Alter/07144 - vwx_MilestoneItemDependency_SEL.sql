IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MilestoneItemDependency_SEL]'))
DROP VIEW [dbo].[vwx_MilestoneItemDependency_SEL]
GO

CREATE VIEW [dbo].[vwx_MilestoneItemDependency_SEL]
AS
SELECT     mi2.MilestoneItemID AS DependentMilestoneItemID, mi2.MilestoneItemName AS DependentMilestoneItemName, mi.MilestoneItemID
FROM         dbo.pMilestoneItem AS mi INNER JOIN
                      dbo.pMilestoneItem AS mi2 ON mi.MilestoneID = mi2.MilestoneID AND mi.MilestoneItemID <> mi2.MilestoneItemID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07144', GetDate())
GO
