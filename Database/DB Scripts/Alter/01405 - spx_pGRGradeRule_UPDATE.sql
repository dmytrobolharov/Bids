IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_pGRGradeRule_UPDATE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_pGRGradeRule_UPDATE
GO
/****** Object:  StoredProcedure [dbo].[spx_pGRGradeRule_UPDATE]    Script Date: 04/13/2011 11:59:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC  [dbo].[spx_pGRGradeRule_UPDATE]
(
@GradeRuleId uniqueidentifier,
@strSizeCol varchar(50),
@strValue decimal (18,4),
@ModifiedBy nvarchar(204),
@ModifiedDate datetime
)
AS


UPDATE pGRGradeRule SET 
			@strSizeCol  = @strValue, 
			MUser = @ModifiedBy,
			MDate = @ModifiedDate
		WHERE GradeRuleGuidID = @GradeRuleId




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01405', GETDATE())
GO	