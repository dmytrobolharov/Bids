/****** Object:  Table [dbo].[uTradePartnerStatus]    Script Date: 11/27/2012 11:12:36 ******/
INSERT [dbo].[uTradePartnerStatus] ([StatusID], [Status], [StatusOrder]) VALUES (1, N'Identification', N'001')
INSERT [dbo].[uTradePartnerStatus] ([StatusID], [Status], [StatusOrder]) VALUES (2, N'Qualification', N'002')
INSERT [dbo].[uTradePartnerStatus] ([StatusID], [Status], [StatusOrder]) VALUES (3, N'On Boarding', N'003')
INSERT [dbo].[uTradePartnerStatus] ([StatusID], [Status], [StatusOrder]) VALUES (4, N'Selection', N'004')
INSERT [dbo].[uTradePartnerStatus] ([StatusID], [Status], [StatusOrder]) VALUES (5, N'Approved', N'005')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '04466', GetDate())
GO
