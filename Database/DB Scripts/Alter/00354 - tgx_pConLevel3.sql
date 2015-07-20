IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pConLevel3]'))
DROP TRIGGER [dbo].[tgx_pConLevel3]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tgx_pConLevel3] on [dbo].[pConLevel3] for DELETE as

begin
 SET NOCOUNT ON
  declare  @errno   int,
           @errmsg  varchar(255)
    delete pConstructTree
      from pConstructTree,deleted
      where
        pConstructTree.Level3ID = deleted.Level3ID
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '354', GetDate())
GO