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
		 * Pages
		 * -----------------------------------------------------------------------------------------------------------
		 */
		// *API Tasks
		group(
			 {
				 'pattern': '/api/tasks'
				,'target' : 'api.Tasks.'
			}
			,function ( ) {

				get(
					 '/:id'
					,'showTask'
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
			}
		);

		// Conventions-Based Routing
		route( ':handler/:action?' ).end( );
	}

}
