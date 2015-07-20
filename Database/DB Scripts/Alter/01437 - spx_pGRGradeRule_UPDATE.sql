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
@SizeCol varchar(50),
@SizeValue   decimal (18,4),
@ModifiedBy nvarchar(204),
@ModifiedDate datetime
)
AS

DECLARE @SQLString  nvarchar(max)
DECLARE @strSizeCol1 varchar(50)
DECLARE @DecColValue decimal (18,4)

SET @SQLString = N'UPDATE pGRGraderule SET '
SET @SQLString = @SQLString + @SizeCol  + ' = '
SET @SQLString = @SQLString + N'@DecColValue  ' 
SET @SQLString = @SQLString + N' , MUser = @ModifiedByVal ' 
SET @SQLString = @SQLString + N' , MDate = @ModifiedDateVal ' 
SET @SQLString = @SQLString + N' WHERE GradeRuleGuidID = @GradeRuleIdVal'

EXECUTE sp_executesql 
          @SQLString,
          N'@DecColValue decimal(18,4), @ModifiedByVal nvarchar(204),
            @ModifiedDateVal datetime,@GradeRuleIdVal uniqueidentifier',
          @DecColValue      = @SizeValue ,
          @ModifiedByVal    = @ModifiedBy,
          @ModifiedDateVal  = @ModifiedDate,
          @GradeRuleIdVal   = @GradeRuleId;



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01437', GETDATE())
GO	