update sSystemButtons set en_US='go to...' where DesignString='btn_goto.gif'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04669', GetDate())
GO
