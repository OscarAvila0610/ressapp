import 'package:fluro/fluro.dart';
import 'package:ress_app/router/admin_handlers.dart';
import 'package:ress_app/router/dashboard_handlers.dart';
import 'package:ress_app/router/no_page_found_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';
  //Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  //Dashboard
  static String airlinesRoute = '/dashboard/airlines';
  static String bookingsRoute = '/dashboard/bookings';
  static String dashboardRoute = '/dashboard';
  static String dashboardUserRoute = '/dashboardUser';
  static String dashboardAnalistRoute = '/dashboardAnalist';
  static String iconsRoute = '/dashboard/icons';
  static String blankRoute = '/dashboard/blank';
  static String containersRoute = '/dashboard/containers';
  static String calculatorRoute = '/dashboard/calculator';
  static String commoditiesRoute = '/dashboard/commodities';
  static String usersRoute = '/dashboard/users';
  static String userRoute = '/dashboard/users/:uid';
  static String awbRoute = '/dashboard/reservas/awb/:awb';
  static String destinationsRoute = '/dashboard/destinations';
  static String originsRoute = '/dashboard/origins';
  static String exportersRoute = '/dashboard/exporters';

  static void configureRoutes() {
    //Auth Routes
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: TransitionType.none);

    //Dashboard
    router.define(airlinesRoute,
        handler: DashboardHandlers.airlines,
        transitionType: TransitionType.none);
    router.define(bookingsRoute,
        handler: DashboardHandlers.bookings,
        transitionType: TransitionType.none);
    router.define(blankRoute,
        handler: DashboardHandlers.blank, transitionType: TransitionType.none);
    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.none);
    router.define(dashboardUserRoute,
        handler: DashboardHandlers.dashboardUser,
        transitionType: TransitionType.none);
    router.define(dashboardAnalistRoute,
        handler: DashboardHandlers.dashboardAnalist,
        transitionType: TransitionType.none);
    router.define(calculatorRoute,
        handler: DashboardHandlers.calculator,
        transitionType: TransitionType.none);
    router.define(destinationsRoute,
        handler: DashboardHandlers.destinations,
        transitionType: TransitionType.none);
    router.define(originsRoute,
        handler: DashboardHandlers.origins,
        transitionType: TransitionType.none);
    router.define(containersRoute,
        handler: DashboardHandlers.containers,
        transitionType: TransitionType.none);
    router.define(commoditiesRoute,
        handler: DashboardHandlers.commodities,
        transitionType: TransitionType.none);
    router.define(exportersRoute,
        handler: DashboardHandlers.exporters,
        transitionType: TransitionType.none);
    router.define(iconsRoute,
        handler: DashboardHandlers.icons, transitionType: TransitionType.none);
    router.define(usersRoute,
        handler: DashboardHandlers.users, transitionType: TransitionType.none);
    router.define(userRoute,
        handler: DashboardHandlers.user, transitionType: TransitionType.none);
    router.define(awbRoute,
        handler: DashboardHandlers.awb, transitionType: TransitionType.none);

    //404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
