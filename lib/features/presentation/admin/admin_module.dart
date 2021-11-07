import 'package:flutter_modular/flutter_modular.dart';

import 'account_admin/account_admin_page.dart';
import 'account_admin/bloc/account_admin_bloc.dart';
import 'account_admin/bloc/status_account_admin_bloc.dart';
import 'admin/admin_page.dart';
import 'admin/bloc/admin_bloc.dart';
import 'admin/pages/accounts/bloc/accounts_page_bloc.dart';
import 'admin/pages/categories/bloc/categories_page_bloc.dart';
import 'arguments/account_arguments.dart';

class AdminModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => AdminBloc()),
    Bind((i) => CategoriesPageBloc(i.get())),
    Bind((i) => AccountsPageBloc(i.get())),
    Bind((i) => StatusAccountAdminBloc()),
    Bind((i) => AccountAdminBloc(i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => const AdminPage()),
    ChildRoute('${Modular.initialRoute}account', child: (_, args) => AccountAdminPage(args: args.data as AccountArguments)),
  ];
}
