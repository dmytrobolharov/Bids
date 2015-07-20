IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MilestoneTemplateItemDependency_SEL]'))
DROP VIEW [dbo].[vwx_MilestoneTemplateItemDependency_SEL]
GO

CREATE VIEW [dbo].[vwx_MilestoneTemplateItemDependency_SEL]
AS
SELECT     mti2.MilestoneTemplateItemID AS DependentMilestoneTemplateItemID, mti2.MilestoneTemplateItemName AS DependentMilestoneTemplateItemName, 
                      mti.MilestoneTemplateItemID
FROM         dbo.pMilestoneTemplateItem AS mti INNER JOIN
                      dbo.pMilestoneTemplateItem AS mti2 ON ISNULL(mti.ParentID, mti.MilestoneTemplateID) = ISNULL(mti2.ParentID, mti2.MilestoneTemplateID) AND 
                      mti.MilestoneTemplateItemID <> mti2.MilestoneTemplateItemID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07168', GetDate())
GO
