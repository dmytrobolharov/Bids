/****** Object:  View [dbo].[vwx_ChangeLogItemMaterial_SEL]    Script Date: 10/11/2012 11:11:33 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ChangeLogItemMaterial_SEL]'))
DROP VIEW [dbo].[vwx_ChangeLogItemMaterial_SEL]
GO

/****** Object:  View [dbo].[vwx_ChangeLogItemMaterial_SEL]    Script Date: 10/11/2012 11:11:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_ChangeLogItemMaterial_SEL]
AS
SELECT     b.ChangeTableID, b.ChangeTablePKID, b.ChangeUserName, b.ChangeDate, a.ChangeLogItemID, a.ChangeTransID, a.ChangeLogID, a.ChangeFieldName, 
                      a.ChangeFieldAlias, a.ChangeBeforeValue, a.ChangeAfterValue, a.ChangeBeforeText, a.ChangeAfterText, a.ChangeSort, d.MaterialName, e.ComponentDescription, 
                      d.MaterialNo, c.ChangeTransTablePKID, c.ChangeSessionNo, c.ChangeTransNo, c.ChangeSessionID, CASE ISNULL(b.ChangeTransTypeID, c.ChangeTransTypeID) 
                      WHEN 0 THEN 'Update' WHEN 1 THEN 'Add' WHEN 2 THEN 'Remove' WHEN 3 THEN 'Copy' WHEN 4 THEN 'Replace' END AS ActionType
FROM         dbo.pChangeLogItem AS a WITH (NOLOCK) INNER JOIN
                      dbo.pChangeLog AS b WITH (NOLOCK) ON a.ChangeLogID = b.ChangeLogID INNER JOIN
                      dbo.pChangeTransaction AS c WITH (NOLOCK) ON c.ChangeTransID = a.ChangeTransID INNER JOIN
                      dbo.pMaterial AS d WITH (NOLOCK) ON d.MaterialID = c.ChangeTransTablePKID INNER JOIN
                      dbo.pComponentType AS e WITH (NOLOCK) ON d.MaterialType = e.ComponentTypeID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04344', GetDate())
GO
