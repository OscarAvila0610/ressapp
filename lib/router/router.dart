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
    router.define(rootRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
    router.define(registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none );

    //Dashboard
    router.define(airlinesRoute, handler: DashboardHandlers.airlines, transitionType: TransitionType.fadeIn);
    router.define(bookingsRoute, handler: DashboardHandlers.bookings, transitionType: TransitionType.none);
    router.define(blankRoute, handler: DashboardHandlers.blank, transitionType: TransitionType.fadeIn);
    router.define(dashboardRoute, handler: DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn);
    router.define(calculatorRoute, handler: DashboardHandlers.calculator, transitionType: TransitionType.fadeIn);
    router.define(destinationsRoute, handler: DashboardHandlers.destinations, transitionType: TransitionType.fadeIn);
    router.define(originsRoute, handler: DashboardHandlers.origins, transitionType: TransitionType.fadeIn);
    router.define(containersRoute, handler: DashboardHandlers.containers, transitionType: TransitionType.fadeIn);
    router.define(commoditiesRoute, handler: DashboardHandlers.commodities, transitionType: TransitionType.fadeIn);
    router.define(exportersRoute, handler: DashboardHandlers.exporters, transitionType: TransitionType.fadeIn);
    router.define(iconsRoute, handler: DashboardHandlers.icons, transitionType: TransitionType.fadeIn);
    router.define(usersRoute, handler: DashboardHandlers.users, transitionType: TransitionType.fadeIn);
    router.define(userRoute, handler: DashboardHandlers.user, transitionType: TransitionType.fadeIn);
    router.define(awbRoute, handler: DashboardHandlers.awb, transitionType: TransitionType.fadeIn);

    //404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
