IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pConLevel1]'))
DROP TRIGGER [dbo].[tgx_pConLevel1]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tgx_pConLevel1] on [dbo].[pConLevel1] for DELETE as

begin
 SET NOCOUNT ON
  declare  @errno   int,
           @errmsg  varchar(255)

    delete pConstructTree
      from pConstructTree,deleted
      where
        pConstructTree.Level1ID = deleted.Level1ID
    return
error:
    RAISERROR (@errmsg,16, 1 );
    rollback transaction
end


GO
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '0.5.0.0000', '06270', GetDate())
GO
