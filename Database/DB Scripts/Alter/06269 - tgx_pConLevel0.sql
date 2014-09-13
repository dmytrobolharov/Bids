IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pConLevel0]'))
DROP TRIGGER [dbo].[tgx_pConLevel0]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tgx_pConLevel0] on [dbo].[pConLevel0] for DELETE as

begin
 SET NOCOUNT ON
  declare  @errno   int,
           @errmsg  varchar(255)

    delete pConstructTree
      from pConstructTree,deleted
      where
        pConstructTree.Level0ID = deleted.Level0ID
    return
error:
    RAISERROR (@errmsg,16, 1 );
    rollback transaction
end
GO
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '0.5.0.0000', '06269', GetDate())
GO
