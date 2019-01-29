USE [NCCRD_TEST]
GO

if((SELECT COUNT(*) FROM [dbo].[Feasibility]) = 0)
BEGIN

	SET IDENTITY_INSERT [dbo].[Feasibility] ON 
	INSERT [dbo].[Feasibility] ([FeasibilityId], [Value], [Description]) VALUES (1, N'Hypothetical', NULL)
	INSERT [dbo].[Feasibility] ([FeasibilityId], [Value], [Description]) VALUES (2, N'Tested', NULL)
	INSERT [dbo].[Feasibility] ([FeasibilityId], [Value], [Description]) VALUES (3, N'Tested with Feasibility Analysis', NULL)
	SET IDENTITY_INSERT [dbo].[Feasibility] OFF

END