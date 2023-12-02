<cfoutput>
  <div class="response">
    <h1>Task Response</h1>
    <p>
      At #PRC.currentViewArgs.data.timeStamp#, a request was made to
      <strong>#PRC.currentRoute#</strong> with a status code returning
      <strong>#PRC.currentViewArgs.statusCode#</strong> and a message of
      #PRC.currentViewArgs.message#.
    </p>

	<div class="response-messages">
		<h3>Messages from response:</h3>
		<ul>
			<cfloop array="#PRC.currentViewArgs.data.messages#" index="message">
			<li>#message#</li>
			</cfloop>
		</ul>
    </div>
  </div>


	<!---  TASK Specific part. Maybe include other files here. --->
  <div class="data-representation">
	<h3>Here is the data:</h3>

	<cfloop array="#PRC.currentViewArgs.data.contents#" item="content">
		<div>
		<table class="data-table">
			<thead>
			<tr>
				<th>Active</th>
				<th>Name</th>
				<th>Description</th>
				<th>Status</th>
				<th>Creation Date</th>
				<th>Modified Date</th>
				<th>Notes</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td><input type="checkbox" value="#content.active#" readonly></td>
				<td>#content.name#</td>
				<td>#content.description#</td>
				<td>#content.status#</td>
				<td>#content.createdOn#</td>
				<td>#content.modifiedOn#</td>
				<td>
					<cfloop array="#content.notes#" item="note">
						<p>#note#</p>
					</cfloop>
				</td>
			</tr>
			</tbody>
		</table>
		</div>
	</cfloop>
  </div>
</cfoutput>
