-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailForm_Comments_UPDATE]
(
@StyleDetailFormID uniqueidentifier,
@Comments nvarchar(2000),
@MUser nvarchar(200),
@MDate nvarchar(50)
)
AS UPDATE    dbo.pStyleDetailForm
SET              Comments = @Comments, MUser = @MUser, MDate = @MDate
WHERE     (StyleDetailFormID = @StyleDetailFormID)
