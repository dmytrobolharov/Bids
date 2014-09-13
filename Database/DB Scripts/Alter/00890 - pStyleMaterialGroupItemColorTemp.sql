ALTER TABLE pStyleColorway ADD MaterialCoreColorID uniqueidentifier NULL

ALTER TABLE pStyleMaterials ADD MaterialLinkID uniqueidentifier NULL,
	MultiMaterialParentID uniqueidentifier NULL


CREATE TABLE [dbo].[pStyleMaterialGroupItemColorTemp](
	[StyleMaterialGroupItemColorTempID] [uniqueidentifier] NOT NULL,
	[MaterialCoreID] [uniqueidentifier] NULL,
	[StyleColorID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[MaterialCoreColorID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pStyleMaterialGroupItemColorTemp] PRIMARY KEY CLUSTERED 
(
	[StyleMaterialGroupItemColorTempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


