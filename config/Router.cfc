/**
 * This is your application router.  From here you can controll all the incoming routes to your application.
 *
 * https://coldbox.ortusbooks.com/the-basics/routing
 */
component {

	function configure ( ) {
		/**
		 * --------------------------------------------------------------------------
		 * Router Configuration Directives
		 * --------------------------------------------------------------------------
		 * https://coldbox.ortusbooks.com/the-basics/routing/application-router#configuration-methods
		 */
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 */

		// A nice healthcheck route example
		route( '/healthcheck', function (
			 event
			,rc
			,prc
		) {
			return 'Ok!';
		} );

		/** -----------------------------------------------------------------------------------------------------------
		 * Other
		 * -----------------------------------------------------------------------------------------------------------
		 */

		 group(
			{
				'pattern': '/api/quotes'
				,'target' : 'api.Quotes.'
			}
			,function ( ) {
				get(
					 '/'
					,'index'
				)
				get(
					 '/:id'
					,'show'
				)
				post(
					 '/'
					,'create'
				)
				put(
					 '/:id'
					,'update'
				)
				delete(
					 '/:id'
					,'delete'
				)
			}
		 )


		/** -----------------------------------------------------------------------------------------------------------
		 * Primary
		 * -----------------------------------------------------------------------------------------------------------
		 */
		// *API Goals
		group(
			 {
				 'pattern': '/api/goals'
				,'target' : 'api.Goals.'
			}
			,function ( ) {
				get(
					'/empty'
					,'getEmpty'
				)
				get(
					 '/show/:id'
					,'showGoal'
				)
				get(
					 '/'
					,'index'
				)

				post(
					 '/'
					,'createNew'
				)
				put(
					 '/:id'
					,'update'
				)
				delete(
					 '/:id'
					,'delete'
				)
				options(
					 '/'
					,'preflight'
				)
			}
		);

		// *API Reminders
		group(
			 {
				 'pattern': '/api/reminders'
				,'target' : 'api.Reminders.'
			}
			,function ( ) {

				get(
					 '/:id'
					,'showReminder'
				)
				get(
					 '/'
					,'index'
				)
				post(
					 '/'
					,'create'
				)
				put(
					 '/:id'
					,'update'
				)
				delete(
					 '/:id'
					,'delete'
				)
				options(
					 '/'
					,'preflight'
				)
			}
		);


		// *API Suggestions
		group(
			 {
				 'pattern': '/api/suggestions'
				,'target' : 'api.Suggestions.'
			}
			,function ( ) {

				get(
					 '/:id'
					,'showSuggestion'
				)
				get(
					 '/'
					,'index'
				)
				post(
					 '/'
					,'create'
				)
				put(
					 '/:id'
					,'update'
				)
				delete(
					 '/:id'
					,'delete'
				)
				options(
					 '/'
					,'preflight'
				)
			}
		);


		// *Statuses
		group(
			 {
				 'pattern': '/api/statuses'
				,'target' : 'api.Statuses.'
			}
			,function ( ) {

				get(
					 '/:id'
					,'showStatus'
				)
				get(
					 '/'
					,'index'
				)
				post(
					 '/'
					,'create'
				)
				put(
					 '/:id'
					,'update'
				)
				delete(
					 '/:id'
					,'delete'
				)
				options(
					 '/'
					,'preflight'
				)
			}
		);

		// *API Motivations
		group(
			 {
				 'pattern': '/api/motivations'
				,'target' : 'api.Motivations.'
			}
			,function ( ) {

				get(
					 '/:id'
					,'showMotivation'
				)
				get(
					 '/'
					,'index'
				)
				post(
					 '/'
					,'create'
				)
				put(
					 '/:id'
					,'update'
				)
				delete(
					 '/:id'
					,'delete'
				)
				options(
					 '/'
					,'preflight'
				)
			}
		);


		// Conventions-Based Routing
		route( ':handler/:action?' ).end( );
	}

}
