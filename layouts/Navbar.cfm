<cfsilent>
	<cfset includeNavbarText = true>
	<cfset brandName = "Cash Navigator Server">
	<cfset navBarMessage = "Welcome">
	<cfset includeMobileToggler = true>
	<cfset mainLink = "echo.index">


	<cfset navLinks = [
		[navLinkId = 'Home', destination = mainLink],

		[navLinkId = 'APIs',
			subLinks = [
				[subLinkIds = 'incomes',
					endPoints = [
						[endPointId = 'get', 	destination = 'income.index'],
						[endPointId = 'post', 	destination = 'income.store'], <!--- TODO: Add the required data, likely through a new page --->
						[endPointId = 'put', 	destination = 'income.update'], <!--- TODO: Add the required data, likely through a new page --->
						[endPointId = 'delete', destination = 'income.destroy'] <!--- TODO: Add the required data, likely through a new page --->
					]
				],
				[subLinkIds = 'expenses',
					endPoints = [
						[endPointId = 'get', 	destination = 'expense.index'],
						[endPointId = 'post', 	destination = 'expense.store'], <!--- TODO: Add the required data, likely through a new page --->
						[endPointId = 'put', 	destination = 'expense.update'], <!--- TODO: Add the required data, likely through a new page --->
						[endPointId = 'delete', destination = 'expense.destroy'] <!--- TODO: Add the required data, likely through a new page --->
					]
				],
				[subLinkIds = 'users',
					endPoints = [
						[endPointId = 'get', 	destination = 'user.index'],
						[endPointId = 'post', 	destination = 'user.store'], <!--- TODO: Add the required data, likely through a new page --->
						[endPointId = 'put', 	destination = 'user.update'], <!--- TODO: Add the required data, likely through a new page --->
						[endPointId = 'delete', destination = 'user.destroy'] <!--- TODO: Add the required data, likely through a new page --->
					]
				],
		]],

		[navLinkId = 'Logs',
			subLinks = [
				[subLinkIds = 'API',
					endPoints = [
						<!--- [endPointId = 'Income_Check', destination = 'assets/logs/API_INCOME_CHECK/']  TODO: Add a more appealing interface, likely through a new page --->
						[endPointId = 'Income_Check', destination = 'LogPages.API_IncomeCheck'] <!--- TODO: Add a more appealing interface, likely through a new page --->
					]
				],
				[subLinkIds = "CORS",
					endPoints = [
						// [endPointId = 'Info', destination = 'assets/logs/CORS_INFO'] <!--- TODO: Add a more appealing interface, likely through a new page --->
						[endPointId = 'Info', destination = 'LogPages.CORS_INFO'] <!--- TODO: Add a more appealing interface, likely through a new page --->
					]
				],
		]]
	]>
</cfsilent>

<cfoutput>
	<cfparam name="session.loggedInId" default="">

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container-fluid">
			<cfif includeNavbarText>
				<a class="navbar-brand" href="#event.buildLink(mainLink)#">
					<cfif brandName neq "">
						<strong>#brandName#</strong>
					<cfelseif navBarMessage neq "">
						<strong>#navBarMessage#</strong>
					<cfelse>
						<strong>Home</strong>
					</cfif>
				</a>
			</cfif>

			<cfif includeMobileToggler>
				<button
					class="navbar-toggler"
					type="button"
					data-bs-toggle="collapse"
					data-bs-target="##navbarSupportedContent"
					aria-controls="navbarSupportedContent"
					aria-expanded="false"
					aria-label="Toggle navigation"
				>
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent">
			</cfif>

			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<cfloop array="#navLinks#" index="navLink">
					<li class="nav-item">
						<cfif !structKeyExists(navLink, "subLinks")>
							<!--- Should be a simple click link and go to page --->
							<a class="nav-link" href="#event.buildLink(navLink.destination)#">#navLink.navLinkId#</a>
						<cfelse>
						<!--- Should be a dropdown menu for subLinks --->
							<ul class="nav-item dropdown">
								<a
									class="nav-link dropdown-toggle"
									href="##"
									id="navbarDropdown"
									role="button"
									data-bs-toggle="dropdown"
									aria-expanded="false"
								>
									#navLink.navLinkId#<b class="caret"></b>
								</a>

								<ul class="nav-item dropdown-menu" aria-labelledby="navbarDropdown">
									<li>
										<cfloop array="#navLink.subLinks#" item="subLink">
											<ul class="nav-item">#subLink.subLinkIds# #navLink.navLinkId#</li>
												<cfloop array="#subLink.endPoints#" index="ep">
													<li style="margin-left: 30px;">
														<a class="nav-item" href="#event.buildLink(ep.destination)#">#ep.endPointId#</a>
													</li>
												</cfloop>
											</ul>
										</cfloop>
									</li>
								</ul>
							</ul>

						</cfif>
					</li>
				</cfloop>
			</ul>

			</div>
		</div>
	</nav>
</cfoutput>
