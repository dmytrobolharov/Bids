IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_sPackageRelationships_RelationshipType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPackageRelationship]'))
ALTER TABLE [dbo].[sPackageRelationship] DROP CONSTRAINT [CK_sPackageRelationships_RelationshipType]
GO

/****** Object:  Table [dbo].[sPackageRelationship]    Script Date: 02/03/2014 15:11:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageRelationship]') AND type in (N'U'))
DROP TABLE [dbo].[sPackageRelationship]
GO

/****** Object:  Table [dbo].[sPackageRelationship]    Script Date: 02/03/2014 15:11:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sPackageRelationship](
	[PackageID] [nvarchar](8) NOT NULL,
	[RelatedPackageID] [nvarchar](8) NOT NULL,
	[RelationshipType] [int] NOT NULL,
 CONSTRAINT [PK_sPackageRelationship] PRIMARY KEY CLUSTERED 
(
	[PackageID] ASC,
	[RelatedPackageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sPackageRelationship]  WITH CHECK ADD  CONSTRAINT [CK_sPackageRelationships_RelationshipType] CHECK  (([RelationshipType]=(1) OR [RelationshipType]=(0) OR [RelationshipType]=(-1)))
GO

ALTER TABLE [dbo].[sPackageRelationship] CHECK CONSTRAINT [CK_sPackageRelationships_RelationshipType]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'-1 is for conflice, 1 is for requirement' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sPackageRelationship', @level2type=N'CONSTRAINT',@level2name=N'CK_sPackageRelationships_RelationshipType'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07077', GetDate())
GO
