IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleDetail' 
    AND  COLUMN_NAME = 'StyleDetailLinkItemID')
	ALTER TABLE pStyleDetail ADD  StyleDetailLinkItemID UNIQUEIDENTIFIER

	
IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleDetail' 
    AND  COLUMN_NAME = 'SessionItemTempID')
	ALTER TABLE pStyleDetail ADD  SessionItemTempID UNIQUEIDENTIFIER



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetail_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleDetail_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_StyleDetail_DELETE](
	@StyleDesignDetailID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet INT,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS 

DECLARE @StyleDetailLinkItemID  UNIQUEIDENTIFIER 

SELECT @StyleDetailLinkItemID  = StyleDetailLinkItemID FROM pStyleDetail WITH(NOLOCK)
WHERE StyleDesignDetailID = @StyleDesignDetailID 

IF @StyleDetailLinkItemID IS NOT NULL 
	DELETE FROM dbo.pStyleDetail 
	WHERE StyleDetailLinkItemID = @StyleDetailLinkItemID
ELSE 
	DELETE FROM dbo.pStyleDetail 
	WHERE StyleDesignDetailID = @StyleDesignDetailID
	AND StyleID = @StyleID
	AND StyleSet = @StyleSet
	
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01078', GetDate())
GO




