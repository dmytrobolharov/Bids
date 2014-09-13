SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tD_pConLevel3] on [dbo].[pConLevel3] for DELETE as

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
