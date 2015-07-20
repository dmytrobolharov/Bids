IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNewCopy_ColorTmp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNewCopy_ColorTmp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleNewCopy_ColorTmp_INSERT](
	@TransactionID UNIQUEIDENTIFIER,
	@StyleColorID UNIQUEIDENTIFIER
)
AS 

INSERT INTO pStyleCopyColorTmp(StyleCopyColorTmpID, TransactionID, StyleColorID)
VALUES (NEWID(), @TransactionID, @StyleColorID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05119', GetDate())
GO
