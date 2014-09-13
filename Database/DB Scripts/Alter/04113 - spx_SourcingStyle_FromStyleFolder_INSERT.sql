IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingStyle_FromStyleFolder_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingStyle_FromStyleFolder_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SourcingStyle_FromStyleFolder_INSERT]
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO pSourcingStyle (SourcingHeaderID, StyleID, Styleset, 
    Progress, Complexity, Priority, Active, CUser, CDate, MUser, MDate)
    SELECT DISTINCT @SourcingHeaderID, @StyleID, StyleSet,
    0, '', '', 1, @CUser, @CDate, @CUser, @CDate 
    FROM pStyleHeader WHERE StyleID = @StyleID
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04113', GetDate())
GO
